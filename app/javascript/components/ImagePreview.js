import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";

import Modal from 'react-modal';
import Icon from './Icon';

Modal.setAppElement('main');

class ImagePreview extends Component {

  componentWillMount = () => {
    this._bindKeyDownEvents();
  }

  _bindKeyDownEvents = () => {
    document.onkeydown = (e) => {
      switch (e.keyCode) {
        case 37:
          this.props.prev(e);
          break;
        case 39:
          this.props.next(e);
          break;
      }
    };
  }

  render () {
    const { image, isPopupMode } = this.props;

    return (
      <Fragment>
        <Modal
          isOpen={isPopupMode}
          onRequestClose={this.props.closeModal}
          shouldCloseOnOverlayClick={true}
          className={{
            base: 'b-modal',
            afterOpen: 'b-modal__open',
            beforeClose: 'b-modal__close'
          }}>
            <img src={image.preview} />
            <a href="#" className="b-modal__close" onClick={(e) => this.props.closeModal(e)}>
              <Icon name="ei-close" size="s" />
            </a>
            <a className="b-modal__prev" onClick={(e) => this.props.prev(e)}>
              <Icon name="ei-chevron-left" size="s" />
            </a>
            <a className="b-modal__next" onClick={(e) => this.props.next(e)}>
              <Icon name="ei-chevron-right" size="s" />
            </a>
        </Modal>
      </Fragment>
    );
  }
}

ImagePreview.propTypes = {
  image: PropTypes.object,
  isPopupMode: PropTypes.bool,
  prev: PropTypes.func,
  next: PropTypes.func,
  closeModal: PropTypes.func
};

export default ImagePreview
