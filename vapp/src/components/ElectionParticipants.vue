<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">ELECTION PARTICIPANTS</h2>
        <div class="ui grid doubling stackable center container">
            <div class="four wide column" v-for="participant in this.election.participants">
                <a class="ui card shadow">
                    <img class="ui image" v-bind:src="participant.avatar" v-bind:alt="participant.avatar">
                    <div class="content">
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
        }
    }
</script>

<style></style>
