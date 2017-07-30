/* global window, customElements, HTMLElement, $, markdown */

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
    this.bindContentPreview()
    this.textArea.after(this.preview)
  }

  disconnectedCallback () {
    window.clearInterval(this.previewInterval)
    this.textArea.off(this.textAreaListeners)
  }

  bindPreviewDimensions () {
    bindDimensions(this.textArea, this.preview)

    this.previewInterval = setInterval(() =>
      bindDimensions(this.textArea, this.preview), PreviewTextArea.dimensionCheckInterval
    )
  }

  bindContentPreview () {
    this.preview.html(markdown.toHTML(this.textArea.val()))

    this.textArea.on(this.textAreaListeners, e => {
      this.preview.html(markdown.toHTML(this.textArea.val()))
    })
  }

  get textAreaListeners () {
    let memo

    if (memo) { return memo }

    memo = ['change', 'keyup', 'cut', 'paste'].join('.preview-text ')
    return memo
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
