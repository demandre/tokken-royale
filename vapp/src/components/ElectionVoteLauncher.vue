<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">PERFORM VOTE FIGHT</h2>
        <div v-if="election.isRunning">
            <router-link :to="{ name: 'fight', params: { election: election, participants: participants }}">
                <button class="ui button green">FIGHT NOW</button>
                <button class="ui button red" @click="stopElection">STOP ELECTION</button>
            </router-link>
        </div>
        <div v-else>
            <p>Election is not current. You can't vote now.</p>
            <button class="ui button red" @click="startElection">START ELECTION</button>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'ElectionVoteLauncher',
        props: {
            election: Object,
            participants: Array
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized', 'drizzleInstance']),
        },

        methods:{
            startElection: function (e) {
                this.drizzleInstance
                    .contracts['ElectionHelper']
                    .methods['startElection']
                    .cacheSend(
                        this.election.id,
                    );

                e.preventDefault();
            },

            stopElection: function (e) {
                this.drizzleInstance
                    .contracts['ElectionHelper']
                    .methods['stopElection']
                    .cacheSend(
                        this.election.id,
                    );

                e.preventDefault();
            }
        }
    }
</script>

<style></style>
