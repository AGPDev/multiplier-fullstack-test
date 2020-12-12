<script>
import AppDialog from 'components/AppDialog.vue'
import AppForm from 'components/AppForm.vue'
import AppInput from 'components/AppInput.vue'

const initFormData = {
  name: null
}

export default ({
  name: 'CategoryAddPage',

  components: {
    AppDialog,
    AppForm,
    AppInput
  },

  data () {
    return {
      dialog: true,
      formData: null,
      loading: false
    }
  },

  created () {
    this.formData = Object.assign({}, initFormData)
  },

  methods: {
    async submit () {
      this.loading = true

      await this.$axios.post('/v1/categories', this.formData)
        .then(({ status }) => {
          if (status === 200) {
            this.$q.notify({
              type: 'positive',
              message: 'Categoria adicionada com sucesso'
            })

            this.$router.push('/categorias')
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
    title="Adicionar categoria"
    :value="dialog"
    @input="$router.push('/categorias')"
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
