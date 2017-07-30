/* global customElements, HTMLElement, $, fetch */

const resolveSelector = (html, selector) => {
  const wrapper = $('<div></div>').append($.parseHTML(html))
  return wrapper.find(selector)
}

class EmbedForm extends HTMLElement {
  constructor (self) {
    self = super(self)
    this.dom = {}
  }

  connectedCallback () {
    this.root = $(this)
    this.form = this.root.find('form')
    this.form.on('submit', (e) => {
      e.preventDefault()

      fetch(this.form.attr('action'), {
        method: this.form.attr('method') || 'GET',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: this.form.serialize(),
        credentials: 'include'
      })
        .then(res => res.text())
        .then(text => {
          const content = this.selector ? resolveSelector(text, this.selector) : text
          this.root.html(content)
        })
        .catch(e => {
          console.log(e)
        })
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

  set form (elem) {
    this.dom.form = elem
  }

  get form () {
    return this.dom.form
  }

  get selector () {
    return this.root.attr('selector')
  }
}

// define it in the CustomElementRegistry
customElements.define('embed-form', EmbedForm)
