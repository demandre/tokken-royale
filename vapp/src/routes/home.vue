<template>
  <div class="ui container" v-if="isDrizzleInitialized">
    <ElectionBrowser v-bind:elections="elections" />
    <br/>
    <ElectionSubmitter />
  </div>

  <div v-else class="ui active dimmer">
    <div class="ui text loader">Loading</div>
  </div>
</template>

<script>
  import ElectionBrowser from '../components/ElectionBrowser'
  import ElectionSubmitter from '../components/ElectionSubmitter'
  import { mapGetters } from 'vuex'

  export default {
    name: 'home',

    components: {
      ElectionBrowser,
      ElectionSubmitter
    },

    computed: {
      ...mapGetters('drizzle', ['isDrizzleInitialized']),
      elections: function() {
        return {
          0: {
            title: "Bob l'éponge et ses amis 1",
            previewPicture: "https://upload.wikimedia.org/wikipedia/fr/b/b8/Bob_l%27%C3%A9ponge_-_Logo.png",
            isOpen: true,
            isCurrent: false,
            participants: {
              0: {
                name: "Bob l'éponge",
                avatar: "https://i.pinimg.com/originals/bb/96/a8/bb96a8ccfc7807cdba75cc90260580a1.png"
              },
              1: {
                name: "Plankton",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/1/1f/Bob_l%27%C3%A9ponge_Plankton.png/revision/latest/scale-to-width-down/340?cb=20170310013607&path-prefix=fr"
              },
              2: {
                name: "Patrick",
                avatar: "https://img.discogs.com/XGSvq-099hah7y1SVfhVx3CnI20=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-5944638-1502980138-6120.jpeg.jpg"
              },
              3: {
                name: "M. Krabs",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/7/7b/Krabs_artwork.png/revision/latest?cb=20190725100918&path-prefix=fr"
              }
            }
          },
          1: {
            title: "Bob l'éponge et ses amis 2",
            previewPicture: "https://upload.wikimedia.org/wikipedia/fr/b/b8/Bob_l%27%C3%A9ponge_-_Logo.png",
            isOpen: false,
            isCurrent: true,
            participants: {
              0: {
                name: "Bob l'éponge",
                avatar: "https://i.pinimg.com/originals/bb/96/a8/bb96a8ccfc7807cdba75cc90260580a1.png"
              },
              1: {
                name: "Plankton",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/1/1f/Bob_l%27%C3%A9ponge_Plankton.png/revision/latest/scale-to-width-down/340?cb=20170310013607&path-prefix=fr"
              },
              2: {
                name: "Patrick",
                avatar: "https://img.discogs.com/XGSvq-099hah7y1SVfhVx3CnI20=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-5944638-1502980138-6120.jpeg.jpg"
              },
              3: {
                name: "M. Krabs",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/7/7b/Krabs_artwork.png/revision/latest?cb=20190725100918&path-prefix=fr"
              }
            }
          },
          2: {
            title: "Bob l'éponge et ses amis 3",
            previewPicture: "https://upload.wikimedia.org/wikipedia/fr/b/b8/Bob_l%27%C3%A9ponge_-_Logo.png",
            isOpen: true,
            isCurrent: true,
            participants: {
              0: {
                name: "Bob l'éponge",
                avatar: "https://i.pinimg.com/originals/bb/96/a8/bb96a8ccfc7807cdba75cc90260580a1.png"
              },
              1: {
                name: "Plankton",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/1/1f/Bob_l%27%C3%A9ponge_Plankton.png/revision/latest/scale-to-width-down/340?cb=20170310013607&path-prefix=fr"
              },
              2: {
                name: "Patrick",
                avatar: "https://img.discogs.com/XGSvq-099hah7y1SVfhVx3CnI20=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-5944638-1502980138-6120.jpeg.jpg"
              },
              3: {
                name: "M. Krabs",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/7/7b/Krabs_artwork.png/revision/latest?cb=20190725100918&path-prefix=fr"
              }
            }
          },
          3: {
            title: "Bob l'éponge et ses amis 4",
            previewPicture: "https://upload.wikimedia.org/wikipedia/fr/b/b8/Bob_l%27%C3%A9ponge_-_Logo.png",
            isOpen: true,
            isCurrent: false,
            participants: {
              0: {
                name: "Bob l'éponge",
                avatar: "https://i.pinimg.com/originals/bb/96/a8/bb96a8ccfc7807cdba75cc90260580a1.png"
              },
              1: {
                name: "Plankton",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/1/1f/Bob_l%27%C3%A9ponge_Plankton.png/revision/latest/scale-to-width-down/340?cb=20170310013607&path-prefix=fr"
              },
              2: {
                name: "Patrick",
                avatar: "https://img.discogs.com/XGSvq-099hah7y1SVfhVx3CnI20=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-5944638-1502980138-6120.jpeg.jpg"
              },
              3: {
                name: "M. Krabs",
                avatar: "https://vignette.wikia.nocookie.net/bob-leponge/images/7/7b/Krabs_artwork.png/revision/latest?cb=20190725100918&path-prefix=fr"
              }
            }
          }
        }
      }
    }
  }
</script>