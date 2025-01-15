use actix_web::*;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // * Method 1
    // HttpServer::new(|| actix_web::App::new().route("/", actix_web::web::get().to(index)))
    //     .bind(("0.0.0.0", 8000))?
    //     .run()
    //     .await
    // * Method 2
    HttpServer::new(|| {
        actix_web::App::new()
            .service(
                actix_web::web::scope("/v1")
                    .route("/profile", actix_web::web::get().to(index))
                    .route("/profile", actix_web::web::post().to(insert)),
            )
            .service(
                actix_web::web::scope("/v2")
                    .route("/profile", actix_web::web::get().to(index))
                    .route("/profile", actix_web::web::post().to(insert)),
            )
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}

async fn index() -> &'static str {
    "Hello, world!"
}

async fn insert() -> &'static str {
    "Data inserted successfully!"
}
