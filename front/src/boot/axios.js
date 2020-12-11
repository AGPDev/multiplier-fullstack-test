import Vue from 'vue'
import axios from 'axios'
import { Loading } from 'quasar'

export default ({ store }) => {
  axios.defaults.timeout = 5000
  axios.defaults.baseURL = '/api'

  axios.interceptors.request.use(function (config) {
    const token = store.state.token

    if (token) {
      config.headers.common.Authorization = 'Bearer ' + token
    }

    // Do something before request is sent
    return config
  }, function (error) {
    return Promise.reject(error)
  })

  axios.interceptors.response.use(function (config) {
    // Do something before request is sent
    return config
  }, function (error) {
    if (error.response.status === 401) {
      store.commit('isAuthenticated', false)
    }

    if (error.response.status === 504) {
      Loading.show({
        backgroundColor: 'red-14',
        message: 'API offline, aguarde um instante e tente novamente.',
        spinnerColor: 'white'
      })

      setTimeout(() => {
        Loading.hide()
      }, 5000)
    } else {
      return Promise.reject(error)
    }
  })

  Vue.prototype.$axios = axios
}
