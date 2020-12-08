<script>
import { ValidationProvider } from 'vee-validate'

export default {
  name: 'AppInput',

  components: {
    ValidationProvider
  },

  props: {
    autocomplete: {
      type: String,
      default: undefined
    },
    autofocus: {
      type: Boolean
    },
    bgColor: {
      type: String,
      default: undefined
    },
    dense: {
      type: Boolean
    },
    disable: {
      type: Boolean
    },
    inputClass: {
      type: String,
      default: undefined
    },
    label: {
      type: String,
      default: undefined
    },
    loading: {
      type: Boolean
    },
    outlined: {
      type: Boolean
    },
    type: {
      type: String,
      default: 'text'
    },
    value: {
      type: [
        Number,
        String
      ],
      default: undefined
    },

    /* ------------------------ */
    /*        Validation        */
    /* ------------------------ */
    validationId: {
      type: String,
      default: ''
    },
    validationName: {
      type: String,
      default: ' '
    },
    validationRules: {
      type: String,
      default: ''
    }
  },

  methods: {
    focus () {
      setTimeout(() => {
        this.$refs.input.focus()
      }, 200)
    },

    setErrors (error) {
      if (typeof error === 'string') {
        error = [error]
      }

      this.$refs.validationProvider.setErrors(error)
    }
  }
}
</script>

<template lang="pug">
  ValidationProvider(
    slim
    ref="validationProvider"
    v-slot="{ errors, failed, passed }"
    :name="validationName"
    :rules="validationRules"
    :vid="validationId"
  )
    q-input(
      bottom-slots
      no-error-icon
      ref="input"
      :autocomplete="autocomplete"
      :autofocus="autofocus"
      :bg-color="bgColor"
      :dense="dense"
      :disable="disable"
      :error="failed"
      :error-message="errors && errors[0]"
      :input-class="inputClass"
      :label="label"
      :loading="loading"
      :outlined="outlined"
      :success="passed"
      :type="type"
      :value="value"
      @input="v => $emit('input', v)"
    )
      slot

      template(v-slot:append)
        slot(name="append")
</template>
