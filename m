Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FAC526751
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382452AbiEMQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382443AbiEMQns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:43:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D52911A3F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:43:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso5509726wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AXeQRWS7YVxCmUANhlN02UaymyyDZK1cu6IVtWT9vQ=;
        b=jw7/CWELAe2YuhU/gWo5XW1TdlJUot58xdVVqfhaSCLpyDtN00c4RyevL/9Q77A/Vd
         pzUibuzHUfx9+aAgkdB1uHe041QEXE6+32t37GKsQfG50dpjK2MMvFiWOrlYN1RJsYEY
         I68L1tVNHvanlTo5VfQXyvKF68nXfHj8rZGphAIsMJ2TtNyKRaErgcsTn7HWwt+upYBg
         gVyiuFvdVR4PGMCNXRsT927rWDRV5eHjLqsZtETdUqe5iKeaG72NgRjfqqrWWzR3wfCj
         Og5STuI/Lh67cghrgcezE3hC5IgrM74Oo/1IXdv5BNlvFZDPkl6bXYdOIM03KLwUhK4s
         OifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AXeQRWS7YVxCmUANhlN02UaymyyDZK1cu6IVtWT9vQ=;
        b=F1EA0ztG+sQuH+SfEo8hyNc/0zw6AkWea5ILnpOvn8V0mPQe46q/hska0ZIsG2v5on
         y/Rh79LZbrA45/aJPSBfSIYbOePJ9+ThWr+FFbJX98D6a4r3LL3dyzJOQKAi2tPqg0NU
         O79c/xXfsekfISxzvWzxp9JtElMTDtvS+WR8WYHGQQU8DBIiCo7GC7sypYlPyiRz5ftY
         v0vIloC4DqShzKfa82tZJ5R11wR48M6AFoW1a3SnKrnrv4ysCLU//bvITGa0Z3BPq2iR
         DfXfqTWfgFSM/ySNdxQXvD0SGQa1w3q1N3OuVjcTsz76GA11fhOgG1VBc8Iz+akBmtvj
         RojQ==
X-Gm-Message-State: AOAM530NmhRhbAZ8kSgx4AJu6PYkOd3x4ktA8EXcUDOAXZ9NLO2f3yqF
        IG9HueRwQMjgOKcvcm7L+beGJKmWiV1+UHKCxb9n1Q==
X-Google-Smtp-Source: ABdhPJyWTAa0IWxLXmTN380TV5OglCtOfBRaBGM1zlok12hZsH2LOHUv9LnRaA6BFSrdzXM5OW9NL5p75cbb8ktXGLo=
X-Received: by 2002:a05:600c:19cc:b0:394:8dc2:a23b with SMTP id
 u12-20020a05600c19cc00b003948dc2a23bmr15801673wmq.182.1652460224757; Fri, 13
 May 2022 09:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220513151554.1054452-1-kan.liang@linux.intel.com>
 <20220513151554.1054452-2-kan.liang@linux.intel.com> <CAP-5=fUO+ag5_HWeYn+_Q4vMtFGSux7sdEEbWm1xFp_HZKfJ1g@mail.gmail.com>
 <018aaf83-fb2a-2b74-7fc1-412f90cccb1b@linux.intel.com>
In-Reply-To: <018aaf83-fb2a-2b74-7fc1-412f90cccb1b@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 09:43:32 -0700
Message-ID: <CAP-5=fXdWKjvZL_Yh95Ghqg+ZQSkoNniprV3w+4NV2Ca-Vrqcw@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf evsel: Fixes topdown events in a weak group for
 the hybrid platform
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
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

