export interface Feature {
    id: number,
    type: string,
    attributes: {
        external_id: string,
        magnitude: number,
        place: string,
        time: string,
        tsunami: number,
        mag_type: string,
        title: string,
        coordinates: {
            longitude: number,
            latitude: number
        }
    },
    links: {
        external_url: string
    }
}
