Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE1574C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiGNLhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiGNLhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:37:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF7E5A47E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:37:52 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MUGNZ-1o45Mb0lJD-00RHc5 for <linux-kernel@vger.kernel.org>; Thu, 14 Jul
 2022 13:37:50 +0200
Received: by mail-yb1-f175.google.com with SMTP id f73so2687513yba.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:37:49 -0700 (PDT)
X-Gm-Message-State: AJIora9R6rSTCFBUqXOHTW8mk4/ac+k67xZ74ftoP8E0pS6VdZ1bE9OQ
        nEjA3LN9df5k+IztzwCcYNic6HFTcjb01i7GELk=
X-Google-Smtp-Source: AGRyM1vUqxnmiBDwPm4ZZ+QFB5vCS44kV3tyUlBCIycJH+CKYZvh5+4M0HQAIPmubCKfIklYgwVZdFK3G+BS53CIsO4=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr8226264ybq.472.1657798668441; Thu, 14
 Jul 2022 04:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com> <20220708094950.41944-3-zhengqi.arch@bytedance.com>
In-Reply-To: <20220708094950.41944-3-zhengqi.arch@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 13:37:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
Message-ID: <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bOopzQesiblVxSC4NsHmLk0yJ6FyUFZxMzq48NsGjp0ulVktlRC
 9H1/W0+4OY6YwYT9ChXWtI9lU9WVs59zn/UEYnrTUhvYZIsYQP42NOcBoPSmS+LfbCfyVzq
 RuPjlxeOtrKSQB+mkqRgULkKtaWsba9YonbeaIZle9RmGx1QDsf02U3fQCb1MUFAEL/GyDr
 RtqETSdFCMPrFYvSKAm9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DB2e9xok1Q=:X82kSsN8bCHJeGj7iAnVzR
 h9vhctxjjZtKfiyJoPek4IUd+GqFjIA9enqjBei+1hq3q0tcE0Cl4RTWIE7Gc2Wiv+lOCF0+M
 52z1k+rtdV9YphlzLNxcs92tkhRvxQPg03mJBqywBptkv7g1Pq2i/qifCj0FU3n6s6qlpCYsX
 p4rbExp92+ONFQVqSk/KZlf0+m/VF75Z/dMMMSqjut8mrlib/JORL2Agk9j1RyymiG08O8+iM
 Bpul8GB/5qRY70xogurmtA7ePoheiSfPUWw1T7kN2di9q+5byJdy7ypGXmQBPmhMRTZQ50g0D
 VSfREcfZslxHHUb0+729CcCZjjYw/PFCnoi48b9k+IUk7b62lqY8VwfgGy7ctWMTu/x5Xa+yb
 kNxMkavNN8ZqUhJ2HcpOEGl4AKe9ELEqwX6MbDwo1RAJtxAjC6sdpZx2JVKS2C2kkwNpVXFxg
 rr9g8sDDDjTUJa2DneuNzl1mgk5IRz8tIGmDo3Gi2kM8D9UM/lcXL+FzR4GUS9JYwjy9VobI0
 LLjKpsFJlEBjdUOHqFnZ3hlETqRjtIYOq590M6WyBLyd4+omw+NultyUzLdwL08SaD1N2dk5u
 JREm8Nm8ol9oE3BhdKDCpP4F3agqQjGS4rFPXz9yfjawkivzSBsBpjldTfVFht0jIDL/z9u3V
 oY5nYn6GONCrzv6WlaFyqFqgopQhixJ7VNKK9gM+UoEgjPFqN3jONdkbaOV+kw1F6yznSUNoh
 43vHrJV8g229eMd7xkCbLAmarnvt+0fUXLg5Gt1uzujky8Uvk3qZ7Opq04y6FuJMZCvc8I+Us
 tXC+3hbCCTIBNpYnmLERseixg/DUZofkaLsYzurAMhC60uEO+IcQB/OR9pAth5DdIvFA6g2QZ
 4U+7Yt2jm34Yv5mcJ4tQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 11:49 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> Since softirqs are handled on the per-CPU IRQ stack,
> let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
> the core code to invoke __do_softirq() directly without
> going through do_softirq_own_stack().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Adding Mark Rutland to Cc, he's the one that worked on this area the most in the
past and should probably review your patch. I still feel like there
should be a way
to improve readability of the IRQ entry path rather than just adding another
level of indirection, but the ideas I had so far have not led to
anything useful.

Overall I suppose your version is an improvement over the extra double stack
switch when entering softirq.

        Arnd

