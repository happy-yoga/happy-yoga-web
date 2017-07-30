/* global customElements, HTMLElement */

class EmbedForm extends HTMLElement {
  constructor (self) {
    self = super(self)
  }

  connectedCallback () {
  }

  disconnetedCallback () {
  }
}

// define it in the CustomElementRegistry
customElements.define('embed-form', EmbedForm)
