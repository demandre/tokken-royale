<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header block">PERFORM VOTE FIGHT</h2>
        <div v-if="election['isCurrent']">
            <router-link :to="{ name: 'fight', params: { election: election }}">
                <button class="ui button red">FIGHT NOW</button>
            </router-link>
        </div>
        <div v-else>
            <p>Election is not current. You can't vote now.</p>
        </div>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'FightLauncher',
        props: {
            election: Array
        },

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        }
    }
</script>

<style></style>
