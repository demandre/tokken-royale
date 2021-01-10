<template>
  <div class="ui container" v-if="isDrizzleInitialized">
    test
  </div>

  <div v-else class="ui active dimmer">
    <div class="ui text loader">Loading</div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'election',

    components: {
    },

    computed: {
      ...mapGetters('drizzle', ['isDrizzleInitialized']),

      election() {
        return this.$route.params.election
      }


    }
  }
</script>