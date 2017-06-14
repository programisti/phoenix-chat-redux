import React, { Component } from 'react'
import { Message, Form } from './'

let ChatContainer = ( props ) => {
  const { messages, sendMessage } = props

  return (
    <div className="row">
      <Message messages={messages} />
      <Form handleSubmit={this.sendMessage}/>
    </div>
  );
}

export default ChatContainer
