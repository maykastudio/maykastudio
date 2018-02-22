import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";

class Image extends Component {

  _isSelected = () => {
    const { image, selected } = this.props;

    return _.includes(selected, image.id) || image.selected;
  }

  _onSelect = (e) => {
    if (e.target.checked) {
      this.props.onSelect(e.target.id);
    } else {
      this.props.onRemoveSelection(e.target.id);
    }
  }

  _onClick = (e) => {
    e.preventDefault();
    this.props.onClick();
  }

  render () {
    const { image, isSelectMode } = this.props;

    return (
      <Fragment>
        { isSelectMode ? (
          <div className="b-image__item">
            <input type="checkbox" 
                   className="b-image__item-input" 
                   id={image.id} 
                   checked={this._isSelected()}
                   onChange={(e) => this._onSelect(e)} />
            <label className="b-image__item-label" htmlFor={image.id}>
              <img src={image.url} />
              <span className="b-image__number">{image.position}</span>
            </label>
          </div>
        ) : (
          <div className={'b-image__item ' + (image.selected ? 'is-selected' : 'stub')}>
            <a className="b-image__item-link" href="#" onClick={(e) => this._onClick(e)}>
              <img src={image.url} />
            </a>
          </div>
        )}
      </Fragment>
    );
  }
}

Image.propTypes = {
  image: PropTypes.object,
  isSelectMode: PropTypes.bool,
  onSelect: PropTypes.func
};

export default Image
