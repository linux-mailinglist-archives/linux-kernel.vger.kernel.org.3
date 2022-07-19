Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06C579B99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiGSMaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiGSM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:29:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61774B4A0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:11:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 70so13358790pfx.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iNDtX2qWi9m1xYihwpiwhJVw0BBHC84OS3fYxxiGs34=;
        b=r6vlUemm7Ry7I9jShfww8oYAQy7YDVVHqAKcZ6xOOb7Ktn1reZr/elTEx+h17sf1Rl
         sdpUKDhyq5zPvRCDI3nTFx6KBEixdwhNkLhj5fjn8Unv5kWb+fkP8d2oY8MzeBgjh6nW
         daUqKmKl6OSHPT1gRCA5s+y+EzzCBBxP5WgVe1yJYxDQuXy7p923PalHeIYu61RjbUK0
         9eQMM7YP4FZiK7QhyrBghSPKfvyjFSVMG3TE8VS/tRas7kRuwIUNQJHCD9N6reaka7xv
         MEgHf+HDHfITTcVURNLtt34/R1CKP9l5DVca9LjRNLv0xkTpiYQECQqMfvrGtLpWlNx/
         QIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iNDtX2qWi9m1xYihwpiwhJVw0BBHC84OS3fYxxiGs34=;
        b=k9GbeHfcevX5zDD0Qx0hoZGasmeQYjGqaWYo2PCRv366dpR/5vqKkRZEtTGAhMdb9v
         55i0ABMk/RURHsR8xC7G7zDMhM3mCj5uEcWcK3Ln8SVrzhIVDEfjvjcK5MLvPLNzVhAY
         nLGb0s7CIxS7homIylDxlZnBGDVk7CuMeS4Ii8+bs68reAeAZb53KHu1j/5jMvdlfPoY
         783NOgStEBCO3H5aTliJ+u3U8M/P6Q5eqrDl8OZ75cXeJunVnIxLzJCNbuxM5EQbYb+E
         Iz6rSdJFNfznID6285umZoQDAVauldFqzuzBMcKUX+GgLqTK/XFpNEKcNMso9VM9Yak4
         D4vA==
X-Gm-Message-State: AJIora8f1FPKQGSc0GQ8+JN8n1mOypVCvwoboLfbNv2rx5gF9zJ4qmFE
        kLBEq3K/+2FQgYiN0MpHCYtt2Q==
X-Google-Smtp-Source: AGRyM1uppWywTWTnYB8naVjAi5O3rVZkJMFwJURmY1UQz1UM2e7wsqLcITZSZrHlkJgkFvIdp7qODg==
X-Received: by 2002:a63:6902:0:b0:41a:3743:c768 with SMTP id e2-20020a636902000000b0041a3743c768mr6082694pgc.512.1658232672681;
        Tue, 19 Jul 2022 05:11:12 -0700 (PDT)
Received: from [10.4.227.241] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0016a109c7606sm1761259plg.259.2022.07.19.05.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 05:11:12 -0700 (PDT)
Message-ID: <8518583c-d712-032f-32a1-f3f03e7c0e27@bytedance.com>
Date:   Tue, 19 Jul 2022 20:11:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v1 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
 <20220708094950.41944-3-zhengqi.arch@bytedance.com>
 <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
 <YtaUZCabQw7nrv4A@FVFF77S0Q05N>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <YtaUZCabQw7nrv4A@FVFF77S0Q05N>
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



On 2022/7/19 19:24, Mark Rutland wrote:
> On Thu, Jul 14, 2022 at 01:37:31PM +0200, Arnd Bergmann wrote:
>> On Fri, Jul 8, 2022 at 11:49 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>> Since softirqs are handled on the per-CPU IRQ stack,
>>> let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
>>> the core code to invoke __do_softirq() directly without
>>> going through do_softirq_own_stack().
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Adding Mark Rutland to Cc, he's the one that worked on this area the most in the
>> past and should probably review your patch. I still feel like there
>> should be a way
>> to improve readability of the IRQ entry path rather than just adding another
>> level of indirection, but the ideas I had so far have not led to
>> anything useful.
>>
>> Overall I suppose your version is an improvement over the extra double stack
>> switch when entering softirq.

Hi Mark,

> 
> The cost of the switch is fairly trivial, so performance-wise I would expect
> that to fall within the noise. So if this is just about avoiding the extra
> switch, I'd prefer to leave this as-is.

In this patch, I just want to avoid the extra switch.

> 
> If we want to move more work after the stack switch, I think we'd want a more
> in depth rethink of the structure of this code (since e.g. we could make the
> common case have almost everything on the IRQ stack, at the cost of making

For now, I don't think it's necessary to put anything other than
irq_{enter|exit}_rcu() on the IRQ stack. For things that we want
to run on the IRQ stack in the future, we can also easily stuff
them into do_handler(). So I think the method of nesting pointers
is good for extensibility except that it is not easy to read. And
this method does not change much. :)

> preemption require more work).

Overall, I'm ok to drop this optimized patch if we don't care about
the performance overhead of extra switching.

Thanks,
Qi

