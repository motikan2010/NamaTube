$(document).ready ->
  $(".message-div").scrollTop($(".message-div")[0].scrollHeight);
  messages = $('#messages')
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: messages.data('room_id') },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    speak: (message)->
      @perform('speak', message: message)

    received: (data) ->
      $('#messages').append(data['message'])
      # コメント欄末尾にスクロール
      $(".message-div").scrollTop($(".message-div")[0].scrollHeight);

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    App.room.speak(event.target.value, $('#room_id').val())
    event.target.value = ''
    event.preventDefault()