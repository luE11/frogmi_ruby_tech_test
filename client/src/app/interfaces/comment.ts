import { Feature } from "./feature"

export interface Comment {
    id: number,
    type: string,
    attributes: {
        message: string,
        feature: Feature
    }
}