import { ForwardedRef, forwardRef, useEffect, useImperativeHandle } from 'react';
import * as bootstrap from 'bootstrap'
import {
  type ModalProps,
  type ModalType } from '../model/types';
let modal:bootstrap.Modal;
const Modal = forwardRef<ModalType,ModalProps>(({children, onClickSave, header}:ModalProps, ref: ForwardedRef<ModalType>) => {
    useEffect(() => {
        const modalElement = document.getElementById('idModal')!
        modal = bootstrap.Modal.getOrCreateInstance(modalElement)
    },[])
    useImperativeHandle(ref,() => ({
        showModal: () => {
          modal?.show()
        },
        hideModal: () => {
          modal?.hide()
        }
    }))
    return (<div id="idModal" className="modal">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title">{header}</h5>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div className="modal-body">
                {children}
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="button" className="btn btn-primary" onClick={() => onClickSave()}>Save changes</button>
            </div>
          </div>
        </div>
        
      </div>)
})

export default Modal