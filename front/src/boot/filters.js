import Vue from 'vue'
import { date } from 'quasar'

Vue.filter('formatDate', function (val) {
  if (!val) {
    return ''
  }

  return date.formatDate(val, 'DD/MM/YYYY HH:mm')
})
