<script>
import AppBtnDelete from 'components/AppBtnDelete'
import AppForm from 'components/AppForm'
import AppInput from 'components/AppInput'
import AppSelect from 'components/AppSelect'

const initItemFormData = {
  category_id: null,
  product: null,
  quantity: 1
}

export default {
  name: 'CartPage',

  components: {
    AppBtnDelete,
    AppForm,
    AppInput,
    AppSelect
  },

  data () {
    return {
      categories: [],
      products: [],
      productsFromCategory: [],
      items: [],
      totalItems: 0,
      totalPrice: 0.00,
      loading: false,
      filter: null,
      itemFormData: Object.assign({}, initItemFormData),
      columns: [
        {
          name: 'id',
          label: 'Código',
          align: 'left',
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'name',
          label: 'Nome',
          align: 'left',
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'quantity',
          label: 'Quantidade',
          align: 'left',
          field: row => row.price,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'price',
          label: 'Preço',
          align: 'left',
          field: row => row.price,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'subtotal',
          label: 'Subtotal',
          align: 'center',
          field: row => row.create_at,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'action',
          required: true,
          label: 'Ação',
          align: 'center',
          field: row => row.id,
          format: val => `${val}`,
          sortable: false
        }
      ],
      pagination: {
        sortBy: 'id',
        descending: false,
        page: 1,
        rowsPerPage: 0
      }
    }
  },

  watch: {
    'itemFormData.category_id': function (val, oldVal) {
      if (val && val !== oldVal) {
        this.itemFormData.product = null
        this.filterProductsByCategory()
      }
    }
  },

  mounted () {
    this.getCategories()
    this.getProducts()
  },

  methods: {
    async getCategories () {
      this.loading = true

      await this.$axios.get('/v1/categories')
        .then(({ data, status }) => {
          if (status === 200) {
            this.categories = data
          }
        })
        .catch(({ response }) => {
          if (response && response.data && response.data.error) {
            this.$q.notify({
              type: 'negative',
              message: response.data.error
            })
          }
        })

      this.loading = false
    },

    async getProducts () {
      this.loading = true

      await this.$axios.get('/v1/products')
        .then(({ data, status }) => {
          if (status === 200) {
            this.products = data
          }
        })
        .catch(({ response }) => {
          if (response && response.data && response.data.error) {
            this.$q.notify({
              type: 'negative',
              message: response.data.error
            })
          }
        })

      this.loading = false
    },

    getTotals () {
      let newTotalItems = 0
      let newTotalPrice = 0.0

      this.items.forEach((item) => {
        newTotalItems += item.quantity
        newTotalPrice += item.subtotal
      })

      this.totalItems = newTotalItems
      this.totalPrice = newTotalPrice
    },

    filterProductsByCategory () {
      this.productsFromCategory = this.products.filter((product) => {
        return product.category_id === this.itemFormData.category_id
      })
    },

    addProduct () {
      this.loading = true

      const itemInCartIndex = this.items.findIndex((item) => {
        return item.id === this.itemFormData.product.id
      })

      if (itemInCartIndex !== -1) {
        const quantity = this.items[itemInCartIndex].quantity + parseInt(this.itemFormData.quantity)
        this.items[itemInCartIndex].quantity = quantity
        this.items[itemInCartIndex].subtotal = this.items[itemInCartIndex].price * quantity
      } else {
        const item = {
          id: this.itemFormData.product.id,
          name: this.itemFormData.product.name,
          quantity: parseInt(this.itemFormData.quantity),
          price: this.itemFormData.product.price,
          subtotal: this.itemFormData.product.price * parseInt(this.itemFormData.quantity)
        }

        this.items.push(item)
      }

      this.getTotals()

      this.loading = false
    },

    removeProduct (id) {
      this.loading = true

      this.items = this.items.filter((item) => {
        return item.id !== id
      })

      this.getTotals()

      this.loading = false
    },

    async createOrder () {
      this.loading = true

      await this.$axios.post('/v1/orders', { products: this.items })
        .then(({ data, status }) => {
          if (status === 200) {
            this.$q.notify({
              type: 'positive',
              message: 'Pedido adicionado com sucesso'
            })

            this.$router.push('/pedidos')
          }
        })
        .catch(({ response }) => {
          if (response && response.data && response.data.error) {
            this.$q.notify({
              type: 'negative',
              message: response.data.error
            })
          }
        })

      this.loading = false
    }
  }
}
</script>

