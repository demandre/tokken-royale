<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <a class="ui card shadow" @mouseover="hoverCard(index)" @mouseout="hoverCard(-1)">
            <img class="ui image" v-show="!isSelected(index)" v-bind:src="participant.imageUrl" v-bind:alt="participant.lastName">
            <div class="ui container" v-show="isSelected(index)">
                <h4 class="ui header block">{{ participant.lastName }}</h4>
                <span class="ui justify black text" >Le lorem ipsum est, en imprimerie,
                    une suite de mots sans signification utilisée à titre
                    provisoire pour calibrer une mise en page, le texte
                    définitif venant remplacer le faux-texte dès qu'il
                    est prêt ou que la mise en page est achevée.
                    Généralement, on utilise un texte en faux latin,
                    le Lorem ipsum ou Lipsum.</span>
            </div>
            <div class="content" v-show="!isSelected(index)">
                <span class="ui label">{{ participant.lastName }}</span>
                <span class="ui label green" v-show="participant.validated">validated</span>
            </div>
        </a>
        <div class="content" v-show="!participant.validated">
            <button @click="validateParticipant" class="ui button green">Validate</button>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'ParticipantCard',
        props: {
            participant: Object,
            index: Number
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized', 'drizzleInstance']),
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
            },
            validateParticipant: function (e) {
                this.drizzleInstance
                    .contracts['ElectionHelper']
                    .methods['validateParticipant']
                    .cacheSend(
                        this.participant.electionId,
                        this.participant.participantAddress
                    );

                e.preventDefault();
            }
        }
    }
</script>

<style></style>
