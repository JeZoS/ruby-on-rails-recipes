import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // console.log(data)
    var parser = new DOMParser()
    var element = document.getElementById('messages')
    element.append( parser.parseFromString(data.message,'text/html').body )
  }
});
