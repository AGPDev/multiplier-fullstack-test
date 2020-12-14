<script>
import { ValidationProvider } from 'vee-validate'

export default {
  name: 'AppSelect',

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
    emitValue: {
      type: Boolean
    },
    label: {
      type: String,
      default: ''
    },
    loading: {
      type: Boolean
    },
    mapOptions: {
      type: Boolean
    },
    options: {
      type: Array,
      default: () => []
    },
    optionLabel: {
      type: String,
      default: 'label'
    },
    optionValue: {
      type: String,
      default: 'value'
    },
    outlined: {
      type: Boolean
    },
    useInput: {
      type: Boolean
    },
    value: {
      type: [
        Number,
        Object,
        String
      ],
      default: null
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

    refresh ([index]) {
      this.$refs.input.updateMenuPosition()
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
    q-select(
      bottom-slots
      no-error-icon
      ref="input"
      :autocomplete="autocomplete"
      :autofocus="autofocus"
      :bg-color="bgColor"
      :dense="dense"
      :disable="disable"
      :emit-value="emitValue"
      :error="failed"
      :error-message="errors && errors[0]"
      :input-class="inputClass"
      :label="label"
      :loading="loading"
      :map-options="mapOptions"
      :options="options"
      :option-label="optionLabel"
      :option-value="optionValue"
      :outlined="outlined"
      :success="passed"
      :use-input="useInput"
      :value="value"
      @input="v => $emit('input', v)"
    )
</template>
