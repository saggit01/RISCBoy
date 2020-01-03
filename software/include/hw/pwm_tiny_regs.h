/*******************************************************************************
*                          AUTOGENERATED BY REGBLOCK                           *
*                            Do not edit manually.                             *
*          Edit the source file (or regblock utility) and regenerate.          *
*******************************************************************************/

#ifndef _PWM_TINY_REGS_H_
#define _PWM_TINY_REGS_H_

// Block name           : pwm_tiny
// Bus type             : apb
// Bus data width       : 32
// Bus address width    : 16

#define PWM_TINY_CTRL_OFFS 0

/*******************************************************************************
*                                     CTRL                                     *
*******************************************************************************/

// PWM control register

// Field: CTRL_VAL  Access: RW
#define PWM_TINY_CTRL_VAL_LSB  0
#define PWM_TINY_CTRL_VAL_BITS 8
#define PWM_TINY_CTRL_VAL_MASK 0xff
// Field: CTRL_DIV  Access: RW
#define PWM_TINY_CTRL_DIV_LSB  8
#define PWM_TINY_CTRL_DIV_BITS 8
#define PWM_TINY_CTRL_DIV_MASK 0xff00
// Field: CTRL_EN  Access: RW
// Enable PWM (reset when low)
#define PWM_TINY_CTRL_EN_LSB  31
#define PWM_TINY_CTRL_EN_BITS 1
#define PWM_TINY_CTRL_EN_MASK 0x80000000
// Field: CTRL_INV  Access: RW
// Invert output
#define PWM_TINY_CTRL_INV_LSB  30
#define PWM_TINY_CTRL_INV_BITS 1
#define PWM_TINY_CTRL_INV_MASK 0x40000000

#endif // _PWM_TINY_REGS_H_
