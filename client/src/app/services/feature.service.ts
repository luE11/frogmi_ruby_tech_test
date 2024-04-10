import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FeatureList } from '../interfaces/feature-list';
import { Observable } from 'rxjs';
import { FeatureFilter } from '../interfaces/feature-filter';


@Injectable({
  providedIn: 'root'
})
export class FeatureService {

  private fetchFeaturesUrl = "/api/features"

  constructor(private http: HttpClient) { }

  getFeatures(params?: FeatureFilter) : Observable<FeatureList> {
    let queryParams = new HttpParams();
    if(params!=undefined){
      if (params?.mag_type!=undefined) {
        params?.mag_type.forEach(element => {
          queryParams = queryParams.append("mag_type[]", element)
        });
      }
      if(params?.page!=undefined) {
        queryParams = queryParams.append("page", params?.page)
      }
      if(params?.per_page!=undefined) {
        queryParams = queryParams.append("per_page", params?.per_page)
      }
    }
    return this.http.get<FeatureList>(this.fetchFeaturesUrl, { params: queryParams });
  }
}
