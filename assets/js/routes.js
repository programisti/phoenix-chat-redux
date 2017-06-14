import React from 'react'
import { BrowserRouter, Switch, Route } from 'react-router-dom'
import { ChatContainer } from './chat/'
import { AgentContainer } from './agent/'

class Routes extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route exact path="/chat" component={ ChatContainer } />
          <Route exact path="/" component={ AgentContainer } />
        </Switch>
      </BrowserRouter>
    )
  }
}

export default Routes
