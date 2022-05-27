Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7A5364DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352032AbiE0Pqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352485AbiE0Pq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:46:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEEB39A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:46:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so7494940lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpYyaIFQsHQ1SQPPWz8FXNjk5sSNyuKP3F6ff73fwcs=;
        b=J5itKyxM6p4O8igDG9E2yvhpKB664PEV3Qzzb7slkZ79sislRCKYyk4SXPv70dd4Ur
         K9/fJl275HBDK7ypbcmyhKScPGJnC/uKRHKtmOr8DJnywk8vzxS9JaJ7f0fVGuJP6Jo2
         k1/RAJKIIO8otMFbWuU5GMeQ5RDX0b+FsshHvl9b3Dipjv0yu8cE5muTfUxeXJy0wS93
         CEJGffbFlPDW8GjvW7A1/i5DAZsa+ECPWhlkkiR92dC2I+Sdn1af9B5TBE0Qw5OmBvs3
         DyJApfgqm0b40pihuOdbrXiNg/njq7n7TZtAjmmfUlVAcbqaRV2GCCs80XzRmc0MKe3g
         cJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpYyaIFQsHQ1SQPPWz8FXNjk5sSNyuKP3F6ff73fwcs=;
        b=FUScSqcZejLHXrGpGF6ly1fgUdfJzyIzWVCuqbz79ZOQNVSGp/wPFwVOT1U8M1zPNN
         tFN2ZMTo8OhoQswB4ZthYPcD7ctXCXFJ1Pu7IMgJ4xgARJEB8kcDzb5Wgv1r/Z+omiPD
         DEGDwoCWm0JWe1jqI4V+MU1zNPnexx+hr6AW0Da/1WFSBgJKEEd0K0otuEM1upBQS79k
         J/Coo2padky8u0ZuwRQHNNgeaAisIubnPzS5PPpMgx3qAbbjVJIPtBC+9u59LYABZ+jL
         VZB9fQLugW2Pofy0SVteZizHA4e9GpFyPxPYnLHyF3p27RJDGoYrGPvfsBrD19lG2T2m
         Tqyw==
X-Gm-Message-State: AOAM531P5c3YgFku8smK/lmx0m7pj0R73uJrKWxnnwCqyLHLcm13a2f+
        drLqXs3Qn/pq7klN2KKGb7lwBok5mD6JwLIlszcDRA==
X-Google-Smtp-Source: ABdhPJxLLF4108Vyr3RLK4ESq5Qf+xu0KWUs8anzlaNyh3897N6wyiC3pfmWVJ+NqEqyVmFEh8eNL4hrP6orT64yPsg=
X-Received: by 2002:a19:7106:0:b0:478:68b5:86d9 with SMTP id
 m6-20020a197106000000b0047868b586d9mr20020202lfc.417.1653666383196; Fri, 27
 May 2022 08:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220525111756.GA15955@axis.com> <20220526010111.755166-1-davidgow@google.com>
 <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
 <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
 <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
 <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
 <134957369d2e0abf51f03817f1e4de7cbf21f76e.camel@sipsolutions.net>
 <CACT4Y+aH7LqDUqAyQ7+hkyeZTtkYnMHia73M7=EeAzMYzJ8pQg@mail.gmail.com> <5eef2f1b43c25447ccca2f50f4964fd77a719b08.camel@sipsolutions.net>
In-Reply-To: <5eef2f1b43c25447ccca2f50f4964fd77a719b08.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 17:46:11 +0200
Message-ID: <CACT4Y+Yv2AGRCLZ=cpxQtkrxz9YKxPGLBcriyFo7FVGoDiyaSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 at 16:28, Johannes Berg <johannes@sipsolutions.net> wrote:
> > > > > On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > > > > > > I did note (this is more for kasan-dev@) that the "freed by" is fairly
> > > > > > > much useless when using kfree_rcu(), it might be worthwhile to annotate
> > > > > > > that somehow, so the stack trace is recorded by kfree_rcu() already,
> > > > > > > rather than just showing the RCU callback used for that.
> [...]
> > Humm... I don't have any explanation based only on this info.
> > Generally call_rcu stacks are memorized and I see the call is still there:
> > https://elixir.bootlin.com/linux/v5.18/source/kernel/rcu/tree.c#L3595
>
> Oh, that's simple then, UML is !SMP && !PREEMPT so it gets TINY_RCU
> instead of TREE_RCU.

Nice!

> Unfortunately, it's not entirely trivial to fix, something like this,
> mostly because of header maze (cannot include kasan.h in rcutiny.h):
>
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 5fed476f977f..d84e13f2c384 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
>   */
>  extern void kvfree(const void *addr);
>
> -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
>         if (head) {
>                 call_rcu(head, func);
> @@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>         kvfree((void *) func);
>  }
>
> +#ifdef CONFIG_KASAN_GENERIC
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +#else
> +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +       __kvfree_call_rcu(head, func);
> +}
> +#endif
> +
>  void rcu_qs(void);
>
>  static inline void rcu_softirq_qs(void)
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 340b3f8b090d..aa235f0332ba 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -217,6 +217,18 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
>  }
>  EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +       if (head) {
> +               void *ptr = (void *) head - (unsigned long) func;
> +
> +               kasan_record_aux_stack_noalloc(ptr);
> +       }
> +
> +       __kvfree_call_rcu(head, func);
> +}
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> +
>  void __init rcu_init(void)
>  {
>         open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
>
>
>
>
> Or I guess I could copy/paste
>
> #ifdef CONFIG_KASAN_GENERIC
> void kasan_record_aux_stack_noalloc(void *ptr);
> #else /* CONFIG_KASAN_GENERIC */
> static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
> #endif /* CONFIG_KASAN_GENERIC */
>
>
> into rcutiny.h, that'd be smaller, and export the symbol ...
>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/5eef2f1b43c25447ccca2f50f4964fd77a719b08.camel%40sipsolutions.net.
