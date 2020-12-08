import ptBR from 'vee-validate/dist/locale/pt_BR.json'

import {
  extend,
  localize,
  setInteractionMode
} from 'vee-validate'

import {
  email,
  required,
  min
} from 'vee-validate/dist/rules'

extend('email', email)
extend('min', min)
extend('required', required)

localize('pt_BR', ptBR)

setInteractionMode('lazy')
