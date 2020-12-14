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
    filled: {
      type: Boolean
    },
    fillMask: {
      type: String
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
    mask: {
      type: String
    },
    reverseFillMask: {
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
      :filled="filled"
      :fill-mask="fillMask"
      :input-class="inputClass"
      :label="label"
      :loading="loading"
      :mask="mask"
      :outlined="outlined"
      :reverse-fill-mask="reverseFillMask"
      :success="passed"
      :type="type"
      :value="value"
      @input="v => $emit('input', v)"
    )
      slot

      template(#append)
        slot(name="append")
</template>
