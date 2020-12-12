<script>
import AppBtnDelete from 'components/AppBtnDelete'

export default {
  name: 'CategoryIndexPage',

  components: {
    AppBtnDelete
  },

  data () {
    return {
      loading: false,
      categories: [],
      columns: [
        {
          name: 'id',
          required: true,
          label: 'Código',
          align: 'left',
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'name',
          required: true,
          label: 'Nome',
          align: 'left',
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'created_at',
          required: true,
          label: 'Criado',
          align: 'center',
          field: row => row.create_at,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: 'updated_at',
          required: true,
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
      if (val === '/categorias' && oldVal !== '/categorias') {
        this.getCategories()
      }
    }
  },

  mounted () {
    this.getCategories()
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

    async deleteCategory (id) {
      this.loading = true

      await this.$axios.delete(`/v1/categories/${id}`)
        .then(({ status }) => {
          if (status === 200) {
            this.getCategories()
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
          title="Categorias cadastradas"
          :columns="columns"
          :data="categories"
          :loading="loading"
          :pagination.sync="pagination"
        )

          template(#top-right)
            q-btn(
              no-caps
              color="teal"
              label="Adicionar"
              @click="$router.push('/categorias/add')"
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
                    @click="$router.push(`/categorias/edit/${props.row.id}`)"
                  )
                  AppBtnDelete(
                    :delete-action="() => deleteCategory(props.row.id)"
                    :key="props.row.id"
                  )
</template>
