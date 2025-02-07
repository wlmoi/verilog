`timescale 1ns / 1ps

// Nama         : William Anthony
// NIM          : 13223048
// Tanggal      : 7 Februari 2025
// Fungsi       : Divider fleksibel berbasis FSM untuk mengurangi penggunaan resource FPGA
// Deskripsi Cara Kerja :
//   - Menggunakan Finite State Machine (FSM) untuk melakukan pembagian secara iteratif.
//   - Input berupa `A` (dividend) dan `B` (divisor), keduanya signed dengan lebar M-bit dan N-bit.
//   - Hasil pembagian berupa `QUOTIENT` (M-bit) dan `REMAINDER` (N-bit).
//   - Jika `B = 0`, output `QUOTIENT` dan `REMAINDER` diset ke 0 untuk menghindari error pembagian nol.
//   - Operasi dilakukan melalui pengurangan dan shifting dalam loop FSM.

module FSM_Divider #(parameter M = 8, parameter N = 8) (
    input clk,                    // Clock
    input rst,                    // Reset
    input start,                  // Start signal
    input signed [M-1:0] A,        // Dividend
    input signed [N-1:0] B,        // Divisor
    output reg signed [M-1:0] QUOTIENT,  // Quotient
    output reg signed [N-1:0] REMAINDER, // Remainder
    output reg done               // Done signal
);

    // FSM states
    typedef enum reg [1:0] {IDLE, INIT, DIVIDE, FINISH} state_t;
    state_t state;

    // Internal registers
    reg signed [M:0] dividend;  // Extended dividend
    reg signed [N-1:0] divisor; // Divisor register
    reg signed [M-1:0] quotient;
    reg [M-1:0] count;          // Counter for division loop

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers
            state      <= IDLE;
            QUOTIENT   <= 0;
            REMAINDER  <= 0;
            done       <= 0;
            dividend   <= 0;
            divisor    <= 0;
            quotient   <= 0;
            count      <= 0;
        end else begin
            case (state)
                // IDLE: Wait for start signal
                IDLE: begin
                    if (start) begin
                        state <= INIT;
                    end
                end

                // INIT: Load values, handle division by zero
                INIT: begin
                    done      <= 0;
                    quotient  <= 0;
                    count     <= M;
                    
                    if (B == 0) begin
                        QUOTIENT  <= 0; // Prevent division by zero
                        REMAINDER <= 0;
                        state     <= FINISH;
                    end else begin
                        dividend  <= A;
                        divisor   <= B;
                        state     <= DIVIDE;
                    end
                end

                // DIVIDE: Perform iterative subtraction and shifting
                DIVIDE: begin
                    if (count > 0) begin
                        dividend = dividend - divisor;  // Subtract divisor from dividend
                        quotient = (quotient << 1) | (dividend >= 0);  // Shift quotient left
                        count    = count - 1;
                    end else begin
                        state <= FINISH;
                    end
                end

                // FINISH: Store results and set done flag
                FINISH: begin
                    QUOTIENT  <= quotient;
                    REMAINDER <= dividend; // Remainder is the final value of the dividend
                    done      <= 1;
                    state     <= IDLE; // Return to IDLE
                end
            endcase
        end
    end
endmodule
