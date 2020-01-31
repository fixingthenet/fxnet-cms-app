<template>
  <lc-cell
    v-bind="cellProps"
    :key="config.id"
    :display="config.display"
    :draggable="editable && !contentEditable"
    @edit:content="editContent"
    @delete:content="$emit('delete:content')"
  >
    <div class="Figure" :style="style">
      <div
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
      </div>
    </div>
  </lc-cell>
</template>

<script>
export default {
  name: 'Figure',
  props: {
    // vue-layout-composer props
    initialConfig:      Object,
    editable:           Boolean,
    cellProps:          Object,

    // custom props
    text:               String,
    background:         String,
    fontFamily:         String,
    color:              String,
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
  computed: {
    style() {
      const { background, fontFamily, color } = this

      if (!background && !fontFamily && !color) return {}

      return {
        background,
        fontFamily,
        color,
      }
    }
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
.Figure {
  height: 100%;
  min-height: 50px;
  line-height: 50px;
  font-family: "Patrick Hand";
  color: #3096f3;
}

.Figure div {
  margin: 0;
  padding: 0 10px;
  width: 100%;
  box-sizing: border-box;
  font-size: 20px;
}
</style>
