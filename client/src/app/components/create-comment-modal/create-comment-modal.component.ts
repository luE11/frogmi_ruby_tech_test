import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { CommentInput } from 'src/app/interfaces/comment-input';
import { CommentService } from 'src/app/services/comment.service';

@Component({
  selector: 'app-create-comment-modal',
  templateUrl: './create-comment-modal.component.html',
  styleUrls: ['./create-comment-modal.component.css']
})
export class CreateCommentModalComponent {
  comment: CommentInput = {};
  @Input() feature_id: number = 0;
  @Output() showToast = new EventEmitter();

  message = new FormControl('', [
    Validators.required,
    Validators.minLength(4)
  ]);
  
  constructor(public activeModal: NgbActiveModal,
    private commentService: CommentService,
  ){
    
  }

  ngOnInit() {
    this.comment.feature_id = this.feature_id;
  }

  createComment(){
    if(this.message.invalid){
      this.message.markAsTouched()
    }else {
      this.comment.message = this.message.value!
      this.commentService.postComment(this.comment)
        .subscribe(res => {
          if(res!=undefined){
            this.showToast.emit({
                message: res.attributes.message,
                feature_title: res.attributes.feature.attributes.title
              });
            this.activeModal.close();
          }
        });
    }
  }
}