> 
> Thanks,
> Mark.
> 
>>
>>          Arnd
>>
>>> ---
>>>   arch/arm64/Kconfig                 |  1 +
>>>   arch/arm64/include/asm/exception.h |  4 +++-
>>>   arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
>>>   arch/arm64/kernel/entry.S          |  6 ++++--
>>>   arch/arm64/kernel/irq.c            |  5 +++--
>>>   5 files changed, 31 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index be0a9f0052ee..d2cc7daecce3 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -231,6 +231,7 @@ config ARM64
>>>          select TRACE_IRQFLAGS_SUPPORT
>>>          select TRACE_IRQFLAGS_NMI_SUPPORT
>>>          select HAVE_SOFTIRQ_ON_OWN_STACK
>>> +       select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>>          help
>>>            ARM 64-bit (AArch64) Linux support.
>>>
>>> diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
>>> index d94aecff9690..8bff0aa7ab50 100644
>>> --- a/arch/arm64/include/asm/exception.h
>>> +++ b/arch/arm64/include/asm/exception.h
>>> @@ -54,7 +54,9 @@ asmlinkage void el0t_32_fiq_handler(struct pt_regs *regs);
>>>   asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
>>>
>>>   asmlinkage void call_on_irq_stack(struct pt_regs *regs,
>>> -                                 void (*func)(struct pt_regs *));
>>> +                                 void (*func)(struct pt_regs *),
>>> +                                 void (*do_func)(struct pt_regs *,
>>> +                                                 void (*)(struct pt_regs *)));
>>>   asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
>>>
>>>   void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
>>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>>> index c75ca36b4a49..935d1ab150b5 100644
>>> --- a/arch/arm64/kernel/entry-common.c
>>> +++ b/arch/arm64/kernel/entry-common.c
>>> @@ -266,14 +266,16 @@ static void __sched arm64_preempt_schedule_irq(void)
>>>   }
>>>
>>>   static void do_interrupt_handler(struct pt_regs *regs,
>>> -                                void (*handler)(struct pt_regs *))
>>> +                                void (*handler)(struct pt_regs *),
>>> +                                void (*do_handler)(struct pt_regs *,
>>> +                                                   void (*)(struct pt_regs *)))
>>>   {
>>>          struct pt_regs *old_regs = set_irq_regs(regs);
>>>
>>>          if (on_thread_stack())
>>> -               call_on_irq_stack(regs, handler);
>>> +               call_on_irq_stack(regs, handler, do_handler);
>>>          else
>>> -               handler(regs);
>>> +               do_handler(regs, handler);
>>>
>>>          set_irq_regs(old_regs);
>>>   }
>>> @@ -441,22 +443,32 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>>>          }
>>>   }
>>>
>>> +static void nmi_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
>>> +{
>>> +       handler(regs);
>>> +}
>>> +
>>>   static __always_inline void __el1_pnmi(struct pt_regs *regs,
>>>                                         void (*handler)(struct pt_regs *))
>>>   {
>>>          arm64_enter_nmi(regs);
>>> -       do_interrupt_handler(regs, handler);
>>> +       do_interrupt_handler(regs, handler, nmi_handler);
>>>          arm64_exit_nmi(regs);
>>>   }
>>>
>>> +static void irq_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
>>> +{
>>> +       irq_enter_rcu();
>>> +       handler(regs);
>>> +       irq_exit_rcu();
>>> +}
>>> +
>>>   static __always_inline void __el1_irq(struct pt_regs *regs,
>>>                                        void (*handler)(struct pt_regs *))
>>>   {
>>>          enter_from_kernel_mode(regs);
>>>
>>> -       irq_enter_rcu();
>>> -       do_interrupt_handler(regs, handler);
>>> -       irq_exit_rcu();
>>> +       do_interrupt_handler(regs, handler, irq_handler);
>>>
>>>          arm64_preempt_schedule_irq();
>>>
>>> @@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>>>          if (regs->pc & BIT(55))
>>>                  arm64_apply_bp_hardening();
>>>
>>> -       irq_enter_rcu();
>>> -       do_interrupt_handler(regs, handler);
>>> -       irq_exit_rcu();
>>> +       do_interrupt_handler(regs, handler, irq_handler);
>>>
>>>          exit_to_user_mode(regs);
>>>   }
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index 254fe31c03a0..1c351391f6bd 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -867,7 +867,9 @@ NOKPROBE(ret_from_fork)
>>>
>>>   /*
>>>    * void call_on_irq_stack(struct pt_regs *regs,
>>> - *                       void (*func)(struct pt_regs *));
>>> + *                       void (*func)(struct pt_regs *)
>>> + *                       void (*do_func)(struct pt_regs *,
>>> + *                                       void (*)(struct pt_regs *)));
>>>    *
>>>    * Calls func(regs) using this CPU's irq stack and shadow irq stack.
>>>    */
>>> @@ -886,7 +888,7 @@ SYM_FUNC_START(call_on_irq_stack)
>>>
>>>          /* Move to the new stack and call the function there */
>>>          mov     sp, x16
>>> -       blr     x1
>>> +       blr     x2
>>>
>>>          /*
>>>           * Restore the SP from the FP, and restore the FP and LR from the frame
>>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>>> index c36ad20a52f3..003db605bc4f 100644
>>> --- a/arch/arm64/kernel/irq.c
>>> +++ b/arch/arm64/kernel/irq.c
>>> @@ -73,14 +73,15 @@ static void init_irq_stacks(void)
>>>   #endif
>>>
>>>   #ifndef CONFIG_PREEMPT_RT
>>> -static void ____do_softirq(struct pt_regs *regs)
>>> +static void ____do_softirq(struct pt_regs *regs,
>>> +                          void (*handler)(struct pt_regs *))
>>>   {
>>>          __do_softirq();
>>>   }
>>>
>>>   void do_softirq_own_stack(void)
>>>   {
>>> -       call_on_irq_stack(NULL, ____do_softirq);
>>> +       call_on_irq_stack(NULL, NULL, ____do_softirq);
>>>   }
>>>   #endif
>>>
>>> --
>>> 2.20.1
>>>

-- 
Thanks,
Qi
