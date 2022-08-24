Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2B59FB84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiHXNi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbiHXNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:38:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D347D7BB;
        Wed, 24 Aug 2022 06:38:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n15so2960079lfe.3;
        Wed, 24 Aug 2022 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OdBnoS8zGnfacBUoB38O3wipMG6DwRHyyQgDcbST94Y=;
        b=BCzSMmHT4nrXEhbH+xrvIhbKLDFCz8BfUSaUvbExriat86XTcUJqUXmZozIcLok1+U
         Nm8y5nFXpVX1Weeizbj+m6+foV4ZUpCNN/aSrbmDzssnL0KyUgdNqqpsskqXth91KhEU
         VG51XEejAMiszJ8tnoG2PmJjz8sibLv+urZYVMlxULaDk5M+qOVPuxXW5FJFmPxDtq5B
         PLRIBxjadn8ld+q9izfiVagHkOrY6a39nuWfQLqHzZYlKHxfFDE+enjrnfnr8jivK1NB
         VVtdldxUstBr+TJFEWPCjLiYAzlNIuv/othu/hrCunbCR3Wlr+GN82eVOagu130Z/F81
         MfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OdBnoS8zGnfacBUoB38O3wipMG6DwRHyyQgDcbST94Y=;
        b=rhe1R8SXCySx0zvMEkMciZ2eLhOka/utCR6dBh4AF0FkToT6nujpb4HISxRKJp4jkE
         dxYl8HmMSNKxNylTpiW4LdaoJnQpbUpP5S98Gu/IgWjpSa8QtbvJJ5ws+I89L7v9VbB8
         ocncbJsBKantdANN2hxGUY25JZHrM2LZP+33O7jZcFJsAs/dG6Ln4inU4sz82demo3En
         KfVfIpWi6ANbwfA5XilgI7C8kbTQ4TzHJ09ZIyeGAnDzz5oSenPx9KKdxLidXAykRBoI
         +pI9h+Fl3+E7ztpzrqprxmhJt2x39waVyJR4v+7yY6LI7vpJx/2BMo0jKxFL+vfGOUsd
         Zhzw==
X-Gm-Message-State: ACgBeo11XWEHKhRl7SpjXMi+uMiWNqUd2ka32JHcWd4pua92aP+1w4lr
        H2nX+aLTN/4rYHDJRBQMPfJOHgFufG9dyCHNDA==
X-Google-Smtp-Source: AA6agR7Z0zmPZ2oTAyl5ghHIdjlSL5e3Ijh1+AfwqpZX6nNCu1Q6vqfZNvjO8c9qRfVSO0gGPMo+SZIWqcvHyA1ZcWw=
X-Received: by 2002:a05:6512:228a:b0:48a:fa84:e298 with SMTP id
 f10-20020a056512228a00b0048afa84e298mr9475953lfu.183.1661348299946; Wed, 24
 Aug 2022 06:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
 <CAEXW_YRH11xFg-0nQfvv59SMFCW=SNTEEL0oHJKTs1X45wGr7w@mail.gmail.com>
 <YwQzyMlY6fa2WrM5@piliu.users.ipa.redhat.com> <CAEXW_YTJGqmi15itkPBNt_=Pj6PNG7aXWxq02UWQZ7rzj2mTiA@mail.gmail.com>
In-Reply-To: <CAEXW_YTJGqmi15itkPBNt_=Pj6PNG7aXWxq02UWQZ7rzj2mTiA@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 24 Aug 2022 21:38:08 +0800
Message-ID: <CAFgQCTsp9QmMrmC_3-ecpwWYFuFYO5zYGP=nhOLktfAKX1OqBA@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Aug 22, 2022 at 9:56 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Mon, Aug 22, 2022 at 02:08:38PM -0400, Joel Fernandes wrote:
> > > On Sun, Aug 21, 2022 at 10:16 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> > > >
> > > > In order to support parallel, rcu_state.n_online_cpus should be
> > > > atomic_dec()
> > >
> > > What does Parallel mean? Is that some kexec terminology?
> > >
> >
> > 'Parallel' means concurrent. It is not a kexec terminology, instead,
> > should be SMP.
>
> Ah ok! Makes sense. Apologies to be the word-police here, but you
> probably could reword it to "In order to support parallel offlining"
> or some such.
>

Thanks for your advice. It is a good English lesson, which can give
more productivity in the community.


Thanks,

    Pingfan


>  - Joel
>
>
>
> >
> > Thanks,
> >
> >         Pingfan
> >
> >
> > > Thanks,
> > >
> > >  - Joel
> > >
> > > >
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Steven Price <steven.price@arm.com>
> > > > Cc: "Peter Zijlstra
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > > > To: linux-kernel@vger.kernel.org
> > > > To: rcu@vger.kernel.org
> > > > ---
> > > >  kernel/cpu.c      | 1 +
> > > >  kernel/rcu/tree.c | 3 ++-
> > > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > > > index 1261c3f3be51..90debbe28e85 100644
> > > > --- a/kernel/cpu.c
> > > > +++ b/kernel/cpu.c
> > > > @@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
> > > >                 .name                   = "RCU/tree:prepare",
> > > >                 .startup.single         = rcutree_prepare_cpu,
> > > >                 .teardown.single        = rcutree_dead_cpu,
> > > > +               .support_kexec_parallel = true,
> > > >         },
> > > >         /*
> > > >          * On the tear-down path, timers_dead_cpu() must be invoked
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 79aea7df4345..07d31e16c65e 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> > > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > >                 return 0;
> > > >
> > > > -       WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > > > +       /* Hot remove path allows parallel, while Hot add races against remove on lock */
> > > > +       atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
> > > >         /* Adjust any no-longer-needed kthreads. */
> > > >         rcu_boost_kthread_setaffinity(rnp, -1);
> > > >         // Stop-machine done, so allow nohz_full to disable tick.
> > > > --
> > > > 2.31.1
> > > >
