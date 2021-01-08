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
    import { mapGetters } from 'vuex'

    export default {
        name: 'ElectionBrowser',
        props: {
            elections: Object
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        }
    }
</script>

<style></style>
