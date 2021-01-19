<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">ELECTION PARTICIPANTS</h2>
        <div class="ui grid doubling stackable center container">
            <div class="four wide column"
                 v-for="(participant, index) in this.participants"
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

    const args = {
        contractName: 'ElectionHelper',
        method: 'getAllElectionParticipant',
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

            participants() {
                let participantsData =  this.getContractData({
                    contract: args.contractName,
                    method: args.method,
                    methodArgs: [this.election.id]
                });
                if(participantsData === "loading" || participantsData === "l" || participantsData === null || typeof participantsData === "undefined") {
                    return [];
                }
                let participants = [];

                participantsData.forEach(function(participantData){
                    let participant = {};
                    participant.electionId = participantData[0];
                    participant.participantAddress = participantData[1];
                    participant.firstName = participantData[2];
                    participant.lastName = participantData[3];
                    participant.age = participantData[4];
                    participant.imageUrl = participantData[5];
                    participant.validated = participantData[6];

                    participants.push(participant);
                });

                this.$emit('participantsUpdated', participants);

                return participants;
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
