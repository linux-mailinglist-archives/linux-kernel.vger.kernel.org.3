Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A075793B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiGSHCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiGSHCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:02:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487A31905
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:02:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id r24so29148plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:from:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=exs2gn7JJUBuYfUOPg6VzX7JaLxQa4T7Pk3HE8BN1qA=;
        b=67f9I2U+p8Gqh6XxNsb95CVAu1Hwp1MXfOcJd9yhjCA1wBdMNIGuVb7IU1kgVBTsX1
         aVTETSvnCdl0GH7Vdv9YewHrR+fOmkCJezUWs3qzvsKrMp2zcEnEc2L8rq5iFHAxy78j
         ZxeDVEa1b1f2TwpI/El6vZgKRggiMcWCBAZoc+Mv0HnF1Oj+mIjqfJp9yGaYPT3P9/GK
         biayVszPhHeUsXvNnnb/8l0wYtKS/ErC2rrXZyV+EcC+9FlaIyzochOIw4vMYOamnNKF
         Bw3F/9wQWQoa8HsQS1IGDXS2syxACyoKXrhO0sHTHOHQ7nug7IMJDoMuqqb2Foe4Wj5n
         K14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :from:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=exs2gn7JJUBuYfUOPg6VzX7JaLxQa4T7Pk3HE8BN1qA=;
        b=UA7Z/WdiJ7ttVNetX7UIUEDrVg39DS/HTziC2lv6B9LLSf6kbD7132Fqk8qNK0gnYf
         Wmm3uQNxITvCHI4Woqa+tyuzDDu0D9Kcr4B+i6oFWObILPfmW6ZIr8UGX5d4SgLHeGZz
         oEURQSVs0PvmL77lCKHtJKAvAjcmeYRcyTtC8sBW9WPau4yAWKHGSUbUAcNW5NLbWe1z
         3RKFsqp/6PcE9Uuw6zAv5NTNPYN8GQJ0WzXUvhX3KGVtuarKANowXNC1ZTkn6Z/6a2Gp
         U9D78qKacwXsq2ywK2lLmPIHlEA2AsZLNWkvneDRGOwJqLTkW2Z6FCrYVMfFVP1l2x6J
         18Bg==
X-Gm-Message-State: AJIora/exl8YEPJ0Q/jJaZjURbJw6Lbq9V522vw6UpRqOXv+2mHPZXy4
        AXIWQFrHqNPBizNoIk6eAPWXkg==
X-Google-Smtp-Source: AGRyM1ty1Md1kPeF3bJPkp5t+KflcrkT9H0DH3c/vAqhm+/5QzYLVV8TrPiYeg33oi5agHL9XA9KCg==
X-Received: by 2002:a17:903:40c6:b0:16c:c82:d626 with SMTP id t6-20020a17090340c600b0016c0c82d626mr30571111pld.28.1658214125421;
        Tue, 19 Jul 2022 00:02:05 -0700 (PDT)
Received: from [10.4.227.241] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id bc11-20020a656d8b000000b003fd9b8b865dsm9453238pgb.0.2022.07.19.00.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:02:04 -0700 (PDT)
Message-ID: <4415cf17-5078-1da8-c209-41936bf4dc0b@bytedance.com>
Date:   Tue, 19 Jul 2022 15:01:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v1 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
 <20220708094950.41944-3-zhengqi.arch@bytedance.com>
 <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
 <3afacff7-e559-b7b5-c65b-414ff988e696@bytedance.com>
Content-Language: en-US
In-Reply-To: <3afacff7-e559-b7b5-c65b-414ff988e696@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/14 19:54, Qi Zheng wrote:
> 
> 
> On 2022/7/14 19:37, Arnd Bergmann wrote:
>> On Fri, Jul 8, 2022 at 11:49 AM Qi Zheng <zhengqi.arch@bytedance.com> 
>> wrote:
>>>
>>> Since softirqs are handled on the per-CPU IRQ stack,
>>> let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
>>> the core code to invoke __do_softirq() directly without
>>> going through do_softirq_own_stack().
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Adding Mark Rutland to Cc, he's the one that worked on this area the 
>> most in the
>> past and should probably review your patch. I still feel like there
>> should be a way
>> to improve readability of the IRQ entry path rather than just adding 
>> another
> 
> Got it. And looking forward to reviews and suggestions from Mark or
> anyone else.

Hi Will, Catalin and Mark,

I don't see any action items left for me. Any suggestions on this patch?

Thanks,
Qi

