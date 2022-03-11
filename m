Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC94D5CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiCKIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiCKIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:01:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65961B84E5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:00:09 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s25so13648744lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eM1cgwx+VAhk2nZBQ1X2SG56yWwdToMPM1cZ/64bkiM=;
        b=kv3w5MYcVkFDnb8v210jeStfyj6r8BMAo75yubtDn4T/+ogAIz+0VQb+EzWDXcrH9i
         W5Wii+wrUYRZZ0JjoV38OssXJ5LpAxOFumsumoY0450yZ2CVnIlf7aLOHMLcE2+6/76f
         S7eD3Ci1556tQQbhekLMNL3Km6brGQFVUqqrCnEGndj9iDNSPdKGMhiZiAAEICYlQ1I/
         Wf7yVpvMbIQI/fABR3KkReO1sXhmXVq2Q3oN0W9BoV9aF8zxsmPMmNg/IhujPobfZJLi
         guLkOc5HI0CGb2QW78PrjknoVBB5D+9NlUdfydB6cAw+hYIfLwcgcmLblrjWpMetVSxm
         ehKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eM1cgwx+VAhk2nZBQ1X2SG56yWwdToMPM1cZ/64bkiM=;
        b=OSzUVXwKfjkR/XFK3LMQyuKcfEOYCGaglYg3u/cP+QiZBgcTBcu1vu/nD5eK0O0/a+
         tiAMfHJhfD94/IgavEEQ2jbVlGrf7b2Snac8Dv+3XPFGxPMN7hj1kYlFiDMc+JJXczta
         buynMslrgVCOq9yd57ZOo+dWPJGRCCe5D56f1ZC8XrmvaTojmRaL0WlHks5ahQulaH/z
         ewlk8pwn52o0JOSrzd1go95faSok6p6ROrBNRnv8CF2WuYWB/EfGWEvFmkXfWn76WhAl
         zLgHpEV0zaVsXkDPh+b10G++Yv7d5qq2PzBaRCwfwRKBVu48U5ZseAgUNIyIvS7S0blQ
         i4pQ==
X-Gm-Message-State: AOAM5317zAxXMM1KVbWek9P4CtnNlRC5JDUIIttidLqOHKW12eMo1Fqc
        DWEKToIVqxqVE+sVj3TLRM74EznQ2dCMkdgGbLarjg==
X-Google-Smtp-Source: ABdhPJw6RzsLNC1oOBI8llDzPbbjY2TzIHMm6DYoGWjDmKXkq+aODzzXICgEnQvTY2mqYsRHX7sIcC9ypzBC1VtjDQs=
X-Received: by 2002:ac2:554a:0:b0:448:2a09:66eb with SMTP id
 l10-20020ac2554a000000b004482a0966ebmr5494030lfk.645.1646985607963; Fri, 11
 Mar 2022 00:00:07 -0800 (PST)
MIME-Version: 1.0
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com> <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 11 Mar 2022 08:59:56 +0100
Message-ID: <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu topology
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 at 03:03, =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrote:
>
>
> >On Thu, 10 Mar 2022 at 13:59, Qing Wang <wangqing@vivo.com> wrote:
> >>
> >> From: Wang Qing <wangqing@vivo.com>
> >>
> >> Some architectures(e.g. ARM64), caches are implemented below:
> >> cluster:                     ****** cluster 0 *****      ****** cluste=
r 1 *****
> >> core:                         0      1          2      3          4   =
   5           6      7
> (add cache level 1)        c0    c1        c2    c3         c4    c5     =
    c6    c7
> >> cache(Leveln):         **cache0**  **cache1**  **cache2**  **cache3**
> (add cache level 3)        *************share level 3 cache *************=
**
> >> sd_llc_id(current):     0      0          0      0          4      4  =
         4      4
> >> sd_llc_id(should be): 0      0          2      2          4      4    =
       6      6
