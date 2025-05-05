module PipeTemp (
input clk , reset ,
input [7:0] adc_out,
output reg alarm , shutdown 
);

localparam normal_state = 2'b00 ,
           alarm_state = 2'b01,
           shutdown_state = 2'b11;

reg [1:0] current_state , next_state ;


always @(posedge clk or negedge reset) begin 
    if (!reset) begin 
        current_state <= normal_state; end 
    else begin
        current_state <= next_state; 
    end 
end

 
always @ (*) begin
    case (current_state) 
        normal_state: begin if (adc_out == 8'd255) 
                        next_state = shutdown_state;
                    else if (adc_out >= 8'd192)
                        next_state = alarm_state;
                    else next_state = current_state; end    

        alarm_state: begin if (adc_out == 8'd255) 
                        next_state = shutdown_state;
                    else if (adc_out < 8'd192)
                        next_state = normal_state;
                    else next_state = current_state; end

        shutdown_state: begin if (adc_out < 8'd192)
                        next_state = normal_state;
                    else if (adc_out < 8'd255)
                        next_state = alarm_state;
                    else next_state = current_state;  end
    endcase 
end


always @(*) begin
    case (current_state)
        normal_state: begin alarm = 1'b0 ; shutdown = 1'b0; end 
        alarm_state: begin alarm = 1'b1 ; shutdown = 1'b0; end 
        shutdown_state: begin alarm = 1'b0 ; shutdown = 1'b1; end 
        default: begin alarm = 1'b0 ; shutdown = 1'b0; end 
    endcase
end

endmodule 
