<script>
import AppDialog from 'components/AppDialog.vue'
import AppForm from 'components/AppForm.vue'
import AppInput from 'components/AppInput.vue'

const initFormData = {
  name: null,
  email: null,
  password: null,
  current_password: null
}

export default ({
  name: 'UserEditPage',

  components: {
    AppDialog,
    AppForm,
    AppInput
  },

  data () {
    return {
      currentId: null,
      dialog: true,
      formData: Object.assign({}, initFormData),
      loading: false,
      showPassword: false,
      showCurrentPassword: false
    }
  },

  created () {
    this.currentId = this.$route.params.id
    this.getUser()
  },

  methods: {
    async getUser () {
      this.pageLoading = true

      await this.$axios.get(`/v1/users/${this.currentId}`)
        .then(({ data, status }) => {
          if (status === 200) {
            this.formData = Object.assign(initFormData, data)
          }
        })
        .catch(({ response }) => {
          this.$q.notify({
            type: 'negative',
            message: response.data
          })
        })
        .finally(() => {
          this.pageLoading = false
        })
    },

    async submit () {
      this.loading = true

      await this.$axios.put(`/v1/users/${this.currentId}`, this.formData)
        .then(({ status }) => {
          if (status === 200) {
            this.$q.notify({
              type: 'positive',
              message: 'Usuário alterado com sucesso'
            })

            this.$router.push('/usuarios')
          }
        })
        .catch(({ response }) => {
          for (const field of Object.keys(response.data)) {
            this.$refs[`input-${field}`].setErrors(response.data[field])
          }
        })
        .finally(() => {
          this.loading = false
        })
    }
  }
})
</script>

<template lang="pug">
  AppDialog(
    title="Editar usuário"
    :value="dialog"
    @input="$router.push('/usuarios')"
  )
    AppForm(
      class="q-col-gutter-sm"
      :submit-action="submit"
    )

      //- Name
      AppInput(
        autocomplete="name"
        label="Nome"
        ref="input-name"
        validation-id="name"
        validation-rules="required"
        v-model="formData.name"
        :disable="loading"
      )

      //- Email
      AppInput(
        autocomplete="email"
        label="E-mail"
        ref="input-email"
        type="email"
        validation-id="email"
        validation-rules="required|email"
        v-model="formData.email"
        :disable="loading"
      )

      //- Password
      AppInput(
        autocomplete="new-password"
        label="Nova Senha"
        ref="input-password"
        validation-id="password"
        validation-rules="min:8"
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

      //- Current Password
      AppInput(
        autocomplete="password"
        label="Senha Atual"
        ref="input-password"
        validation-id="password"
        validation-rules="required|min:8"
        v-model="formData.current_password"
        :disable="loading"
        :type="showCurrentPassword ? 'text' : 'password'"
      )
        template(v-slot:append)
          q-icon(
            class="cursor-pointer"
            :name="showCurrentPassword ? 'mdi-eye-off' : 'mdi-eye'"
            @click="showCurrentPassword = !showCurrentPassword"
          )

      //- Submit Button
      div(class="row justify-center q-pt-md")
        q-btn(
          push
          color="indigo-14"
          label="Salvar"
          type="submit"
          :loading="loading"
        )
</template>
