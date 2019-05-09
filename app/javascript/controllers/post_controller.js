// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import consumer from '../channels/consumer'

export default class extends Controller {
  static targets = [ "message", "commentList" ]

  consumer = null;

  initialize() {
    console.log('[post] initialized')
  }
  connect() {
    console.log('[post] connected')
    this.consumer = this.connectToActionCable()
  }

  disconnect() {
    if (this.consumer) {
      console.log('[post]disconnected => ', this.consumer)
      this.consumer.unsubscribe()
    }
  }

  onPostSuccess(event) {
    event.preventDefault()
    this.messageTarget.value = "";
  }

  onPostError (event) {
    console.log('event => ', event)
  }

  connectToActionCable() {
    const thisController = this
    // TODO: Get Post Id from template
    const SUBSCRIPTION = { channel: "PostChannel", room: window.location.pathname.replace('/posts/', '') }

    return consumer.subscriptions.create(SUBSCRIPTION, {
      connected() {
        console.log('[channel][post] connected');
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        console.log('[channel][post] disconnected');
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log('received => ', data)
        const { type, event, payload, html } = data;
        if (type === 'comment' && event === 'created') {
          thisController.commentListTarget.innerHTML += html;
        }
      }
    });
  }
}
