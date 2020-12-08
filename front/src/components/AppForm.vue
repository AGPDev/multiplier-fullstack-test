<script>
import { ValidationObserver } from 'vee-validate'

export default {
  name: 'AppForm',

  components: {
    ValidationObserver
  },

  props: {
    submitAction: {
      type: Function,
      required: true
    }
  },

  methods: {
    reset () {
      this.$refs.validationObserver.reset()
    }
  }
}
</script>

<template lang="pug">
  ValidationObserver(
    slim
    ref="validationObserver"
    v-slot="{ handleSubmit }"
  )
    form(@submit.prevent="handleSubmit(submitAction)")
      slot
</template>
