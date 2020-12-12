<script>
import AppDialog from 'components/AppDialog.vue'
import AppForm from 'components/AppForm.vue'
import AppInput from 'components/AppInput.vue'

const initFormData = {
  name: null,
  email: null,
  password: null
}

export default ({
  name: 'UserAddPage',

  components: {
    AppDialog,
    AppForm,
    AppInput
  },

  data () {
    return {
      dialog: true,
      formData: null,
      loading: false,
      showPassword: false
    }
  },

  created () {
    this.formData = Object.assign({}, initFormData)
  },

  methods: {
    async submit () {
      this.loading = true

      await this.$axios.post('/v1/users', this.formData)
        .then(({ status }) => {
          if (status === 200) {
            this.$q.notify({
              type: 'positive',
              message: 'Usuário adicionado com sucesso'
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
    title="Adicionar usuário"
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
        label="Senha"
        ref="input-password"
        validation-id="password"
        validation-rules="required|min:8"
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
          color="indigo-14"
          label="Salvar"
          type="submit"
          :loading="loading"
        )
</template>
