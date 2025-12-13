# Tyrel Barstow - Static Content Site

A clean, modern static website for showcasing personal content, projects, and resources.

## Overview

This is a static content site focused on providing easy access to various digital resources, projects, and information about Tyrel Barstow. The site is built with pure HTML, CSS, and JavaScript for simplicity and fast loading times.

## Features

- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile devices
- **Modern UI**: Clean, gradient-based design with smooth animations
- **Static Content Delivery**: Fast, reliable access to documents, images, and other media
- **Easy Navigation**: Intuitive menu system for quick access to different sections
- **Lightweight**: No dependencies, frameworks, or build tools required

## Project Structure

```
static_site/
├── index.html          # Main landing page
├── about.html          # About page (to be created)
├── projects.html       # Projects showcase (to be created)
├── contact.html        # Contact information (to be created)
├── content/            # Static content directory
│   ├── documents/      # PDF, text files, etc.
│   ├── images/         # Photos and graphics
│   ├── videos/         # Video content
│   └── downloads/      # Downloadable resources
├── css/                # Additional stylesheets (optional)
├── js/                 # JavaScript files (optional)
└── README.md           # This file
```

## Getting Started

### Local Development

1. Clone or download this repository
2. Open `index.html` in your web browser
3. That's it! No build process required.

### Deployment

You can deploy this static site to any web hosting service:

#### GitHub Pages
```bash
# Push to GitHub
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/TyrelCB/static_site.git
git push -u origin main

# Enable GitHub Pages in repository settings
```

#### Netlify
- Drag and drop the site folder to [Netlify Drop](https://app.netlify.com/drop)
- Or connect your Git repository for automatic deployments

#### Vercel
```bash
npm i -g vercel
vercel
```

#### Traditional Web Hosting
- Upload all files via FTP/SFTP to your web server's public directory

## Customization

### Updating Content

1. **Change the name/branding**: Edit the `<h1>` tag in `index.html`
2. **Modify colors**: Update the CSS gradient and color variables in the `<style>` section
3. **Add new sections**: Create additional HTML files and link them in the navigation

### Adding Static Content

1. Create subdirectories in the `content/` folder
2. Upload your files (images, PDFs, videos, etc.)
3. Link to them from your HTML pages

### Styling

The site uses inline CSS for simplicity. You can:
- Keep styles inline for easy management
- Move styles to external CSS files in a `css/` directory
- Use CSS frameworks like Bootstrap or Tailwind (requires additional setup)

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Performance

- No external dependencies
- Minimal HTTP requests
- Fast page load times
- SEO-friendly structure

## License

This project is open source. Feel free to use and modify as needed.

## Contact

For questions or suggestions, please visit the contact page or reach out directly.

---

**Built with ❤️ using pure HTML, CSS, and JavaScript**
