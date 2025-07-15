# Contributing to Advanced Tic Tac Toe

Thank you for your interest in contributing to Advanced Tic Tac Toe! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.4.3 or higher)
- Dart (comes with Flutter)
- Git
- A code editor (VS Code, Android Studio, etc.)

### Setting Up Development Environment

1. **Fork the repository**
   ```bash
   # Clone your fork
   git clone https://github.com/YOUR_USERNAME/advanced_tic_tac_toe.git
   cd advanced_tic_tac_toe/advanced_tic_tac_toe_game
   
   # Add upstream remote
   git remote add upstream https://github.com/ghodketejas/advanced_tic_tac_toe.git
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📋 Development Guidelines

### Code Style
- Follow Dart/Flutter best practices
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use proper indentation (2 spaces)

### Documentation
- Add documentation comments for all public classes and methods
- Update README.md if adding new features
- Include examples in documentation when helpful

### Testing
- Test your changes on multiple platforms when possible
- Ensure the app runs without errors
- Test edge cases and error scenarios

### Git Workflow
1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write clean, well-documented code
   - Test thoroughly
   - Update documentation if needed

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: brief description of your feature"
   ```

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request**
   - Go to your fork on GitHub
   - Click "New Pull Request"
   - Select your feature branch
   - Fill out the PR template

## 🎯 Areas for Contribution

### High Priority
- **Bug fixes**: Report and fix any bugs you encounter
- **Performance improvements**: Optimize game logic or UI rendering
- **Accessibility**: Improve accessibility features
- **Testing**: Add unit tests and widget tests

### Medium Priority
- **UI/UX improvements**: Enhance the visual design or user experience
- **New features**: Add new game modes or settings
- **Platform support**: Improve support for specific platforms
- **Documentation**: Improve existing documentation

### Low Priority
- **Code refactoring**: Improve code structure and organization
- **Dependencies**: Update dependencies to latest versions
- **Examples**: Add more examples or tutorials

## 🐛 Reporting Bugs

When reporting bugs, please include:

1. **Platform**: Android, iOS, Web, Windows, macOS, or Linux
2. **Flutter version**: `flutter --version`
3. **Steps to reproduce**: Clear, step-by-step instructions
4. **Expected behavior**: What should happen
5. **Actual behavior**: What actually happens
6. **Screenshots**: If applicable
7. **Additional context**: Any relevant information

## 💡 Feature Requests

When suggesting features:

1. **Clear description**: Explain what the feature should do
2. **Use case**: Why is this feature needed?
3. **Implementation ideas**: How might this be implemented?
4. **Mockups**: Visual examples if applicable

## 📝 Pull Request Guidelines

### PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Performance improvement

## Testing
- [ ] Tested on Android
- [ ] Tested on iOS
- [ ] Tested on Web
- [ ] Tested on Windows/macOS/Linux

## Screenshots
Add screenshots if UI changes were made

## Checklist
- [ ] Code follows project style guidelines
- [ ] Documentation updated
- [ ] No new warnings or errors
- [ ] Tested on multiple platforms
```

### Review Process
1. **Automated checks**: Ensure all CI checks pass
2. **Code review**: Address any feedback from maintainers
3. **Testing**: Verify changes work as expected
4. **Merge**: Once approved, changes will be merged

## 🏷️ Commit Message Guidelines

Use conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples
```
feat(game): add new game mode selection
fix(ui): resolve button alignment issue
docs(readme): update installation instructions
style: format code according to dart guidelines
```

## 🤝 Community Guidelines

- Be respectful and inclusive
- Help other contributors
- Provide constructive feedback
- Follow the project's code of conduct

## 📞 Getting Help

- **Issues**: Use GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub discussions for questions and ideas
- **Documentation**: Check the README and code comments first

## 🎉 Recognition

Contributors will be recognized in:
- Project README
- Release notes
- GitHub contributors list

Thank you for contributing to Advanced Tic Tac Toe! 🎮 