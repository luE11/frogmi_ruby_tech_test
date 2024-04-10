import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateCommentModalComponent } from './create-comment-modal.component';

describe('CreateCommentModalComponent', () => {
  let component: CreateCommentModalComponent;
  let fixture: ComponentFixture<CreateCommentModalComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CreateCommentModalComponent]
    });
    fixture = TestBed.createComponent(CreateCommentModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
