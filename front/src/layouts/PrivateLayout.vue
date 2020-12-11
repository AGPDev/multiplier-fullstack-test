<script>
export default {
  name: 'PrivateLayout',

  data () {
    return {
      userName: null,
      tab: 'home',
      tabs: [
        {
          name: 'home',
          icon: 'mdi-home',
          label: 'Home',
          to: '/'
        },
        {
          name: 'pedidos',
          icon: 'mdi-cash-register',
          label: 'Pedidos',
          to: '/pedidos'
        },
        {
          name: 'categorias',
          icon: 'mdi-sitemap',
          label: 'Categorias',
          to: '/categorias'
        },
        {
          name: 'produtos',
          icon: 'mdi-package-variant-closed',
          label: 'Produtos',
          to: '/produtos'
        },
        {
          name: 'usuarios',
          icon: 'mdi-account',
          label: 'Usuários',
          to: '/usuarios'
        }
      ]
    }
  },

  created () {
    this.getUser()
  },

  methods: {
    async getUser () {
      return this.$axios.get('/v1/auth/me')
        .then(({ data, status }) => {
          if (status === 200) {
            this.userName = data.name
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
    },

    async logout () {
      return this.$axios.get('/v1/auth/logout')
        .then(({ data, status }) => {
          if (status === 200) {
            this.$store.commit('token', null)
            this.$router.push('/login')
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
    }
  }
}
</script>

<template lang="pug">
  q-layout(view="hHh LpR fFf")
    q-page-container(class="bg-grey-3")
      q-page(padding)
        div(class="row justify-center")
          div(class="col-12 col-md-10 col-lg-10 col-xl-8")
            q-toolbar(class="bg-indigo-14 text-white shadow-2 rounded-borders")
              q-tabs(
                inline-label
                no-caps
                v-model="tab"
              )
                q-route-tab(
                  v-for="tab in tabs"
                  :icon="tab.icon"
                  :key="`tab-${tab.name}`"
                  :label="tab.label"
                  :name="tab.name"
                  :to="tab.to"
                )

              q-space

              q-btn-dropdown(
                flat
                no-caps
                stretch
                :label="userName"
              )
                q-list
                  q-item(
                    clickable
                    v-close-popup
                    @click="logout"
                  )
                    q-item-section
                      q-item-label
                        | Sair

          div(class="col-12 col-md-10 col-lg-10 col-xl-8")
            router-view
</template>
