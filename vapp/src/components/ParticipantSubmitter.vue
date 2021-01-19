<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">SUBMIT NEW PARTICIPANT</h2>
        <div v-if="election.isOpen">
            <form class="ui form container">
                <div class="field">
                    <label>Participant name</label>
                    <input type="text" v-model="firstName" name="firstName" placeholder="Participant first name">
                </div>
                <div class="field">
                    <input type="text" v-model="lastName" name="lastName" placeholder="Participant last name">
                </div>
                <div class="field">
                    <label>Participant age</label>
                    <input type="number" v-model="age" name="age" placeholder="21">
                </div>
                <div class="field">
                    <label>Participant avatar url</label>
                    <input type="text" v-model="avatarUrl" name="avatarUrl" placeholder="Participant avatar url">
                </div>
                <button class="ui button" @click.prevent="submitParticipant">Submit</button>
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
            ...mapGetters('drizzle', ['isDrizzleInitialized', 'drizzleInstance', 'drizzleState']),
        },

        data() {
            return {
                firstName: null,
                lastName: null,
                age: null,
                avatarUrl: null
            };
        },

        methods:{
            submitParticipant: function (e) {
                //let accountAddress = this.drizzleInstance.store.getState().accounts[0];
                /** TODO : fix adding to participant map in contract **/
                this.drizzleInstance
                    .contracts['ElectionHelper']
                    .methods['participateInElection']
                    .cacheSend(
                            this.election['id'],
                            this.firstName,
                            this.lastName,
                            this.age,
                            this.avatarUrl
                    );

                e.preventDefault();
            }
        }
    }
</script>

<style></style>
