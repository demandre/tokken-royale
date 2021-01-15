<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">ELECTIONS</h2>
        <div class="ui grid doubling stackable center container">
           <div class="four wide column"
                v-for="(election,index) in this.elections"
                v-bind:key="index">
               <router-link :to="{ name: 'election', params: { election: election }}">
                   <a class="ui card shadow">
                       <img class="ui image" v-bind:src="election.previewPicture" v-bind:alt="election.title">
                       <div class="content">
                           <span class="ui label">{{ election.title }}</span>
                       </div>
                   </a>
               </router-link>
           </div>
       </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex';

    const args = {
        contractName: 'ElectionHelper',
        method: 'getAllElections',
        methodArgs: ''
    };

    export default {
        name: 'ElectionBrowser',

        computed: {
            ...mapGetters('drizzle', ['drizzleInstance','isDrizzleInitialized']),
            ...mapGetters("contracts", ["getContractData"]),

            elections() {
                let electionsData =  this.getContractData({
                    contract: args.contractName,
                    method: args.method
                });
                if(electionsData === "loading") {
                    return [];
                }
                let elections = [];

                electionsData[0].forEach(function(electionData, index){
                    let election = [];
                    election["id"] = index;
                    election["title"] = electionData[0];
                    election["isRunning"] = electionData[1];
                    election["isOpen"] = electionData[2];
                    election["previewPicture"] = "https://upload.wikimedia.org/wikipedia/fr/b/b8/Bob_l%27%C3%A9ponge_-_Logo.png";

                    elections.push(election);
                });

                return elections;
            }
        },

        created() {
            this.$store.dispatch('drizzle/REGISTER_CONTRACT', args);
        }
    }
</script>

<style></style>
