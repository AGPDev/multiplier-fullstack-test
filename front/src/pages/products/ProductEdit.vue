<script>
import AppDialog from 'components/AppDialog.vue'
import AppForm from 'components/AppForm.vue'
import AppInput from 'components/AppInput.vue'
import AppSelect from 'components/AppSelect.vue'

const initFormData = {
  name: null,
  category_id: null,
  price: null
}

export default ({
  name: 'ProductEditPage',

  components: {
    AppDialog,
    AppForm,
    AppInput,
    AppSelect
  },

  data () {
    return {
      categories: [],
      dialog: true,
      formData: Object.assign({}, initFormData),
      loading: false
    }
  },

  created () {
    this.currentId = this.$route.params.id
    this.getProduct()
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

    async getProduct () {
      this.pageLoading = true

      await this.$axios.get(`/v1/products/${this.currentId}`)
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

      await this.$axios.put(`/v1/products/${this.currentId}`, this.formData)
        .then(({ status }) => {
          if (status === 200) {
            this.$q.notify({
              type: 'positive',
              message: 'Produto alterado com sucesso'
            })

            this.$router.push('/produtos')
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
    title="Editar produto"
    :value="dialog"
    @input="$router.push('/produtos')"
  )
    AppForm(
      class="q-col-gutter-sm"
      :submit-action="submit"
    )

      //- Name
      AppInput(
        label="Nome"
        ref="input-name"
        validation-id="name"
        validation-rules="required"
        v-model="formData.name"
        :disable="loading"
      )

      //- Category
      AppSelect(
        emit-value
        map-options
        label="Categoria"
        option-label="name"
        option-value="id"
        ref="input-category_id"
        validation-id="category_id"
        validation-rules="required"
        v-model="formData.category_id"
        :disable="loading"
        :options="categories"
      )

      //- Price
      AppInput(
        reverse-fill-mask
        fill-mask="0"
        input-class="text-right"
        label="Preço"
        mask="#.##"
        ref="input-price"
        validation-id="price"
        validation-rules="required"
        v-model="formData.price"
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
