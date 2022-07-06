Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34678568AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiGFOIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiGFOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:08:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C71101B;
        Wed,  6 Jul 2022 07:08:30 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MCXhr-1oICFt3vt5-009i0R; Wed, 06 Jul 2022 16:08:27 +0200
Message-ID: <8d952be9-8ea4-7ffa-107d-d73d5f08889c@vivier.eu>
Date:   Wed, 6 Jul 2022 16:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] m68k: Add forward declaration for show_registers()
Content-Language: fr
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <d5b6a7f9af3e82f0ccb67edac09d9ee45d457932.1657114791.git.geert@linux-m68k.org>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <d5b6a7f9af3e82f0ccb67edac09d9ee45d457932.1657114791.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yUkA2TeWWfPuZf5nJv8cRVPiE4yBE0sIqwehpUpZpd/uefhryRJ
 0qk9Z1mkX4Y20RPySif0caci8yas/uqjZbtWFsJc8a83REsicJxlHWVIMGzEstudXj1eDAE
 odvsoi5rvqJA4+aVDPtxlopdZzV5p7yeD2W6b+rKdCXOCuzlaE5eBcJrsLLrhJjr3hZyxF1
 4MnKII0IVuIH9/fmV8hJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nx65Dcr3efc=:8689rSaWT/mZREixusj7TM
 0MmMm/EPwzTwDNUY9p8OKGaU7GxQKImimoSafHVltUETbxduPAWLl2NT2hY05y/4kNmDX6NiX
 egJOWgUNsqKXtqknYYEiEU1y1y1Hl1UVMyGH+iBkXGkkNWos4jO6XCeJPu/OK4T9Qd0X0xUT1
 9uNJ05jGQ/xt6+jhoMfvzKmGOguoNuGtLZCGWDcVl1OeDM/+Z6PvIh0Db2ZUVEEJSIBMXNxJW
 0ZLb34rgwz/G8pEY4nVIMDyTHmRW9Inl7c59WEUAindXjky9KCwfM8n2PrejddSyoNoVVg/y6
 6dABkuu/m8mBTy0Lc51hxJTeUQtB79zFHbela2RAsV4k4gmLNRSPbc5rnqWk/IzpL9L14zVPW
 JNuX30kdqIFPMo3z4qRhr5OIwLULXXEK+7zeiXtEFKCVCjCyn9oYTksg3ZWwbL0tRzOIMJ+fi
 v1Sa3QheSoK6TiCj5ozikOecX5OnzYC35VpuW4j0MOTL4ZaBHxH1I8B29sQAYLL8lwsAO1XPX
 qfD78a9Ul44lDWBmHrQ1fSaKPOkS5QagXYOlF/9xk8fSHs8X6hzXKPLLZgRFDYMFe4O8283ld
 +rtg1ML2Z9aAsLIdVlRsY89e+rKpkcjpzJUFKun2Tlon5CzA6v71Fecote27Yw/Mn/6Wy4mJP
 yR1Zrq3IFoeoZf2DyKkAawoRuI5gDVq3QlP2i1KDGDwYzwuAi8FBG7UphbQFVnETACGswphKI
 6rMNP29JpEJhqUo/YitblP5SkTGSbiypCE8fNQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/07/2022 à 15:48, Geert Uytterhoeven a écrit :
> There are several forward declarations for show_registers() in C source
> files.  Replace these by a single common forward declaration in
> <asm/processor.h>, and include <asm/processor.h> where needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> To be queued in the m68k tree for v5.20.
> 
>   arch/m68k/include/asm/processor.h | 1 +
>   arch/m68k/kernel/traps.c          | 1 +
>   arch/m68k/mac/macints.c           | 3 +--
>   arch/m68k/virt/ints.c             | 3 +--
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
> index ffeda9aa526a5420..d86b4009880b4e79 100644
> --- a/arch/m68k/include/asm/processor.h
> +++ b/arch/m68k/include/asm/processor.h
> @@ -151,6 +151,7 @@ static inline void release_thread(struct task_struct *dead_task)
>   }
>   
>   unsigned long __get_wchan(struct task_struct *p);
> +void show_registers(struct pt_regs *regs);
>   
>   #define	KSTK_EIP(tsk)	\
>       ({			\
> diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
> index 59fc63feb0dcce8a..5c8cba0efc63e580 100644
> --- a/arch/m68k/kernel/traps.c
> +++ b/arch/m68k/kernel/traps.c
> @@ -36,6 +36,7 @@
>   #include <linux/uaccess.h>
>   #include <asm/traps.h>
>   #include <asm/machdep.h>
> +#include <asm/processor.h>
>   #include <asm/siginfo.h>
>   #include <asm/tlbflush.h>
>   
> diff --git a/arch/m68k/mac/macints.c b/arch/m68k/mac/macints.c
> index 883e48230f87a187..5cbaf6e9497c698a 100644
> --- a/arch/m68k/mac/macints.c
> +++ b/arch/m68k/mac/macints.c
> @@ -126,8 +126,7 @@
>   #include <asm/mac_baboon.h>
>   #include <asm/hwtest.h>
>   #include <asm/irq_regs.h>
> -
> -extern void show_registers(struct pt_regs *);
> +#include <asm/processor.h>
>   
>   static unsigned int mac_irq_startup(struct irq_data *);
>   static void mac_irq_shutdown(struct irq_data *);
> diff --git a/arch/m68k/virt/ints.c b/arch/m68k/virt/ints.c
> index 95818f901ebe322d..896aa6eb8bcc6f3d 100644
> --- a/arch/m68k/virt/ints.c
> +++ b/arch/m68k/virt/ints.c
> @@ -12,6 +12,7 @@
>   #include <asm/hwtest.h>
>   #include <asm/irq.h>
>   #include <asm/irq_regs.h>
> +#include <asm/processor.h>
>   #include <asm/virt.h>
>   
>   #define GFPIC_REG_IRQ_PENDING           0x04
> @@ -19,8 +20,6 @@
>   #define GFPIC_REG_IRQ_DISABLE           0x0c
>   #define GFPIC_REG_IRQ_ENABLE            0x10
>   
> -extern void show_registers(struct pt_regs *regs);
> -
>   static struct resource picres[6];
>   static const char *picname[6] = {
>   	"goldfish_pic.0",

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
