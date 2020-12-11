<template>
    <div v-if="isDrizzleInitialized" class="ui container">
        <h2 class="ui huge header">SUBMIT NEW ELECTION</h2>
        <form class="ui form">
            <div class="field">
                <label>Election title</label>
                <input type="text" name="election-title" placeholder="Election title">
            </div>
            <div class="field">
                <label>Election preview picture link</label>
                <input type="text" name="election-preview-picture" placeholder="Election preview picture">
            </div>
            <button class="ui button" type="submit">Submit</button>
        </form>
    </div>

    <div v-else>Loading...</div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        name: 'ElectionSubmitter',

        computed: {
            ...mapGetters('drizzle', ['isDrizzleInitialized']),
        }
    }
</script>

<style></style>
