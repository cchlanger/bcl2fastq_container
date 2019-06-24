FROM docker.io/centos:7
WORKDIR /home
COPY . /home/install/

# Update and create base image
RUN yum update -y &&\
    yum install -y wget &&\
    yum install -y unzip &&\
    yum install -y bzip2
# Install bcl2fastq
RUN wget -q https://support.illumina.com/content/dam/illumina-support/documents/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-linux-x86-64.zip &&\
    unzip bcl2fastq2-v2-20-0-linux-x86-64.zip &&\
    rpm -i bcl2fastq2-v2.20.0.422-Linux-x86_64.rpm
# Install fastQC
RUN yum install -y java-1.8.0-openjdk &&\
    wget -q https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip &&\
    unzip fastqc_v0.11.8.zip
# Install Anaconda
RUN wget -q https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh &&\
    bash Anaconda3-2019.03-Linux-x86_64.sh -b -p /root/anaconda3
ENV PATH="/root/anaconda3/bin:${PATH}"
RUN conda update -y conda &&\
    conda init
# Install Nextflow
RUN source ~/.bashrc &&\
    conda install -c bioconda -y nextflow

#CMD [ "bash" ]
#bcl2fastq --create-fastq-for-index-reads -R 190227_NB551430_0099_AHLWT5BGX9 --sample-sheet HLWT5BGX9.csv -o test_output
