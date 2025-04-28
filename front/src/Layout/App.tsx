import { } from 'react'
import Header from './Header';
import { DialogProvider } from '../contexts/dialogContext';
import { Routes, Route } from 'react-router-dom';
import TestPalabras from '../components/TestPalabras/TestPalabras';
import AgregarPalabras from '../components/AgregarPalabras/AgregarPalabras';


function App() {
  return (<div>
            <Header/>
            <DialogProvider>
              <div className="container">
                  <Routes>
                    <Route path="/" element={<TestPalabras/>} />
                    <Route path="/form" element={<AgregarPalabras/>} />
                  </Routes>
              </div>
            </DialogProvider>
          </div>)
}

export default App
