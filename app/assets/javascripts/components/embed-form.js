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
    this.initializeForm()
  }

  disconnetedCallback () {
  }

  initializeForm () {
    console.log('initialize Form')
    this.form = this.root.find('form')
    this.form.on('submit', (e) => {
      e.preventDefault()
      this.serializeForm()
    })
  }

  serializeForm (e) {
    const body = this.form.serialize()
    const method = this.form.attr('method') || 'GET'
    this.disableForm()

    return fetch(this.form.attr('action'), {
      method,
      body,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      credentials: 'include'
    })
      .then(res => res.text())
      .then(text => {
        const content = this.selector ? resolveSelector(text, this.selector) : text
        this.root.html(content)
      })
      .then(() => this.initializeForm())
      .catch(e => {
        this.enableForm()
        console.log(e)
      })
  }

  disableForm () {
    this.form.find(':input').prop('disabled', true)
  }

  enableForm () {
    this.form.find(':input').prop('disabled', false)
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
