# Digital China Worldwide - Hugo Frontend

This repository contains the Hugo frontend for the Digital China Worldwide project. It's a multilingual website built using Hugo static site generator, Tailwind CSS for styling, and custom JavaScript for enhanced functionality.

## Project Structure

- `archetypes/`: Contains default content templates
- `content/`: Multilingual content files (en, zh-cn, zh-tw, ja, ko)
- `layouts/`: HTML templates for the site structure
- `static/`: Static assets like CSS and images
- `themes/`: Contains the custom VNovel theme
- `config/`: Configuration files for different environments
- `i18n/`: Internationalization files for multilingual support
- `download_data.sh`: Script to download data from the GraphQL backend

## Features

- Multilingual support (English, Simplified Chinese, Traditional Chinese, Japanese, Korean)
- Responsive design using Tailwind CSS
- Dark mode support
- Search functionality
- Custom shortcodes and partials for flexible content management
- Integration with a GraphQL backend for dynamic content

## Prerequisites

- [Hugo Extended](https://gohugo.io/getting-started/installing/) (version 0.128.0 or later)
- [Node.js](https://nodejs.org/) (version 14 or later)
- [npm](https://www.npmjs.com/) (usually comes with Node.js)
- [curl](https://curl.se/) (for running the download_data.sh script)
- [jq](https://stedolan.github.io/jq/) (for JSON processing in the download_data.sh script)

## Local Development

1. Clone the repository:
   ```
   git clone https://github.com/your-repo/digital-china-worldwide.git
   cd digital-china-worldwide
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Initialize and update the submodules (for the VNovel theme):
   ```
   git submodule init
   git submodule update
   ```

4. Download data from the GraphQL backend:
   ```
   chmod +x download_data.sh
   ./download_data.sh
   ```
   This script will fetch the latest data from the GraphQL backend and save it to `data/all.json`. It will retry up to 5 times if the download fails.

5. Run the development server:
   ```
   npm run start
   ```

   This command will start both Hugo server and Tailwind CSS watcher.

6. Open your browser and visit `http://localhost:1313` to see the site.

## Building for Production

To build the site for production, run:

```
npm run build
```

This command will generate the optimized and minified site in the `public/` directory.

## Deployment

The project is set up with a GitHub Actions workflow for continuous deployment. Any push to the `main` branch will trigger a build and deploy process. The workflow includes running the `download_data.sh` script to fetch the latest data before building the site.

## Using download_data.sh

The `download_data.sh` script is used to fetch the latest data from the GraphQL backend. Here's how to use it:

1. Make sure the script is executable:
   ```
   chmod +x download_data.sh
   ```

2. Run the script:
   ```
   ./download_data.sh
   ```

3. The script will attempt to download the data up to 5 times if it encounters errors.

4. If successful, it will save the data to `data/all.json`.

5. You can modify the `GRAPHQL_ENDPOINT` variable in the script if the backend URL changes.

It's recommended to run this script before starting local development or building the site to ensure you have the latest data.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.