> >>
> Here, n always be 2 in ARM64, but others are also possible.
> core[0,1] form a complex(ARMV9),  which share L2 cache, core[2,3] is the =
same.
>
> >> Caches and cpus have different topology, this causes cpus_share_cache(=
)
> >> return the wrong value, which will affect the CPU load balance.
> >>
> >What does your current scheduler topology  look like?
> >
> >For CPU 0 to 3, do you have the below ?
> >DIE [0     -     3] [4-7]
> >MC  [0] [1] [2] [3]
>
> The current scheduler topology consistent with CPU topology:
> DIE  [0-7]
> MC  [0-3] [4-7]  (SD_SHARE_PKG_RESOURCES)
> Most Android phones have this topology.
> >
> >But you would like something like below for cpu 0-1 instead ?
> >DIE [0     -     3] [4-7]
> >CLS [0 - 1] [2 - 3]
> >MC  [0] [1]
> >
> >with SD_SHARE_PKG_RESOURCES only set to MC level ?
>
> We don't change the current scheduler topology, but the
> cache topology should be separated like below:

The scheduler topology is not only cpu topology but a mixed of cpu and
cache/memory cache topology

> [0-7]                          (shared level 3 cache )
> [0-1] [2-3][4-5][6-7]   (shared level 2 cache )

So you don't  bother the intermediate cluster level which is even simpler.
you have to modify generic arch topology so that cpu_coregroup_mask
returns the correct cpu mask directly.

You will notice a llc_sibling field that is currently used by acpi but
not DT to return llc cpu mask

