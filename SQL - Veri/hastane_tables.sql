CREATE TABLE poliklinikler (
    poliklinik_id SERIAL PRIMARY KEY,
    poliklinik_adi VARCHAR(100) NOT NULL,
    kat_no INT,
    telefon VARCHAR(15),
    aktif BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE hastalar (
    hasta_id SERIAL PRIMARY KEY,
    tc_no CHAR(11) NOT NULL UNIQUE,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    dogum_tarihi DATE NOT NULL,
    kan_grubu VARCHAR(5),
    cinsiyet CHAR(1) NOT NULL
        CHECK (cinsiyet IN ('K', 'E'))
);

CREATE TABLE doktorlar (
    doktor_id SERIAL PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    cinsiyet CHAR(1) NOT NULL
        CHECK (cinsiyet IN ('K', 'E')),
    uzmanlik_alani VARCHAR(100),
    poliklinik_id INT,
    unvan VARCHAR(50),
    CONSTRAINT fk_doktor_poliklinik
        FOREIGN KEY (poliklinik_id)
        REFERENCES poliklinikler (poliklinik_id)
        ON DELETE RESTRICT
);


CREATE TABLE randevular (
    randevu_id SERIAL PRIMARY KEY,
    hasta_id INT NOT NULL,
    doktor_id INT NOT NULL,
    tarih_saat TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    durum VARCHAR(10)
        CHECK (durum IN ('Geldi', 'Gelmedi')),
    CONSTRAINT fk_randevu_hasta
        FOREIGN KEY (hasta_id)
        REFERENCES hastalar (hasta_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_randevu_doktor
        FOREIGN KEY (doktor_id)
        REFERENCES doktorlar (doktor_id)
        ON DELETE CASCADE
);

CREATE TABLE teshisler (
    teshis_id SERIAL PRIMARY KEY,
    randevu_id INT NOT NULL,
    tani_kodu VARCHAR(20),
    recete_no VARCHAR(20),
    aciklama TEXT,
    CONSTRAINT fk_teshis_randevu
        FOREIGN KEY (randevu_id)
        REFERENCES randevular (randevu_id)
        ON DELETE CASCADE
);
