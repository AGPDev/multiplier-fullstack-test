<script>
export default {
  name: 'AppDialog',

  props: {
    loading: {
      type: Boolean
    },
    title: {
      type: String,
      default: ''
    },
    value: {
      type: Boolean
    }
  },

  data () {
    return {
      activeLocal: this.value
    }
  },

  watch: {
    value (val) {
      this.activeLocal = val
    }
  }
}
</script>

<template lang="pug">
  q-dialog(
    persistent
    v-model="activeLocal"
    @hide="$emit('input', false)"
  )
    q-card(style="min-width: 400px")
      q-card-section(class="row items-center")
        div(class="text-h6")
          | {{ title }}
        q-space
        q-btn(
          dense
          flat
          round
          v-close-popup
          icon="mdi-close"
        )

      div(class="row")
        q-separator

      q-inner-loading(:showing="loading")
        q-spinner(
          color="orange-14"
          size="50px"
        )

      q-card-section
        slot
</template>
