import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CommentReportModalComponent } from './comment-report-modal.component';

describe('CommentReportModalComponent', () => {
  let component: CommentReportModalComponent;
  let fixture: ComponentFixture<CommentReportModalComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CommentReportModalComponent]
    });
    fixture = TestBed.createComponent(CommentReportModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
