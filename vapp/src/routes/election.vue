<template>
  <div class="ui container" v-if="isDrizzleInitialized">
    <ElectionParticipants v-bind:election="election" />
    <ParticipantSubmitter v-bind:election="election" />
  </div>

  <div v-else class="ui active dimmer">
    <div class="ui text loader">Loading</div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import ElectionParticipants from "../components/ElectionParticipants";
  import ParticipantSubmitter from "../components/ParticipantSubmitter";

  export default {
    name: 'election',

    components: {
      ElectionParticipants,
      ParticipantSubmitter
    },

    computed: {
      ...mapGetters('drizzle', ['isDrizzleInitialized']),

      election() {
        return this.$route.params.election
      }


    }
  }
</script>