> ---
>  arch/arm64/Kconfig                 |  1 +
>  arch/arm64/include/asm/exception.h |  4 +++-
>  arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
>  arch/arm64/kernel/entry.S          |  6 ++++--
>  arch/arm64/kernel/irq.c            |  5 +++--
>  5 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index be0a9f0052ee..d2cc7daecce3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -231,6 +231,7 @@ config ARM64
>         select TRACE_IRQFLAGS_SUPPORT
>         select TRACE_IRQFLAGS_NMI_SUPPORT
>         select HAVE_SOFTIRQ_ON_OWN_STACK
> +       select HAVE_IRQ_EXIT_ON_IRQ_STACK
>         help
>           ARM 64-bit (AArch64) Linux support.
>
> diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
> index d94aecff9690..8bff0aa7ab50 100644
> --- a/arch/arm64/include/asm/exception.h
> +++ b/arch/arm64/include/asm/exception.h
> @@ -54,7 +54,9 @@ asmlinkage void el0t_32_fiq_handler(struct pt_regs *regs);
>  asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
>
>  asmlinkage void call_on_irq_stack(struct pt_regs *regs,
> -                                 void (*func)(struct pt_regs *));
> +                                 void (*func)(struct pt_regs *),
> +                                 void (*do_func)(struct pt_regs *,
> +                                                 void (*)(struct pt_regs *)));
>  asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
>
>  void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index c75ca36b4a49..935d1ab150b5 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -266,14 +266,16 @@ static void __sched arm64_preempt_schedule_irq(void)
>  }
>
>  static void do_interrupt_handler(struct pt_regs *regs,
> -                                void (*handler)(struct pt_regs *))
> +                                void (*handler)(struct pt_regs *),
> +                                void (*do_handler)(struct pt_regs *,
> +                                                   void (*)(struct pt_regs *)))
>  {
>         struct pt_regs *old_regs = set_irq_regs(regs);
>
>         if (on_thread_stack())
> -               call_on_irq_stack(regs, handler);
> +               call_on_irq_stack(regs, handler, do_handler);
>         else
> -               handler(regs);
> +               do_handler(regs, handler);
>
>         set_irq_regs(old_regs);
>  }
> @@ -441,22 +443,32 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>         }
>  }
>
> +static void nmi_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
> +{
> +       handler(regs);
> +}
> +
>  static __always_inline void __el1_pnmi(struct pt_regs *regs,
>                                        void (*handler)(struct pt_regs *))
>  {
>         arm64_enter_nmi(regs);
> -       do_interrupt_handler(regs, handler);
> +       do_interrupt_handler(regs, handler, nmi_handler);
>         arm64_exit_nmi(regs);
>  }
>
> +static void irq_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
> +{
> +       irq_enter_rcu();
> +       handler(regs);
> +       irq_exit_rcu();
> +}
> +
>  static __always_inline void __el1_irq(struct pt_regs *regs,
>                                       void (*handler)(struct pt_regs *))
>  {
>         enter_from_kernel_mode(regs);
>
> -       irq_enter_rcu();
> -       do_interrupt_handler(regs, handler);
> -       irq_exit_rcu();
> +       do_interrupt_handler(regs, handler, irq_handler);
>
>         arm64_preempt_schedule_irq();
>
> @@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>         if (regs->pc & BIT(55))
>                 arm64_apply_bp_hardening();
>
> -       irq_enter_rcu();
> -       do_interrupt_handler(regs, handler);
> -       irq_exit_rcu();
> +       do_interrupt_handler(regs, handler, irq_handler);
>
>         exit_to_user_mode(regs);
>  }
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 254fe31c03a0..1c351391f6bd 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -867,7 +867,9 @@ NOKPROBE(ret_from_fork)
>
>  /*
>   * void call_on_irq_stack(struct pt_regs *regs,
> - *                       void (*func)(struct pt_regs *));
> + *                       void (*func)(struct pt_regs *)
> + *                       void (*do_func)(struct pt_regs *,
> + *                                       void (*)(struct pt_regs *)));
>   *
>   * Calls func(regs) using this CPU's irq stack and shadow irq stack.
>   */
> @@ -886,7 +888,7 @@ SYM_FUNC_START(call_on_irq_stack)
>
>         /* Move to the new stack and call the function there */
>         mov     sp, x16
> -       blr     x1
> +       blr     x2
>
>         /*
>          * Restore the SP from the FP, and restore the FP and LR from the frame
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index c36ad20a52f3..003db605bc4f 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -73,14 +73,15 @@ static void init_irq_stacks(void)
>  #endif
>
>  #ifndef CONFIG_PREEMPT_RT
> -static void ____do_softirq(struct pt_regs *regs)
> +static void ____do_softirq(struct pt_regs *regs,
> +                          void (*handler)(struct pt_regs *))
>  {
>         __do_softirq();
>  }
>
>  void do_softirq_own_stack(void)
>  {
> -       call_on_irq_stack(NULL, ____do_softirq);
> +       call_on_irq_stack(NULL, NULL, ____do_softirq);
>  }
>  #endif
>
> --
> 2.20.1
>
