Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8956A537E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiE3N5H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 May 2022 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiE3Nv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:51:27 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAFA880CA;
        Mon, 30 May 2022 06:36:28 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id t31so6154031ybi.2;
        Mon, 30 May 2022 06:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ctyj8jhtqDdweE4lavI3quEUZCKV+EHuOOErPIUdLrc=;
        b=H9rITRT741X/2k2LFXhTwgphnhEvHMag2VmmuRNDeJ3EGuNxsuwPB1FrLE678kfZG4
         5B7Di18sAXd2XzC96N8teBImSosgPDx657bEGfu//rYcFYGJVzxaV+f7qVLOH/HbMoHP
         +D9jcR/zAz4mQa4M2MbSY3zGoyx5EBCGXHzMrF80MvKHAPB/W1umx9MB79EH+pI/v+4q
         dIzStMAfpSUctl4YZ3GbZcBMse4NtIxktnUh5d4NWdyB4PAVuTtyzAc/6bD3BZW2eReK
         vJUrYQ2s1FvOXL96J3pqE7Vg7JLDNPQEpXfEpz/Nkv46PZdXtlDyPJ0JMB69na19J7IS
         IrEg==
X-Gm-Message-State: AOAM532QZmk+KSVONaUm6STryhR+Cula2hOUa7ytJYF8NgGKqtnPPMxS
        PNsa+glkPPmZn/7U9zukTqSDXsLf3pUe3kVX0+g=
X-Google-Smtp-Source: ABdhPJyb0iZxfAaRN/OL5PW28EO/JOfURGcI7tX4+kyohamIRvWbmypvoyTbRkJ+jLQBQNzIZcV9m5XrxzQC8NRT1RU=
X-Received: by 2002:a25:d98b:0:b0:65c:9dc9:7a8f with SMTP id
 q133-20020a25d98b000000b0065c9dc97a8fmr10646856ybg.622.1653917787866; Mon, 30
 May 2022 06:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220530100424.103301-1-pierre.gondois@arm.com>
 <20220530100424.103301-2-pierre.gondois@arm.com> <f2b9386a-16dd-bd03-4972-aaa026f72c03@hisilicon.com>
In-Reply-To: <f2b9386a-16dd-bd03-4972-aaa026f72c03@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 May 2022 15:36:16 +0200
Message-ID: <CAJZ5v0h7UEhXUUW5u=1PhvRWGURUF-KNJMPwL_MQPU-cAaYYDA@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/1] cpufreq: CPPC: Fix unused-function warning
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 1:56 PM Shaokun Zhang
<zhangshaokun@hisilicon.com> wrote:
>
> Hi,
>
> It works for me on compile when CONFIG_ENERGY_MODEL=n, please feel free to add:
> Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Applied, thanks!

> On 2022/5/30 18:04, Pierre Gondois wrote:
> > Building the cppc_cpufreq driver with for arm64 with
> > CONFIG_ENERGY_MODEL=n triggers the following warnings:
> >  drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
> > [-Werror=unused-function]
> >    550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
> >        |            ^~~~~~~~~~~~~~~~~
> >  drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
> > [-Werror=unused-function]
> >    481 | static int cppc_get_cpu_power(struct device *cpu_dev,
> >        |            ^~~~~~~~~~~~~~~~~~
> >
> > Move the Energy Model related functions into specific guards.
> > This allows to fix the warning and prevent doing extra work
> > when the Energy Model is not present.
> >
> > Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> > Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index f0a8bb2c59e5..24eaf0ec344d 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -441,6 +441,14 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
> >       }
> >       return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> >  }
> > +#else
> > +static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
> > +{
> > +     return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> > +}
> > +#endif
> > +
> > +#if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
> >
> >  static DEFINE_PER_CPU(unsigned int, efficiency_class);
> >  static void cppc_cpufreq_register_em(struct cpufreq_policy *policy);
> > @@ -621,21 +629,12 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> >  }
> >
> >  #else
> > -
> > -static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
> > -{
> > -     return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> > -}
> >  static int populate_efficiency_class(void)
> >  {
> >       return 0;
> >  }
> > -static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> > -{
> > -}
> >  #endif
> >
> > -
> >  static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
> >  {
> >       struct cppc_cpudata *cpu_data;
> >
