import { createContext, useRef, FC, ReactNode, useContext, useState } from "react";
import {
    type ModalType,
    type AvistoType,
    type ToastRefType,
    type ContextToastType,
    ModalParams } from "../model/types";
import Toast from './Toast'
import Modal from './Modal'

const DialogContext = createContext<ContextToastType | undefined>(undefined);

export const DialogProvider:FC<{ children: ReactNode }> = ({children}) => {
    const toastRef = useRef<ToastRefType>(null)
    const modalRef = useRef<ModalType>(null)
    const [modalShowParam, setModalShowParam ] = useState<ModalParams>({contenido:<div/>, onClickSave:() => null, header:''})
    const showMsg = (msg:AvistoType) => {
        toastRef.current?.showMsg(msg)
    }
    const modalShow = (modalShow:ModalParams) => {
        modalRef.current?.showModal()
        setModalShowParam(modalShow);
    }
    const modalHide = () => {
        modalRef.current?.hideModal()
    }
    return (<DialogContext.Provider value={{ showMsg, modalShow, modalHide }}>
                <Toast ref={toastRef}/>
                <Modal ref={modalRef}
                    header={modalShowParam.header}
                    onClickSave={modalShowParam.onClickSave}>
                    {modalShowParam.contenido}
                </Modal>
                {children}
            </DialogContext.Provider>)
}

export const useDialog = (): ContextToastType | undefined => {
    const context = useContext(DialogContext);
    if (!context) throw new Error("useToast debe usarse dentro de un DialogProvider");
    return context;
};