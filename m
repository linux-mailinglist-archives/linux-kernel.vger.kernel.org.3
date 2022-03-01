Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56B4C8F11
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiCAP1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiCAP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:27:11 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3D5A9A45;
        Tue,  1 Mar 2022 07:26:28 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id f5so4077568ybg.9;
        Tue, 01 Mar 2022 07:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Wey3VSiTvyRuXo9mjhrzq8FpZ0njIfhcGgB6MBC7jA=;
        b=w41X/EriwiL5TMGEXM1JL+VRAb4iiKUj2iqAkgCr20ZQzDtxhlEewHGaPPEbncvwS5
         XePd5EctIuKFvIZJD0Cl+sOg/CYTW427LEJ/DoaBohPkg+vRldfHLDddn8Oj2f4gWAE5
         aMGPA+vqfI0skGV+Qhq+oVHKetKO7U3+Rmp/aq7k75e0How7tRPYPz8oB5EZJuV+GHHh
         dgo/v9UqrzC96TaT14ABr3fDbiapaJJKbIjXpUZKTIYybMHnaFtERNvsybYpsBNfpdl7
         vf9KiQmzNi92XhLGnN8wmRPX9k1u8CpS8KCXKPN2fgt9RVgMzbry2R05rvghr6rYlefL
         h2Zw==
X-Gm-Message-State: AOAM530sAVBDOkoh7keWj+k/UWwCSTkcteK+c8h8OsT6d8tAtdqSoAHn
        3SRaQvztyqg+OPvXpzUzfHCx9B3OF5+E3yhkz5A6z8XR
X-Google-Smtp-Source: ABdhPJx9yCCmcPK0M0eehbTXM8Bf1am0xs+djt55GEVxAmM2RiMZUPbcfsKuNpItrF/m+EtSG87Fjst3qSyAEu/C+e8=
X-Received: by 2002:a25:3f47:0:b0:628:7571:b07d with SMTP id
 m68-20020a253f47000000b006287571b07dmr4035239yba.622.1646148387217; Tue, 01
 Mar 2022 07:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20220223100350.3523826-1-Jinzhou.Su@amd.com> <20220223100350.3523826-2-Jinzhou.Su@amd.com>
In-Reply-To: <20220223100350.3523826-2-Jinzhou.Su@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 16:26:16 +0100
Message-ID: <CAJZ5v0iaY3tsNKFXv09Z4wg_2R3+9UsSnqfPBbOYFaqoVS1qCg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
To:     Jinzhou Su <Jinzhou.Su@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Huang Rui <ray.huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Du, Xiaojian" <xiaojian.du@amd.com>,
        "Yuan, Perry" <perry.yuan@amd.com>, li.meng@amd.com
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

On Wed, Feb 23, 2022 at 11:04 AM Jinzhou Su <Jinzhou.Su@amd.com> wrote:
>
> Add frequency, mperf, aperf and tsc in the trace. This can be used
> to debug and tune the performance of AMD P-state driver.
>
> Use the time difference between amd_pstate_update to calculate CPU
> frequency. There could be sleep in arch_freq_get_on_cpu, so do not
> use it here.
>
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

I'm not sure what the second sign-off is for.

If this is a maintainer's sign-off, it should be added by the
maintainer himself  and you should not add it when submitting the
patch.

