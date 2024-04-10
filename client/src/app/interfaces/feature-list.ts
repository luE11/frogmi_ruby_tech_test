import { Feature } from "./feature";

export interface FeatureList {
    data: Feature[],
    pagination: {
        current_page: number,
        total: number,
        per_page: number
    }
}
