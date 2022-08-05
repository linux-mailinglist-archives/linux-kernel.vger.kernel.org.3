Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08F58A6C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbiHEHL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiHEHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:11:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083A13D6D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:10:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pm17so1906768pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+TTzONA/D6X8kOwQstBuCxA5JSSlF4quOuCiq/JFqPg=;
        b=d2EcMeO5TdFW9fstG94LiP18zn2Gj1wSiCI3bwsAPs/krF3f1Mfkvt4SWjqTtQDu1O
         11pOO8xwKj6alzWd6jNxEB9daCp5+d0ga2Q815SF5H0YFfENBzV+E6iCaLcS0Gz5AxIB
         VR7tRnCNLliA2Br88hcAIQ0qAAoCALIgtvj9/ylWxYKTxhl6LOxHtWocx/D0fvI4DLrQ
         KkCP/orNv9usNby0jB5YX6tcHa6b6V7zoZ7GfBT+wRa6vX7oCeMFMAz68FbFSlkzDshe
         ZphCfr6IWiecz+lFdxX+veoZm0RMK/VR1aUSx6r87pueHF1QOuNWNIb5DFe4j4YpDwbq
         n8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+TTzONA/D6X8kOwQstBuCxA5JSSlF4quOuCiq/JFqPg=;
        b=nmCyho9aTXAFeX0c0MI3/Q/Z6/LI/X2rq+71bcnmVgZX2RG3wQRmAekWXY4vFF3qKF
         f2pmR9PB6iOqxz240jPsXcJsu0m8G+EFxXLWwXbJuL6e6vwUYKw4kcTgUZeCLH2pw11E
         nX5H3cPMeWekrIWdbfERmwflYzwanX+9q2/ZszVhaqevdzBSnDLKi4m+SjvBgqPOVbiq
         s5bVk4fYZURf55Vtur9iCBn5beyO72AVaLvlA5F0j4GGja9U+nRSpjiKr4iDtt46qD2Q
         MHlYoYl4iPdWfZZrTUhdzlxQB08c1qABsG9WpNcEmJslS/XjlM+LaC1HFefAAUvq6Xqb
         onDA==
X-Gm-Message-State: ACgBeo3nujkywMWqgyOCQc4zLmGanfcmtfRqViujv+I2PWilqxcV5mdy
        mCHnoWSESDXx6RTOjP2hDZoSn4F847GvZg==
X-Google-Smtp-Source: AA6agR7TIErJU5B8btuaj/7lSLhxgrr4y84Xe0iMDLWqN9Ma/jXVwav3sx8UkoP4J9xfbxtiC8axeg==
X-Received: by 2002:a17:90b:350a:b0:1f5:6a5e:5d12 with SMTP id ls10-20020a17090b350a00b001f56a5e5d12mr6663202pjb.46.1659683440092;
        Fri, 05 Aug 2022 00:10:40 -0700 (PDT)
Received: from [10.4.82.173] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 204-20020a6218d5000000b00528c22fbb45sm2197721pfy.141.2022.08.05.00.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 00:10:39 -0700 (PDT)
Message-ID: <5dbced25-7cef-7078-78a9-f47545e6a9fe@bytedance.com>
Date:   Fri, 5 Aug 2022 15:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v2] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/2 14:53, Qi Zheng wrote:
> Currently arm64 supports per-CPU IRQ stack, but softirqs
> are still handled in the task context.
> 
> Since any call to local_bh_enable() at any level in the task's
> call stack may trigger a softirq processing run, which could
> potentially cause a task stack overflow if the combined stack
> footprints exceed the stack's size, let's run these softirqs
> on the IRQ stack as well.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Will Deacon <will@kernel.org>

Hi Will,

Are we good to merge it into 6.0-rc1?

Thanks,
Qi

> ---
> v1: https://lore.kernel.org/lkml/20220708094950.41944-1-zhengqi.arch@bytedance.com/
> RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/
> 
> Changelog in v1 -> v2:
>   - temporarily discard [PATCH v1 2/2] to allow this patch to be merged first
>   - rebase onto the v5.19
>   - collect Reviewed-by and Acked-by
> 
> Changelog in RFC -> v1:
>   - fix conflicts with commit f2c5092190f2 ("arch/*: Disable softirq stacks on PREEMPT_RT.")
> 
>   arch/arm64/Kconfig      |  1 +
>   arch/arm64/kernel/irq.c | 13 +++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1652a9800ebe..90f1ab403724 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -226,6 +226,7 @@ config ARM64
>   	select THREAD_INFO_IN_TASK
>   	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
>   	select TRACE_IRQFLAGS_SUPPORT
> +	select HAVE_SOFTIRQ_ON_OWN_STACK
>   	help
>   	  ARM 64-bit (AArch64) Linux support.
>   
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index bda49430c9ea..c36ad20a52f3 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -22,6 +22,7 @@
>   #include <linux/vmalloc.h>
>   #include <asm/daifflags.h>
>   #include <asm/vmap_stack.h>
> +#include <asm/exception.h>
>   
>   /* Only access this in an NMI enter/exit */
>   DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
> @@ -71,6 +72,18 @@ static void init_irq_stacks(void)
>   }
>   #endif
>   
> +#ifndef CONFIG_PREEMPT_RT
> +static void ____do_softirq(struct pt_regs *regs)
> +{
> +	__do_softirq();
> +}
> +
> +void do_softirq_own_stack(void)
> +{
> +	call_on_irq_stack(NULL, ____do_softirq);
> +}
> +#endif
> +
>   static void default_handle_irq(struct pt_regs *regs)
>   {
>   	panic("IRQ taken without a root IRQ handler\n");

-- 
Thanks,
Qi
