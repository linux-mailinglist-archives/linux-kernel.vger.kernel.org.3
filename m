Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A535AC860
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiIEBBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIEBBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:01:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C83EA19286
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 18:01:15 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJSShVjKlQRAA--.6168S3;
        Mon, 05 Sep 2022 09:01:08 +0800 (CST)
Subject: Re: [PATCH 1/3] LoongArch: Add kexec support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1661747823-23745-1-git-send-email-tangyouling@loongson.cn>
 <1661747823-23745-2-git-send-email-tangyouling@loongson.cn>
Cc:     Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <c4dbb14a-5580-1e47-3d15-5d2079e88404@loongson.cn>
Date:   Mon, 5 Sep 2022 09:01:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1661747823-23745-2-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxBOJSShVjKlQRAA--.6168S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw47WFW7Xr13AFy3uFWxJFb_yoWfGw1Dp3
        WqkF4DKr4kXF1xtryFqw15Zr98Xw1kWa12g3W7Ka4rJFsFqrnxXrn7Xr9FqF4kK395KFWI
        qF1S9asa9a1UG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5s6pJUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2022 12:37 PM, Youling Tang wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> LoongArch architecture that add support for the kexec re-boot mechanis
> (CONFIG_KEXEC) on LoongArch platforms.
>
> Supports loading vmlinux (vmlinux.elf) in ELF format and vmlinux.efi in
> PE format.
>
> I tested this on  LoongArch 3A5000 machine and works as expected,
>
>  $ sudo kexec -l /boot/vmlinux.efi --reuse-cmdline
>  $ sudo kexec -e
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/loongarch/Kconfig                  |  11 ++
>  arch/loongarch/include/asm/kexec.h      |  58 ++++++++
>  arch/loongarch/kernel/Makefile          |   2 +
>  arch/loongarch/kernel/head.S            |   7 +-
>  arch/loongarch/kernel/machine_kexec.c   | 178 ++++++++++++++++++++++++
>  arch/loongarch/kernel/relocate_kernel.S | 125 +++++++++++++++++
>  6 files changed, 380 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/include/asm/kexec.h
>  create mode 100644 arch/loongarch/kernel/machine_kexec.c
>  create mode 100644 arch/loongarch/kernel/relocate_kernel.S
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 45364cffc793..903c82fa958d 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -409,6 +409,17 @@ config FORCE_MAX_ZONEORDER
>  	  The page size is not necessarily 4KB.  Keep this in mind
>  	  when choosing a value for this option.
>
> +config KEXEC
> +	bool "Kexec system call"
> +	select KEXEC_CORE
> +	help
> +	  kexec is a system call that implements the ability to shutdown your
> +	  current kernel, and to start another kernel.  It is like a reboot
> +	  but it is independent of the system firmware.   And like a reboot
> +	  you can start any kernel with it, not just Linux.
> +
> +	  The name comes from the similarity to the exec system call.
> +
>  config SECCOMP
>  	bool "Enable seccomp to safely compute untrusted bytecode"
>  	depends on PROC_FS
> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
> new file mode 100644
> index 000000000000..5c9e7b5eccb8
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kexec.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * kexec.h for kexec
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef _ASM_KEXEC_H
> +#define _ASM_KEXEC_H
> +
> +#include <asm/stacktrace.h>
> +#include <asm/page.h>
> +
> +/* Maximum physical address we can use pages from */
> +#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
> +/* Maximum address we can reach in physical address mode */
> +#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
> + /* Maximum address we can use for the control code buffer */
> +#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
> +
> +/* Reserve a page for the control code buffer */
> +#define KEXEC_CONTROL_PAGE_SIZE PAGE_SIZE
> +
> +/* The native architecture */
> +#define KEXEC_ARCH KEXEC_ARCH_LOONGARCH
> +
> +static inline void crash_setup_regs(struct pt_regs *newregs,
> +				    struct pt_regs *oldregs)
> +{
> +	if (oldregs)
> +		memcpy(newregs, oldregs, sizeof(*newregs));
> +	else
> +		prepare_frametrace(newregs);
> +}
> +
> +#define ARCH_HAS_KIMAGE_ARCH
> +
> +struct kimage_arch {
> +	unsigned long boot_flag;
> +	unsigned long fdt_addr;
> +};
> +
> +typedef void (*do_kexec_t)(unsigned long boot_flag,
> +			   unsigned long fdt_addr,
> +			   unsigned long first_ind_entry,
> +			   unsigned long jump_addr);
> +
> +struct kimage;
> +extern const unsigned char relocate_new_kernel[];
> +extern const size_t relocate_new_kernel_size;
> +
> +#ifdef CONFIG_SMP
> +extern atomic_t kexec_ready_to_reboot;
> +extern const unsigned char kexec_smp_wait[];
> +extern void kexec_reboot(void);
> +#endif
> +
> +#endif /* !_ASM_KEXEC_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index a213e994db68..20b64ac3f128 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -17,6 +17,8 @@ obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
>  obj-$(CONFIG_MODULES)		+= module.o module-sections.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>
> +obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o
> +
>  obj-$(CONFIG_PROC_FS)		+= proc.o
>
>  obj-$(CONFIG_SMP)		+= smp.o
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 01bac62a6442..22bdf4928325 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -20,7 +20,12 @@
>
>  _head:
>  	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
> -	.org	0x3c			/* 0x04 ~ 0x3b reserved */
> +	.org	0x8
> +	.quad	0			/* Image load offset from start of RAM */
> +	.dword	_end - _text		/* Effective size of kernel image */
> +	.quad	0
> +	.dword	kernel_entry		/* Kernel entry point */
> +	.org	0x3c			/* 0x28 ~ 0x3b reserved */
>  	.long	pe_header - _head	/* Offset to the PE header */
>
>  pe_header:
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
> new file mode 100644
> index 000000000000..4ffcd4cd9c8c
> --- /dev/null
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * machine_kexec.c for kexec
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/compiler.h>
> +#include <linux/cpu.h>
> +#include <linux/kexec.h>
> +#include <linux/mm.h>
> +#include <linux/delay.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_fdt.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/cacheflush.h>
> +#include <asm/page.h>
> +
> +/* 0x100000 ~ 0x200000 is safe */
> +#define KEXEC_CTRL_CODE	TO_CACHE(0x100000UL)
> +#define KEXEC_BLOB_ADDR	TO_CACHE(0x108000UL)
> +
> +static unsigned long reboot_code_buffer;
> +#ifdef CONFIG_SMP
> +void (*relocated_kexec_smp_wait)(void *);
> +atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
> +#endif
> +
> +static unsigned long jump_addr;
> +static unsigned long first_ind_entry;
> +static unsigned long boot_flag;
> +static unsigned long fdt_addr;
> +
> +static void kexec_image_info(const struct kimage *kimage)
> +{
> +	unsigned long i;
> +
> +	pr_debug("kexec kimage info:\n");
> +	pr_debug("\ttype:        %d\n", kimage->type);
> +	pr_debug("\tstart:       %lx\n", kimage->start);
> +	pr_debug("\thead:        %lx\n", kimage->head);
> +	pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
> +
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
> +			kimage->segment[i].mem,
> +			kimage->segment[i].mem + kimage->segment[i].memsz);
> +		pr_debug("\t\t0x%lx bytes, %lu pages\n",
> +			(unsigned long)kimage->segment[i].memsz,
> +			(unsigned long)kimage->segment[i].memsz /  PAGE_SIZE);
> +	}
> +}
> +
> +int machine_kexec_prepare(struct kimage *kimage)
> +{
> +	int i;
> +	void *dtb = (void *)KEXEC_BLOB_ADDR;
> +
> +	kexec_image_info(kimage);
> +
> +	/* Find the Flattened Device Tree */
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		if (!fdt_check_header(kimage->segment[i].buf)) {
> +			memcpy(dtb, kimage->segment[i].buf, SZ_64K);
> +			kimage->arch.boot_flag = fw_arg0;
> +			kimage->arch.fdt_addr = (unsigned long) dtb;
> +			break;
> +		}
> +		continue;
> +	}
> +
> +	/* kexec need a safe page to save reboot_code_buffer */
> +	kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
> +
> +	reboot_code_buffer =
> +	  (unsigned long)page_address(kimage->control_code_page);
> +	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
> +	       relocate_new_kernel_size);
> +
> +	/* All secondary cpus now may jump to kexec_smp_wait cycle */
> +	relocated_kexec_smp_wait = reboot_code_buffer +
> +		(void *)(kexec_smp_wait - relocate_new_kernel);
> +
> +	return 0;
> +}
> +
> +void machine_kexec_cleanup(struct kimage *kimage)
> +{
> +}
> +
> +#ifdef CONFIG_SMP
> +void kexec_reboot(void)
> +{
> +	do_kexec_t do_kexec = NULL;
> +
> +	/* All secondary cpus go to kexec_smp_wait */
> +	if (smp_processor_id() > 0) {
> +		relocated_kexec_smp_wait(NULL);
> +		unreachable();
> +	}
> +
> +	do_kexec = (void *)reboot_code_buffer;
> +	do_kexec(boot_flag, fdt_addr, first_ind_entry, jump_addr);
> +
> +	unreachable();
> +}

self-check,
kexec_reboot() is in! SMP needs to be used, modified as follows:

void kexec_reboot(void)
{
         do_kexec_t do_kexec = NULL;

#ifdef CONFIG_SMP
         /* All secondary cpus go to kexec_smp_wait */
         if (smp_processor_id() > 0) {
                 relocated_kexec_smp_wait(NULL);
                 unreachable();
         }
#endif

         do_kexec = (void *)reboot_code_buffer;
         do_kexec(boot_flag, fdt_addr, first_ind_entry, jump_addr);

         unreachable();
}

Youling

