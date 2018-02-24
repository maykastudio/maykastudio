import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";

import Icon from './Icon';

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
    const { code, image, isSelectMode, isDownloadMode } = this.props;

    return (
      <Fragment>
        { isSelectMode && (
          <div className="b-image__item">
            <a className="b-image__item-link b-image__item-link__preview" href="#" onClick={(e) => this._onClick(e)}>
              <img src={image.url} />
            </a>
            <input type="checkbox" 
                   className="b-image__item-input" 
                   id={image.id} 
                   checked={this._isSelected()}
                   onChange={(e) => this._onSelect(e)} />
            <label className="b-image__item-label" htmlFor={image.id}>
              <span className={'b-image__check ' + (this._isSelected() ? 'is-selected' : 'stub')}></span>
            </label>
          </div>
        )} 
        
        { !isSelectMode && image.download && (
          <a className="b-image__item is-selected" href={`${image.download}`} download>
            <img src={image.url} />
          </a>
        )}
      </Fragment>
    );
  }
}

Image.propTypes = {
  code: PropTypes.string,
  image: PropTypes.object,
  selected: PropTypes.array,
  isSelectMode: PropTypes.bool,
  onSelect: PropTypes.func
};

export default Image
