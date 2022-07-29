Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4949C584984
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiG2CBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiG2CBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:01:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EF097969C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:01:48 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj9CBP+NiTsFAAA--.27427S3;
        Fri, 29 Jul 2022 10:01:38 +0800 (CST)
Subject: Re: [PATCH 1/3] LoongArch: Add guess unwinder support
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20220728140519.5420-1-zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <1288a80b-4038-126f-aec0-74f18cf2fea2@loongson.cn>
Date:   Fri, 29 Jul 2022 10:01:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220728140519.5420-1-zhangqing@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxj9CBP+NiTsFAAA--.27427S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rGF18GFW7Zry8uw1xZrb_yoWfCrWDpF
        yDC3Z3GrW7K340gr9rXr1UZF98Grs2kw12gF9rtFyrCFnFqFyxWrnaka4DZF4DJ3ykGa1I
        qF95Kws8KanFqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing

On 07/28/2022 10:05 PM, Qing Zhang wrote:
> Name "guess unwinder" comes from x86, It scans the stack and reports
> every kernel text address it finds.
>
> Three stages when we do unwind,
>   (1)unwind_start(), the prapare of unwinding, fill unwind_state.
>   (2)unwind_done(), judge whether the unwind process is finished or not.
>   (3)unwind_next_frame(), unwind the next frame.
>
> Make the dump_stack process go through unwind process.
> Add get_stack_info() to get stack info. At present we have irq stack and
> task stack. Maybe add another type in future. The next_sp means the key
> info between this type stack and next type stack.
>
> Dividing unwinder helps to add new unwinders in the future.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>
> diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
> index e69de29bb2d1..68634d4fa27b 100644
> --- a/arch/loongarch/Kconfig.debug
> +++ b/arch/loongarch/Kconfig.debug
> @@ -0,0 +1,9 @@
> +config UNWINDER_GUESS
> +	bool "Guess unwinder"
> +	help
> +	  This option enables the "guess" unwinder for unwinding kernel stack
> +	  traces.  It scans the stack and reports every kernel text address it
> +	  finds.  Some of the addresses it reports may be incorrect.
> +
> +	  While this option often produces false positives, it can still be
> +	  useful in many cases.
> diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
> index 26483e396ad1..33077010356d 100644
> --- a/arch/loongarch/include/asm/stacktrace.h
> +++ b/arch/loongarch/include/asm/stacktrace.h
> @@ -10,6 +10,23 @@
>  #include <asm/loongarch.h>
>  #include <linux/stringify.h>
>
> +enum stack_type {
> +	STACK_TYPE_UNKNOWN,
> +	STACK_TYPE_TASK,
> +	STACK_TYPE_IRQ,
> +};
> +
> +struct stack_info {
> +	enum stack_type type;
> +	unsigned long begin, end, next_sp;
> +};
> +
> +bool in_task_stack(unsigned long stack, struct task_struct *task,
> +			struct stack_info *info);
> +bool in_irq_stack(unsigned long stack, struct stack_info *info);
> +int get_stack_info(unsigned long stack, struct task_struct *task,
> +			struct stack_info *info);
> +
>  #define STR_LONG_L    __stringify(LONG_L)
>  #define STR_LONG_S    __stringify(LONG_S)
>  #define STR_LONGSIZE  __stringify(LONGSIZE)
> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> new file mode 100644
> index 000000000000..243330b39d0d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/unwind.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Most of this ideas comes from x86.
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_UNWIND_H
> +#define _ASM_UNWIND_H
> +
> +#include <linux/sched.h>
> +
> +#include <asm/stacktrace.h>
> +
> +struct unwind_state {
> +	struct stack_info stack_info;
> +	struct task_struct *task;
> +	unsigned long sp, pc;
> +	bool first;
> +	bool error;
> +};
> +
> +void unwind_start(struct unwind_state *state, struct task_struct *task,
> +		      struct pt_regs *regs);
> +bool unwind_next_frame(struct unwind_state *state);
> +unsigned long unwind_get_return_address(struct unwind_state *state);
> +
> +static inline bool unwind_done(struct unwind_state *state)
> +{
> +	return state->stack_info.type == STACK_TYPE_UNKNOWN;
> +}
> +
> +static inline bool unwind_error(struct unwind_state *state)
> +{
> +	return state->error;
> +}
> +
> +#endif /* _ASM_UNWIND_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 940de9173542..c5fa4adb23b6 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -22,4 +22,6 @@ obj-$(CONFIG_SMP)		+= smp.o
>
>  obj-$(CONFIG_NUMA)		+= numa.o
>
> +obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
> +
>  CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index bfa0dfe8b7d7..709b7a1664f8 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -44,6 +44,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
>  #include <asm/reg.h>
> +#include <asm/unwind.h>
>  #include <asm/vdso.h>
>
>  /*
> @@ -183,6 +184,66 @@ unsigned long __get_wchan(struct task_struct *task)
>  	return 0;
>  }
>
> +bool in_task_stack(unsigned long stack, struct task_struct *task,
> +			struct stack_info *info)
> +{
> +	unsigned long begin = (unsigned long)task_stack_page(task);
> +	unsigned long end = begin + THREAD_SIZE - 32;
> +
> +	if (stack < begin || stack >= end)
> +		return false;
> +
> +	info->type = STACK_TYPE_TASK;
> +	info->begin = begin;
> +	info->end = end;
> +	info->next_sp = 0;
> +
> +	return true;
> +}
> +
> +bool in_irq_stack(unsigned long stack, struct stack_info *info)
> +{
> +	unsigned long nextsp;
> +	unsigned long begin = (unsigned long)this_cpu_read(irq_stack);
> +	unsigned long end = begin + IRQ_STACK_START;
> +
> +	if (stack < begin || stack >= end)
> +		return false;
> +
> +	nextsp = *(unsigned long *)end;
> +	if (nextsp & (SZREG - 1))
> +		return false;
> +
> +	info->type = STACK_TYPE_IRQ;
> +	info->begin = begin;
> +	info->end = end;
> +	info->next_sp = nextsp;
> +
> +	return true;
> +}
> +
> +int get_stack_info(unsigned long stack, struct task_struct *task,
> +		   struct stack_info *info)
> +{
> +	task = task ? : current;
> +
> +	if (!stack || stack & (SZREG - 1))
> +		goto unknown;
> +
> +	if (in_task_stack(stack, task, info))
> +		return 0;
> +
> +	if (task != current)
> +		goto unknown;
> +
> +	if (in_irq_stack(stack, info))
> +		return 0;
> +
> +unknown:
> +	info->type = STACK_TYPE_UNKNOWN;
> +	return -EINVAL;
> +}
> +
>  unsigned long stack_top(void)
>  {
>  	unsigned long top = TASK_SIZE & PAGE_MASK;
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 1bf58c65e2bf..ef2c3aeb1dab 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -43,6 +43,7 @@
>  #include <asm/stacktrace.h>
>  #include <asm/tlb.h>
>  #include <asm/types.h>
> +#include <asm/unwind.h>
>
>  #include "access-helper.h"
>
> @@ -64,19 +65,18 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
>  			   const char *loglvl, bool user)
>  {
>  	unsigned long addr;
> -	unsigned long *sp = (unsigned long *)(regs->regs[3] & ~3);
> +	struct unwind_state state;
> +	struct pt_regs *pregs = (struct pt_regs *)regs;
> +
> +	if (!task)
> +		task = current;
> +
> +	unwind_start(&state, task, pregs);
>
>  	printk("%sCall Trace:", loglvl);
> -#ifdef CONFIG_KALLSYMS
> -	printk("%s\n", loglvl);
> -#endif
> -	while (!kstack_end(sp)) {
> -		if (__get_addr(&addr, sp++, user)) {
> -			printk("%s (Bad stack address)", loglvl);
> -			break;
> -		}
> -		if (__kernel_text_address(addr))
> -			print_ip_sym(loglvl, addr);
> +	for (; !unwind_done(&state); unwind_next_frame(&state)) {
> +		addr = unwind_get_return_address(&state);
> +		print_ip_sym(loglvl, addr);
>  	}
>  	printk("%s\n", loglvl);
>  }
> diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
> new file mode 100644
> index 000000000000..7eeb3e1a989d
> --- /dev/null
> +++ b/arch/loongarch/kernel/unwind_guess.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/kernel.h>
> +
> +#include <asm/unwind.h>
> +
> +unsigned long unwind_get_return_address(struct unwind_state *state)
> +{
> +	if (unwind_done(state))
> +		return 0;
This judgment can be removed, because unwind_done() has been judged
before entering this function, and unwind_get_return_address will not
be called if it is true.

> +	else if (state->first)
> +		return state->pc;
> +
> +	return *(unsigned long *)(state->sp);
> +}
> +EXPORT_SYMBOL_GPL(unwind_get_return_address);
> +
> +bool unwind_next_frame(struct unwind_state *state)
> +{
> +	struct stack_info *info = &state->stack_info;
> +	unsigned long addr;
> +
> +	if (unwind_done(state))
> +		return false;
> +
Can be removed as above.

Thanks,
Youling
> +	if (state->first)
> +		state->first = false;
> +
> +	do {
> +		for (state->sp += sizeof(unsigned long);
> +		     state->sp < info->end;
> +		     state->sp += sizeof(unsigned long)) {
> +			addr = *(unsigned long *)(state->sp);
> +
> +			if (__kernel_text_address(addr))
> +				return true;
> +		}
> +
> +		state->sp = info->next_sp;
> +
> +	} while (!get_stack_info(state->sp, state->task, info));
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(unwind_next_frame);
> +
> +void unwind_start(struct unwind_state *state, struct task_struct *task,
> +		    struct pt_regs *regs)
> +{
> +	memset(state, 0, sizeof(*state));
> +
> +	state->task = task;
> +
> +	state->sp = regs->regs[3];
> +	state->pc = regs->csr_era;
> +	state->first = true;
> +
> +	get_stack_info(state->sp, state->task, &state->stack_info);
> +
> +	if (!unwind_done(state) && !__kernel_text_address(state->pc))
> +		unwind_next_frame(state);
> +}
> +EXPORT_SYMBOL_GPL(unwind_start);
>

