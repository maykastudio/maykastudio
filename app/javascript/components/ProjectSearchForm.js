import React, { Component, Fragment } from "react";
// import classNames from 'react-classnames';
import PropTypes from "prop-types";

class ProjectSearchForm extends Component {

  constructor(props) {
    super(props);

    this.state = {
      code: null,
      isValid: true
    }
  }

  _onChange = (event) => {
    console.log(event.target.value);
    this.setState({code: event.target.value, isValid: true});
  }

  _onClick = (e) => {
    e.preventDefault();

    if (this.state.code) {
      window.location.href = `/projects/${this.state.code}`
    } else {
      this.setState({isValid: false})
    }
  }

  render () {
    return (
      <Fragment>
        <div className="b-code">
          <h1 className="b-code__form-title">У меня есть код</h1>
          <form className="b-code__form">
              <input className = {'b-code__form-input ' + (this.state.isValid ? 'is-valid' : 'is-error')} type="text" name="code" placeholder="Введите код" onChange={(e) => this._onChange(e)} />
              <button onClick={(e) => this._onClick(e)}>Перейти</button>
          </form>
        </div>
      </Fragment>
    );
  }
}

ProjectSearchForm.propTypes = {
  code: PropTypes.string
};

export default ProjectSearchForm
