Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520DD4DCF98
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiCQUnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCQUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:43:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65F10CF18;
        Thu, 17 Mar 2022 13:42:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so13190062ejd.5;
        Thu, 17 Mar 2022 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BgQnw+BqusxL9RJ+sc/8dhfcjQxpoNkAjiP0V+wfr98=;
        b=SYegcS9YNSU0vv5yR5gINCKQHpg+/XqF9+gzIf7ZIUFM9walUETQONunOSMMgl4HB2
         zCqnFH2a7rhCGrTh1Vd3AzmjQIpEb90wh4ODtWjOGsvbblvHJAiEHynhL8EQTAcvsZbi
         V1zGzmg+B7NfQqJCIKFJZ9VA5NMyIQz2egBuKmwqdgV9kznKaBGpH1LqiYfu61QAVQZB
         sKNgB3Ci7KrFbhlulNrmxa7BptLiLsjn8Slde6S3yr6CKcwpfKMtlGM8zemRHjCh85wN
         GRAFLHNno3yHeVpsMMUXGvm3TslovFj+wa2UvbXpkOOIxN9L1LJuJxCSpJMtl/OV2CuY
         cV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BgQnw+BqusxL9RJ+sc/8dhfcjQxpoNkAjiP0V+wfr98=;
        b=D+3hPt/cB0OKlekMYuHZmg9GqRUnc1NbaMVy11y5LDuK3dsjzuAB8MKDmmAzi2QxKn
         pOjYaqah2yw1aXmzyD0ohHFATLc/S9pojXQOkMX3uw3RQ5sKapML+6/5W1dfM+peQQy3
         EFdGrrBl6DyK+N31/3mdIS7GWqGXX/p1W+tdANbg96EUF93I1G6KqOYQkgZPq07Sx6uu
         sRnDcI0ZhgD0+BqM/rxqCcOGCV64AfndCv/jNRPp0UDTVRycj6G60TRYE5yM1zb2Dgyn
         /7nxA8hlQ8Bo4Nmld4BAHzK71HjUtJJnTVLuh5C7O6y+xI2OM/oYnRaU8RdNtAFCkR/m
         bmuA==
X-Gm-Message-State: AOAM5312gwCGikzi5DsIxsXxX3gjkeAI0MfRcL9zVQGiPDDvGP++mW9G
        Pa0ZsBsvAazvZaVT8alZDrue8UrziCfFhGjqhos=
X-Google-Smtp-Source: ABdhPJzEbN9DOOisz1Ugx2LgbjMjBSsuDgEYw04K57+AdtuDehT5TPDBxAAYS6R6GfzSWB1BSvvcYbx0RXnbm8oBG3Y=
X-Received: by 2002:a17:906:7746:b0:6ce:a12e:489f with SMTP id
 o6-20020a170906774600b006cea12e489fmr5990415ejn.551.1647549731023; Thu, 17
 Mar 2022 13:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1> <YjNSuprCqjAgGgqB@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317162033.GP4285@paulmck-ThinkPad-P17-Gen-1> <YjNll+Iv++LORS0n@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317173621.GQ4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220317173621.GQ4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 18 Mar 2022 04:41:59 +0800
Message-ID: <CAABZP2zu3Qiqtnw=DRnFUig8xO3WtvKuVkf=gqQ6kRihOmDTLQ@mail.gmail.com>
Subject: Re: RCU: undefined reference to irq_work_queue
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, rcu <rcu@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On Fri, Mar 18, 2022 at 4:20 AM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Thu, Mar 17, 2022 at 04:45:11PM +0000, Hyeonggon Yoo wrote:
> > On Thu, Mar 17, 2022 at 09:20:33AM -0700, Paul E. McKenney wrote:
> > > On Thu, Mar 17, 2022 at 03:24:42PM +0000, Hyeonggon Yoo wrote:
> > > > On Thu, Mar 17, 2022 at 07:00:00AM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
> > > > > > Hello RCU folks,
> > > > > >
> > > > > > I like to use minimal configuration for kernel development.
> > > > > > when building with tinyconfig + CONFIG_PREEMPT=3Dy on arm64:
> > > > > >
> > > > > > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > > > > > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > > > > > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_=
CALL26 against undefined symbol `irq_work_queue'
> > > > > > make: *** [Makefile:1155: vmlinux] Error 1
> > > > > >
> > > > > > It seems RCU calls irq_work_queue() without checking if CONFIG_=
IRQ_WORK is enabled.
> > > > >
> > > > > Indeed it does!
> > > > >
> > > > > And kernel/rcu/Kconfig shows why:
> > > > >
> > > > > config TASKS_TRACE_RCU
> > > > >         def_bool 0
> > > > >         select IRQ_WORK
> > > > >         help
> > > > >           This option enables a task-based RCU implementation tha=
t uses
> > > > >           explicit rcu_read_lock_trace() read-side markers, and a=
llows
> > > > >           these readers to appear in the idle loop as well as on =
the CPU
> > > > >           hotplug code paths.  It can force IPIs on online CPUs, =
including
> > > > >           idle ones, so use with caution.
> > > > >
> > > > > So the solution is to further minimize your configuration so as t=
o
> > > > > deselect TASKS_TRACE_RCU.
> > > >
> > > > They are already not selected.
> > >
> > > Good, thank you.
> > >
> > > How about TASKS_RUDE_RCU, TASKS_TRACE_RCU, and TASKS_RCU_GENERIC?
> >
> > TASKS_RUDE_RCU=3Dn
> > TASKS_TRACE_RCU=3Dn
> > TASKS_RCU_GENERIC=3Dy
> > TASKS_RCU=3Dy
> >
> > > > > This means making sure that both BPF and
> > > > > the various RCU torture tests are all deselected.
> > > >
> > > > I wanted to say call_rcu_tasks() can be referenced even when IRQ_WO=
RK is not
> > > > selected, making it fail to build.
> > >
> > > I am guessing because TASKS_RCU_GENERIC is selected?
> > >
> >
> > Right.
> >
> > > If so, does the patch at the end of this email help?
> > >
> >
> > No. did not help.
> >
> > I think I found reason...
> > with PREEMPTION=3Dy,
> >
> > in kernel/rcu/Kconfig:
> > config TASKS_RCU
> >         def_bool PREEMPTION
> >         help
> >           This option enables a task-based RCU implementation that uses
> >           only voluntary context switch (not preemption!), idle, and
> >           user-mode execution as quiescent states.  Not for manual sele=
ction.
> >
> > in kernel/rcu/Kconfig:
> > config TASKS_RCU_GENERIC
> >         def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
> >         select SRCU
> >         help
> >           This option enables generic infrastructure code supporting
> >           task-based RCU implementations.  Not for manual selection.
>
> Ah, this is because some of the tracing code uses TASKS_RCU only
> when PREEMPTION=3Dy.  That would be KPROBES and TRACING.  Maybe also
> TRACE_CLOCK and TRACEPOINTS, but I would hope that TRACING would
> cover those.  Adding the tracing guys for their thoughts.
>
> > > > > > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > > > > > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > > > > > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_=
CALL26 against undefined symbol `irq_work_queue'
> > > > > > make: *** [Makefile:1155: vmlinux] Error 1
> > > >
> > > > Isn't it better to fix this build failure?
> > >
> > > But of course!  However, first I need to know exactly what is causing=
 your
