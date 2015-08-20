#ifndef FLP_MAF_H_INCLUDED
#define FLP_MAF_H_INCLUDED

typedef struct float_ii{
   uint64_t mantissa;
   uint32_t exp;
   uint32_t sign;
}float_i;


uint64_t get_mantissa(float f);
uint32_t get_exp(float f);
uint32_t get_sign(float f);
void conv_to_float_i(float_i* f, float F);
float conv_from_float_i(float_i* f);
void print_float_i(float_i* f);
uint32_t is_comp(uint32_t sign_a,
                 uint32_t sign_b,
                 uint32_t sign_c);
uint32_t align_calc(uint32_t exp_a,
                    uint32_t exp_b,
                    uint32_t exp_c);
uint64_t align_shifter(uint64_t mantissa_c,
                       int32_t shift_amount,
                       uint32_t comp_i);
uint32_t exp_calc(uint32_t exp_a,
                  uint32_t exp_b,
                  uint32_t exp_C);
uint32_t sign_logic(uint32_t sign_AB,
                    uint32_t sign_c,
                    uint32_t comp_add);
uint32_t LZD(int64_t adder_result);
uint32_t exp_adj(uint32_t exp, uint32_t LZN);
uint32_t Normalize(uint64_t adder_result, uint32_t LZN);



#endif // FLP_MAF_H_INCLUDED
