import { CategoriaEnum } from "./httpModel"

export type ErrorType = {
    message:string
    touch:boolean
    format:string
}

export type StateType<T extends Record<string, string> | CategoriaEnum,E> = {
    formData: T
    errors: Partial<Record<keyof T, E>>
    isValid:boolean
}

type PayloadType = {
    name:string
    value:string
}

export enum ActionType {
    UPDATE_FIELD,
    RESET_FORM,
    TOUCH_ALL,
    VALID_DUPLICATE
}

export type DispatchType = 
    { type:ActionType.UPDATE_FIELD, payload:PayloadType} |
    { type:ActionType.RESET_FORM } |
    { type:ActionType.TOUCH_ALL } |
    { type:ActionType.VALID_DUPLICATE, payload:boolean }