```markdown
# 📚 Panduan Pemula Verilog untuk Semua Kalangan

**Verilog** adalah bahasa deskripsi perangkat keras (HDL) untuk memodelkan sistem digital. Mari pelajari syntax penting dengan contoh yang mudah dipahami!

![Verilog Banner](https://example.com/verilog-banner.jpg) **(Ganti dengan link gambar sesuai kebutuhan)***

## 🧱 Struktur Dasar Modul
Setiap komponen digital dimodelkan sebagai **modul** dengan antarmuka dan logika internal.

```verilog
module NamaModul (
    input  wire a,      // Input port
    output reg  b       // Output port
);
    // Logika internal di sini
endmodule
```

## 🎨 3 Gaya Pemodelan
### 1. Structural (Rangkaian)
```verilog
module GerbangAND (
    input  wire a, b,
    output wire y
);
    and(y, a, b);  // Instansiasi gerbang AND
endmodule
```

### 2. Dataflow (Aliran Data)
```verilog
module Penjumlahan (
    input  wire [3:0] a, b,
    output wire [3:0] hasil
);
    assign hasil = a + b;  // Operasi langsung
endmodule
```

### 3. Behavioral (Perilaku)
```verilogmodule Pembilang (
    input  wire clk,
    output reg [7:0] count
);
    always @(posedge clk) begin
        count <= count + 1;  // Update di clock edge
    end
endmodule
```

## 🔑 Syntax Penting
### Tipe Data Dasar
| Tipe   | Deskripsi                          | Contoh           |
|--------|------------------------------------|------------------|
| `wire` | Koneksi fisik (seperti kabel)     | `wire led;`      |
| `reg`  | Penyimpanan nilai (seperti memori)| `reg [3:0] num;` |

### Contoh Operasi
```verilog
// Bitwise
assign y = a & b;    // AND
assign z = a | b;    // OR

// Aritmatika
assign sum = a + 5;
assign diff = b - 3;

// Perbandingan
assign isGreater = (a > 10);
```

## 🕹 Struktur Kontrol
### Pengambilan Keputusan
```verilog
// If-Else
always @(*) begin
    if (suhu > 30) kipas = 1;
    else if (suhu < 20) kipas = 0;
    else kipas = kipas;
end

// Switch-Case
always @(*) begin
    case (mode)
        2'b00: lampu = 3'b001;
        2'b01: lampu = 3'b010;
        default: lampu = 3'b100;
    endcase
end
```

### Perulangan
```verilog
integer i;
always @(*) begin
    for(i=0; i<8; i=i+1) begin
        // Lakukan sesuatu 8x
    end
end
```

## ⏱ Timing & Paralelisme
```verilog
initial begin
    #10;           // Delay 10 unit waktu
    data = 8'hFF;  // Set data setelah delay
    #5 clk = ~clk; // Toggle clock tiap 5 unit
end
```

## 🧪 Membuat Testbench
```verilog
module Testbench;
    reg clk;
    wire [7:0] output;
    
    // Generate clock
    always #5 clk = ~clk;
    
    // Instansiasi modul
    ModulSaya uut(clk, output);
    
    initial begin
        clk = 0;
        #100;       // Jalankan 100 unit waktu
        $finish;    // Akhiri simulasi
    end
endmodule
```

## 💡 Tips Penting
1. **Paralelisme**: Semua blok `always` berjalan bersamaan
2. **Non-blocking**: Gunakan `<=` untuk flip-flop
3. **Blocking**: Gunakan `=` untuk logika kombinasional
4. **Vector**: `reg [3:0]` = 4-bit (MSB ke LSB)

## 🚀 Contoh Projek Sederhana
**Saklar Pintar** - Menyalakan lampu jika gelap dan ada gerakan
```verilog
module SmartSwitch (
    input  wire sensorGerak,
    input  wire sensorCahaya,
    output reg  lampu
);
    always @(*) begin
        lampu = sensorGerak && !sensorCahaya;
    end
endmodule
```

## 📖 Referensi Cepat
| Simbol | Arti          | Contoh       |
|--------|---------------|--------------|
| `[]`   | Bit selector  | `data[3:0]`  |
| `#`    | Delay         | `#10 a = 1;` |
| `'b`   | Binary literal| `4'b1010`    |
| `'h`   | Hex literal   | `8'hFF`      |

```
**🎉 Selamat Mencoba!** Mulailah dengan modul sederhana dan perlahan tingkatkan kompleksitasnya.
```
