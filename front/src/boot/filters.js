import Vue from 'vue'
import { date } from 'quasar'

Vue.filter('formatDate', function (val) {
  if (!val) {
    return ''
  }

  return date.formatDate(val, 'DD/MM/YYYY HH:mm')
})

Vue.filter('formatPrice', function (val) {
  if (!val) {
    return ''
  }

  return parseFloat(val).toLocaleString('pt-br', { style: 'currency', currency: 'BRL' })
})

Vue.filter('truncate', function (text, stop, clamp) {
  if (text && text.length > stop) {
    return text.slice(0, stop) + (stop < text.length ? clamp || '...' : '')
  } else {
    return text
  }
})
