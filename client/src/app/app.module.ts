import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from  '@angular/common/http';
import { NgbModule, NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { AppComponent } from './app.component';
import { FeatureListComponent } from './components/feature-list/feature-list.component';
import { RouterModule } from '@angular/router';
import { CommentReportModalComponent } from './components/comment-report-modal/comment-report-modal.component';

@NgModule({
  declarations: [
    AppComponent,
    FeatureListComponent,
    CommentReportModalComponent,
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    RouterModule.forRoot([]),
    NgbModule,
  ],
  providers: [
    NgbActiveModal,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
