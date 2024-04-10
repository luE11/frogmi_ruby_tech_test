import { Component } from '@angular/core';
import { NgbModal, NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { CommentReport } from 'src/app/interfaces/comment-report';
import { CommentService } from 'src/app/services/comment.service';

@Component({
  selector: 'app-comment-report-modal',
  templateUrl: './comment-report-modal.component.html',
  styleUrls: ['./comment-report-modal.component.css']
})
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
