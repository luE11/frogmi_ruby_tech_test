import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FeatureList } from '../interfaces/feature-list';
import { Observable } from 'rxjs';
import { FeatureFilter } from '../interfaces/feature-filter';


@Injectable({
  providedIn: 'root'
})
/**
 * Service to consume server features endpoints
 */
export class FeatureService {

  private readonly FETCH_FEATURES_ENDPOINT = "/api/features"

  constructor(private http: HttpClient) { }

  /**
   * Consumes /api/features service to get a list of stores features
   * @param params filter options object
   * @returns Observable with request response
   */
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
    return this.http.get<FeatureList>(this.FETCH_FEATURES_ENDPOINT, { params: queryParams });
  }
}
