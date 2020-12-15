import ptBR from 'vee-validate/dist/locale/pt_BR.json'

import {
  extend,
  localize,
  setInteractionMode
} from 'vee-validate'

/* eslint camelcase: ["error", {ignoreImports: true}] */
import {
  email,
  min,
  min_value,
  max_value,
  required
} from 'vee-validate/dist/rules'

extend('email', email)
extend('min', min)
extend('min_value', min_value)
extend('max_value', max_value)
extend('required', required)

localize('pt_BR', ptBR)

setInteractionMode('lazy')
