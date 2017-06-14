import { combineReducers } from 'redux';

import messages from './messages';
import chats from './chats';

const rootReducer = combineReducers({
  chats,
  messages
});

export default rootReducer;
