export function isAuthenticated (state, data) {
  if (!data) {
    state.token = null
  }

  state.isAuthenticated = data
}

export function token (state, data) {
  state.isAuthenticated = !!data

  state.token = data
}
