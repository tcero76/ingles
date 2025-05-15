import { FC } from 'react'
import { CategoriaEnum, type TableProps } from '../../model/httpModel'
const Table:FC<TableProps> = ({data} :TableProps) => {
    const renderRow = () => {
        return data?.map((d,idx) => {
            return (<tr key={idx}>
                        <th>{d.palabra}</th>
                        <td>{d.significado}</td>
                        <td>{d.frase}</td>
                        <th>{d.level}</th>
                        <th>{CategoriaEnum[d.categoria]}</th>
                    </tr>)
        })
    }
    const renderBody = () => {
        return (<tbody>
                    {renderRow()}
                </tbody>)
    }
    return (<table className="table mt-5">
        <thead>
        <tr>
            <th scope="col">Palabra</th>
            <th scope="col">Significado</th>
            <th scope="col">Frase</th>
            <th scope="col">Level</th>
            <th scope="col">Categoria</th>
            <th scope="col"></th>
        </tr>
        </thead>
        {renderBody()}
    </table>)
}

export default Table