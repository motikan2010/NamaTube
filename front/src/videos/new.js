import React from 'react';
import ReactDom from 'react-dom';

class App extends React.Component {

  errorList; // エラーメッセージ格納先

  constructor() {
    super();
    let ele = document.getElementById('video_url_list');
    let videoUrlList = (ele !== null) ? JSON.parse(ele.getAttribute('data-json')) : [""];
    this.state = {
      videoUrlList: videoUrlList
    };

    this.componentWillMount = this.componentWillMount.bind(this);
    this.addUrlInput = this.addUrlInput.bind(this);
    this.removeUrlInput = this.removeUrlInput.bind(this);
    this.changeVideoUrl = this.changeVideoUrl.bind(this);
  }

  componentWillMount() {
    // エラーメッセージの格納
    let ele = document.getElementById('video_error_list');
    let videoErrorList = (ele !== null) ? JSON.parse(ele.getAttribute('data-json')) : [""];
    this.errorList = [];
    for (let i=0; i < videoErrorList.length; i++) {
      this.errorList[videoErrorList[i]['index']] = videoErrorList[i]['msg'];
    }
  }

  // URLフォーム追加
  addUrlInput() {
    if (this.state.videoUrlList.length > 10) {
      return;
    }
    this.setState({
      videoUrlList: this.state.videoUrlList.concat([""])
    });
  }

  // URLフォーム削除
  removeUrlInput() {
    if (this.state.videoUrlList.length <= 1) {
      return;
    }
    this.state.videoUrlList.pop(); // 削除
    this.setState({
      videoUrlList: this.state.videoUrlList
    });
  }

  changeVideoUrl(id, e) {
    this.errorList[id] = ''; // エラーメッセージを消す

    const videoUrlList = this.state.videoUrlList.slice();
    videoUrlList[id] = e.target.value;
    this.setState({
      videoUrlList: videoUrlList
    });
  }

  render () {
    let urlInputList = this.state.videoUrlList.map((videoUrl, i) => {
      return (
          <div key={i} className="form-group">
            <label className="error-msg">{this.errorList[i]}</label>
            <input type="text" className="form-control" name="video_url[]" value={videoUrl}
                   onChange={e => this.changeVideoUrl(i, e)} placeholder="https://www.youtube.com/watch?v=XXXXXXXXXXX"/>
          </div>
      )
    });

    return (
        <div>
          <label>Video URL</label>
          <div>{urlInputList}</div>
          <div className="row">
            <div className="col-md-6">
              <button type="button" className="btn btn-info" onClick={this.addUrlInput}>＋</button>
              <button type="button" className="btn btn-danger offset-md-1" onClick={this.removeUrlInput}>ー</button>
            </div>
            <div className="col-md-6">
              <div className="text-right">
                <button type="submit" className="btn btn-primary">Confirm</button>
              </div>
            </div>
          </div>
        </div>
    );
  }
}

ReactDom.render(<App/>, document.getElementById('new-url-input'));