# Echolog - Project Conversation History

A Ruby on Rails application that tracks project conversations and status changes, built as a technical task for Homey.

## Requirements Analysis & Questions

Before implementation, I considered several clarifying questions that would typically be asked in a real-world scenario:

### Questions and Expected Answers

1. **Project Status Management:**
   - Q: "What are the possible status values for a project? Should they be configurable or fixed?"
   - A: Implemented fixed statuses (Not Started, In Progress, Under Review, Completed) for the scope of this task, but designed the system to be easily extendable.

2. **User Management:**
   - Q: "Should the system support multiple users? How should user permissions be handled?"
   - A: Implemented basic user authentication with Devise. Each project belongs to a user, and only the owner can modify it.

3. **Activity History:**
   - Q: "How should we handle the chronological display of both comments and status changes?"
   - A: Used polymorphic associations to treat both as activities, enabling a unified timeline view.

4. **Data Retention:**
   - Q: "Are there any requirements for data retention or the ability to delete/edit comments?"
   - A: Implemented basic CRUD operations with soft delete capability for future expansion.

## Technical Decisions

### Architecture
- Used Rails 8
- Implemented polymorphic associations for flexible activity tracking
- Used Tailwind CSS for styling
- Slim templating engine for cleaner views

### Models
- `User`: Authentication and ownership
- `Project`: Core entity with status management
- `Comment`: User comments on projects
- `StatusChange`: Tracks project status transitions
- `Activity`: Polymorphic association for unified timeline

### Testing
- RSpec for unit and integration tests
- Capybara for system tests
- FactoryBot for test data

## Setup

### Prerequisites
- Ruby 3.2.2
- PostgreSQL
- Chrome (for system tests)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/janchruszcz/echolog.git
cd echolog
```

2. Install dependencies:
```bash
bundle install
```

3. Setup database:
```bash
rails db:create db:migrate
```

4. Run tests:
```bash
bundle exec rspec
```

5. Start the server:
```bash
./bin/dev
```

Visit `http://localhost:3000`

## Features

- User authentication
- Project creation and management
- Status tracking with history
- Comment system
- Unified activity timeline
- Real-time updates using Turbo
- Responsive design with Tailwind CSS

## Design Patterns Used

1. **Polymorphic Associations**
   - Used for unified activity tracking of comments and status changes

2. **Service Objects**
   - Encapsulated status change logic

3. **Form Objects**
   - Used for complex form handling

4. **Observers**
   - Activity creation on status changes and comments

## Testing Strategy

- **Unit Tests**: Models and service objects
- **Integration Tests**: Controllers and user flows
- **System Tests**: End-to-end user scenarios

## Future Improvements

1. Advanced user roles and permissions
2. Activity filtering and search
3. Email notifications
4. API endpoints
5. Comment editing and deletion
6. Rich text comments
7. File attachments

## Contributing

This is a technical task project, but contributions would be welcome in a real-world scenario.

## License

This project is open-source and available under the MIT License.