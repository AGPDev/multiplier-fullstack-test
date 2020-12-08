<script >
export default {
  name: 'Error404'
}
</script>

<template lang="pug">
  q-page
    div(class="absolute-center text-center")
      p
        img(
          src="~assets/sad.svg"
          style="width:30vw;max-width:150px;"
        )

      p(class="text-faded")
        | Ops, página não encontrada...<strong>(404)</strong>

      q-btn(
        color="blue-14"
        label="Voltar"
        style="width:200px;"
        @click="$router.go(-1)"
      )
</template>
