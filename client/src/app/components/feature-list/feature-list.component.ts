import { Component } from '@angular/core';
import { FeatureFilter } from 'src/app/interfaces/feature-filter';
import { FeatureList } from 'src/app/interfaces/feature-list';
import { FeatureService } from 'src/app/services/feature.service';

@Component({
  selector: 'app-feature-list',
  templateUrl: './feature-list.component.html',
  styleUrls: ['./feature-list.component.css']
})
export class FeatureListComponent {

  features?: FeatureList;
  private filter: FeatureFilter = {}

  constructor(private featureService: FeatureService) { }

  ngOnInit(){
    this.getFeatures()
  }

  getFeatures(){
    this.featureService.getFeatures(this.filter)
      .subscribe(data => {
        this.features = data
      })
  }

}
