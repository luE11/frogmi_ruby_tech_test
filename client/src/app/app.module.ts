import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from  '@angular/common/http';
import { NgbModule, NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { AppComponent } from './app.component';
import { FeatureListComponent } from './components/feature-list/feature-list.component';
import { RouterModule } from '@angular/router';
import { CommentReportModalComponent } from './components/comment-report-modal/comment-report-modal.component';
import { CreateCommentModalComponent } from './components/create-comment-modal/create-comment-modal.component';
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AppComponent,
    FeatureListComponent,
    CommentReportModalComponent,
    CreateCommentModalComponent,
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    RouterModule.forRoot([]),
    NgbModule,
    ReactiveFormsModule,
  ],
  providers: [
    NgbActiveModal,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
