import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { chatActions } from '../actions/'
import { Message } from './'

class ChatContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      user: "",
      body: ""
    }
    this.sendMessage = this.sendMessage.bind(this)
    this.handleUser = this.handleUser.bind(this)
    this.handleBody = this.handleBody.bind(this)
  }

  componentDidMount() {
    this.props.fetchMessages()
  }

  handleUser(event) {
    this.setState({user: event.target.value});
  }

  handleBody(event) {
    this.setState({body: event.target.value});
  }

  sendMessage() {
    this.props.sendMessage(this.state.body, this.state.user)
  }

  render() {
    const { messages } = this.props

    return (
      <div className="row">
        <Message messages={messages} />

        <div className="row">
          <div className="col-sm-2">
            <div className="input-group">
              <span className="input-group-addon">@</span>
              <input
                id="username"
                type="text"
                className="form-control"
                placeholder="username"
                value={this.state.user}
                onChange={this.handleUser}
              />
            </div>
          </div>
          <div className="col-sm-8">
            <input
              id="message-input"
              className="form-control"
              value={this.state.body}
              onChange={this.handleBody}
            />
          </div>
          <div className="col-sm-2">
            <button
             className="btn btn-block btn-lg btn-primary"
             onClick={() => this.sendMessage()}
            >Send</button>
          </div>
        </div>

      </div>
    );
  }
}

ChatContainer = connect(
  ({ messages }) => ({ messages }),
  dispatch => bindActionCreators(Object.assign({}, chatActions), dispatch)
)(ChatContainer)

export default ChatContainer
