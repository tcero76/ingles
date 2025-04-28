import { useEffect, useState, FC } from 'react'
import { getWord } from '../../../http'
import { DiccionarioProps, MeaningsType, WordNetType } from '../../../model/httpModel' 
import { AxiosResponse } from 'axios'

const Diccionario:FC<DiccionarioProps> = ({ word }:DiccionarioProps) => {
    const [means, setMeans] = useState<MeaningsType[]>()
    useEffect(() => {
        getWord(word)
            .then((res:AxiosResponse<WordNetType>) => {
                setMeans(res.data.meanings)
            })
    },[word])
    return <div>
      <div className="alert alert-warning alert-dismissible fade show" role="alert">
        {means?.map((mean, idx) => {
            return <div key={idx}>
                        <div>
                            <strong>*{mean.definition}</strong>
                        </div> 
                        <ol>
                            {mean.examples.map((ex,idx) => <li key={idx}>{ex}</li>)}
                        </ol>
                        <p>
                            {mean.lemas?.map((lem,idx) => <span className="lemmas" key={idx}>{lem}</span>)}
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