<template>
    <div v-if="isDrizzleInitialized">
        <h2 class="ui huge header">ELECTIONS</h2>
        <div class="ui grid doubling stackable center container">
           <div class="five wide column" v-for="election in this.elections">
               <a class="ui card shadow" href="">
                   <img class="ui image" v-bind:src="election.previewPicture" v-bind:alt="election.title">
                   <div class="content">
                       <span class="ui label">{{ election.title }}</span>
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
