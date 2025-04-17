FROM rocker/rstudio:4.2.3

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libcurl4-openssl-dev \
      libssl-dev \
      libxml2-dev \
      libfontconfig1-dev \
      libfreetype6-dev \
      libx11-dev \
      pandoc \
      zlib1g-dev \
      pkg-config && \
    rm -rf /var/lib/apt/lists/

# Set working directory
WORKDIR /home/rstudio/project

# Copy raw data folder; ensure your local 'input' folder contains your raw data
COPY input /home/rstudio/project/input

# Copy remaining project files
COPY . /home/rstudio/project

# Fix permissions
RUN chown -R rstudio:rstudio /home/rstudio/project

# Restore project
RUN R -e "renv::restore(project = '/home/rstudio/project', prompt = FALSE)"

# Expose RStudio Server port
EXPOSE 8787

# Set RStudio user password (default user is 'rstudio')
ENV PASSWORD=yourpassword

# Start RStudio Server
CMD ["/init"]
