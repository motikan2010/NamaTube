$(document).ready ->
  $('.message-div > div').scrollTop($('.message-div > div')[0].scrollHeight);
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
      $(".message-div > div").scrollTop($(".message-div > div")[0].scrollHeight);

# コメントの送信 Enter
$(document).on 'keypress', '[data-behavior~=room_message]', (event) ->
  if event.keyCode is 13
    if event.target.value isnt ''
      App.room.speak(event.target.value, $('#room_id').val())
      event.target.value = ''
    event.preventDefault()

# コメントの送信 ボタン
$('#comment_send').on 'click', () ->
  comment = $('#comment').val()
  if (comment isnt '')
    App.room.speak(comment, $('#room_id').val())
    $('#comment').val('')
