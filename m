Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129525849A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiG2CNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiG2CNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:13:12 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3027AB39
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:13:11 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx39AwQuNiw8ZAAA--.2929S3;
        Fri, 29 Jul 2022 10:13:05 +0800 (CST)
Subject: Re: [PATCH 3/3] LoongArch: Add stacktrace support
To:     Qing Zhang <zhangqing@loongson.cn>
References: <20220728140519.5420-1-zhangqing@loongson.cn>
 <20220728140519.5420-3-zhangqing@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <1a2ec963-2539-d29e-a9a4-07257d603b78@loongson.cn>
Date:   Fri, 29 Jul 2022 10:13:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220728140519.5420-3-zhangqing@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx39AwQuNiw8ZAAA--.2929S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4fGF15XF1xZw43Wr15Jwb_yoWrGr43pF
        yvkwnrGr42kr409ryjq3y5ury5Jrn2g3y2gFy3ta45Crn0g34fGF18Ka47ZFWYyw4kAw1S
        vr1Fkw1IyF4qqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUomiiDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/28/2022 10:05 PM, Qing Zhang wrote:
> Use common arch_stack_walk infrastructure to avoid duplicated code and
> avoid taking care of the stack storage and filtering.
> Add sra (means __schedule return address) and scfa (means __schedule call
> frame address) to thread_info and store it in switch_to().
>
> Now we can print the process stack by cat /proc/*/stack and can better
> support ftrace.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index b57daee98b89..1bd656285674 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -38,6 +38,7 @@ config LOONGARCH
>  	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
> +	select ARCH_STACKWALK
>  	select ARCH_SPARSEMEM_ENABLE
>  	select ARCH_SUPPORTS_ACPI
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> @@ -141,6 +142,10 @@ config LOCKDEP_SUPPORT
>  	bool
>  	default y
>
> +config STACKTRACE_SUPPORT
> +	bool
> +	default y
> +
>  # MACH_LOONGSON32 and MACH_LOONGSON64 are delibrately carried over from the
>  # MIPS Loongson code, to preserve Loongson-specific code paths in drivers that
>  # are shared between architectures, and specifically expecting the symbols.
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index 57ec45aa078e..1c4b4308378d 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -101,6 +101,10 @@ struct thread_struct {
>  	unsigned long reg23, reg24, reg25, reg26; /* s0-s3 */
>  	unsigned long reg27, reg28, reg29, reg30, reg31; /* s4-s8 */
>
> +	/* __schedule() return address / call frame address */
> +	unsigned long sched_ra;
> +	unsigned long sched_cfa;
> +
>  	/* CSR registers */
>  	unsigned long csr_prmd;
>  	unsigned long csr_crmd;
> @@ -129,6 +133,9 @@ struct thread_struct {
>  	struct loongarch_fpu fpu FPU_ALIGN;
>  };
>
> +#define thread_saved_ra(tsk)	(tsk->thread.sched_ra)
> +#define thread_saved_fp(tsk)	(tsk->thread.sched_cfa)
> +
>  #define INIT_THREAD  {						\
>  	/*							\
>  	 * Main processor registers				\
> @@ -145,6 +152,8 @@ struct thread_struct {
>  	.reg29			= 0,				\
>  	.reg30			= 0,				\
>  	.reg31			= 0,				\
> +	.sched_ra		= 0,				\
> +	.sched_cfa		= 0,				\
>  	.csr_crmd		= 0,				\
>  	.csr_prmd		= 0,				\
>  	.csr_euen		= 0,				\
> diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
> index 2a8d04375574..836cfcc19498 100644
> --- a/arch/loongarch/include/asm/switch_to.h
> +++ b/arch/loongarch/include/asm/switch_to.h
> @@ -15,12 +15,15 @@ struct task_struct;
>   * @prev:	The task previously executed.
>   * @next:	The task to begin executing.
>   * @next_ti:	task_thread_info(next).
> + * @sched_ra:	__schedule return address.
> + * @sched_cfa:	__schedule call frame address.
>   *
>   * This function is used whilst scheduling to save the context of prev & load
>   * the context of next. Returns prev.
>   */
>  extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
> -			struct task_struct *next, struct thread_info *next_ti);
> +			struct task_struct *next, struct thread_info *next_ti,
> +			void *sched_ra, void *sched_cfa);
>
>  /*
>   * For newly created kernel threads switch_to() will return to
> @@ -31,7 +34,8 @@ extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
>  #define switch_to(prev, next, last)					\
>  do {									\
>  	lose_fpu_inatomic(1, prev);					\
> -	(last) = __switch_to(prev, next, task_thread_info(next));	\
> +	(last) = __switch_to(prev, next, task_thread_info(next),	\
> +		 __builtin_return_address(0), __builtin_frame_address(0)); \
'\' format alignment.

Thanks,
Youling

