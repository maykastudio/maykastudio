import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";

import Modal from 'react-modal';
import Image from './Image';
import Icon from './Icon';

Modal.setAppElement('main');

class Project extends Component {

  constructor(props) {
    super(props);

    this.state = {
      project: {},
      isSelectMode: false,
      isPopupMode: false,
      popupImage: {},
      selected: [],
    }

    this.openModal = this._onOpenModal.bind(this);
    this.closeModal = this._onCloseModal.bind(this);
  }

  componentWillMount = () => {
    this._loadProject(); 
  }

  _loadProject = () => {
    const { code } = this.props;
    const headers = {
      Accept: "application/json",
      "Content-Type": "application/json",
    };

    fetch(`/${code}.json`, {
      method: "GET",
      headers: headers,
    })
    .then(response => response.json())
    .then(data => this.setState({ project: data, selectLeft: data.download_count }))
    .catch(error => {
      console.log(error);
    }); 
  }

  _onSelectToggle = (e) => {
    e.preventDefault();
    
    this.setState({
      selected: [],
      isSelectMode: !this.state.isSelectMode, 
      selectLeft: this.state.project.download_count,
    });
  }

  _onOpenModal = (image) => {
    this.setState({isPopupMode: true, popupImage: image});
  }

  _onCloseModal = (e) => {
    e.preventDefault();
    this.setState({isPopupMode: false});
  }

  _onSelect = (image) => {
    const { selected, selectLeft } = this.state;
    let images = selected;

    if (selectLeft > 0) {
      if (!_.includes(images, image.id)) {
        images.push(image.id)
      }

      this.setState({selected: images, selectLeft: selectLeft - 1});
    } else {
      this.setState({selected: images});
    }
  }

  _onRemoveSelection = (image) => {
    const { selected, selectLeft } = this.state;
    let images = selected;

    const index = images.indexOf(image.id);

    if (index >= 0) {
      images.splice(index, 1);

      this.setState({ selected: images, selectLeft: selectLeft + 1 });
    } else {
      this.setState({selected: images});
    }
  }

  _onSave = (e) => {
    e.preventDefault()

    const { code } = this.props;
    const { selected } = this.state;

    const headers = {
      Accept: "application/json",
      "Content-Type": "application/json",
    };

    fetch(`/${code}/select`, {
      method: "POST",
      headers: headers,
      body: JSON.stringify({project: { images: selected }})
    })
    .then(response => {
      response.json();
      this.setState({isSelectMode: false});
      this._loadProject();
    })
    .catch(error => {
      console.log(error);
    });
  }

  render () {
    const { project, isSelectMode, isPopupMode, popupImage, selected, selectLeft } = this.state;
    
    return (
      <Fragment>
        { project.images ? (
          <div className="b-project">
            <div className="b-project__header">
              <div className="b-project__header-title">
                <h1>{project.title}</h1>
                { isSelectMode && (
                  <h2>Осталось выбрать {selectLeft}</h2>
                )}
              </div>

              <div className="b-project__actions">
                <button className="b-project__selection-toggle" disabled={selectLeft < 1 && !isSelectMode} onClick={(e) => this._onSelectToggle(e)}>
                  { isSelectMode ? (
                    <span>Отмена</span>
                  ) : (
                    <span>Выбрать</span>
                  )}
                </button>
                { isSelectMode && (
                  <button className="b-project__selection-save" onClick={(e) => this._onSave(e)}>
                    Сохранить
                  </button>
                )}
              </div>
            </div>

            <div className="b-project__images">
              {project.images.map((image, index) => 
                <Image key={index} 
                       image={image} 
                       selected={selected}
                       isSelectMode={isSelectMode} 
                       onClick={() => this._onOpenModal(image)} 
                       onSelect={() => this._onSelect(image)}
                       onRemoveSelection={() => this._onRemoveSelection(image)} />
              )}
            </div>
          </div>
          ) : (
            <h1>Ничего не нашлось</h1>
        )}

        <Modal
          isOpen={isPopupMode}
          onRequestClose={this.closeModal}
          shouldCloseOnOverlayClick={true}
          className={{
            base: 'b-modal',
            afterOpen: 'b-modal__open',
            beforeClose: 'b-modal__close'
          }}>
            <a href="#" className="b-modal__close" onClick={(e) => this.closeModal(e)}>
              <Icon name="ei-close" size="s" />
            </a>
            <img src={popupImage.preview} />
        </Modal>
      </Fragment>
    );
  }
}

Project.propTypes = {
  code: PropTypes.string
};

export default Project
