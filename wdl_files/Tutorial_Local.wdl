workflow tutorial {
  String workdir
  Array[File] fastq_files
  Array[Pair[File, File]] fastq_files_paired
  scatter (sample in fastq_files_paired) {
    call Fastqc {
      input:
        workdir = workdir,
        fastq_R1 = workdir + "/files/" + sample.left,
        fastq_R2 = workdir + "/files/" + sample.right,
        base_name1 = basename(sample.left, ".fastq"),
        base_name2 = basename(sample.right, ".fastq"),
        fastqcdir = workdir + "/fastqc_container"
    }
  }
}

task Fastqc {
  File fastq_R1
  File fastq_R2
  String base_name1
  String base_name2
  String workdir
  String fastqcdir
  command {
    mkdir -p ${fastqcdir}
    fastqc ${fastq_R1} -o ${fastqcdir}
    fastqc ${fastq_R2} -o ${fastqcdir}
  }
  output {
    File fastqc_zip_1 = "${workdir}" + "/fastqc_container/${base_name1}_fastqc.zip"
    File fastqc_html_1 = "${workdir}" + "/fastqc_container/${base_name1}_fastqc.html"
    File fastqc_zip_2 = "${workdir}" + "/fastqc_container/${base_name2}_fastqc.zip"
    File fastqc_html_2 = "${workdir}" + "/fastqc_container/${base_name2}_fastqc.html"
  }
}
