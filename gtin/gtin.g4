/*
BSD License

Copyright (c) 2017, Tom Everett
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of Tom Everett nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*

http://www.gtin.info/

*/
grammar gtin;

gtin
    : (gtin8 | gtin12 | gtin13) EOF
    ;

gtin8
    : ean8
    ;

ean8
    : DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT
    ;

gtin12
    : upc
    ;

gtin13
    : /*('0' upc)  
    | */ ean13
    ;

upc
   : (upc_a | upc_e) 
   ;

// 12 digits (1+5+5+1)
upc_a
   : num_system upc_a_manufacturer upc_a_product check_code supplemental_code?
   ;

upc_a_manufacturer
   : upc_a_5
   ;

upc_a_product
   : upc_a_5
   ;

upc_a_5
   : DIGIT DIGIT DIGIT DIGIT DIGIT
   ;

upc_e
   : DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT
   ;

num_system
   : DIGIT
   ;

check_code
   : DIGIT
   ;

supplemental_code
   : supplemental_code_5
   | supplemental_code_2
   ;

supplemental_code_5
   : DIGIT DIGIT DIGIT DIGIT DIGIT
   ;

supplemental_code_2
   : DIGIT DIGIT
   ;

// 13 digits (3+9+1)
ean13
    : gs1_prefix ean_13_manprod check_code supplemental_code?
    ;

// 9 digits in two groups of variable length
ean_13_manprod
    : DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT
    ;

gs1_prefix
    : DIGIT DIGIT DIGIT
    ;


DIGIT
   : ('0' .. '9')
   ;

HYPHEN
   : '-' -> skip
   ;

WS
   : [ \t\r\n] + -> skip
   ;