<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">FIGHT</h2>
        <div class="ui grid two column centered">
            <div class="three column row">
                <div class="column">
                    <ParticipantCard v-if="currentFight" v-bind:participant="election.participants[0]" v-bind:index="0"/>
                    <br/>
                    <button class="ui button blue centered huge" @click="voteFight(election.participants[0])" v-if="currentFight">{{election.participants[0].name}}</button>
                </div>
                <div class=" column">
                    <img class="ui image" v-if="currentFight" src="https://upload.wikimedia.org/wikipedia/commons/7/70/Street_Fighter_VS_logo.png" alt="VS">
                </div>
                <div class=" column">
                    <ParticipantCard v-if="currentFight" v-bind:participant="election.participants[1]" v-bind:index="1"/>
                    <br/>
                    <button class="ui button blue huge" @click="voteFight(election.participants[0])" v-if="currentFight">{{election.participants[1].name}}</button>
                </div>
                <button class="ui button blue huge centered" @click="generateAndLaunchFight()" v-if="!currentFight && !finished">FIGHT !!!!!!</button>
                <button class="ui button blue huge centered" @click="sendVotes()" v-if="!currentFight && finished">SEND MY VOTES</button>
            </div>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'
    import ParticipantCard from "./ParticipantCard";

    export default {
        name: 'FightVoter',
        components: {ParticipantCard},
        props: {
            election: Object
        },

        data() {
            return {
                currentFight: false,
                finished: false,
                votes: {}
            }
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        },

        methods: {
            generateAndLaunchFight: function () {
                this.currentFight = "P1 vs P2";
            },
            sendVotes: function () {
                console.log(this.votes);
            },
            voteFight: function (winner) {
                this.votes[this.currentFight] =  winner;
                this.currentFight = false;
                this.finished = true;
            }
        }
    }
</script>

<style></style>
