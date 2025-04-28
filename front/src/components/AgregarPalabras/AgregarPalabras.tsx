import { useLayoutEffect, useState, useRef } from 'react'
import Form from './Form'
import Table from './Table'
import { getPage } from '../../http'
import { type FormRef } from '../../model/types'
import { type TablePageType } from '../../model/httpModel'
import Pagination from './Pagination'
import { useDialog } from '../../contexts/dialogContext'

const AgregarPalabras = () => {
    const [ tableState, setTableState ] = useState<TablePageType>({rows:[], page:1, limit:10, totalPages:0, totalRows: 0})
    const contextDialog = useDialog()
    const formRef = useRef<FormRef>({onClickForm:() => null, initForm:() => null})
    const getData = (page:number, rows:number) => {
        getPage(page, rows)
        .then(res => {
            setTableState(res.data)
        })
        .catch(res => {
            console.error(res);
        })
    }
    const getDisplacement = (displacement:number, rows:number) => {
        getData(tableState.page + displacement, rows)
    }
    useLayoutEffect(() => {
        getData(tableState?.page, tableState?.limit)
    },[])    
    const onClickShowModal = () => {
        const contenido = <Form ref={formRef}/>
        formRef.current.initForm()
        contextDialog?.modalShow({ 
            contenido, 
            onClickSave:() => formRef.current.onClickForm(),
            header:"Registro Palabras"
        })
    }
    return (
        <div>
            <h1>Registro Palabras</h1>
            <Table data={tableState.rows} />
            <Pagination totalPages={tableState.totalPages}
                page={tableState.page}
                getDisplacement={getDisplacement}
                getData={getData}
                limit={tableState.limit}
            />
            <button className='btn-primary btn' onClick={() => onClickShowModal()}>Agregar</button>
        </div>
    )
}

export default AgregarPalabras