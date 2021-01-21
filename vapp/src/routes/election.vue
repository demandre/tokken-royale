<template>
  <div class="ui container" v-if="isDrizzleInitialized">
    <div v-if="election.isRunning || election.isOpen">
      <ElectionParticipants v-bind:election="election"  v-on:participantsUpdated="updateParticipants"/>
      <br/>
      <ElectionVoteLauncher v-bind:election="election" v-bind:participants="participants" />
      <br />
      <ParticipantSubmitter v-bind:election="election" />
      <br />
      <VoterSubmitter v-bind:election="election" />
    </div>
    <div v-else>
      <ElectionWinner v-bind:election="election"/>
    </div>
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
  import ElectionWinner from "../components/ElectionWinner";
  import VoterSubmitter from "../components/VoterSubmitter";

  export default {
    name: 'election',

    data() {
      return {
        participantsArray: []
      }
    },

    components: {
      VoterSubmitter,
      ElectionVoteLauncher,
      ElectionParticipants,
      ParticipantSubmitter,
      ElectionWinner
    },

    computed: {
      ...mapGetters('drizzle', ['isDrizzleInitialized']),

      election() {
        return this.$route.params.election;
      },

      participants() {
        return this.participantsArray;
      }

    },

    methods: {
      updateParticipants(participants) {
        this.participantsArray = participants;
      }
    }
  }
</script>