`timescale 1ns/1ps
module tb ();

reg clk_t;
reg reset_t;
reg [7:0] adc_out_t;
wire alarm_t, shutdown_t;


PipeTemp DUT (
.clk(clk_t),
.reset(reset_t),
.adc_out(adc_out_t),
.alarm(alarm_t),
.shutdown(shutdown_t)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk_t=~clk_t;


initial begin

clk_t = 1;
reset_t = 0;
adc_out_t = 8'd0;
#10
reset_t = 1;
$display ("******************* test the normal operation ***************************");
adc_out_t = 8'd100; 
#10.001
if (alarm_t == 0 && shutdown_t == 0) 
    $display ("testcase passed");
else 
    $display ("testcase failed");

adc_out_t = 8'd200;
#10.001
if (alarm_t == 1 && shutdown_t == 0) 
    $display ("testcase passed");
else 
    $display ("testcase failed");

adc_out_t = 8'd0;
#10
adc_out_t = 8'd255;
#10.001
if (alarm_t == 0 && shutdown_t == 1) 
    $display ("testcase passed");
else 
    $display ("testcase failed");
$display ("******************* finishing test the normal operation ***************************");


$display ("******************* test the alarm operation ***************************");
adc_out_t = 8'd200;
#10
adc_out_t = 8'd0;
#10.001
if (alarm_t == 0 && shutdown_t == 0) 
    $display ("testcase passed");
else 
    $display ("testcase failed");

adc_out_t = 8'd200;
#10.001
if (alarm_t == 1 && shutdown_t == 0) 
    $display ("testcase passed");
else 
    $display ("testcase failed");

adc_out_t = 8'd255;
#10.001
if (alarm_t == 0 && shutdown_t == 1) 
    $display ("testcase passed");
else 
    $display ("testcase failed");
$display ("******************* finishing test the alarm operation ***************************");


$display ("******************* test the shut down operation ***************************");
adc_out_t = 8'd255;
#10
adc_out_t = 8'd0;
#10.001
if (alarm_t == 0 && shutdown_t == 0) 
    $display ("testcase passed");
else 
    $display ("testcase failed");

adc_out_t = 8'd255;
#10
adc_out_t = 8'd200;
#10.001

if (alarm_t == 1 && shutdown_t == 0) 
    $display ("testcase passed");
else 
    $display ("testcase failed");

adc_out_t = 8'd255;
#10
adc_out_t = 8'd255;
#10.001

if (alarm_t == 0 && shutdown_t == 1) 
    $display ("testcase passed");
else 
    $display ("testcase failed");
$display ("******************* finishing test the shut down operation ***************************");
    
$stop;
end
endmodule