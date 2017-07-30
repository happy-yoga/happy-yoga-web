/* global window, customElements, HTMLElement, $ */

const preview = () => `<embed-form-preview></embed-form-preview>`

const bindDimensions = function bindDimensions (reference, element) {
  element
    .css('height', reference.css('height'))
    .css('width', reference.css('width'))
}

class PreviewTextArea extends HTMLElement {
  static get dimensionCheckInterval () { return 1000 }

  constructor (self) {
    self = super(self)
    this.dom = {}
  }

  connectedCallback () {
    this.root = $(this)
    this.textArea = this.root.find('textarea')
    this.preview = $(preview())

    this.bindPreviewDimensions()
    this.textArea.after(this.preview)
  }

  disconnetedCallback () {
    window.clearInterval(this.previewInterval)
  }

  bindPreviewDimensions () {
    bindDimensions(this.textArea, this.preview)

    this.previewInterval = setInterval(() =>
      bindDimensions(this.textArea, this.preview), PreviewTextArea.dimensionCheckInterval
    )
  }

  set root (root) {
    this.dom.root = root
  }

  get root () {
    return this.dom.root
  }

  set textArea (textArea) {
    this.dom.textArea = textArea
  }

  get textArea () {
    return this.dom.textArea
  }

  set preview (preview) {
    this.dom.preview = preview
  }

  get preview () {
    return this.dom.preview
  }
}

// define it in the CustomElementRegistry
customElements.define('preview-text-area', PreviewTextArea)
