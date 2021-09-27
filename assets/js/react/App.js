import React, { useState } from 'react'
import UrlForm from './components/UrlForm'
import UrlCopier from './components/UrlCopier'

const App = props => {
  const [formDisplayed, setFormDisplayed] = useState(true)
  const [shortUrl, setShortUrl] = useState('')

  const onShortUrlResponse = (url) => {
    setShortUrl(url)
  }

  const cleanShortUrl = () => {
    setShortUrl(null)
  }

  let content = <UrlForm setShortUrl={onShortUrlResponse} />

  if (shortUrl) {
    content = <UrlCopier cleanShortUrl={cleanShortUrl} shortUrl={shortUrl} />
  }

  return content
}

export default App
