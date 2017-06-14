import { configureChannel } from '../channel';

let socket = configureChannel();
let lobbyChannel = socket.channel('rooms:lobby');

export function sendMessage(body, user) {
  return dispatch => {
    let payload = {
      user: user,
      body: body
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

export function fetchMessages() {
  return dispatch => {
    dispatch({ type: 'FETCH_MESSAGES' });

    lobbyChannel.join()
      .receive('ok', messages => {
        console.warn('catching up', messages);
      })
      .receive('error', reason => {
        console.error('failed join', reason);
      })

    lobbyChannel.on('new:msg', message => {
      console.warn('new:msg', message);
      dispatch({ type: "ADD_MESSAGE", message});
    });
  };
}
