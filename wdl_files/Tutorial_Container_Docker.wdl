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
    }
  }
}

task Fastqc {
  File fastq_R1
  File fastq_R2
  String base_name1
  String base_name2
  command {
    fastqc ${fastq_R1} -o .
    fastqc ${fastq_R2} -o .
  }
  output {
    File fastqc_zip_1 = "${base_name1}_fastqc.zip"
    File fastqc_html_1 = "${base_name1}_fastqc.html"
    File fastqc_zip_2 = "${base_name2}_fastqc.zip"
    File fastqc_html_2 = "${base_name2}_fastqc.html"
  }
  runtime {
    docker: "staphb/fastqc:0.11.8"
  }
}
