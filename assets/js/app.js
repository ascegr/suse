// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

const copyUrlButton = document.querySelector("#copy-url-button")
const shortUrl = document.querySelector("#short-url")
const copiedText = document.querySelector("#copied-text")

const updateClipboard = (text) => {
  navigator.clipboard.writeText(text).then(() => {
    copiedText.classList.remove("hidden")
  }, (err) => {
    console.log(err)
  })
}

if (copyUrlButton) {
  copyUrlButton.addEventListener("click", () => {
    updateClipboard(shortUrl.innerText)
  })
}
