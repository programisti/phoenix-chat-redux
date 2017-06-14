import React from 'react'
import { BrowserRouter, Switch, Route } from 'react-router-dom'
import { ChatContainer } from './chat/'

class Routes extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={ ChatContainer } />
        </Switch>
      </BrowserRouter>
    )
  }
}

export default Routes
