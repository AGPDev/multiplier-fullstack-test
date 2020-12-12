<script>
import AppDialog from 'components/AppDialog.vue'
import AppForm from 'components/AppForm.vue'
import AppInput from 'components/AppInput.vue'

const initFormData = {
  name: null
}

export default ({
  name: 'CategoryEditPage',

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
      loading: false
    }
  },

  created () {
    this.currentId = this.$route.params.id
    this.getCategory()
  },

  methods: {
    async getCategory () {
      this.pageLoading = true

      await this.$axios.get(`/v1/categories/${this.currentId}`)
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

      await this.$axios.put(`/v1/categories/${this.currentId}`, this.formData)
        .then(({ status }) => {
          if (status === 200) {
            this.$q.notify({
              type: 'positive',
              message: 'Categoria alterada com sucesso'
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
    title="Editar categoria"
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
