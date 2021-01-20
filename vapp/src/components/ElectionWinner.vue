<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">ELECTION WINNER</h2>
        <div class="ui grid container">
            <div class="ui column">
                <ParticipantCard v-bind:participant="winner" v-bind:index="index"/>
            </div>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'
    import ParticipantCard from "./ParticipantCard";

    const args = {
        contractName: 'ElectionHelper',
        method: 'getElectionWinner',
        methodArgs: ''
    };

    export default {
        name: 'ElectionParticipants',
        components: {ParticipantCard},
        props: {
            election: Object
        },

        computed: {
            ...mapGetters('drizzle', ['drizzleInstance','isDrizzleInitialized']),
            ...mapGetters("contracts", ["getContractData"]),

            winner() {
                let winnerData =  this.getContractData({
                    contract: args.contractName,
                    method: args.method,
                    methodArgs: [this.election.id]
                });
                if(winnerData === "loading" || winnerData === "l" || winnerData === null || typeof winnerData === "undefined") {
                    return [];
                }
                let winner = {};
                winner.electionId = winnerData[0];
                winner.participantAddress = winnerData[1];
                winner.firstName = winnerData[2];
                winner.lastName = winnerData[3];
                winner.age = winnerData[4];
                winner.imageUrl = winnerData[5];
                winner.validated = winnerData[6];

                return winner;
            }
        },

        created() {
            this.$store.dispatch('drizzle/REGISTER_CONTRACT', {
                contractName: args.contractName,
                method: args.method,
                methodArgs: [this.election.id]
            });
        }
    }
</script>

<style></style>
