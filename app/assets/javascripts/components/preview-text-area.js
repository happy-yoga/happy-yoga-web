/* global customElements, HTMLElement, $, SimpleMDE */

class PreviewTextArea extends HTMLElement {
  constructor (self) {
    self = super(self)
    this.dom = {}
  }

  connectedCallback () {
    this.root = $(this)
    this.textArea = this.root.find('textarea')
    this.mde = new SimpleMDE({
      element: this.textArea[0],
      spellChecker: false

    })
  }

  disconnetedCallback () {
  }

  set root (elem) {
    this.dom.root = elem
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
}

// define it in the CustomElementRegistry
customElements.define('preview-text-area', PreviewTextArea)
