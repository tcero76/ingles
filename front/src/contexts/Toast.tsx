import { ForwardedRef, forwardRef, useEffect, useImperativeHandle, useState } from 'react'
import * as bootstrap from 'bootstrap';
import { AvisosStyle,
    ToastRefType,
    type AvistoType,
    type ToastType } from '../model/types';
let toastBootstrap:bootstrap.Toast;
const Toast = forwardRef<ToastRefType,ToastType>(({}:ToastType, ref:ForwardedRef<ToastRefType>) => {
    const [aviso, setAviso ] = useState<AvistoType>({msg:'',tipo:AvisosStyle.INFO})
    useEffect(() => {
        toastBootstrap = bootstrap.Toast.getOrCreateInstance(document.getElementById('liveToast')!)
    },[])
    useImperativeHandle(ref, () => ({
        showMsg: (avisoVal:AvistoType) => {
            setAviso(avisoVal)
            toastBootstrap?.show()
        }
        })
    )
    return (<div className="toast-container position-fixed top-0 end-0 p-3">
                <div id='liveToast' className="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div className="toast-header">
                <svg className="bd-placeholder-img rounded me-2" width="20" height="20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
                <rect width="100%" height="100%" fill={aviso.tipo.color}></rect></svg>
                    <strong className="me-auto">{ aviso.tipo.tituto }</strong>
                    <button type="button" className="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div className="toast-body">
                    {aviso.msg}
                </div>
                </div>
            </div>)
})

export default Toast;