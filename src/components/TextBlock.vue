<template>
  <lc-cell
    v-bind="cellProps"
    :key="config.id"
    :display="config.display"
    :draggable="editable && !contentEditable"
    @edit:content="editContent"
    @delete:content="$emit('delete:content')"
  >
    <div class="TextBlock">
      <p
        :contenteditable="contentEditable"
        @keydown.enter="updateText"
        @focusout="updateText"
        :draggable="contentEditable"
        @dragstart.prevent.stop
        @drag.prevent.stop
        @focus="onFocus"
        ref="text"
      >
        {{ internalText }}
      </p>
    </div>
  </lc-cell>
</template>

<script>
export default {
  name: 'TextBlock',
  props: {
    // vue-layout-composer props
    initialConfig:      Object,
    editable:           Boolean,
    cellProps:          Object,

    // custom props
    text:               String,
  },
  data() {
    return {
      internalText: this.text,
      config:       {},
      contentEditable:  false,
    }
  },
  created() {
    this.config = {
      ...this.initialConfig,
    }
  },
  watch: {
    internalText() {
      this.config.props.text = this.internalText
    },
  },
  methods: {
    getConfig() {
      return this.config
    },
    editContent() {
      this.contentEditable = true
      setTimeout(() => this.$refs.text.focus(), 0)
    },
    onFocus(event) {
      this.setEndOfContenteditable(event.target)
    },
    updateText(event) {
      this.internalText = event.target.textContent.trim()
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

<style scoped>
.TextBlock {
  height: 100%;
  min-height: 12px;
  line-height: 18px;
  padding: 10px;
  box-sizing: border-box;
}

p {
  margin: 10px 0;
  padding: 0;
  font-size: 20px;
  font-family: "Patrick Hand";
  color: #2196f3;
}
</style>
