import axios from 'axios';
export default axios.create({
    baseURL: `${process.env.REACT_APP_API_URL}/api/`,
    // headers: {'Authorization': 'Bearer ' + localStorage.getItem(ACCESS_TOKEN)}
})