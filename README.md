# URL Shortener

A robust and performant URL shortening service built with Ruby on Rails and PostgreSQL. This application allows users to create shortened URLs and track visit analytics.

## Features

- **URL Shortening**: Generate short links for any valid URL
- **Visit Analytics**: Track visits with referrer, user agent, and IP information
- **RESTful API**: Full-featured API for integration with other services

## Technologies

- **Backend**: Ruby on Rails 7.0+
- **Database**: PostgreSQL
- **Caching**: Redis
- **Testing**: RSpec, Factory Bot, Shoulda Matchers
- **Background Jobs**: ActiveRecord Background Jobs

## Requirements

- Ruby 3.0+
- PostgreSQL 13+
- Redis (for caching)
- Node.js (for asset compilation)

## Installation

### Standard Setup

1. Clone the repository
   ```bash
   git clone https://github.com/zunair-dev/url-shortener.git
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

## Configuration

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
    "url": "https://example.com"
  }
}
```

Response:
```json
{
  "id": 1,
  "url": "https://example.com",
  "slug": "custom",
  "visits_count": 0,
  "created_at": "2023-01-01T12:00:00Z",
  "shortened_link": "http://localhost:3000/custom"
}
```

### Get All URLs

**GET** `/api/urls`

Response:
```json
[
  {
    "id": 1,
    "url": "https://example.com",
    "slug": "custom",
    "visits_count": 5,
    "created_at": "2023-01-01T12:00:00Z",
    "shortened_link": "http://localhost:3000/custom"
  },
  {
    "id": 2,
    "url": "https://another-example.com",
    "slug": "abc123",
    "visits_count": 10,
    "created_at": "2023-01-02T12:00:00Z",
    "shortened_link": "http://localhost:3000/abc123"
  }
]
```

### Get a Specific URL

**GET** `/api/urls/:id`

Response:
```json
{
  "id": 1,
  "url": "https://example.com",
  "slug": "custom",
  "visits_count": 5,
  "created_at": "2023-01-01T12:00:00Z",
  "shortened_link": "http://localhost:3000/custom"
}
```

## Testing

Run the test suite:
```bash
rspec
```

## Performance Considerations

- Database indexes on `slug` and `url` fields for faster lookups
- Redis caching for frequently accessed short URLs
- Eager loading of associated records to minimize database queries

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