import { JSX, ReactNode } from "react";

export const AvisosStyle = {
    INFO: {
        color: '#007aff',
        tituto: 'Aviso',
    },
    ERROR: {
        color: '#ff2300',
        tituto: 'Error',

    }
} as const

export type AvisoKeyType = keyof typeof AvisosStyle
export type AvisoValueType = (typeof AvisosStyle)[AvisoKeyType];

export type AvistoType = {
    tipo:AvisoValueType
    msg:string
}

export type ToastType = {
}

export type ToastRefType = {
    showMsg: (avisoVal:AvistoType) => void
}

export type PaginationProps = {
    totalPages:number
    page:number
    limit:number
    getDisplacement:(displacement:number, rows:number) => void
    getData:(page:number, rows:number) => void
}

export type ContextToastType = {
    showMsg:(msg:AvistoType) => void
    modalShow:(modalShow:ModalParams) => void
    modalHide:() => void
}

export type ModalProps = {
    children: ReactNode,
    onClickSave:() => void
    header:string
}

export type ModalType = {
    showModal:() => void
    hideModal:() => void
}

export type ModalParams = {
    contenido:JSX.Element
    onClickSave:() => void
    header:string
}

export type FormRef = {
    onClickForm:() => void
    initForm:() => void
}

export interface FormProps {}