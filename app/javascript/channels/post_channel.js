import consumer from "./consumer"
consumer.subscriptions.create({ channel: "PostChannel", room: "test" }, {
  connected() {
    console.log('[channel][post] connected');
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log('[channel][post] disconnected');
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log('[channel][post] received');
    // Called when there's incoming data on the websocket for this channel
  }
});
