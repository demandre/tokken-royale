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
                electionPreviewPicture: 'https://static.lexpress.fr/medias_11460/w_1751,h_980,c_crop,x_263,y_0/w_480,h_270,c_fill,g_north/v1492978859/emmanuel-macron-g-battrait-largement-marine-le-pen-d-au-second-tour-de-l-election-presidentielle-selon-deux-sondages-realises-dimanche-soir-apres-l-annonce-des-resultats-du-1er-tour_5867591.jpg'
            };
        },

        methods:{
            submitElection: function (e) {
                this.drizzleInstance
                    .contracts['ElectionHelper']
                    .methods['addElection']
                    .cacheSend(
                        this.electionTitle,
                        this.electionPreviewPicture
                    );

                e.preventDefault();
            }
        }
    }
</script>

<style></style>
