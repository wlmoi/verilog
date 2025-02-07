`timescale 1ns / 1ps

// Nama         : William Anthony
// NIM          : 13223048
// Tanggal      : 7 Februari 2025
// Fungsi       : Multiplier fleksibel dengan input signed dan output lebih besar untuk menangani overflow
// Deskripsi Cara Kerja :
//   - Modul ini menerima dua input `A` dan `B` yang bertipe signed dengan lebar M-bit dan N-bit.
//   - Hasil perkalian `PROD` memiliki lebar (M+N+1) bit untuk menghindari overflow.
//   - Output `PROD` menyimpan hasil dari `A * B` dalam format signed.

module W_Multiplier #(parameter M = 8, parameter N = 8) ( // M dan N dapat diubah sesuai kebutuhan
    input  signed [M-1:0] A,      // Input pertama, signed dengan M-bit
    input  signed [N-1:0] B,      // Input kedua, signed dengan N-bit
    output signed [M+N:0] PROD    // Output hasil perkalian, signed dengan (M+N+1)-bit
);

    assign PROD = A * B;  // Perkalian signed, hasil memiliki tambahan 1 bit untuk overflow

endmodule
