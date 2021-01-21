<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">SUBMIT NEW VOTER</h2>
        <div v-if="election.isOpen">
            <form class="ui form container">
                <div class="field">
                    <label>Voter address</label>
                    <input type="text" v-model="voterAddress" name="voterAddress" placeholder="Voter address">
                </div>
                <button class="ui button" @click.prevent="submitVoter">Submit</button>
            </form>
        </div>
        <div v-else>
            <p>You can't add voter anymore.</p>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'VoterSubmitter',
        props: {
            election: Object
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized', 'drizzleInstance', 'drizzleState']),
        },

        data() {
            return {
                voterAddress: null
            };
        },

        methods:{
            submitVoter: function (e) {
                this.drizzleInstance
                    .contracts['ElectionHelper']
                    .methods['addVoter']
                    .cacheSend(
                            this.election['id'],
                            this.voterAddress
                    );

                e.preventDefault();
            }
        }
    }
</script>

<style></style>
