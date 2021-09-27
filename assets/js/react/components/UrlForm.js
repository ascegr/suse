import React, { useState } from 'react'

const UrlForm = props => {
  let errorCode = null
  const [url, setUrl] = useState('')
  const [error, setError] = useState('')

  const submitForm = (event) => {
    event.preventDefault()
    if (!url) setError('Please enter a URL')

    const fetchParams = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ long_url: url })
    }

    fetch('/api/urls', fetchParams)
      .then(response => response.json())
      .then(data => {
        if (data.status === "error") {
          setError(data.error)
        } else {
          props.setShortUrl(data.url)
        }
      }).catch(whatever => console.log(whatever))

  }

  const changeUrl = (event) => {
    setError('')
    setUrl(event.target.value)
  }

  if (error) {
    errorCode = (
      <div className="mx-auto max-w-3xl bg-blue-100 rounded p-4 mt-2 text-sm text-red-500">
        {error}
      </div>
    )
  }

  return (
    <div>
      <div className='relative'>
        <div className='sm:text-center'>
          <h2 className='text-3xl font-extrabold text-white tracking-tight sm:text-4xl'>
            Welcome to Super URL Shortener Exercise (SUSE)!
          </h2>
          <p className='mt-6 mx-auto max-w-3xl text-lg text-indigo-200'>
            Enter a valid URL below, starting with http:// or https:// to get a short url using our service.
          </p>
        </div>
        <form onSubmit={submitForm} className='mt-12 sm:mx-auto sm:max-w-3xl sm:flex'>
          <div className='min-w-0 flex-1'>
            <label htmlFor='long_url' className='sr-only'>Long URL</label>
            <input onChange={changeUrl} value={url} type='text' id='long_url' className='form-input' placeholder='http(s)://' />
          </div>
          <div className='mt-4 sm:mt-0 sm:ml-3'>
            <button className='form-button'>Shorten URL</button>
          </div>
        </form>
      </div>
      {errorCode}
    </div>
  )
}

export default UrlForm
