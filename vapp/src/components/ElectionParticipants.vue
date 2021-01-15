<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">ELECTION PARTICIPANTS</h2>
        <div class="ui grid doubling stackable center container">
            <div class="four wide column"
                 v-for="(participant, index) in this.election.participants"
                 v-bind:key="index"
                 :ref="`card_${index}`">
                <ParticipantCard v-bind:participant="participant" v-bind:index="index"/>
            </div>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'
    import ParticipantCard from "./ParticipantCard";

    export default {
        name: 'ElectionParticipants',
        components: {ParticipantCard},
        props: {
            election: Array
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        },
    }
</script>

<style></style>
