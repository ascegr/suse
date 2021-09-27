import React, { useState } from 'react'

const UrlCopier = props => {
  const [hiddenClass, setHiddenClass] = useState('hidden')

  const updateClipboard = () => {
    navigator.clipboard.writeText(props.shortUrl).then(() => {
      setHiddenClass(null)
    })
  }

  return (
    <div className='relative'>
      <div className='sm:text-center'>
        <h2 className='text-xl md:text-3xl font-extrabold text-white tracking-tight sm:text-4xl'>
          Here is your generated URL
        </h2>
        <div className='mt-6 mx-auto max-w-3xl text-lg text-indigo-200 rounded-full bg-blue-700 p-4 md:p-4'>
          <span id='short-url' className='text-sm font-bold md:text-xl'>
            {props.shortUrl}
          </span>
          <button
            id='copy-url-button'
            className='display-block w-10 rounded p-2 ml-1 align-middle bg-blue-700 hover:bg-blue-900'
            onClick={updateClipboard}>
            <img src='/images/clipboard.svg' />
          </button>
        </div>
        <p className='flex flex-col p-4 items-center'>
          <span id='copied-text' className={`text-white align-center rounded ${hiddenClass ? hiddenClass : ''}`} >
            URL has been copied!
          </span>
        </p>
        <div className='flex flex-col items-center'>
          <button className='form-button md:w-max' onClick={props.cleanShortUrl}>Shorten another URL</button>
        </div>
      </div>
    </div >
  )
}

export default UrlCopier
