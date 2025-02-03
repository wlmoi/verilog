`timescale 1ns/1ps

// =======================
// Modul CORDIC
// =======================
module cordic_sin_cos #(
    parameter WIDTH = 16,  
    parameter ITER = 16    
)(
    input signed [WIDTH-1:0] angle,   
    output reg signed [WIDTH-1:0] sin_out, 
    output reg signed [WIDTH-1:0] cos_out, 
    input clk,  
    input rst,
    output reg done  // Indikasi bahwa iterasi selesai
);

    reg signed [WIDTH-1:0] atan_table [0:ITER-1];
    reg signed [WIDTH-1:0] x, y, z;
    reg [4:0] i;  

    initial begin
        atan_table[0]  = 16'sd25735;  
        atan_table[1]  = 16'sd15192;  
        atan_table[2]  = 16'sd8027;   
        atan_table[3]  = 16'sd4074;   
        atan_table[4]  = 16'sd2045;   
        atan_table[5]  = 16'sd1023;   
        atan_table[6]  = 16'sd511;    
        atan_table[7]  = 16'sd255;    
        atan_table[8]  = 16'sd127;    
        atan_table[9]  = 16'sd63;     
        atan_table[10] = 16'sd31;
        atan_table[11] = 16'sd15;
        atan_table[12] = 16'sd7;
        atan_table[13] = 16'sd3;
        atan_table[14] = 16'sd1;
        atan_table[15] = 16'sd1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x <= 16'sd19898; // 0.607252 * 32768 (Scaling factor dalam Q1.15)
            y <= 16'sd0;
            z <= angle;
            i <= 0;
            done <= 0;
        end else if (i < ITER) begin
            if (z >= 0) begin
                x <= x - (y >>> i);
                y <= y + (x >>> i);
                z <= z - atan_table[i];
            end else begin
                x <= x + (y >>> i);
                y <= y - (x >>> i);
                z <= z + atan_table[i];
            end
            i <= i + 1;
        end else if (!done) begin
            sin_out <= y; 
            cos_out <= x; 
            done <= 1;
        end
    end

endmodule

// =======================
// Testbench CORDIC
// =======================
module cordic_tb;

    parameter WIDTH = 16;
    parameter ITER = 16;

    reg signed [WIDTH-1:0] angle;   
    wire signed [WIDTH-1:0] sin_out; 
    wire signed [WIDTH-1:0] cos_out; 
    reg clk;  
    reg rst;  
    wire done;  

    cordic_sin_cos #(.WIDTH(WIDTH), .ITER(ITER)) uut (
        .angle(angle),
        .sin_out(sin_out),
        .cos_out(cos_out),
        .clk(clk),
        .rst(rst),
        .done(done)
    );

    always #50 clk = ~clk;  // Clock lebih lambat

    function signed [WIDTH-1:0] deg_to_fixed;
        input real deg;
        real rad;
    begin
        rad = deg * 3.14159265358979 / 180.0;
        deg_to_fixed = rad * (2**15);  
    end
    endfunction

    function real fixed_to_float;
        input signed [WIDTH-1:0] value;
    begin
        fixed_to_float = value / (2.0 ** 15);
    end
    endfunction

    initial begin
        clk = 0;
        rst = 1;
        angle = 0;
        #100 rst = 0;

        angle = deg_to_fixed(0);    
        wait(done);  #500;  
        $display("Angle: 0°  -> Sin: %f, Cos: %f", fixed_to_float(sin_out), fixed_to_float(cos_out));

        rst = 1; #100; rst = 0; // Reset ulang sebelum setiap iterasi
        angle = deg_to_fixed(30);   
        wait(done);  #500;
        $display("Angle: 30° -> Sin: %f, Cos: %f", fixed_to_float(sin_out), fixed_to_float(cos_out));

        rst = 1; #100; rst = 0;
        angle = deg_to_fixed(45);   
        wait(done);  #500;
        $display("Angle: 45° -> Sin: %f, Cos: %f", fixed_to_float(sin_out), fixed_to_float(cos_out));

        rst = 1; #100; rst = 0;
        angle = deg_to_fixed(60);   
        wait(done);  #500;
        $display("Angle: 60° -> Sin: %f, Cos: %f", fixed_to_float(sin_out), fixed_to_float(cos_out));

        rst = 1; #100; rst = 0;
        angle = deg_to_fixed(90);   
        wait(done);  #500;
        $display("Angle: 90° -> Sin: %f, Cos: %f", fixed_to_float(sin_out), fixed_to_float(cos_out));

        #100;
        $stop;
    end
endmodule
