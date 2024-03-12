# HAIG FRAS PROJECT DOCUMENTATION

This project represents the documentation for the Digital Twin project for Haig-Fras.

It was assembled based on the mkdocs package.

## Installation

1. Create a Python 3 virtual environment and activate it:

   ```bash
   pyenv virtualenv imfe-documentation
   ```

2. Clone the project and install it:

   ```bash
   git clone git@git.noc.ac.uk:ocean-informatics/imfepilot/documentation.git
   cd documentation
   pyenv local imfe-documentation
   pip install -r requirements.txt
   ```

## Running the Server Locally

If the configuration was done correctly, you can run the following command to launch the documentation:

```bash
mkdocs serve
```

This will run the app in development mode. Open [http://localhost:8000](http://localhost:8000) in your browser to access it. The page will automatically reload when you make edits.

## Running the Server as a Docker Compose

First, build the Docker Compose:

```bash
docker build mkdocs .
```

Now, start the containers:

```bash
docker run -d -p 8084:8000 --rm mkdocs
```

This will run the app in development mode. Open [http://localhost:8084](http://localhost:8084) in your browser to access it.

## Information about MkDocs

The central file of the documentation is `docs/index.md`.

All images should be stored in the `docs/assets` folder.

MkDocs uses Markdown language. Therefore, you can easily import your README files from GitHub/GitLab to include in the documentation.

In the `mkdocs.yml` file, you can define the main navigation bar of your project. For example, below, I am indicating that only `index.md` and `about.md` will be present in the navbar:

```yaml
nav:
  - 'index.md'
  - 'about.md'
```

If you do not include the `nav` option, all your .md files in the `docs` folder will be items in your navbar.

## License
Haig Fras Digital Twin Documentation © 2023 by National Oceanography Centre is licensed under CC BY 4.0. To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/

