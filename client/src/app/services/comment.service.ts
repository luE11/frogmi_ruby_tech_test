import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CommentReport } from '../interfaces/comment-report';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  private readonly GET_COMMENT_REPORT_ENDPOINT = "/api/comments/report";
  private readonly POST_COMMENT_ENDPOINT = (id: number) => `/api/features/${id}/comments`

  constructor(private http: HttpClient) { }

  getCommentReport() : Observable<CommentReport> {
    return this.http.get<CommentReport>(this.GET_COMMENT_REPORT_ENDPOINT)
  }
}
