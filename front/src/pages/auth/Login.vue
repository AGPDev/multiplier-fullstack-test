<script>
import AppForm from 'components/AppForm.vue'
import AppInput from 'components/AppInput.vue'

export default {
  name: 'LoginPage',

  components: {
    AppForm,
    AppInput
  },

  data () {
    return {
      formData: null,
      loading: false,
      showPassword: false,
      redirect: '/'
    }
  },

  created () {
    this.redirect = this.$route.query.redirect || '/'

    if (this.$store.state.isAuthenticated) {
      this.$router.go(-1)
    }

    this.formData = Object.assign({}, {
      email: null,
      password: null
    })
  },

  methods: {
    async submit () {
      this.loading = true

      await this.$axios.post('/v1/auth/login', this.formData)
        .then(({ data, status }) => {
          if (status === 200) {
            this.$store.commit('token', data.access_token)

            this.$router.push(this.redirect)
          }
        })
        .catch(({ response }) => {
          if (response && response.data && response.data.error) {
            this.$q.notify({
              type: 'negative',
              message: 'Email ou senha incorreto.'
            })

            this.formData.password = null
            this.$refs.inputPassword.focus()
          }
        })

      this.loading = false
    }
  }
}
</script>

<template lang="pug">
  q-page(class="bg-dark")
    div(class="row window-height justify-center items-center")
      div(class="col-12 col-md-4 col-lg-4 col-xl-3 q-px-xs-lg q-px-sm-xl q-px-md-xl q-px-lg-xl q-px-xl-xl text-center")

        //- Logo
        div(class="q-pb-xl")
          img(
            width="300px"
            src="~assets/multiplier.svg"
          )

        //- Card with Form
        q-card(
          flat
          class="q-pa-xs-md q-pa-xl-lg"
        )
          q-card-section(class="justify-center text-h5 q-pb-md")
            | Identifique-se
          q-card-section
            AppForm(
              class="q-col-gutter-sm"
              ref="appForm"
              :submit-action="submit"
            )

              //- Email
              AppInput(
                autofocus
                autocomplete="email"
                label="Email"
                type="email"
                validation-id="email"
                validation-rules="required|email"
                v-model="formData.email"
                :disable="loading"
              )

              //- Password
              AppInput(
                autocomplete="current-password"
                label="Senha"
                ref="inputPassword"
                validation-id="password"
                validation-rules="required"
                v-model="formData.password"
                :disable="loading"
                :type="showPassword ? 'text' : 'password'"
              )
                template(v-slot:append)
                  q-icon(
                    class="cursor-pointer"
                    :name="showPassword ? 'mdi-eye-off' : 'mdi-eye'"
                    @click="showPassword = !showPassword"
                  )

              //- Submit Button
              div(class="row justify-center q-pt-md")
                q-btn(
                  push
                  color="primary full-width"
                  label="Login"
                  type="submit"
                  :loading="loading"
                )
</template>
