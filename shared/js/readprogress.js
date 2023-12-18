// Create HTML elements to show read progress bar.
window.onload = () => {
  const progress_container = document.createElement("div");
  progress_container.className = "progress-container";
  const progress_bar = document.createElement("div");
  progress_bar.className = "progress-bar";
  progress_bar.id = "read-bar";
  progress_container.appendChild(progress_bar);
  document.body.prepend(progress_container);
}

// When the user scrolls the page, update read progress.
window.onscroll = function() {updateReadProgress()};

function updateReadProgress() {
  var winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  var scrolled = (winScroll / height) * 100;
  document.getElementById("read-bar").style.width = scrolled + "%";
}
