export default function(state = [], action) {
  switch(action.type) {
    case 'FETCH_MESSAGES': {
      console.warn('FETCH MESSAGES ACTIONS')
      return state
    }
    case 'ADD_MESSAGE': {
      console.warn('addmessage action', action)
      return [...state, action.message]
    }
    default:
      return state
  }
}
