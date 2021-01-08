<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">ELECTION PARTICIPANTS</h2>
        <div class="ui grid doubling stackable center container">
            <div class="four wide column"
                 v-for="(participant, index) in this.election.participants"
                 v-bind:key="index"
                 :ref="`card_${index}`"
                 @mouseover="hoverCard(index)"
                 @mouseout="hoverCard(-1)">
                <a class="ui card shadow" @mouseover="hoverCard(index)" @mouseout="hoverCard(-1)">
                    <img class="ui image" v-show="!isSelected(index)" v-bind:src="participant.avatar" v-bind:alt="participant.avatar">
                    <div class="ui container" v-show="isSelected(index)">
                        <h4 class="ui header block">{{ participant.name }}</h4>
                        <span class="ui justify black text" >Le lorem ipsum est, en imprimerie,
                            une suite de mots sans signification utilisée à titre
                            provisoire pour calibrer une mise en page, le texte
                            définitif venant remplacer le faux-texte dès qu'il
                            est prêt ou que la mise en page est achevée.
                            Généralement, on utilise un texte en faux latin,
                            le Lorem ipsum ou Lipsum.</span>
                    </div>
                    <div class="content" v-show="!isSelected(index)">
                        <span class="ui label">{{ participant.name }}</span>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'ElectionParticipants',
        props: {
            election: Object
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        },

        data() {
            return {
                selectedCard: -1
            }
        },

        methods: {
            hoverCard(selectedIndex) {
                this.selectedCard = selectedIndex
            },
            isSelected (cardIndex) {
                return this.selectedCard === cardIndex
            }
        }
    }
</script>

<style></style>
