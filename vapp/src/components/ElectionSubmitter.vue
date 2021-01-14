<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">SUBMIT NEW ELECTION</h2>
        <form class="ui form container">
            <div class="field">
                <label>Election title</label>
                <input v-model="electionTitle" type="text" name="electionTitle" placeholder="Election title">
            </div>
            <div class="field">
                <label>Election preview picture link</label>
                <input v-model="electionPreviewPicture" type="text" name="electionPreviewPicture" placeholder="Election preview picture">
            </div>
            <button class="ui button" type="submit" @click.prevent="submitElection">Submit</button>
        </form>
    </div>
    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'ElectionSubmitter',

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized', 'drizzleInstance']),
        },

        data() {
            return {
                electionTitle: null,
                electionPreviewPicture: null
            };
        },

        methods:{
            submitElection: function (e) {
                this.drizzleInstance
                    .contracts['ElectionHelper']
                    .methods['addElection']
                    .cacheSend(this.electionTitle);

                e.preventDefault();
            }
        }
    }
</script>

<style></style>