> 
>> level of indirection, but the ideas I had so far have not led to
>> anything useful.
>>
>> Overall I suppose your version is an improvement over the extra double 
>> stack
>> switch when entering softirq.
>>
>>          Arnd
> 
> Thanks,
> Qi
> 
>>
>>> ---
>>>   arch/arm64/Kconfig                 |  1 +
>>>   arch/arm64/include/asm/exception.h |  4 +++-
>>>   arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
>>>   arch/arm64/kernel/entry.S          |  6 ++++--
>>>   arch/arm64/kernel/irq.c            |  5 +++--
>>>   5 files changed, 31 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index be0a9f0052ee..d2cc7daecce3 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -231,6 +231,7 @@ config ARM64
>>>          select TRACE_IRQFLAGS_SUPPORT
>>>          select TRACE_IRQFLAGS_NMI_SUPPORT
>>>          select HAVE_SOFTIRQ_ON_OWN_STACK
>>> +       select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>>          help
>>>            ARM 64-bit (AArch64) Linux support.
>>>
>>> diff --git a/arch/arm64/include/asm/exception.h 
>>> b/arch/arm64/include/asm/exception.h
>>> index d94aecff9690..8bff0aa7ab50 100644
>>> --- a/arch/arm64/include/asm/exception.h
>>> +++ b/arch/arm64/include/asm/exception.h
>>> @@ -54,7 +54,9 @@ asmlinkage void el0t_32_fiq_handler(struct pt_regs 
>>> *regs);
>>>   asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
>>>
>>>   asmlinkage void call_on_irq_stack(struct pt_regs *regs,
>>> -                                 void (*func)(struct pt_regs *));
>>> +                                 void (*func)(struct pt_regs *),
>>> +                                 void (*do_func)(struct pt_regs *,
>>> +                                                 void (*)(struct 
>>> pt_regs *)));
>>>   asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
>>>
>>>   void do_mem_abort(unsigned long far, unsigned long esr, struct 
>>> pt_regs *regs);
>>> diff --git a/arch/arm64/kernel/entry-common.c 
>>> b/arch/arm64/kernel/entry-common.c
>>> index c75ca36b4a49..935d1ab150b5 100644
>>> --- a/arch/arm64/kernel/entry-common.c
>>> +++ b/arch/arm64/kernel/entry-common.c
>>> @@ -266,14 +266,16 @@ static void __sched 
>>> arm64_preempt_schedule_irq(void)
>>>   }
>>>
>>>   static void do_interrupt_handler(struct pt_regs *regs,
>>> -                                void (*handler)(struct pt_regs *))
>>> +                                void (*handler)(struct pt_regs *),
>>> +                                void (*do_handler)(struct pt_regs *,
>>> +                                                   void (*)(struct 
>>> pt_regs *)))
>>>   {
>>>          struct pt_regs *old_regs = set_irq_regs(regs);
>>>
>>>          if (on_thread_stack())
>>> -               call_on_irq_stack(regs, handler);
>>> +               call_on_irq_stack(regs, handler, do_handler);
>>>          else
>>> -               handler(regs);
>>> +               do_handler(regs, handler);
>>>
>>>          set_irq_regs(old_regs);
>>>   }
>>> @@ -441,22 +443,32 @@ asmlinkage void noinstr 
>>> el1h_64_sync_handler(struct pt_regs *regs)
>>>          }
>>>   }
>>>
>>> +static void nmi_handler(struct pt_regs *regs, void (*handler)(struct 
>>> pt_regs *))
>>> +{
>>> +       handler(regs);
>>> +}
>>> +
>>>   static __always_inline void __el1_pnmi(struct pt_regs *regs,
>>>                                         void (*handler)(struct 
>>> pt_regs *))
>>>   {
>>>          arm64_enter_nmi(regs);
>>> -       do_interrupt_handler(regs, handler);
>>> +       do_interrupt_handler(regs, handler, nmi_handler);
>>>          arm64_exit_nmi(regs);
>>>   }
>>>
>>> +static void irq_handler(struct pt_regs *regs, void (*handler)(struct 
>>> pt_regs *))
>>> +{
>>> +       irq_enter_rcu();
>>> +       handler(regs);
>>> +       irq_exit_rcu();
>>> +}
>>> +
>>>   static __always_inline void __el1_irq(struct pt_regs *regs,
>>>                                        void (*handler)(struct pt_regs 
>>> *))
>>>   {
>>>          enter_from_kernel_mode(regs);
>>>
>>> -       irq_enter_rcu();
>>> -       do_interrupt_handler(regs, handler);
>>> -       irq_exit_rcu();
>>> +       do_interrupt_handler(regs, handler, irq_handler);
>>>
>>>          arm64_preempt_schedule_irq();
>>>
>>> @@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs 
>>> *regs,
>>>          if (regs->pc & BIT(55))
>>>                  arm64_apply_bp_hardening();
>>>
>>> -       irq_enter_rcu();
>>> -       do_interrupt_handler(regs, handler);
>>> -       irq_exit_rcu();
>>> +       do_interrupt_handler(regs, handler, irq_handler);
>>>
>>>          exit_to_user_mode(regs);
>>>   }
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index 254fe31c03a0..1c351391f6bd 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -867,7 +867,9 @@ NOKPROBE(ret_from_fork)
>>>
>>>   /*
>>>    * void call_on_irq_stack(struct pt_regs *regs,
>>> - *                       void (*func)(struct pt_regs *));
>>> + *                       void (*func)(struct pt_regs *)
>>> + *                       void (*do_func)(struct pt_regs *,
>>> + *                                       void (*)(struct pt_regs *)));
>>>    *
>>>    * Calls func(regs) using this CPU's irq stack and shadow irq stack.
>>>    */
>>> @@ -886,7 +888,7 @@ SYM_FUNC_START(call_on_irq_stack)
>>>
>>>          /* Move to the new stack and call the function there */
>>>          mov     sp, x16
>>> -       blr     x1
>>> +       blr     x2
>>>
>>>          /*
>>>           * Restore the SP from the FP, and restore the FP and LR 
>>> from the frame
>>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>>> index c36ad20a52f3..003db605bc4f 100644
>>> --- a/arch/arm64/kernel/irq.c
>>> +++ b/arch/arm64/kernel/irq.c
>>> @@ -73,14 +73,15 @@ static void init_irq_stacks(void)
>>>   #endif
>>>
>>>   #ifndef CONFIG_PREEMPT_RT
>>> -static void ____do_softirq(struct pt_regs *regs)
>>> +static void ____do_softirq(struct pt_regs *regs,
>>> +                          void (*handler)(struct pt_regs *))
>>>   {
>>>          __do_softirq();
>>>   }
>>>
>>>   void do_softirq_own_stack(void)
>>>   {
>>> -       call_on_irq_stack(NULL, ____do_softirq);
>>> +       call_on_irq_stack(NULL, NULL, ____do_softirq);
>>>   }
>>>   #endif
>>>
>>> -- 
>>> 2.20.1
>>>
> 

-- 
Thanks,
Qi
