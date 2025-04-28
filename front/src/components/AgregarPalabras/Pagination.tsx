import { FC } from 'react'
import { PaginationProps } from '../../model/types'

const Pagination:FC<PaginationProps> = ({totalPages, page, limit, getDisplacement, getData }) => {
    const renderNumbers = () => {
        const arr = Array.from({length: totalPages}, (_, index) => index + 1);
        return arr.map(p => {
            const active = p === page ? ' active' : ''
            return <li key={p} className="page-item"><button className={`page-link${active}`} onClick={() => getData(p, limit)}>{p}</button></li>
        })
    }
    return (
        <nav aria-label="Page navigation example">
            <ul className="pagination">
                <li className="page-item"><button className="page-link" onClick={() => getDisplacement(-1, limit)}>Previous</button></li>
                {renderNumbers()}
                <li className="page-item"><button className="page-link" onClick={() => getDisplacement(1, limit)}>Next</button></li>
            </ul>
        </nav>
    )
}

export default Pagination;