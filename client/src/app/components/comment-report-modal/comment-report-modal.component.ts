import { Component } from '@angular/core';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { CommentReport } from 'src/app/interfaces/comment-report';
import { CommentService } from 'src/app/services/comment.service';

@Component({
  selector: 'app-comment-report-modal',
  templateUrl: './comment-report-modal.component.html',
  styleUrls: ['./comment-report-modal.component.css']
})
/**
 * Modal which shows a simple report about every comment stored
 */
export class CommentReportModalComponent {

  report?: CommentReport;

  constructor(public activeModal: NgbActiveModal,
    private commentService: CommentService,
  ){
    
  }

  ngOnInit(){
    this.commentService.getCommentReport()
      .subscribe(data => {
        this.report = data;
      });
  }

}
