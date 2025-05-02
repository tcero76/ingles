import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './theme.scss'
import App from './Layout/App.tsx'
import { BrowserRouter } from 'react-router'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </StrictMode>,
)
