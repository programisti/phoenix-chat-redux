import React, { Component } from 'react'

class Message extends Component {

  render() {
    return (
      <div className="row">
        <div className="col-sm-12">
          { this.props.messages.map((m, i) =>
            <p key={i}>{m.user} - {m.body}</p>
          )}
        </div>
      </div>
    );
  }
}

export default Message
