<template>
  <div class="ui container" v-if="isDrizzleInitialized">
    <ElectionParticipants v-bind:election="election" />
    <br/>
    <ElectionVoteLauncher v-bind:election="election"  />
    <br/>
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
  import ElectionVoteLauncher from "../components/ElectionVoteLauncher";

  export default {
    name: 'election',

    components: {
      ElectionVoteLauncher,
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