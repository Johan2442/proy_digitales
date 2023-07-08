/**
 * Universidad de Costa Rica
 * Escuela de Ingeniería Eléctrica
 * Circuitos Digitales I - IE0323
 * Proyecto Verilog
 *
 * archivo: asm_ascensor.v
 * autores:
 * Sergio Garino Vargas - B73157
 * Johan Herrera Chaves - C03811
 *
 * Descripción: 
 * Modulo PWM capaz de generar pulsos con una frecuencia de 8 veces la señal de Clk
 */
module PWM_Generator (
    input Clk, Reset, // Señal de reloj y señal de reset
    input [1:0] DutyCycle, // Ciclo de trabajo (00: 0%, 01: 25%, 10: 50%, 11: 75%)
    output reg PWM // Salida de la señal de PWM
);

    reg [2:0] counter; // Contador de 3 bits para determinar el ciclo de trabajo
    always @(posedge Clk, posedge Reset)
    begin
        if (Reset)
            counter <= 3'b0; // Si se activa la señal de reset, se reinicia el contador
        else if (counter == 3'b111)
            counter <= 3'b0; // Cuando el contador alcanza el valor máximo, se reinicia
        else
            counter <= counter + 1; // Incrementa el contador en 1 en cada flanco de subida del reloj
    end

    always @(*)
    begin
        case (DutyCycle)
            2'b00: PWM = 1'b0; // Si el ciclo de trabajo es 0%, la salida de PWM es siempre 0
            2'b01: PWM = (counter < 2); // Si el ciclo de trabajo es 25%, la salida de PWM es 1 durante los primeros 2 ciclos del contador
            2'b10: PWM = (counter < 4); // Si el ciclo de trabajo es 50%, la salida de PWM es 1 durante los primeros 4 ciclos del contador
            2'b11: PWM = (counter < 6); // Si el ciclo de trabajo es 75%, la salida de PWM es 1 durante los primeros 6 ciclos del contador
        endcase
    end

endmodule
