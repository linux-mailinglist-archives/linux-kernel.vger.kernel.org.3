Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F695072D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354499AbiDSQSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354500AbiDSQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:18:50 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE038BCE;
        Tue, 19 Apr 2022 09:16:07 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id d19so3529942ybc.5;
        Tue, 19 Apr 2022 09:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdJkQFegCpx/QCihmoNqss9vW3lewnxP27ekVArKHfw=;
        b=ofpT7J+qkBpnLPhWNfQIOaHgKNILGpmIIkFiX8aeotW2Dfo46DK+xwvo03Tnws9ijo
         YQS6fQL7hgGZBOPcZzzKQU7m8DrwKGLv678Opyv/u5x6QiUv1GC3O6+SK7/8nFHtOMqc
         6IGxsWYtUMDhfw0NJspspuoI11F7wkJmahvnIie8yyJQQsbC8xIx/Ax8FYpdOT7JB5DO
         Vrz4QuRwhG7/uFSGPjZOOYq5lmVzP6s+5VNhsIs+0Vesloe+eRiCK3Y/XClYH3mYM0A1
         2pXJAahmSTTELndIEsEY4mg4Qb1UYoP/S5R69LD3pg4OXKLd5+HIx93bAeU8h6SkxSs2
         YLAA==
X-Gm-Message-State: AOAM5324cMemcSlYI2pyTt9sczPHRXNX5DUR1UntDjop5TnUTqgaux4L
        EtQEyG5IzmOZ4CNmYqcDkajElrjvMnhpU9ouSbo=
X-Google-Smtp-Source: ABdhPJxiVNde9jKEH2NeYbLowMGmePdDc0ZZQ/YbGNZnXsT0SNO4zMDbDEtbXKHc6MfCIBnc7cwq1XpjeOZWIgEewrU=
X-Received: by 2002:a05:6902:1543:b0:642:3fd:316c with SMTP id
 r3-20020a056902154300b0064203fd316cmr15328475ybu.622.1650384966773; Tue, 19
 Apr 2022 09:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.648485667@linutronix.de>
In-Reply-To: <20220415161206.648485667@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:15:56 +0200
Message-ID: <CAJZ5v0hLn9APoLL13eEjTDKZNr0o5JnvTZrit793R2dAtvj79w@mail.gmail.com>
Subject: Re: [patch 05/10] x86/aperfmperf: Put frequency invariance
 aperf/mperf data into a struct
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 9:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Preparation for sharing code with the CPU frequency portion of the
> aperf/mperf code.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

All good AFAICS:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/aperfmperf.c |   26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -22,6 +22,13 @@
>
>  #include "cpu.h"
>
> +struct aperfmperf {
> +       u64             aperf;
> +       u64             mperf;
> +};
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct aperfmperf, cpu_samples);
> +
>  struct aperfmperf_sample {
>         unsigned int    khz;
>         atomic_t        scfpending;
> @@ -194,8 +201,6 @@ unsigned int arch_freq_get_on_cpu(int cp
>
>  DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
>
> -static DEFINE_PER_CPU(u64, arch_prev_aperf);
> -static DEFINE_PER_CPU(u64, arch_prev_mperf);
>  static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
>  static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
>
> @@ -407,8 +412,8 @@ static void init_counter_refs(void)
>         rdmsrl(MSR_IA32_APERF, aperf);
>         rdmsrl(MSR_IA32_MPERF, mperf);
>
> -       this_cpu_write(arch_prev_aperf, aperf);
> -       this_cpu_write(arch_prev_mperf, mperf);
> +       this_cpu_write(cpu_samples.aperf, aperf);
> +       this_cpu_write(cpu_samples.mperf, mperf);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> @@ -474,9 +479,8 @@ DEFINE_PER_CPU(unsigned long, arch_freq_
>
>  void arch_scale_freq_tick(void)
>  {
> -       u64 freq_scale;
> -       u64 aperf, mperf;
> -       u64 acnt, mcnt;
> +       struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
> +       u64 aperf, mperf, acnt, mcnt, freq_scale;
>
>         if (!arch_scale_freq_invariant())
>                 return;
> @@ -484,11 +488,11 @@ void arch_scale_freq_tick(void)
>         rdmsrl(MSR_IA32_APERF, aperf);
>         rdmsrl(MSR_IA32_MPERF, mperf);
>
> -       acnt = aperf - this_cpu_read(arch_prev_aperf);
> -       mcnt = mperf - this_cpu_read(arch_prev_mperf);
> +       acnt = aperf - s->aperf;
> +       mcnt = mperf - s->mperf;
>
> -       this_cpu_write(arch_prev_aperf, aperf);
> -       this_cpu_write(arch_prev_mperf, mperf);
> +       s->aperf = aperf;
> +       s->mperf = mperf;
>
>         if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
>                 goto error;
>
