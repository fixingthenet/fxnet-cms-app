<template>
  <lc-cell
    v-bind="cellProps"
    :key="config.id"
    :display="config.display"
    :draggable="editable && !contentEditable"
    @edit:content="editContent"
    @delete:content="$emit('delete:content')"
  >
    <div class="Title">
      <h1
        :contenteditable="contentEditable"
        @keydown.enter="updateTitle"
        @focusout="updateTitle"
        :draggable="contentEditable"
        @dragstart.prevent.stop
        @drag.prevent.stop
        @focus="onFocus"
        ref="title"
      >
        {{ internalTitle }}
      </h1>
    </div>
  </lc-cell>
</template>

<script>
export default {
  name: 'Title',
  props: {
    // vue-layout-composer props
    initialConfig:      Object,
    editable:           Boolean,
    cellProps:          Object,

    // custom props
    title:              String,
  },
  data() {
    return {
      internalTitle:    this.title,
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
    internalTitle() {
      this.config.props.title = this.internalTitle
    },
  },
  methods: {
    getConfig() {
      return this.config
    },
    editContent() {
      this.contentEditable = true
      setTimeout(() => this.$refs.title.focus(), 0)
    },
    onFocus(event) {
      this.setEndOfContenteditable(event.target)
    },
    updateTitle(event) {
      this.internalTitle = event.target.textContent.trim()
      this.contentEditable = false
    },
    setEndOfContenteditable(contentEditableElement) {
      let range,selection;
      
      if(document.createRange) {
        range = document.createRange();
        range.selectNodeContents(contentEditableElement);
        range.collapse(false);
        selection = window.getSelection();
        selection.removeAllRanges();
        selection.addRange(range);
      } else if(document.selection) { 
        range = document.body.createTextRange();
        range.moveToElementText(contentEditableElement);
        range.collapse(false);
        range.select();
      }
    }
  }
}
</script>

<style scoped lang="scss">
.Title {
  height: 100%;
  min-height: 50px;
  line-height: 50px;
  box-sizing: border-box;
}

h1 {
  margin: 0;
  padding: 0;
  color: #2196f3;
  font-size: 35px;
  font-family: 'Crushed';
  font-weight: 400;
}

input {
  width: 100%;
  height: 30px;
  font-size: 20px;
}
</style>
