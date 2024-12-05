`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 19:25:34
// Design Name: 
// Module Name: control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module control (
    input logic clk,    //reloj
    input logic rst,    //reset
    input logic go, mayor, mayor_2, data_exist, ready, n_max, n_max2,algoritmo,
    input logic [3:0] DONE1,
    input logic [5:0] DONE2,
    output logic [5:0] EN2,
    output logic [3:0] EN1,
    output logic [1:0] select_counter, select_addr_newman,
    output logic we, re, select, enable, write2,select_out,enable2,set,select_out_sequence,set_n
);

    // Declaración de los estados
    typedef enum {
        INICIO,
        SELECT_ALGORITM,
        
                //diagrama de estados para la secuencia de recaman
            RECAMAN,
                INCREMENTO,
                ACT_REG1,
                LECTURA,
                ACT_REG2,
                ACT_REG3,
                ACT_REG4,
                COMPROBAR_EXIST,
                FOUND,
                DESBORDE,
                
                //diagrama de estados para la secuencia de newman
        NEWMAN,
            INC,
            ESCRIBIR,
            DESB,
            COMPARAR,
            REG1,
            LEER1,
            LEER2,
            LEER3,
            REG5,
            REG3,
            REG4_REG6,
            ESCRITURA,
           
           //lectura de datos y mostrar en display
            
        DISPLAY,
            //finaliza
        FINISH
        
    } Estado;

    Estado estado_actual, estado_siguiente;

    // Sincronización de señales de entrada
    logic go_sync, mayor_sync, mayor2_sync, data_exist_sync, ready_sync, n_max_sync, n_max2_sync;
    logic done1_sync, done2_sync, done3_sync, done4_sync;
    logic d1_sync,d2_sync,d3_sync,d4_sync,d5_sync,d6_sync;
    

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            go_sync <= 0;
            mayor_sync <= 0;
            mayor2_sync <= 0;
            data_exist_sync <= 0;
            ready_sync <= 0;
            n_max_sync <= 0;
            n_max2_sync <= 0;
            done1_sync <= 0;
            done2_sync <= 0;
            done3_sync <= 0;
            done4_sync <= 0;
            d1_sync <= 0;
            d2_sync <= 0;
            d3_sync <= 0;
            d4_sync <= 0;
            d5_sync <= 0;
            d6_sync <= 0;
        end else begin
            go_sync <= go;
            mayor_sync <= mayor;
            mayor2_sync <= mayor_2;
            data_exist_sync <= data_exist;
            ready_sync <= ready;
            n_max_sync <= n_max;
            n_max2_sync <= n_max2;
            done1_sync <= DONE1[0];
            done2_sync <= DONE1[1];
            done3_sync <= DONE1[2];
            done4_sync <= DONE1[3];
            d1_sync <= DONE2[0];
            d2_sync <= DONE2[1];
            d3_sync <= DONE2[2];
            d4_sync <= DONE2[3]; 
            d5_sync <= DONE2[4];
            d6_sync <= DONE2[5];
        end
    end

    // cambia de estados 
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            estado_actual <= INICIO;  // Reset a estado inicial
        end else begin
            estado_actual <= estado_siguiente;  // Transición de estado
        end
    end

    // Lógica de transición de estados
    always_comb begin
        case (estado_actual)
        
            INICIO: 
                estado_siguiente = (go_sync) ? SELECT_ALGORITM : INICIO;
                
            SELECT_ALGORITM :
                 estado_siguiente = (algoritmo) ? RECAMAN:NEWMAN;
                 
                
                //recaman logica de transicion para el algoritmo 
                
                    RECAMAN: 
                        estado_siguiente = INCREMENTO;
        
                    INCREMENTO: 
                        estado_siguiente = DESBORDE;
                        
                    DESBORDE: 
                        estado_siguiente = (n_max_sync) ? DISPLAY : ACT_REG1;
                        
                    LECTURA: 
                        estado_siguiente = (ready_sync) ? ACT_REG2 : LECTURA;
        
                    ACT_REG1: 
                        estado_siguiente = (done1_sync) ? LECTURA : ACT_REG1;
                        
                    ACT_REG2: 
                        estado_siguiente = (~done2_sync) ? ACT_REG2 : 
                                           (done2_sync && ~mayor_sync ) ? ACT_REG3 : ACT_REG4;
        
                    ACT_REG3: 
                        estado_siguiente = (done3_sync) ? ACT_REG4 : ACT_REG3;
        
                    ACT_REG4: 
                        estado_siguiente = (done4_sync) ? ACT_REG4 : COMPROBAR_EXIST;
                              
                    COMPROBAR_EXIST: 
                        estado_siguiente = (ready_sync) ? FOUND : COMPROBAR_EXIST;
        
                    FOUND: 
                        estado_siguiente = (data_exist_sync) ? ACT_REG3 : INCREMENTO;
                    
                    DISPLAY:
                        estado_siguiente = (n_max2_sync) ? FINISH : DISPLAY;                 
        
                    FINISH: 
                        estado_siguiente = (rst) ? INICIO : FINISH;
        
        //newman logica transicion para el algoritmo 
        
      NEWMAN:
        estado_siguiente = INC;
      
      INC:
        estado_siguiente = DESB;
        
      DESB:
        estado_siguiente = (n_max_sync) ? DISPLAY : COMPARAR;
      
      COMPARAR:
        estado_siguiente = (~mayor2_sync) ? REG1: ESCRIBIR;
      
      ESCRIBIR:
        estado_siguiente = (ready_sync) ? INC : ESCRIBIR;
        
      REG1:
        estado_siguiente = (d1_sync) ? LEER1: REG1;
        
      LEER1:
        estado_siguiente = (ready_sync) ? REG5: LEER1;
      
      REG5:
        estado_siguiente = (d2_sync || d5_sync) ? LEER2: REG5;
      
      LEER2:
        estado_siguiente = (ready_sync) ? REG3: LEER2;
      
      REG3:
        estado_siguiente = (d3_sync) ? LEER3: REG3;
      
      LEER3:
        estado_siguiente = (ready_sync) ? REG4_REG6: LEER3;
      
      REG4_REG6:
        estado_siguiente = (d6_sync) ? ESCRIBIR: REG4_REG6;
        
            default:
                estado_siguiente = INICIO;  // Estado de reinicio
            
        endcase
    end

    // Logica combinacional para mandar señales de control segun el estadoa actual
    always_comb begin
        // Valores por defecto
        set_n=1'b0;
        we = 1'b0;
        re = 1'b0;
        EN1[0] = 1'b0;
        EN1[1] = 1'b0;
        EN1[2] = 1'b0;
        EN1[3] = 1'b0;
        EN2[0] = 1'b0;
        EN2[1] = 1'b0;
        EN2[2] = 1'b0;
        EN2[3] = 1'b0;
        EN2[4] = 1'b0;
        EN2[5] = 1'b0;
        enable2=1'b0;
        enable = 1'b0;
        select_out= 1'b1;
        
        // Lógica específica por estado
        case (estado_actual)
            INICIO: begin
                set_n=1'b1;  
                enable = 1'b0;
                select_out=1'b1;             
            end
            
         // LOGICA DE NEWMAN
            NEWMAN: begin
            select_counter = 2'b01;
            select_out_sequence=1'b1;
            select_addr_newman=2'b00;
            write2= 1'b1;
            end
            
            INC:begin
                if(-mayor2_sync)begin
                set=1'b1;
                EN2[5] = 1'b1;
                EN2[0] = 1'b1;
                end
                enable = 1'b1;
                enable2 = 1'b0;
            end
            
            COMPARAR:begin
            if(-mayor2_sync)begin
                set=1'b1;
                EN2[0] = 1'b1;
                end
            EN2[5] = 1'b1;
            end
            
            REG1: begin
            set=1'b0;
            EN2[5] = 1'b0;
            EN2[0]=1'b1;
            select_addr_newman=2'b00;
            end
                       
            LEER1:begin
            re=1'b1;
            EN2[1]=1'b1;
            end
            
            REG5:begin
            select_addr_newman=2'b10;
            EN2[4]=1'b1;
            end
            
            LEER2:begin
            re=1'b1;
            end
            
            REG3:begin
            select_addr_newman=2'b01;
            EN2[2]=1'b1;
            end
            
            LEER3:begin
            re=1'b1;
            end
            
            REG4_REG6:begin
            EN2[3]=1'b1;
            EN2[5]=1'b1;
            select_addr_newman=2'b00;
            end
            
            ESCRIBIR: begin
            we = (~ready_sync) ? 1'b1 : 1'b0;
            end
                   
          //LOIGCA DE RECAMAN
            
            RECAMAN: begin
            select_counter = 2'b00;
            select_out_sequence=1'b0;
            end   
            
            INCREMENTO: begin
                enable = 1'b1;
                EN1[3] = 1'b0;
            end

            ACT_REG1: begin
                EN1[0] = 1'b1;
            end

            LECTURA: begin
                re = 1'b1;
            end

            ACT_REG2: begin
                EN1[1] = 1'b1;
                select = 1'b0;
                write2= 1'b0;
            end

            ACT_REG3: begin
                EN1[2] = 1'b1;
                select = 1'b1;
                write2= 1'b1;
            end

            ACT_REG4: begin
                EN1[3] = 1'b1;
            end 
            
            FOUND: begin 
            end
            
            COMPROBAR_EXIST: begin
                we = (~ready_sync) ? 1'b1 : 1'b0;
            end
             
            DISPLAY: begin
            enable2=1'b1;
            re = 1'b1;
            select_counter = 2'b10;
            select_out= 1'b0;
            end
            
            FINISH: begin
            re = 1'b0;
            select_out=1'b0;
            enable2=1'b0;
            end

        endcase
    end

endmodule



