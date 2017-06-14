import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { deskActions } from '../actions/'

class AgentContainer extends Component {
  componentDidMount() {
    this.props.fetchChats()
  }

  render() {
    console.log(this.props.chats)
    return (
      <div className="row">
        <div className="table-responsive">
          <div className="panel panel-success">
            <div className="panel-heading">Lobby</div>
            <table className="table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Customer</th>
                  <th>Start Chat</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td>Mark</td>
                  <td>@mdo</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    );
  }
}

AgentContainer = connect(
  ({ chats }) => ({ chats }),
  dispatch => bindActionCreators(Object.assign({}, deskActions), dispatch)
)(AgentContainer)

export default AgentContainer
