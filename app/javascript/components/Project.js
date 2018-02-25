import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";

import Image from './Image';
import ImagePreview from "./ImagePreview";

class Project extends Component {

  constructor(props) {
    super(props);

    this.state = {
      project: {},
      isSelectMode: true,
      isDownloadMode: false,
      isPopupMode: false,
      popupImage: {},
      selected: [],
    }

    this.openModal = this._onOpenModal.bind(this);
    this.closeModal = this._onCloseModal.bind(this);
  }

  componentWillMount = () => {
    console.log('--- componentWillMount ---');

    this._loadProject(); 
  }

  _loadProject = () => {
    console.log('--- _loadProject ---');

    const { code } = this.props;
    const headers = {
      Accept: "application/json",
      "Content-Type": "application/json",
      "Cache-Control": "no-cache",
    };

    console.log(code);

    fetch(`/${code}.json`, {
      method: "GET",
      headers: headers,
    })
    .then(response => response.json())
    .then(data => this.setState({ 
      project: data, 
      selectLeft: data.download_count 
    }))
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

  _onPrev = (e) => {
    e.preventDefault();

    const { project, popupImage } = this.state;

    let idx = _.indexOf(project.images, popupImage);

    if (idx > 0) {
      this.setState({popupImage: project.images[idx - 1]});
    }
  }

  onNext = (e) => {
    e.preventDefault();

    const { project, popupImage } = this.state;

    let idx = _.indexOf(project.images, popupImage);

    if (idx + 1 < project.images.length) {
      this.setState({popupImage: project.images[idx + 1]});
    }
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

  _isSaveDisabled = () => {
    return Math.max(this.state.selected.length, this.state.project.selected) === 0;
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
      this.setState({isSelectMode: false, isDownloadMode: true});
      this._loadProject();
    })
    .catch(error => {
      console.log(error);
    });
  }

  render () {
    const { project, isSelectMode, isDownloadMode, isPopupMode, popupImage, selected, selectLeft } = this.state;
    
    return (
      <Fragment>
        { project.images ? (
          <div className="b-project">
            <div className="b-project__header">
              <div className="b-project__header-title">
                <h1>{project.title}</h1>
                { isSelectMode ? (
                  <div className="b-project__header-select">
                    <h2>Выберите фотографии для скачивания</h2>
                    <h2>Осталось <strong>{selectLeft}</strong> фото</h2>
                  </div>
                ) : (
                  <div className="b-project__header-download">
                    <h2>Нажмите на фото для загрузки</h2>
                  </div>
                )}
              </div>

              <div className="b-project__actions">
                { isSelectMode ? (
                  <button className="b-project__selection-save" disabled={this._isSaveDisabled()} onClick={(e) => this._onSave(e)}>
                    Скачать
                  </button>
                ) : (
                  <button className="b-project__selection-toggle" onClick={(e) => this._onSelectToggle(e)}>
                    Назад
                  </button>
                )}
              </div>
            </div>

            <div className="b-project__images">
              {project.images.map((image, index) => 
                <Image key={index} 
                       code={project.code}
                       image={image} 
                       selected={selected}
                       isSelectMode={isSelectMode} 
                       isDownloadMode={isDownloadMode}
                       onClick={() => this._onOpenModal(image)} 
                       onSelect={() => this._onSelect(image)}
                       onRemoveSelection={() => this._onRemoveSelection(image)} />
              )}
            </div>
          </div>
          ) : (
            <h1>Ничего не нашлось</h1>
        )}

        <ImagePreview image={popupImage} 
                      isPopupMode={isPopupMode} 
                      prev={(e) => this._onPrev(e)}
                      next={(e) => this.onNext(e)}
                      closeModal={(e) => this._onCloseModal(e)} />
      </Fragment>
    );
  }
}

Project.propTypes = {
  code: PropTypes.string
};

export default Project
