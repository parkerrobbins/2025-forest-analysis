# Project README

Welcome! This guide will help you build and run the Dockerized RStudio environment locally so you can reproduce the analysis in one step.

---

## 1. Prerequisites

- **Docker Desktop** installed on your Windows machine.
- A copy of this repository (e.g., via `git clone` or **Download ZIP**).

---

## 2. Folder Structure

After cloning or unzipping, you should see:

```
├── input/            ← Put your raw data files here
├── Dockerfile        ← Docker configuration
├── analysis.Rmd      ← Your main analysis script (or `run_analysis.R`)
└── README.md         ← (This file)
```

> **Note:** Make sure your raw data lives in the `input/` folder (rename any existing folder accordingly).

---

## 3. Build the Docker Image

1. Open a terminal (PowerShell or Git Bash) in the project root.
2. Run:

   ```bash
   docker build -t my-rstudio-image .
   ```

   - `-t my-rstudio-image` gives your image a name (feel free to change it).
   - The final `.` tells Docker to use the `Dockerfile` in this directory.

---

## 4. Run the Container

1. In the same terminal, start the container:

   ```bash
   docker run -d -p 8787:8787 \
     -e PASSWORD=yourpassword \
     my-rstudio-image
   ```

   - `-p 8787:8787` maps the container’s RStudio port to your PC.
   - `-e PASSWORD=yourpassword` sets the RStudio login password (replace `yourpassword`).
   - `my-rstudio-image` must match the name you built.

2. Wait a few seconds for RStudio Server to start.

---

## 5. Access RStudio

1. Open your web browser and go to:

   ```
   http://localhost:8787
   ```

2. Log in with:

   - **Username:** `rstudio`
   - **Password:** whatever you set in the `docker run` command (e.g., `yourpassword`)

---

## 6. Run the Analysis

- In the **Files** pane, open `analysis.Rmd` and click **Knit** (or open `run_analysis.R` and click **Source**).
- Everything (packages, data, paths) is configured to work out of the box.

---

## 7. Customization Tips

- To change the image name or password, edit the commands in **Steps 3** and **4**.
- If you add new R packages, update your script to install them (no need to change the Dockerfile).

---

You’re all set! Enjoy your reproducible analysis environment.

