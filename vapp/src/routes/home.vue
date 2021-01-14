<template>
  <div class="ui container" v-if="isDrizzleInitialized">
    <ElectionBrowser />
    <br/>
    <ElectionSubmitter />
  </div>

  <div v-else class="ui active dimmer">
    <div class="ui text loader">Loading</div>
  </div>
</template>

<script>
  import ElectionBrowser from '../components/ElectionBrowser'
  import ElectionSubmitter from '../components/ElectionSubmitter'
  import { mapGetters } from 'vuex'

  export default {
    name: 'home',

    components: {
      ElectionBrowser,
      ElectionSubmitter
    },

    computed: {
      ...mapGetters('drizzle', ['isDrizzleInitialized']),
    }
  }
</script>