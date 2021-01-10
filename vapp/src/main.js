import Vue from 'vue'
import App from './App.vue'
import Vuex from 'vuex'
import VueRouter from 'vue-router'

// Todo: Update this when publishing
// import drizzleVuePlugin from '@drizzle/vue-plugin'
//
import drizzleVuePlugin from '@drizzle/vue-plugin'
import drizzleOptions from './drizzleOptions'

Vue.use(Vuex)
const store = new Vuex.Store({ state: {} })

Vue.use(drizzleVuePlugin, { store, drizzleOptions })

// Routers
Vue.use(VueRouter);
import home from './routes/home'
import election from './routes/election'
import fight from './routes/fight'
const routes = [
  { name: 'home', path:'/', component: home },
  { name: 'election', path:'/election', component: election },
  { name: 'fight', path:'/fight', component: fight }
];
const router = new VueRouter({
  routes // short for `routes: routes`
});


Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
