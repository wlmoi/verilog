`timescale 1ns / 1ps

// Nama         : William Anthony
// NIM          : 13223048
// Tanggal      : 7 Februari 2025
// Fungsi       : Subtractor fleksibel dengan input berukuran N-bit dan output (N+2)-bit
// Deskripsi Cara Kerja :
//   - Modul ini menerima dua input `A` dan `B` yang bertipe signed dengan lebar N-bit.
//   - Hasil pengurangan `DIFF` memiliki lebar (N+2) bit untuk menghindari overflow.
//   - Output `DIFF` menyimpan hasil dari `A - B` dalam format signed.

module W_Subtractor #(parameter N = 8) (  // N dapat diubah sesuai kebutuhan
    input  signed [N-1:0] A,      // Input pertama, signed dengan N-bit
    input  signed [N-1:0] B,      // Input kedua, signed dengan N-bit
    output signed [N+1:0] DIFF    // Output hasil pengurangan, signed dengan (N+2)-bit
);

    assign DIFF = A - B;  // Operasi signed subtraction

endmodule