> > > build failure.  I cannot see your .config file, so I am having to gue=
ss.
> > >
> > > Don't get me wrong, I do have a lot of practice guessing, but it is s=
till
> > > just guessing.  ;-)
> >
> > Sorry to make you guess. Maybe too late, but added config as attachment=
 ;)
>
> Perhaps I needed the practice.  ;-)
>
> > > > It fails to build when both TASKS_TRACE_RCU and IRQ_WORK are not se=
lected
> > > > and PREEMPT is selected.
> > > >
> > > >   =E2=94=82 Symbol: TASKS_TRACE_RCU [=3Dn]                         =
                   =E2=94=82
> > > >   =E2=94=82 Type  : bool                                           =
                 =E2=94=82
> > > >   =E2=94=82 Defined at kernel/rcu/Kconfig:96                       =
                 =E2=94=82
> > > >   =E2=94=82 Selects: IRQ_WORK [=3Dn]                               =
                   =E2=94=82
> > > >   =E2=94=82 Selected by [n]:                                       =
                 =E2=94=82
> > > >   =E2=94=82   - BPF_SYSCALL [=3Dn]                                 =
                   =E2=94=82
> > > >   =E2=94=82   - RCU_SCALE_TEST [=3Dn] && DEBUG_KERNEL [=3Dy]       =
                     =E2=94=82
> > > >   =E2=94=82   - RCU_TORTURE_TEST [=3Dn] && DEBUG_KERNEL [=3Dy]     =
                     =E2=94=82
> > > >   =E2=94=82   - RCU_REF_SCALE_TEST [=3Dn] && DEBUG_KERNEL [=3Dy]
> > > >
> > > > Thanks!
> > > >
> > > > >
> > > > > Or turn on IRQ_WORK, for example, if you need to use BPF.
> > >
> > > Or do you already have TASKS_RCU_GENERIC deselected?
> > >
> >
> > No, this is selected. TASKS_RCU_GENERIC=3Dy. because of PREEMPTION=3Dy.
>
> OK, the patch shown below allows me to get TASKS_RCU_GENERIC=3Dn even
> with PREEMPTION=3Dy.  This might somehow subtly break tracing, but in
> that case further adjustments can be made.  Untested other than
> generating a few .config combinations.
>
> Thoughts?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 678a80713b21..66c5b5543511 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -38,6 +38,7 @@ config KPROBES
>         depends on MODULES
>         depends on HAVE_KPROBES
>         select KALLSYMS
> +       select TASKS_RCU if PREEMPTION
>         help
>           Kprobes allows you to trap at almost any kernel address and
>           execute a callback function.  register_kprobe() establishes
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index f559870fbf8b..4f665ae0cf55 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -78,7 +78,8 @@ config TASKS_RCU_GENERIC
>           task-based RCU implementations.  Not for manual selection.
>
>  config TASKS_RCU
> -       def_bool PREEMPTION
> +       def_bool 0
> +       select IRQ_WORK
>         help
>           This option enables a task-based RCU implementation that uses
>           only voluntary context switch (not preemption!), idle, and
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 752ed89a293b..a7aaf150b704 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -127,6 +127,7 @@ config TRACING
>         select BINARY_PRINTF
>         select EVENT_TRACING
>         select TRACE_CLOCK
> +       select TASKS_RCU if PREEMPTION
>
>  config GENERIC_TRACER
>         bool
I apply above patch, and invoke
$make  ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-
CC=3Daarch64-linux-gnu-gcc-10 tinyconfig
$make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-
CC=3Daarch64-linux-gnu-gcc-10 -j 16
kernel build successful this time (without above patch, kernel build
will quit with undefined reference to `irq_work_queue'
Tested-by: Zhouyi Zhou<zhouzhouyi@gmail.com>

Thanks
Zhouyi
