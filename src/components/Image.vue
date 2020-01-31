<template>
  <lc-cell
    v-bind="cellProps"
    :key="config.id"
    :display="config.display"
    :draggable="editable && !contentEditable"
    @edit:content="contentEditable = true"
    @delete:content="$emit('delete:content')"
  >
    <div class="Image">
      <div v-if="contentEditable" class="Image__Form">
        <input type="text" v-model="internalUrl" autofocus />
        <button @click="updateUrl">Save</button>
      </div>
      <img :src="url" :draggable="false" />
    </div>
  </lc-cell>
</template>

<script>
export default {
  name: 'Image',
  props: {
    // vue-layout-composer props
    initialConfig:      Object,
    editable:           Boolean,
    cellProps:          Object,

    // custom props
    url:                String,
  },
  data() {
    return {
      internalUrl:      this.url,
      config:           {},
      contentEditable:  false,
    }
  },
  created() {
    this.config = {
      ...this.initialConfig,
    }
  },
  watch: {
    internalUrl() {
      this.config.props.url = this.internalUrl
    },
  },
  methods: {
    getConfig() {
      return this.config
    },
    updateUrl() {
      this.contentEditable = false
    },
  }
}
</script>

<style scoped>
.Image {
  height: 100%;
  min-height: 12px;
  box-sizing: border-box;
  border: 2px solid rgb(252, 228, 236);
  border-radius: 5px;
}

.Image__Form {
  display: flex;
  background: #fff;
  position: absolute;
  width: 100%;
  box-sizing: border-box;
}

.Image__Form input {
  flex-grow: 2;
}

img {
  margin: 0;
  padding: 0;
  width: 100%;
}
</style>
