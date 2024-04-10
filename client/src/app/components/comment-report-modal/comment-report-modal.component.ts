import { Component } from '@angular/core';
import { NgbModal, NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-comment-report-modal',
  templateUrl: './comment-report-modal.component.html',
  styleUrls: ['./comment-report-modal.component.css']
})
export class CommentReportModalComponent {

  constructor(public activeModal: NgbActiveModal){
    
  }

}
