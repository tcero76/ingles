import { useState, useLayoutEffect} from 'react'
import { getPalabra, putTestPalabra } from '../../http'
import { AxiosResponse } from 'axios'
import { AvisosStyle } from '../../model/types'
import { type GetPalabraResType, CategoriaEnum, ResultadoEnum, StatusEnum} from '../../model/httpModel'
import { useDialog } from '../../contexts/dialogContext'
import TextEditor from './TextEditor/TextEditor'
  const inicialWordState:GetPalabraResType = {
    palabra: {
        ID: 0,
        palabra: '',
        frase: '',
        significado: '',
        status: StatusEnum.PENDIENTE,
        level: 0,
        categoria: CategoriaEnum.VERBO_COMPUESTO,
        nfallos: 0,
        nintentos: 0
    },
    size:0,
    total:0
}
const TestPalabras = () => {
    const [word, setWord ] = useState<GetPalabraResType>(inicialWordState)
    const [hide, setHide] = useState<boolean>(true)
    const context = useDialog()
    useLayoutEffect(() => {
        getPalabra()
        .then((res:AxiosResponse<GetPalabraResType>) => {
              setWord(res.data)
        });
    },[])
    const onClickResultado = (resultado:ResultadoEnum) => {
        putTestPalabra({id:word.palabra.ID, resultado})
            .then((res:AxiosResponse<GetPalabraResType>) => {
                setWord(res.data)
                setHide(true)
                context?.showMsg({
                    msg: 'Datos enviados',
                    tipo: resultado ? AvisosStyle.INFO : AvisosStyle.ERROR
                })
            })
    }
    const onClickVer = () => {
        setHide(false)
    }
    return  <div className="card">
                <div className="card-header"><strong>Test Palabras: </strong><i>({word.size}:pendientes/{word.total}:total)</i></div>
                <div className="card-body">
                <h5 className="card-title"></h5>
                    <p className="card-text">Palabra: <b>{ word.palabra.ID === 0 ? '-' : word.palabra.palabra }</b><i>({word.palabra.nfallos}:fallos/{word.palabra.nintentos}:intentos)</i></p>
                    <p className="card-text">Frase: { hide ? 'oculto' :  word.palabra.frase }</p>
                    <p className="card-text">Significado: { hide ? 'oculto' :  word.palabra.significado }</p>
                    <div>
                        <button type="button" className="btn btn-primary mx-2" onClick={()=> onClickResultado(ResultadoEnum.EXITO)}>Recordada</button>
                        <button type="button" className="btn btn-danger mx-2" onClick={() => onClickResultado(ResultadoEnum.FALLO)}>Fallo</button>
                        <button type="button" className="btn btn-success mx-2" onClick={() => onClickVer()}>Ver</button>
                    </div>
                </div>
                <div className="card-body">
                <TextEditor/></div>
            </div>
}

export default TestPalabras