> >
> >>
> >> Cache topology should be separated with CPU topology, it can be obtain=
ed
> >> from "next-level-cache" in DTS preferentially.
> >>
> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >> ---
> >>  arch/arm64/kernel/smp.c       |  1 +
> >>  drivers/base/arch_topology.c  | 23 +++++++++++++++++++++++
> >>  include/linux/arch_topology.h |  3 +++
> >>  kernel/sched/topology.c       | 33 +++++++++++++++++++++++++++++++--
> >>  4 files changed, 58 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> >> index 27df5c1..94cf649
> >> --- a/arch/arm64/kernel/smp.c
> >> +++ b/arch/arm64/kernel/smp.c
> >> @@ -723,6 +723,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus=
)
> >>         unsigned int this_cpu;
> >>
> >>         init_cpu_topology();
> >> +       init_cpu_cache_topology();
> >>
> >>         this_cpu =3D smp_processor_id();
> >>         store_cpu_topology(this_cpu);
> >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology=
.c
> >> index 9761541..613213f
> >> --- a/drivers/base/arch_topology.c
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -613,6 +613,7 @@ static int __init parse_dt_topology(void)
> >>   */
> >>  struct cpu_topology cpu_topology[NR_CPUS];
> >>  EXPORT_SYMBOL_GPL(cpu_topology);
> >> +struct device_node *cache_topology[NR_CPUS][MAX_CPU_CACHE_LEVEL];
> >
> >AFAICT, arch_topology.c is only used by arm/arm64 and riscv so this is
> >not initialized for other archs
>
> I see, will be fixed in V2.
>
> Thanks,
> Wang
> >
> >>
> >>  const struct cpumask *cpu_coregroup_mask(int cpu)
> >>  {
> >> @@ -738,4 +739,26 @@ void __init init_cpu_topology(void)
> >>         else if (of_have_populated_dt() && parse_dt_topology())
> >>                 reset_cpu_topology();
> >>  }
> >> +
> >> +void __init init_cpu_cache_topology(void)
> >> +{
> >> +       struct device_node *node_cpu, *node_cache;
> >> +       int cpu, level;
> >> +
> >> +       for_each_possible_cpu(cpu) {
> >> +               node_cpu =3D of_get_cpu_node(cpu, NULL);
> >> +               if (!node_cpu)
> >> +                       continue;
> >> +
> >> +               level =3D 0;
> >> +               node_cache =3D node_cpu;
> >> +               while (level < MAX_CPU_CACHE_LEVEL) {
> >> +                       node_cache =3D of_parse_phandle(node_cache, "n=
ext-level-cache", 0);
> >> +                       if (!node_cache)
> >> +                               break;
> >> +                       cache_topology[cpu][level++] =3D node_cache;
> >> +               }
> >> +               of_node_put(node_cpu);
> >> +       }
> >> +}
> >>  #endif
> >> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topolo=
gy.h
> >> index cce6136b..d37f47d
> >> --- a/include/linux/arch_topology.h
> >> +++ b/include/linux/arch_topology.h
> >> @@ -72,6 +72,8 @@ struct cpu_topology {
> >>  };
> >>
> >>  #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
> >> +#define MAX_CPU_CACHE_LEVEL 7
> >> +extern struct device_node *cache_topology[NR_CPUS][MAX_CPU_CACHE_LEVE=
L];
> >>  extern struct cpu_topology cpu_topology[NR_CPUS];
> >>
> >>  #define topology_physical_package_id(cpu)      (cpu_topology[cpu].pac=
kage_id)
> >> @@ -82,6 +84,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
> >>  #define topology_cluster_cpumask(cpu)  (&cpu_topology[cpu].cluster_si=
bling)
> >>  #define topology_llc_cpumask(cpu)      (&cpu_topology[cpu].llc_siblin=
g)
> >>  void init_cpu_topology(void);
> >> +void init_cpu_cache_topology(void);
> >>  void store_cpu_topology(unsigned int cpuid);
> >>  const struct cpumask *cpu_coregroup_mask(int cpu);
> >>  const struct cpumask *cpu_clustergroup_mask(int cpu);
> >> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >> index d201a70..10850d6
> >> --- a/kernel/sched/topology.c
> >> +++ b/kernel/sched/topology.c
> >> @@ -650,6 +650,36 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_as=
ym_packing);
> >>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> >>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
> >>
> >> +static void set_sd_llc(int cpu, struct sched_domain *sd, int *first_c=
pu, int *cpu_num)
> >> +{
> >> +       int cache_level, cpu_id;
> >> +       int first, last;
> >> +       int id =3D cpumask_first(sched_domain_span(sd));
> >> +       int size =3D cpumask_weight(sched_domain_span(sd));
> >> +
> >> +       *first_cpu =3D id;
> >> +       *cpu_num =3D size;
> >> +
> >> +       for (cache_level =3D 0; cache_level < MAX_CPU_CACHE_LEVEL; cac=
he_level++) {
> >> +               if (!cache_topology[cpu][cache_level])
> >> +                       break;
> >> +
> >> +               first =3D -1;
> >> +               last =3D id;
> >> +               for (cpu_id =3D 0; cpu_id < NR_CPUS; cpu_id++) {
> >> +                       if (cache_topology[cpu][cache_level] =3D=3D ca=
che_topology[cpu_id][cache_level]) {
> >> +                               if (cpu_id >=3D id && cpu_id < id + si=
ze) {
> >> +                                       first =3D (first =3D=3D -1)?cp=
u_id:first;
> >> +                                       last =3D cpu_id;
> >> +                               } else
> >> +                                       return;
> >> +                       }
> >> +               }
> >> +               *first_cpu =3D first;
> >> +               *cpu_num =3D last - first + 1;
> >> +       }
> >> +}
> >> +
> >>  static void update_top_cache_domain(int cpu)
> >>  {
> >>         struct sched_domain_shared *sds =3D NULL;
> >> @@ -659,8 +689,7 @@ static void update_top_cache_domain(int cpu)
> >>
> >>         sd =3D highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
> >>         if (sd) {
> >> -               id =3D cpumask_first(sched_domain_span(sd));
> >> -               size =3D cpumask_weight(sched_domain_span(sd));
> >> +               set_sd_llc(cpu, sd, &id, &size);
> >
> >In scheduler, we look for the last level of SD_SHARE_PKG_RESOURCES to
> >find shared memory. It seems that cpu_coregroup_mask doesn't return
> >the correct cpumask in your case as it returns a full cluster instead
> >of a subset
> >
> >>                 sds =3D sd->shared;
> >
> >sds must  stay aligned with id and size so instead of modifying id and
> >size you should returns a cpumask that reflects your topology
> >
> >>         }
> >>
> >> --
> >> 2.7.4
> >
