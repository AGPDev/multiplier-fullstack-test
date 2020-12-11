<script>
export default ({
  name: 'AppBtnDelete',

  props: {
    deleteAction: {
      type: Function,
      default: () => {}
    }
  }
})
</script>

<template lang="pug">
  q-btn(
    dense
    flat
    color="negative"
    icon="mdi-delete"
  )
    q-menu(
      auto-close
      cover
      anchor="center middle"
    )
      div(
        class="row justify-center q-gutter-md q-pa-sm bg-warning"
        style="width: 280px"
      )
        div(class="text-h6")
          | Tem certeza disso?
        div
          q-btn(
            unelevated
            no-caps
            class="q-mr-sm"
            color="negative"
            label="Sim, excluir"
            @click="deleteAction"
          )
          q-btn(
            unelevated
            no-caps
            class="q-ml-sm"
            color="grey-8"
            label="Não, cancelar"
          )
</template>
