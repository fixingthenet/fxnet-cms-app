<template>
  <div id="app">

    <layout-composer
      :displayComponents="displayComponents"
      :config="internalConfig"
      @change:config="onConfigChange"
    />
  </div>
</template>

<script>
import 'vue-layout-composer/dist/vue-layout-composer.css'
import config from '../../config/layout.json'
//var config = {}

import Title from '../components/Title'
import TextBlock from '../components/TextBlock'
import Image from '../components/Image'
import Figure from '../components/Figure'

export default {
  name: 'DefaultLayout',
  data () {
    return {
      displayComponents: {
        'Title':      Title,
        'TextBlock':  TextBlock,
        'Image':      Image,
        'Figure':     Figure,
      },
    }
  },
  methods: {
    onConfigChange(newConfig) {
      console.log(newConfig)
    },
  },
  computed: {
    internalConfig() {
      //return this.config && JSON.parse(this.config.content)
      return config
    },
  },
}
</script>
