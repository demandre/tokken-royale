<template>
  <div class="ui container" v-if="isDrizzleInitialized">
    <FightVoter v-bind:election="election" />
  </div>

  <div v-else class="ui active dimmer">
    <div class="ui text loader">Loading</div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import FightVoter from '../components/FightVoter'

  export default {
    name: 'election',

    components: {
      FightVoter
    },

    computed: {
      ...mapGetters('drizzle', ['isDrizzleInitialized']),

      election() {
        return this.$route.params.election
      }


    }
  }
</script>