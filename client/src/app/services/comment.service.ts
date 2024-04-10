import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CommentReport } from '../interfaces/comment-report';
import { Observable } from 'rxjs';
import { CommentInput } from '../interfaces/comment-input';
import { Comment } from '../interfaces/comment';

@Injectable({
  providedIn: 'root'
})
/**
 * Service to consume server comment endpoints
 */
export class CommentService {

  private readonly GET_COMMENT_REPORT_ENDPOINT = "/api/comments/report";
  private readonly POST_COMMENT_ENDPOINT = (id: number) => `/api/features/${id}/comments`

  constructor(private http: HttpClient) { }

  /**
   * Gets a comment report including all stored comments
   * @returns Observable object with request response
   */
  getCommentReport() : Observable<CommentReport> {
    return this.http.get<CommentReport>(this.GET_COMMENT_REPORT_ENDPOINT)
  }

  /**
   * Posts a comment with given attributes
   * @param comment input object with new comment data
   * @returns Observable with inserted comment object
   */
  postComment(comment: CommentInput) : Observable<Comment> {
    let url: string = this.POST_COMMENT_ENDPOINT(comment.feature_id!);
    return this.http.post<Comment>(url, { message: comment.message });
  }

}