On Fri, May 13, 2022 at 9:24 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 5/13/2022 11:39 AM, Ian Rogers wrote:
> > On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The patch ("perf evlist: Keep topdown counters in weak group") fixes the
> >> perf metrics topdown event issue when the topdown events are in a weak
> >> group on a non-hybrid platform. However, it doesn't work for the hybrid
> >> platform.
> >>
> >> $./perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
> >> cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
> >> cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
> >> cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
> >> cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
> >> cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
> >> cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1
> >>
> >>   Performance counter stats for 'system wide':
> >>
> >>         751,765,068      cpu_core/slots/                                               (84.07%)
> >>     <not supported>      cpu_core/topdown-bad-spec/
> >>     <not supported>      cpu_core/topdown-be-bound/
> >>     <not supported>      cpu_core/topdown-fe-bound/
> >>     <not supported>      cpu_core/topdown-retiring/
> >>          12,398,197      cpu_core/branch-instructions/                                     (84.07%)
> >>           1,054,218      cpu_core/branch-misses/                                       (84.24%)
> >>         539,764,637      cpu_core/bus-cycles/                                          (84.64%)
> >>              14,683      cpu_core/cache-misses/                                        (84.87%)
> >>           7,277,809      cpu_core/cache-references/                                     (77.30%)
> >>         222,299,439      cpu_core/cpu-cycles/                                          (77.28%)
> >>          63,661,714      cpu_core/instructions/                                        (84.85%)
> >>                   0      cpu_core/mem-loads/                                           (77.29%)
> >>          12,271,725      cpu_core/mem-stores/                                          (77.30%)
> >>         542,241,102      cpu_core/ref-cycles/                                          (84.85%)
> >>               8,854      cpu_core/cache-misses/                                        (76.71%)
> >>           7,179,013      cpu_core/cache-references/                                     (76.31%)
> >>
> >>         1.003245250 seconds time elapsed
> >>
> >> A hybrid platform has a different PMU name for the core PMUs, while
> >> the current perf hard code the PMU name "cpu".
> >>
> >> The evsel->pmu_name can be used to replace the "cpu" to fix the issue.
> >> For a hybrid platform, the pmu_name must be non-NULL. Because there are
> >> at least two core PMUs. The PMU has to be specified.
> >> For a non-hybrid platform, the pmu_name may be NULL. Because there is
> >> only one core PMU, "cpu". For a NULL pmu_name, we can safely assume that
> >> it is a "cpu" PMU.
> >>
> >> With the patch,
> >>
> >> $perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
> >> cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
> >> cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
> >> cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
> >> cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
> >> cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
> >> cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1
> >>
> >>   Performance counter stats for 'system wide':
> >>
> >>         766,620,266      cpu_core/slots/                                               (84.06%)
> >>          73,172,129      cpu_core/topdown-bad-spec/ #      9.5% bad speculation         (84.06%)
> >>         193,443,341      cpu_core/topdown-be-bound/ #     25.0% backend bound           (84.06%)
> >>         403,940,929      cpu_core/topdown-fe-bound/ #     52.3% frontend bound          (84.06%)
> >>         102,070,237      cpu_core/topdown-retiring/ #     13.2% retiring                (84.06%)
> >>          12,364,429      cpu_core/branch-instructions/                                     (84.03%)
> >>           1,080,124      cpu_core/branch-misses/                                       (84.24%)
> >>         564,120,383      cpu_core/bus-cycles/                                          (84.65%)
> >>              36,979      cpu_core/cache-misses/                                        (84.86%)
> >>           7,298,094      cpu_core/cache-references/                                     (77.30%)
> >>         227,174,372      cpu_core/cpu-cycles/                                          (77.31%)
> >>          63,886,523      cpu_core/instructions/                                        (84.87%)
> >>                   0      cpu_core/mem-loads/                                           (77.31%)
> >>          12,208,782      cpu_core/mem-stores/                                          (77.31%)
> >>         566,409,738      cpu_core/ref-cycles/                                          (84.87%)
> >>              23,118      cpu_core/cache-misses/                                        (76.71%)
> >>           7,212,602      cpu_core/cache-references/                                     (76.29%)
> >>
> >>         1.003228667 seconds time elapsed
> >>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>   tools/perf/arch/x86/util/evsel.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> >> index 00cb4466b4ca..24510bcb4bf4 100644
> >> --- a/tools/perf/arch/x86/util/evsel.c
> >> +++ b/tools/perf/arch/x86/util/evsel.c
> >> @@ -33,8 +33,9 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
> >>
> >>   bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >>   {
> >> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> >> -           !pmu_have_event("cpu", "slots"))
> >> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
> >> +
> >> +       if (!pmu_have_event(pmu_name, "slots"))
> >
> > Playing devil's advocate, if I have a PMU for my network accelerator
> > and it has an event called "slots" then this test will also be true.
> >
>
> IIRC, the pmu_have_event should only check the event which is exposed by
> the kernel. It's very unlikely that another PMU expose the exact same name.
>
> If you still worry about it, I think we can check the PMU type
> PERF_TYPE_RAW here, which is reserved for the core PMU. Others cannot
> use it.

