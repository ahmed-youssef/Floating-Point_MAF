#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "FLP_MAF.h"

uint32_t mult_shift_amount;

int main()
{
   float A, B, C, maf, F;
   float_i a, b, c, MAF;
   uint64_t m_AB;
   uint32_t comp_i, comp_add=0;
   int32_t shift_amount;
   uint64_t m_C;
   int64_t adder_result;
   uint32_t LZN, maf_hex;

   A = 0.5;
   B = -0.5;
   C = 1000000.06;

   F = A*B + C;

   conv_to_float_i(&a, A);
   conv_to_float_i(&b, B);
   conv_to_float_i(&c, C);

   // First Stage
   comp_i = is_comp(a.sign, b.sign, c.sign);
   shift_amount = align_calc(a.exp, b.exp, c.exp);
   m_C = align_shifter(c.mantissa, shift_amount, comp_i);
   printf("a.mantissa = %llX\n", a.mantissa);
   printf("b.mantissa = %llX\n", b.mantissa);
   printf("c.mantissa = %llX\n", c.mantissa);
   printf("a.exp = %u\n", a.exp);
   printf("b.exp = %u\n", b.exp);
   printf("c.exp = %u\n", c.exp);

   m_AB = a.mantissa * b.mantissa;

   if(mult_shift_amount>0){
      m_AB = m_AB >> (uint64_t)mult_shift_amount;
   }

   //Second Stage
   adder_result = m_AB + m_C;
   if(adder_result < 0)
   {
      adder_result = -adder_result;
      comp_add = 1;
   }
   MAF.exp = exp_calc(a.exp, b.exp, c.exp);
   MAF.sign = sign_logic((a.sign)^(b.sign), c.sign, comp_add);

   //Third Stage
   LZN = LZD(adder_result);
   MAF.exp = exp_adj(MAF.exp, LZN);
   MAF.mantissa = Normalize(adder_result, LZN);
   maf = conv_from_float_i(&MAF);

   memcpy(&maf_hex, &maf, sizeof maf);
   printf("F mantissa = %00llX\n", get_mantissa(F));
   printf("F exp = %u\n", get_exp(F));
   printf("maf = %f\nF = %f\n", maf, F);
   printf("float maf hex = %X\n", maf_hex);
   return 0;
}

uint64_t get_mantissa(float f)
{
   uint64_t mantissa=0;

   memcpy(&mantissa, &f, sizeof f);
   mantissa = mantissa & 0x7FFFFF; //mask mantissa
   mantissa = mantissa | 0x0000000000800000; //add hidden one

   return mantissa;
}

uint32_t get_exp(float f)
{
   uint32_t exp=0;

   memcpy(&exp, &f, sizeof f);
   exp = exp & 0x7F800000; // mask exponent
   exp = exp >> 23;
   return exp;
}

uint32_t get_sign(float f)
{
   uint32_t sign=0;

   memcpy(&sign, &f, sizeof f);
   sign = sign & 0x80000000;

   sign = sign >> 31;
   return sign;
}

void conv_to_float_i(float_i* f, float F)
{
   f->mantissa = get_mantissa(F);
   f->exp = get_exp(F);
   f->sign = get_sign(F);
}

float conv_from_float_i(float_i* f)
{
   uint64_t temp=0;
   float result;

   temp = f->mantissa;
   temp = temp & (uint64_t)0x7FFFFF;
   temp = temp | ((f->exp) << 23);

   if(f->sign == 1) temp = temp | (1 << 31);

   memcpy(&result, &temp, sizeof(float));

   return result;
}

void print_float_i(float_i* f)
{
   printf("exponent is %0X\n", f->exp);
   printf("mantissa is %016llX\n", f->mantissa);
   printf("sign is %u\n", f->sign);
}

uint32_t is_comp(uint32_t sign_a,
                 uint32_t sign_b,
                 uint32_t sign_c)
{
   return sign_a^sign_b^sign_c;
}

uint32_t align_calc(uint32_t exp_a,
                    uint32_t exp_b,
                    uint32_t exp_c)

{
   int32_t shift_amount, exp_AB;

   exp_AB = exp_a + exp_b - 127 + 16;

   shift_amount = exp_AB - exp_c;
   mult_shift_amount= 0;
   if(shift_amount < 0)
   {
      if(shift_amount < -10)shift_amount = -10;
      mult_shift_amount = -shift_amount;
      shift_amount = 0;
   } else if(shift_amount > 64){
      shift_amount = 64;
   }

   return shift_amount;
}

uint64_t align_shifter(uint64_t mantissa_c,
                       int32_t shift_amount,
                       uint32_t comp_i)
{
   uint64_t m_C=0, shift;

   shift = 39;
   mantissa_c = mantissa_c << shift;
   m_C = mantissa_c>>(uint64_t)(shift_amount);
   if(comp_i)
   {
      m_C = ~m_C + 1;
   }
   return m_C;
}

uint32_t exp_calc(uint32_t exp_a,
                  uint32_t exp_b,
                  uint32_t exp_C)
{
   uint32_t exp_MAF_int;
   int32_t exp_AB;

   exp_AB = exp_a + exp_b - 111;
   if(exp_AB < 0) exp_AB = 0;

   if(exp_C > exp_AB)
   {
      exp_MAF_int = exp_C;
   } else {
      exp_MAF_int = exp_AB;
   }

   return exp_MAF_int;
}


uint32_t sign_logic(uint32_t sign_AB,
                    uint32_t sign_c,
                    uint32_t comp_add)
{
   uint32_t sign_MAF=0;

   sign_MAF = (sign_AB & (~comp_add & 0x1)) | (sign_c & comp_add);

   return sign_MAF;
}

uint32_t LZD(int64_t adder_result)
{
   uint32_t LZN;
   uint64_t MSB;

   adder_result = adder_result << (uint64_t) 1;
   MSB = (uint64_t)1 << (uint64_t)63;

   LZN = 0;
   while(!(adder_result & MSB))
   {
      adder_result = adder_result << (uint64_t)1;
      LZN++;
   }

   return LZN;
}

uint32_t exp_adj(uint32_t exp, uint32_t LZN)
{
   int32_t exp_MAF=0;

   exp_MAF = exp - LZN;
   if(exp_MAF < 0) exp_MAF = -1;

   return exp_MAF;
}

uint32_t Normalize(uint64_t adder_result, uint32_t LZN)
{
   uint64_t mantissa=0;

   mantissa = adder_result << (uint64_t)LZN; //Normalize
   mantissa = mantissa >> (uint64_t)39;//truncate;

   return mantissa;
}
