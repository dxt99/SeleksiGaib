# Unsupervised Learning
Direktori ini berisi implementasi algoritma clustering unsupervised learning.

## Cara Menjalankan Program
Program ini dibuat menggunakan bahasa [Ruby](https://www.ruby-lang.org/en/documentation/installation/). Program dapat dijalankan dengan menjalankan `ruby ./src/main.rb` pada direktori ini.

## Spesifikasi Program
- ### Masukan data
Program akan meminta masukan data berupa nama file csv. File csv harus berata pada direktori `./data/`. Misalnya, untuk memberi masukan `water.csv` yang sudah berada pada direktori `./data/`, cukup dimasukkan `water.csv` pada program. Data masukan diasumsikan sudah disanitasi, sehingga data masukan tidak memiliki header atribut, semua kolom data merupakan kolom numerik, dan tidak ada entri yang kosong.
- ### Metode Clustering
Setelah memasukkan data, program akan memberi pilihan metode clustering data, yaitu [DBScan](https://en.wikipedia.org/wiki/DBSCAN), [KMeans](https://en.wikipedia.org/wiki/K-means_clustering), atau [KMedoids](https://en.wikipedia.org/wiki/K-medoids), dan meminta masukan tambahan sesuai metode, yaitu nilai epsilon dan minimum points untuk DBScan, nilai K dan iterasi maksimum untuk KMeans, serta nilai K untuk KMedoids. Ketiga algoritma menghitung cost/distance menggunakan [euclidian distance](https://en.wikipedia.org/wiki/Euclidean_distance), serta data masukan akan dinormalisasi terlebih dahulu menggunakan [min-max normalization](https://en.wikipedia.org/wiki/Feature_scaling#Rescaling_(min-max_normalization)). Perhatikan bahwa untuk DBScan, masukan epsilon akan dibandingkan dengan data yang sudah dinormalisasi.