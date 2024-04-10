import { Component, ElementRef, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FeatureFilter } from 'src/app/interfaces/feature-filter';
import { FeatureList } from 'src/app/interfaces/feature-list';
import { FeatureService } from 'src/app/services/feature.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { CommentReportModalComponent } from '../comment-report-modal/comment-report-modal.component';
import { CreateCommentModalComponent } from '../create-comment-modal/create-comment-modal.component';
@Component({
  selector: 'app-feature-list',
  templateUrl: './feature-list.component.html',
  styleUrls: ['./feature-list.component.css']
})
export class FeatureListComponent {
  readonly MAG_TYPE_OPTIONS: string[] = ["md", "ml", "ms", "mw", "me", "mi", "mb", "mlg"]
  features?: FeatureList
  filter: FeatureFilter = {
    page: 1,
    per_page: 10,
  }
  toast?: { message: string, feature_title: string };

  constructor(private _route: ActivatedRoute,
    private _router: Router,
    private modalService: NgbModal,
    private featureService: FeatureService) { }

  ngOnInit(){
    this._route.queryParams.subscribe(params => {
      this.filter.mag_type = params['mag_type'] || undefined;
      if(this.filter.mag_type!==undefined && typeof this.filter.mag_type=="string"){
        this.filter.mag_type = [ this.filter.mag_type ];
      }
      this.filter.page = parseInt(params['page'] || 1);
      this.filter.per_page = parseInt(params['per_page'] || 10);
      this.getFeatures();
    });
  }

  onPerPageChange(e: Event){
    let el = (e.target as HTMLInputElement);
    let val = parseInt(el.value);
    if(val<1){
      el.value = "1";
    }else if(val>1000){
      el.value = "1000";
    }
    this.filter.per_page = parseInt(el.value);
    el.value = this.filter.per_page.toString()
  }

  onMagTypeChange(e: Event){
    let el = (e.target as HTMLInputElement);
    let val = el.value
    if(this.filter.mag_type==undefined){
      this.filter.mag_type = []
    }
    if(el.checked){
      let exists = this.filter.mag_type.find(t => t==val)
      if(exists==undefined){
        this.filter.mag_type.push(val);
      }
    }else {
      this.filter.mag_type = this.filter.mag_type.filter(item => item !== val)
    }
  }

  isMagTypeSelected(val: string){
    if(this.filter.mag_type==undefined){
      return false
    }
    let exists = this.filter.mag_type.find(t => t==val)
    return exists!==undefined
  }

  setFilter(){
    if(this.filter.mag_type?.length==0){
      this.filter.mag_type = undefined;
    }
    this.filter.page = 1;
    this.updateQueryParams()
    this.getFeatures()
  }

  getResultsRange(){
    if(this.features==undefined){
      return "";
    }
    let higher = this.filter.per_page*this.filter.page
    let lower = higher-this.filter.per_page+1

    return `${lower}-${higher}`;
  }

  nextPage(){
    this.setPage(this.filter.page+1);
  }

  previousPage(){
    this.setPage(this.filter.page-1);
  }

  setPage(page: number) {
    this.filter.page = page;
    this.updateQueryParams()
    this.getFeatures()
  }

  updateQueryParams(){
    this._router.navigate([], {
      relativeTo: this._route,
      queryParams: this.filter,
      queryParamsHandling: 'merge'
    });
  }

  getFeatures(){
    this.featureService.getFeatures(this.filter)
      .subscribe(data => {
        this.features = data
      })
  }

  getTotalPages(){
    if(this.features==undefined){
      return 1
    }
    let total = this.features?.pagination.total;
    let per_page = this.features?.pagination.per_page;
    return Math.ceil(total/per_page);
  }

  showCommentReportModal(){
    this.modalService.open(CommentReportModalComponent);
  }

  showCreateCommentModal(feature_id: number) {
    const modalRef = this.modalService.open(CreateCommentModalComponent);
    modalRef.componentInstance.feature_id = feature_id;
    modalRef.componentInstance.showToast.subscribe((e: { message: string; feature_title: string; }) => {
      this.showToast(e.message, e.feature_title);
    } );
  }

  showToast(message: string, title: string){
    this.toast = {
      message: message,
      feature_title: title
    };
    setTimeout(() => {
      this.toast = undefined;
    }, 8000);
  }

}
