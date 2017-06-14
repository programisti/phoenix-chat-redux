import { configureChannel } from '../channel';

let socket = configureChannel();
let lobbyChannel = socket.channel('rooms:lobby');

export function fetchChats() {
  return dispatch => {
    dispatch({ type: 'FETCH_CHATS' });

    lobbyChannel.join()
      .receive('ok', response => {
        console.warn('joined success', response);
      })
      .receive('error', reason => {
        console.error('failed join', reason);
      })

    lobbyChannel.on('customer_entered', chat => {
      console.warn('customer_entered', chat);
      dispatch({ type: "ADD_CHAT", chat});
    });
  };
}

export function takeChat(chat_id) {
  return dispatch => {
    let payload = {
      chat_id: chat_id
    };

    lobbyChannel.push('rooms:lobby', payload)
      .receive('ok', response => {
        console.warn('message Sent', response);
      })
      .receive('error', error => {
        console.error('Error while sending messsage', error);
      });
  };
}
