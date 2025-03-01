# URL Shortener

A robust and performant URL shortening service built with Ruby on Rails and PostgreSQL. This application allows users to create shortened URLs with optional custom slugs, track visit analytics, and manage URL expirations.

## Features

- **URL Shortening**: Generate short links for any valid URL
- **Custom Slugs**: Optionally specify custom short URLs
- **Visit Analytics**: Track visits with referrer, user agent, and IP information
- **URL Expiration**: Set expiration dates for temporary links
- **RESTful API**: Full-featured API for integration with other services
- **Responsive UI**: Clean, intuitive interface built with Bootstrap

## Technologies

- **Backend**: Ruby on Rails 7.0+
- **Database**: PostgreSQL
- **Caching**: Redis
- **Testing**: RSpec, Factory Bot, Shoulda Matchers
- **Frontend**: HTML, JavaScript, Bootstrap 5
- **Containerization**: Docker (optional)

## Requirements

- Ruby 3.0+
- PostgreSQL 13+
- Redis (for production caching)
- Node.js (for asset compilation)

## Installation

### Standard Setup

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/url-shortener.git
   cd url-shortener
   ```

2. Install dependencies
   ```bash
   bundle install
   ```

3. Set up the database
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the server
   ```bash
   rails server
   ```

The application will be available at http://localhost:3000

### Docker Setup

1. Make sure Docker and Docker Compose are installed on your system

2. Build and start the containers
   ```bash
   docker-compose up --build
   ```

3. Set up the database (first time only)
   ```bash
   docker-compose exec web rails db:create db:migrate
   ```

The application will be available at http://localhost:3000

## Configuration

The application uses environment variables for configuration. Create a `.env` file in the root directory with the following variables:

```
DATABASE_URL=postgres://user:password@localhost:5432/url_shortener_production
REDIS_URL=redis://localhost:6379/1
```

## API Documentation

### Create a Short URL

**POST** `/api/urls`

Request body:
```json
{
  "url": {
    "original_url": "https://example.com",
    "short_url": "custom",  // Optional
    "expires_at": "2023-12-31T23:59:59Z"  // Optional
  }
}
```

Response:
```json
{
  "id": 1,
  "original_url": "https://example.com",
  "short_url": "custom",
  "visits_count": 0,
  "created_at": "2023-01-01T12:00:00Z",
  "short_url_path": "http://localhost:3000/custom"
}
```

### Get All URLs

**GET** `/api/urls`

Response:
```json
[
  {
    "id": 1,
    "original_url": "https://example.com",
    "short_url": "custom",
    "visits_count": 5,
    "created_at": "2023-01-01T12:00:00Z",
    "short_url_path": "http://localhost:3000/custom"
  },
  {
    "id": 2,
    "original_url": "https://another-example.com",
    "short_url": "abc123",
    "visits_count": 10,
    "created_at": "2023-01-02T12:00:00Z",
    "short_url_path": "http://localhost:3000/abc123"
  }
]
```

### Get a Specific URL

**GET** `/api/urls/:id`

Response:
```json
{
  "id": 1,
  "original_url": "https://example.com",
  "short_url": "custom",
  "visits_count": 5,
  "created_at": "2023-01-01T12:00:00Z",
  "short_url_path": "http://localhost:3000/custom"
}
```

## Testing

Run the test suite:
```bash
rspec
```

## Performance Considerations

- Database indexes on `short_url` and `original_url` fields for faster lookups
- Redis caching for frequently accessed short URLs
- Counter cache for visit counts to reduce database load

## Deployment

The application is containerized and can be easily deployed to any Docker-compatible hosting service:

1. Set up production environment variables
2. Build the Docker image
   ```bash
   docker build -t url-shortener .
   ```
3. Deploy the image to your hosting service

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Ruby on Rails](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)
- [Bootstrap](https://getbootstrap.com/)