That's cool, this isn't documented behavior though:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/include/uapi/linux/perf_event.h?h=perf/core#n34
and PERF_TYPE_HARDWARE wouldn't seem a wholly unreasonable type. It
kind of feels like depending on a quirk, and so we should bury the
quirk in a helper function and document it :-)

> It looks like arch_evsel__must_be_in_group() is the only user for the
> evsel__sys_has_perf_metrics() for now, so I make it static.
>
> The other pmu_have_event("cpu", "slots") is in evlist.c.
> topdown_sys_has_perf_metrics() in patch 4 should be used to replace it.
> I think Zhengjun will post patches for the changes for the evlist.c

Ok, is Zhengjun putting his changes on top of this and fixing up the
APIs or is he waiting on these changes landing? Let me know how to
help. I'm guessing landing my changes is the first step.

Thanks,
Ian

> diff --git a/tools/perf/arch/x86/util/evsel.c
> b/tools/perf/arch/x86/util/evsel.c
> index 24510bcb4bf4..a4714174e30f 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -31,11 +31,20 @@ void arch_evsel__fixup_new_cycles(struct
> perf_event_attr *attr)
>          free(env.cpuid);
>   }
>
> -bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> +static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
>   {
>          const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
>
> -       if (!pmu_have_event(pmu_name, "slots"))
> +       if ((evsel->core.attr.type == PERF_TYPE_RAW) &&
> +           pmu_have_event(pmu_name, "slots"))
> +               return true;
> +
> +       return false;
> +}
> +
> +bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> +{
> +       if (!evsel__sys_has_perf_metrics(evsel))
>                  return false;
>
>          return evsel->name &&
>
> Thanks,
> Kan
>
> > The property that is being tested here is "does this CPU have topdown
> > events" and so allowing any PMU removes the "does this CPU" part of
> > the equation. I think ideally we'd have an arch functions something
> > like:
> >
> > bool arch_pmu__has_intel_topdown_events(void)
> > {
> >    static bool has_topdown_events = pmu_have_event("cpu", "slots") ||
> > pmu_have_event("cpu_core", "slots");
> >
> >    return has_topdown_events;
> > }
> >
> > bool arch_pmu__supports_intel_topdown_events(const char *pmu_name)
> > {
> >    if (!pmu_name)
> >      return false;
> >    return arch_pmu__has_intel_topdown_events() && (!strncmp(pmu_name,
> > "cpu") || !strncmp(pmu_name, "cpu_core"));
> > }
> >
> > bool arch_evsel__is_intel_topdown_event(struct evsel *evsel)
> > {
> >    if (!arch_pmu__supports_intel_topdown_events(evsel->pmu))
> >      return false;
> >
> >    return strcasestr(evsel->name, "slots") || strcasestr(evsel->name, "topdown");
> > }
> >
> > This then gives us:
> >
> > bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> > {
> >    return  arch_evsel__is_intel_topdown_event(evsel);
> > }
> >
> > These functions can then be reused for the arch_evlist topdown code,
> > etc. What I don't see in these functions is use of any hybrid
> > abstraction and so it isn't clear to me how with hybrid something like
> > this would be plumbed in.
> >
> > Thanks,
> > Ian
> >
> >>                  return false;
> >>
> >>          return evsel->name &&
> >> --
> >> 2.35.1
> >>
