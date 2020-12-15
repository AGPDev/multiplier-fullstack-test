<script>
import AppBtnDelete from 'components/AppBtnDelete'

export default {
  name: 'ProductIndexPage',

  components: {
    AppBtnDelete
  },

  data () {
    return {
      loading: false,
      products: [],
      visibleColumns: ['name', 'category.name', 'price'],
      filter: null,
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
          name: 'category.name',
          label: 'Categoria',
          align: 'left',
          field: row => row.category.name,
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
          name: 'created_at',
          label: 'Criado',
          align: 'center',
          field: row => row.create_at,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'updated_at',
          label: 'Modificado',
          align: 'center',
          field: row => row.updated_at,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'actions',
          required: true,
          label: 'Ações',
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
        rowsPerPage: 15
      }
    }
  },

  watch: {
    '$route.path': function (val, oldVal) {
      if (val === '/produtos' && oldVal !== '/produtos') {
        this.getProducts()
      }
    }
  },

  mounted () {
    this.getProducts()
  },

  methods: {
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

    async deleteProduct (id) {
      this.loading = true

      await this.$axios.delete(`/v1/products/${id}`)
        .then(({ status }) => {
          if (status === 200) {
            this.getProducts()
          }
        })
        .catch(({ response }) => {
          this.$q.notify({
            type: 'negative',
            message: response.error
          })

          this.loading = false
        })
    }
  }
}
</script>

<template lang="pug">
  div(class="row q-py-xl")

    router-view

    q-card(
      bordered
      flat
      class="col-12"
    )
      q-card-section
        q-table(
          flat
          class="sticky-action-column"
          title="Produtos cadastrados"
          :columns="columns"
          :data="products"
          :filter="filter"
          :loading="loading"
          :pagination.sync="pagination"
          :visible-columns="visibleColumns"
        )

          template(#top-right)
            div(class="row q-gutter-md")
              q-input(
                dense
                outlined
                debounce="300"
                placeholder="Procurar"
                v-model="filter"
              )
                template(#append)
                  q-icon(name="mdi-magnify")
              q-select(
                dense
                emit-value
                map-options
                multiple
                outlined
                options-dense
                options-cover
                option-value="name"
                style="min-width: 150px"
                v-model="visibleColumns"
                :display-value="$q.lang.table.columns"
                :options="columns"
              )
              q-btn(
                no-caps
                unelevated
                color="teal"
                label="Adicionar"
                @click="$router.push('/produtos/add')"
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
                key="category.name"
                :props="props"
              )
                | {{ props.row.category.name }}
              q-td(
                key="price"
                :props="props"
              )
                | {{ props.row.price | formatPrice }}
              q-td(
                key="created_at"
                :props="props"
              )
                | {{ props.row.created_at | formatDate }}
              q-td(
                key="updated_at"
                :props="props"
              )
                | {{ props.row.updated_at | formatDate }}
              q-td(
                key="actions"
                :props="props"
              )
                div(class="q-gutter-sm")
                  q-btn(
                    dense
                    flat
                    color="indigo-14"
                    icon="mdi-square-edit-outline"
                    @click="$router.push(`/produtos/edit/${props.row.id}`)"
                  )
                  AppBtnDelete(
                    :delete-action="() => deleteProduct(props.row.id)"
                    :key="props.row.id"
                  )
</template>
