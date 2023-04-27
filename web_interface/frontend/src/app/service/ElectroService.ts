import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {ElectroData} from "../model/ElectroData";

@Injectable()
export class ElectroService {
    private apiServerUrl='http://localhost:8080/electro';

    constructor(private http:HttpClient) { }
    public getData():Observable<ElectroData>{
        return  this.http.get<ElectroData>(this.apiServerUrl+'/find')
    }
    public addData(data:ElectroData ):Observable<ElectroData>{
        return  this.http.post<ElectroData>(this.apiServerUrl+'/add',data);
    }

}
