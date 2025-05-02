import { useImperativeHandle, ForwardedRef, forwardRef } from 'react'
import { getPalabraValid, putPalabra } from '../../http'
import { useDialog } from '../../contexts/dialogContext'
import { AvisosStyle, FormProps,  type FormRef } from '../../model/types'
import { ActionType, type ErrorType,type StateType } from '../../model/ValidationForm'
import useForm from '../../hooks/useForm'
import { z } from 'zod';
import { CategoriaEnum } from '../../model/httpModel'
import { AxiosResponse } from 'axios'

const initialState:StateType<FormDataType,ErrorType> = {
    formData: {
        palabra: '',
        frase: '',
        significado: '',
        categoria: ''
    },
    errors: {
        palabra: {
            message:'',
            touch:false,
            format:''
        },
        frase: {
            message:'',
            touch:false,
            format:''
        },
        significado: {
            message:'',
            touch:false,
            format:''
        },
        categoria: {
            message:'',
            touch:false,
            format:''
        }
    },
    isValid: false,
}
const validate = z.object({
    palabra: z.string().min(1),
    frase: z.string().min(1),
    significado: z.string().min(1),
    categoria: z.string().min(1)
})
type FormDataType = {
    palabra:string
    frase:string
    significado:string
    categoria:CategoriaEnum | ''
}
const validateField = (form:FormDataType):Partial<Record<keyof FormDataType, ErrorType>> => {
    const validated = {
        palabra: validate.pick({ palabra:true }).safeParse({ palabra:form.palabra}).success ? 
        { message:'' , format:" is-valid" } :
        { message:'Valor es requerido' , format:' is-invalid' },
        frase: validate.pick({ frase:true }).safeParse({ frase:form.frase }).success? 
        { message:'' , format:" is-valid" } :
        { message:'Valor es requerido' , format:' is-invalid' },
        significado: validate.pick({ significado:true }).safeParse({ significado:form.significado }).success? 
        { message:'' , format:" is-valid" } :
        { message:'Valor es requerido' , format:' is-invalid' },
        categoria: validate.pick({ categoria:true }).safeParse({ categoria:form.categoria }).success? 
        { message:'' , format:" is-valid" } :
        { message:'Valor es requerido' , format:' is-invalid' }
    }
    return {
        palabra:{ ...validated.palabra , touch: true },
        frase:{ ...validated.frase , touch: true },
        significado:{ ...validated.significado , touch: true },
        categoria:{ ...validated.categoria , touch: true }
}
}
const Form = forwardRef<FormRef,FormProps>(({getData, tablePage}, ref:ForwardedRef<FormRef>) => {
    const contextDialog = useDialog();
    const [state, dispatch] = useForm<FormDataType>({validateField,initialState})
    const { palabra, frase, significado, categoria } = state.formData
    const { errors } = state;
    useImperativeHandle(ref,() =>({
        onClickForm:() => {
            if(state.isValid) {
                putPalabra(palabra, frase, significado, categoria)
                .then(() => {
                    contextDialog?.modalHide()
                    contextDialog?.showMsg({ msg: "Palabra almacenda", tipo: AvisosStyle.INFO })
                    getData(tablePage.page, tablePage.limit)
                })
                .catch(res => {
                    contextDialog?.showMsg({ msg: res.response.data.message, tipo: AvisosStyle.ERROR})
                })
            } else {
                dispatch({ type: ActionType.TOUCH_ALL });
            }
        },
        initForm:() => {
            dispatch({type: ActionType.RESET_FORM })
        }
    }))
    const handleChange = (e:React.ChangeEvent<HTMLInputElement>) => {
        const { name, value } = e.target;
        dispatch({
          type: ActionType.UPDATE_FIELD,
          payload: { name, value }, 
        })
      };
      const handleSelect = (e:React.ChangeEvent<HTMLSelectElement>) => {
          const { name, value } = e.target;
          dispatch({
            type: ActionType.UPDATE_FIELD,
            payload: { name, value }, 
          })
        };
    return (<form className="p-3" style={{border: '#eee solid 0.1px'}}>
                <div className="mb-3">
                    <label htmlFor="idPalabra" className="form-label">Palabra</label>
                    <input id="idPalabra" type="text" className={"form-control" + errors.palabra?.format} name="palabra"
                        onChange={handleChange}
                        value={palabra}
                    ></input>
                    <div className="invalid-feedback">
                        {errors.palabra?.message}
                    </div>
                </div>
                <div className="mb-3">
                    <label htmlFor="idFrase" className="form-label">Frase</label>
                    <input id="idFrase" type="text" className={"form-control" + errors.frase?.format} name="frase"
                        onChange={handleChange}
                        value={frase}
                    ></input>
                    <div className="invalid-feedback">
                        {errors.frase?.message}
                    </div>
                </div>
                <div className="mb-3">
                    <label htmlFor="idSignificado" className="form-label">Significado</label>
                    <input id="idSignificado" type="text" className={"form-control" + errors.significado?.format} name="significado"
                        onChange={handleChange}
                        value={significado}
                    ></input>
                    <div className="invalid-feedback">
                        {errors.significado?.message}
                    </div>
                </div>
                <div className="md-3">
                    <label htmlFor="idCategoria" className="form-label">State</label>
                    <select className={"form-control" + errors.categoria?.format} id="idCategoria" name="categoria"
                        onChange={handleSelect} value={categoria}
                        required>
                        <option defaultValue key={'0'} value="">Choose...</option>
                        {Object.entries(CategoriaEnum).map(([key,value]) => <option key={key} value={key}>{value}</option>)}
                    </select>
                    <div className="invalid-feedback">
                        {errors.categoria?.message}
                    </div>
                </div>
            </form>);
})

export default Form