<template lang="pug">
  div(class="row q-py-xl")

    q-card(
      bordered
      flat
      class="col-12 q-mb-md"
    )
      q-card-section
        div(class="q-pa-sm q-table__title")
          | Selecione o produto
        AppForm(
          class="row q-gutter-md q-pa-sm items-center"
          :submit-action="addProduct"
        )
          //- Category
          div(class="col-3")
            AppSelect(
              dense
              emit-value
              map-options
              outlined
              label="Categoria"
              option-label="name"
              option-value="id"
              ref="input-category_id"
              validation-id="category_id"
              validation-rules="required"
              v-model="itemFormData.category_id"
              :disable="loading"
              :options="categories"
            )

          //- Product
          div(class="col-4")
            AppSelect(
              dense
              outlined
              label="Produto"
              option-label="name"
              option-value="id"
              ref="input-product"
              validation-id="product"
              validation-rules="required"
              v-model="itemFormData.product"
              :disable="loading || productsFromCategory.length === 0"
              :options="productsFromCategory"
            )
              template(#selected="{ selectedString }")
                | {{ selectedString | truncate(40) }}

            q-tooltip(
              v-if="productsFromCategory.length === 0"
              :offset="[0,-10]"
            )
              | Selecione uma categoria

          //- Quantity
          div(class="col-2")
            AppInput(
              dense
              outlined
              label="Quantidade"
              ref="input-quantity"
              type="number"
              validation-id="quantity"
              validation-rules="required|min_value:1|max_value:100"
              v-model="itemFormData.quantity"
              :disable="loading"
            )

          div(class="col-auto q-pb-md")
            q-btn(
              no-caps
              unelevated
              color="teal"
              label="Adicionar"
              type="submit"
            )

    q-card(
      bordered
      flat
      class="col-12"
    )
      q-card-section
        q-table(
          flat
          virtual-scroll
          class="sticky-action-column"
          no-data-label="Seu carrinho está vazio"
          title="Carrinho"
          :columns="columns"
          :data="items"
          :filter="filter"
          :loading="loading"
          :pagination.sync="pagination"
          :rows-per-page-options="[0]"
        )
          template(#no-data="{ message }")
            div(class="full-width row flex-center q-gutter-sm")
              span
                | {{ message }}

          template(#top-right)
            q-btn(
              no-caps
              unelevated
              color="negative"
              icon="mdi-cart-remove"
              label="Limpar"
              v-if="items.length > 0"
              @click="items = []"
            )

          template(#body="props")
            q-tr(:props="props")
              q-td(
                key="id"
                :props="props"
              )
                | {{ props.row.id }}
              q-td(
                key="name"
                :props="props"
              )
                | {{ props.row.name }}
              q-td(
                key="quantity"
                :props="props"
              )
                | {{ props.row.quantity }}
              q-td(
                key="price"
                :props="props"
              )
                | {{ props.row.price | formatPrice }}
              q-td(
                key="subtotal"
                :props="props"
              )
                | {{ props.row.subtotal | formatPrice }}
              q-td(
                key="action"
                :props="props"
              )
                div(class="q-gutter-sm")
                  AppBtnDelete(
                    :delete-action="() => removeProduct(props.row.id)"
                    :key="props.row.id"
                  )

          template(#bottom)
            div(class="offset-6 col-6 self-end q-px-md q-pt-md")
              div(class="row justify-end")
                div(class="col-2 text-subtitle1")
                  | Items
                div(class="col-2 text-right text-subtitle1")
                  | {{ totalItems }}
              div(class="row justify-end")
                div(class="col-2 text-subtitle1")
                  | Total
                div(class="col-2 text-right text-subtitle1")
                  | {{ totalPrice | formatPrice }}

      q-separator(inset)

      q-card-section
        div(class="q-pb-md text-center")
          q-btn(
            no-caps
            unelevated
            color="indigo-14"
            icon="mdi-cart-check"
            label="Finalizar Pedido"
            :disable="items.length === 0"
            :loading="loading"
            @click="createOrder"
          )
          q-tooltip(
            v-if="items.length === 0"
            :offset="[0,-10]"
          )
            | Adicione produtos no seu carrinho

</template>
