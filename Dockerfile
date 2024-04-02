FROM fedora:latest 

ENV USERNAME=fortran
ENV NRLMOL_BASIS=/home/fortran/basis

RUN dnf update  -y
RUN dnf install -y vim gcc-gfortran lapack openmpi lapack openblas scalapack-openmpi hostname
RUN echo "fortran ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN usermod -aG wheel $USERNAME 

COPY flosic_exe         /home/$USERNAME/
COPY examples           /home/$USERNAME/examples
COPY basis              /home/$USERNAME/basis
COPY README.md          /home/$USERNAME/

RUN echo "module load mpi" >> /home/$USERNAME/.bashrc
#RUN echo "module load mpi" >> /home/$USERNAME/bashenv
#ENV BASH_ENV=/home/$USERNAME/bashenv

RUN  chown -R $USERNAME:$USERNAME /home/$USERNAME
WORKDIR /home/$USERNAME
USER $USERNAME

CMD env
