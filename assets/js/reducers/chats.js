export default function(state = [], action) {
  switch(action.type) {
    case 'FETCH_CHATS': {
      return state
    }
    case 'ADD_CHAT': {
      console.warn('add chat', action)
      return [...state, action.chat]
    }
    default:
      return state
  }
}
