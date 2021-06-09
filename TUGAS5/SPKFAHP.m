namaSiswa = {'Kageyama' 'Bokuto' 'Hinata' 'Atsumu'};
data = [ 95 88 70
         87 79 90
         60 75 88
         92 97 79];
    
maksNilaiPsikotes = 100;
maksNilaiAkademik = 100;
maksNilaiNonAkademik = 100;

data(:,1) = data(:,1) / maksNilaiPsikotes
data(:,2) = data(:,2) / maksNilaiAkademik
data(:,3) = data(:,3) / maksNilaiNonAkademik

relasiAntarKriteria = [ 1     2     2
                          0     1     4
                          0     0     1];
                      
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};
   
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)
if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);    

    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria';
    
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama siswa, skor akhir, Kelas')
end

    for i = 1:size(ahp, 1)
        if ahp(i) < 0.5
            status = 'Reguler';
        elseif ahp(i) < 0.75
            status = 'Prestasi';
        elseif ahp(i) < 0.95
            status = 'Beasiswa plus';
        end
        
        disp([char(namaSiswa(i)), blanks(13 - cellfun('length',namaSiswa(i))), ', ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
             char(status)])
    end