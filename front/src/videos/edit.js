import React from 'react';
import ReactDom from 'react-dom';

class EditVideo extends React.Component {

  constructor() {
    super();
    this.state = {
      videoList: []
    };

    this.componentWillMount = this.componentWillMount.bind(this);
    this.upVideo = this.upVideo.bind(this);
    this.downVideo = this.downVideo.bind(this);
  }

  componentWillMount() {
    fetch('/api/videos/2', { credentials : 'include' }).then(response => {
      console.log(response.status);
      return response.json();
    }).then(json => {
      console.log('json:', json.data);
      this.setState({
        videoList: json.data
      });
    });
  }

  upVideo(e, i) {
    if (i === 0) {
      return;
    }
    let moveVideo = this.state.videoList[i];
    this.state.videoList.splice(i, 1, this.state.videoList[i-1]);
    this.state.videoList.splice(i-1, 1, moveVideo);
    this.setState({
      videoList: this.state.videoList
    });
  }

  downVideo(e, i) {
    if (this.state.videoList.length === i+1) {
      return;
    }
    let moveVideo = this.state.videoList[i];
    this.state.videoList.splice(i, 1, this.state.videoList[i+1]);
    this.state.videoList.splice(i+1, 1, moveVideo);
    this.setState({
      videoList: this.state.videoList
    });
  }

  render () {
    let videos = this.state.videoList.map((video, i) => {
      return (
          <tr key={i}>
            <td><img className="rounded edit-video-thumbnail" src={video.thumbnail}/></td>
            <td>{video.title}</td>
            <td><button className="btn btn-outline-secondary" onClick={(e) => this.upVideo(e, i)}><span className="oi oi-caret-top"/></button></td>
            <td><button className="btn btn-outline-secondary" onClick={(e) => this.downVideo(e, i)}><span className="oi oi-caret-bottom"/></button></td>
          </tr>
      )
    });

    return (
        <table className="table">
          <tbody>
          { videos }
          </tbody>
        </table>
    );
  }
}

ReactDom.render(<EditVideo/>, document.getElementById('edit-video-list'));