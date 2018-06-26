
var videoList = [];
[].forEach.call(document.getElementsByClassName('video-list'), function(element) {
    videoList[videoList.length] = {
        id: element.getAttribute('data-youtube-id'),
        playTime: element.getAttribute('data-play-time')
    };
});

var videoIndex = 0;
var startSeconds = 0;

init();

function init() {
  var date = new Date();
  var totalSeconds = date.getHours() * 3600 + date.getMinutes() * 60 + date.getSeconds();
  var totalPlayTime = 0;
  for (i=0; i < videoList.length; i++) {
      totalPlayTime += parseInt(videoList[i]['playTime']);
  }
  var startIndex = 0;
  var seconds = totalSeconds % totalPlayTime;
  for (i=0; i < videoList.length; i++) {
    if (seconds >= videoList[i]['playTime']) {
        seconds -= videoList[i]['playTime'];
        startIndex++;
    } else {
        break;
    }
  }
  videoIndex = startIndex;
  startSeconds = seconds;
}

var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var ytPlayer;
function onYouTubeIframeAPIReady() {
  console.log('Called onYouTubeIframeAPIReady()');
  ytPlayer = new YT.Player('video',
  {
    width: 640,
    height: 390,
    videoId: videoList[videoIndex]['id'],
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    },
    playerVars: {
      autoplay: 1,
      rel: 0
    }
  });
}

// 自動再生
function onPlayerReady(event) {
  console.log("index -> " + videoIndex + " seconds -> " + startSeconds);
  ytPlayer.seekTo(startSeconds);
  event.target.playVideo();
}

var playerStop = false;
function onPlayerStateChange(event) {
  var ytStatus = event.data;

  // 動画終了 次の動画を再生
  if (ytStatus === YT.PlayerState.ENDED) {
    console.log('再生終了');
    videoIndex++;
    videoIndex = videoIndex % videoList.length;
    event.target.loadVideoById(videoList[videoIndex]['id']);
  }

  if (ytStatus === YT.PlayerState.PLAYING) {
    if(playerStop) {
      console.log('再生中');
      init();
      ytPlayer.seekTo(startSeconds);
      playerStop = false;
    }
  }
  if (ytStatus === YT.PlayerState.PAUSED) {
    console.log('停止中');
    playerStop = true;
  }
}