import React, { Component } from 'react'
import { Field, reduxForm } from 'redux-form'

let Form = ( props ) => {
  const { handleSubmit } = this.props
  return (
    <div className="row">
      <form onSubmit={handleSubmit}>
        <div className="col-sm-10">
          <div className="input-group">
            <Field
              name="text"
              className="form-control"
              component="input"
              type="text"
              placeholder="Say hello to customer"
            />
          </div>
        </div>
        <div className="col-sm-2">
          <button
           className="btn btn-block btn-lg btn-primary"
           type="submit"
          >Send</button>
        </div>
      </form>
    </div>
  );
}

Form = reduxForm({
  form: 'chatForm'
})(Form)

export default Form