> ---
>  drivers/cpufreq/amd-pstate-trace.h | 22 ++++++++++-
>  drivers/cpufreq/amd-pstate.c       | 59 +++++++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index 647505957d4f..35f38ae67fb1 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -27,6 +27,10 @@ TRACE_EVENT(amd_pstate_perf,
>         TP_PROTO(unsigned long min_perf,
>                  unsigned long target_perf,
>                  unsigned long capacity,
> +                u64 freq,
> +                u64 mperf,
> +                u64 aperf,
> +                u64 tsc,
>                  unsigned int cpu_id,
>                  bool changed,
>                  bool fast_switch
> @@ -35,6 +39,10 @@ TRACE_EVENT(amd_pstate_perf,
>         TP_ARGS(min_perf,
>                 target_perf,
>                 capacity,
> +               freq,
> +               mperf,
> +               aperf,
> +               tsc,
>                 cpu_id,
>                 changed,
>                 fast_switch
> @@ -44,6 +52,10 @@ TRACE_EVENT(amd_pstate_perf,
>                 __field(unsigned long, min_perf)
>                 __field(unsigned long, target_perf)
>                 __field(unsigned long, capacity)
> +               __field(unsigned long long, freq)
> +               __field(unsigned long long, mperf)
> +               __field(unsigned long long, aperf)
> +               __field(unsigned long long, tsc)
>                 __field(unsigned int, cpu_id)
>                 __field(bool, changed)
>                 __field(bool, fast_switch)
> @@ -53,15 +65,23 @@ TRACE_EVENT(amd_pstate_perf,
>                 __entry->min_perf = min_perf;
>                 __entry->target_perf = target_perf;
>                 __entry->capacity = capacity;
> +               __entry->freq = freq;
> +               __entry->mperf = mperf;
> +               __entry->aperf = aperf;
> +               __entry->tsc = tsc;
>                 __entry->cpu_id = cpu_id;
>                 __entry->changed = changed;
>                 __entry->fast_switch = fast_switch;
>                 ),
>
> -       TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
> +       TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s fast_switch=%s",
>                   (unsigned long)__entry->min_perf,
>                   (unsigned long)__entry->target_perf,
>                   (unsigned long)__entry->capacity,
> +                 (unsigned long long)__entry->freq,
> +                 (unsigned long long)__entry->mperf,
> +                 (unsigned long long)__entry->aperf,
> +                 (unsigned long long)__entry->tsc,
>                   (unsigned int)__entry->cpu_id,
>                   (__entry->changed) ? "true" : "false",
>                   (__entry->fast_switch) ? "true" : "false"
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ce75ed11f8e..7be38bc6a673 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,18 @@ MODULE_PARM_DESC(shared_mem,
>
>  static struct cpufreq_driver amd_pstate_driver;
>
> +/**
> + * struct  amd_aperf_mperf
> + * @aperf: actual performance frequency clock count
> + * @mperf: maximum performance frequency clock count
> + * @tsc:   time stamp counter
> + */
> +struct amd_aperf_mperf {
> +       u64 aperf;
> +       u64 mperf;
> +       u64 tsc;
> +};
> +
>  /**
>   * struct amd_cpudata - private CPU data for AMD P-State
>   * @cpu: CPU number
> @@ -81,6 +93,9 @@ static struct cpufreq_driver amd_pstate_driver;
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
>   * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
> + * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> + * @prev: Last Aperf/Mperf/tsc count value read from register
> + * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
> @@ -102,6 +117,10 @@ struct amd_cpudata {
>         u32     nominal_freq;
>         u32     lowest_nonlinear_freq;
>
> +       struct amd_aperf_mperf cur;
> +       struct amd_aperf_mperf prev;
> +
> +       u64 freq;
>         bool    boost_supported;
>  };
>
> @@ -211,6 +230,39 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>                                             max_perf, fast_switch);
>  }
>
> +static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
> +{
> +       u64 aperf, mperf, tsc;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       rdmsrl(MSR_IA32_APERF, aperf);
> +       rdmsrl(MSR_IA32_MPERF, mperf);
> +       tsc = rdtsc();
> +
> +       if (cpudata->prev.mperf == mperf || cpudata->prev.tsc == tsc) {
> +               local_irq_restore(flags);
> +               return false;
> +       }
> +
> +       local_irq_restore(flags);
> +
> +       cpudata->cur.aperf = aperf;
> +       cpudata->cur.mperf = mperf;
> +       cpudata->cur.tsc =  tsc;
> +       cpudata->cur.aperf -= cpudata->prev.aperf;
> +       cpudata->cur.mperf -= cpudata->prev.mperf;
> +       cpudata->cur.tsc -= cpudata->prev.tsc;
> +
> +       cpudata->prev.aperf = aperf;
> +       cpudata->prev.mperf = mperf;
> +       cpudata->prev.tsc = tsc;
> +
> +       cpudata->freq = div64_u64((cpudata->cur.aperf * cpu_khz), cpudata->cur.mperf);
> +
> +       return true;
> +}
> +
>  static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>                               u32 des_perf, u32 max_perf, bool fast_switch)
>  {
> @@ -226,8 +278,11 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>         value &= ~AMD_CPPC_MAX_PERF(~0L);
>         value |= AMD_CPPC_MAX_PERF(max_perf);
>
> -       trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> -                             cpudata->cpu, (value != prev), fast_switch);
> +       if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
> +               trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> +                       cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
> +                               cpudata->cpu, (value != prev), fast_switch);
> +       }
>
>         if (value == prev)
>                 return;
> --
> 2.27.0
>
