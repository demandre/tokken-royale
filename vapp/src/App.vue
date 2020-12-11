<template>
  <div id="app">
    <h1 class="ui block huge header">
      <router-link to="/">TOKKEN ROYALE</router-link>
    </h1>

    <div class="ui container">
      <router-view/>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'app'
  }
</script>
