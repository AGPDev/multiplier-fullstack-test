<script>
import AppBtnDelete from 'components/AppBtnDelete'

export default {
  name: 'OrderIndexPage',

  components: {
    AppBtnDelete
  },

  data () {
    return {
      loading: false,
      orders: [],
      filter: null,
      columns: [
        {
          name: 'id',
          label: 'Ordem',
          align: 'left',
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'qty_products',
          label: 'Items',
          align: 'left',
          field: row => row.qty_products,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'total',
          label: 'Total',
          align: 'left',
          field: row => row.total,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'created_at',
          label: 'Data da Venda',
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
        rowsPerPage: 15
      }
    }
  },

  watch: {
    '$route.path': function (val, oldVal) {
      if (val === '/pedidos' && oldVal !== '/pedidos') {
        this.getOrders()
      }
    }
  },

  mounted () {
    this.getOrders()
  },

  methods: {
    async getOrders () {
      this.loading = true

      await this.$axios.get('/v1/orders')
        .then(({ data, status }) => {
          if (status === 200) {
            this.orders = data
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

    async deleteOrder (id) {
      this.loading = true

      await this.$axios.delete(`/v1/orders/${id}`)
        .then(({ status }) => {
          if (status === 200) {
            this.getOrders()
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

    q-card(
      bordered
      flat
      class="col-12"
    )
      q-card-section
        q-table(
          flat
          class="sticky-action-column"
          title="Pedidos"
          :columns="columns"
          :data="orders"
          :filter="filter"
          :loading="loading"
          :pagination.sync="pagination"
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
              q-btn(
                no-caps
                unelevated
                color="teal"
                label="Adicionar"
                @click="$router.push('/pedidos/carrinho')"
              )

          template(#header="props")
            q-tr(:props="props")
              q-th(auto-width)
              q-th(
                v-for="col in props.cols"
                :key="col.name"
                :props="props"
              )
                | {{ col.label }}

          template(#body="props")
            q-tr(:props="props")
              q-td(auto-width)
                q-btn(
                  dense
                  round
                  unelevated
                  color="indigo-14"
                  size="sm"
                  :icon="props.expand ? 'mdi-close' : 'mdi-details'"
                  @click="props.expand = !props.expand"
                )
              q-td(
                key="id"
                :props="props"
              )
                | {{ props.row.id }}
              q-td(
                key="qty_products"
                :props="props"
              )
                | {{ props.row.qty_products }}
              q-td(
                key="total"
                :props="props"
              )
                | {{ props.row.total | formatPrice }}
              q-td(
                key="created_at"
                :props="props"
              )
                | {{ props.row.created_at | formatDate }}
              q-td(
                key="action"
                :props="props"
              )
                div(class="q-gutter-sm")
                  AppBtnDelete(
                    :delete-action="() => deleteOrder(props.row.id)"
                    :key="props.row.id"
                  )
            q-tr(
              v-show="props.expand"
              :props="props"
            )
              q-td(colspan="100%")
                q-list
                  q-item(
                    v-for="product in JSON.parse(props.row.products)"
                    :key="product.id"
                  )
                    q-item-section(avatar)
                      | {{ product.quantity }}
                    q-item-section
                      | {{ product.name }}
                    q-item-section(side)
                      | {{ product.price | formatPrice }}

</template>
