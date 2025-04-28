import { useReducer } from "react";
import { ActionType, DispatchType, type ErrorType, type StateType } from "../model/ValidationForm";
import { CategoriaEnum } from "../model/types";

type UseFormType<T extends Record<string, string>> = {
    validateField:(form:T) => Partial<Record<keyof T, ErrorType>>
    initialState:StateType<T,ErrorType>
}

const useForm= <T extends Record<string, string> | CategoriaEnum>({validateField, initialState}:UseFormType<T>) => {
    const formReducer = (state:StateType<T,ErrorType>, action:DispatchType):StateType<T,ErrorType> => {
      switch (action.type) {
        case ActionType.UPDATE_FIELD:
          const { name, value } = action.payload;
          const newFormData = { ...state.formData, [name]: value };
          const newErrors = validateField(newFormData);
          return {
            ...state,
            formData: newFormData,
            errors: { ...state.errors, [name]: newErrors[name] },
            isValid: Object.values(newErrors).every((error) => error?.message.length === 0),
          };
        case ActionType.RESET_FORM:
          return initialState;
        case ActionType.TOUCH_ALL:
            const neoErrors = validateField(state.formData);
            return {
                ...state,
                errors: neoErrors,
                isValid: Object.values(neoErrors).every((error) => error?.message.length === 0),
                }
        default:
          return state;
      }
    }
    return useReducer<StateType<T,ErrorType>,[DispatchType]>(formReducer,initialState)
}

export default useForm;