<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">FIGHT</h2>
        <div class="ui grid two column centered">
            <div class="three column row">
                <div class="column">
                    <ParticipantCard v-if="currentFight !== false" v-bind:participant="currentFight.participant1" v-bind:index="0"/>
                    <br/>
                    <button v-if="currentFight !== false"
                            class="ui button blue centered huge"
                            @click="voteFight(currentFight.participant1, currentFight.participant2)">
                        {{currentFight.participant1.name}}
                    </button>
                </div>
                <div class=" column">
                    <img class="ui image" v-if="currentFight !== false" src="https://upload.wikimedia.org/wikipedia/commons/7/70/Street_Fighter_VS_logo.png" alt="VS">
                </div>
                <div class=" column">
                    <ParticipantCard v-if="currentFight !== false" v-bind:participant="currentFight.participant2" v-bind:index="1"/>
                    <br/>
                    <button v-if="currentFight !== false"
                            class="ui button blue centered huge"
                            @click="voteFight(currentFight.participant2, currentFight.participant1)">
                        {{currentFight.participant2.name}}
                    </button>
                </div>
                <button class="ui button blue huge centered" @click="generateFightsAndLaunchFirst()" v-if="currentFight === false && !finished">FIGHT !!!!!!</button>
                <button class="ui button blue huge centered" @click="sendVotes()" v-if="currentFight === false && finished">SEND MY VOTES</button>
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
            election: Object,
            participants: Array
        },

        data() {
            return {
                fights: [],
                currentFight: false,
                finished: false,
                votes: []
            }
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        },

        methods: {
            generateFightsAndLaunchFirst: function () {
                for (let i = 0; i < this.participants.length-1; i++) {
                    for (let j = i+1; j < this.participants.length; j++) {
                        this.fights.push({
                            participant1: this.participants[i],
                            participant2: this.participants[j],
                        })
                    }
                }

                this.launchNextFight();
            },
            launchNextFight: function() {
                let fight = this.fights.pop();
                if(typeof(fight) !== 'undefined') {
                    this.currentFight = fight;
                } else {
                    this.currentFight = false;
                    this.finished = true;
                }
            },
            voteFight: function (winner, loser) {
                this.votes.push({
                    winnerId: winner.name,
                    loserId: loser.name
                });
                this.launchNextFight();
            },
            sendVotes: function () {
                console.log(this.votes);
            }
        }
    }
</script>

<style></style>
