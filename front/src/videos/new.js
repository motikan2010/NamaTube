import React from 'react';
import ReactDom from 'react-dom';

class App extends React.Component {

  constructor() {
    super();
    this.state = {
      urlInputList: [0],
      index: 1
    };

    this.addUrlInput = this.addUrlInput.bind(this);
    this.removeUrlInput = this.removeUrlInput.bind(this);
  }

  // URLフォーム追加
  addUrlInput() {
    if (this.state.index > 10) {
      return;
    }
    this.setState({
      urlInputList: this.state.urlInputList.concat([this.state.index]),
      index: this.state.index + 1
    });
  }

  // URLフォーム削除
  removeUrlInput() {
    if (this.state.index <= 1) {
      return;
    }
    this.state.urlInputList.pop(); // 削除
    this.setState({
      urlInputList: this.state.urlInputList,
      index: this.state.index - 1
    });
    console.log(this.state.index);
    console.log(this.state.urlInputList);
  }

  render () {
    let urlInputList = this.state.urlInputList.map(function (i){
      return (
          <div key={i} className="form-group">
            <input type="text" className="form-control" name="video_url[]" placeholder="https://www.youtube.com/watch?v=XXXXXXXXXXX"/>
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