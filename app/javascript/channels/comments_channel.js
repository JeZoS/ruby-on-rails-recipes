import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('hit...................')
    var parser = new DOMParser()
    // console.log(typeof data)
    // console.log('hit...................')
    // $('#messages').prepend(data)
    const element = document.getElementById('messages')
    // element.prepend(data)
    // var node =  parser.parseFromString(data,'text/html')
    // console.log(node.body)
    element.prepend( parser.parseFromString(data,'text/html').body )
    // console.log(element)
  }
});
