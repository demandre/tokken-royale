<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">SUBMIT NEW PARTICIPANT</h2>
        <div v-if="election.isOpen">
            <form class="ui form container">
                <div class="field">
                    <label>Participant name</label>
                    <input type="text" name="participant-name" placeholder="Participant name">
                </div>
                <div class="field">
                    <label>Participant avatar link</label>
                    <input type="text" name="participant-avatar-link" placeholder="Participant avatar link">
                </div>
                <button class="ui button" type="submit">Submit</button>
            </form>
        </div>
        <div v-else>
            <p>You can't participate anymore.</p>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'ParticipantSubmitter',
        props: {
            election: Object
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        }
    }
</script>

<style></style>
