FROM rocker/rstudio:4.2.3

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /home/rstudio/project

# Copy raw data folder; ensure your local 'input' folder contains your raw data
COPY input /home/rstudio/project/input

# Copy remaining project files
COPY . /home/rstudio/project

# Fix permissions
RUN chown -R rstudio:rstudio /home/rstudio/project

# Expose RStudio Server port
EXPOSE 8787

# Set RStudio user password (default user is 'rstudio')
ENV PASSWORD=yourpassword

# Start RStudio Server
CMD ["/init"]
