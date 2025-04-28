import React, { useEffect, useState } from 'react'


const Diccionario = (alerta) => {
    const [significado, setSignificado] = useState([])
    useEffect(() => {
        fetch(`${process.env.REACT_APP_API_URL}/wn/word/${alerta["alerta"]}`)
            .then(res => res.json())
            .then(res => {
                setSignificado(res.meanings)
            })

    },[alerta])
    return <div>
      <div className="alert alert-warning alert-dismissible fade show" role="alert">
        {significado.map((mean, idx) => {
            return <div key={idx}>
                        <div>
                            <strong>*{mean.definition}</strong>
                        </div> 
                        <ol>
                            {mean.examples.map((ex,idx) => <li key={idx}>{ex}</li>)}
                        </ol>
                        <p>
                            {mean.lemmas.map((lem,idx) => <span className="lemmas" key={idx}>{lem}</span>)}
                        </p>
                        <style>{`
                            .lemmas {
                                margin: 2px 2px;
                            }
                            `}</style>
                    </div>
        })}
        <button type="button" className="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </div>
}

export default Diccionario