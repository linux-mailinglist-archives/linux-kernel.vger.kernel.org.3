Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A2569349
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiGFU02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiGFU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:26:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29464175BC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:26:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so23572248wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd/cz1ZdOZDG0dGUCc56UGlwZRbZux/IHLKbAzN98Js=;
        b=LO0ddP6IpeapDsidsXkOEyQ+saT7ncixARK9nt1HA3oZyERRJd0FQIIojqRBKqfaFz
         +XAcZ/GkXc3ZoXDRmqbwdZr1aEGsNnJtxJDN6nCxM3+mS5+gJPJY3WiIHUVlHcEmCo6h
         bGqElsZBwf6tPPCxLXYqPk0Ck2d1yig7FYAo2XTcWBNBcT2YYh/w9HGa3R2LMILBmZl5
         HdANoc64OsBGuwzVhgklcWy1Q9fF9ay/YNUaTVkTTswIPjotbWfiRKD/knMEqTkodlVa
         3Hraa3O9LLAv2Y76IEP8SWpKXcTJ3WIX9jaAe1FCAiRiOHP8Uxm0VNG0Udp0FIflMYFi
         sHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd/cz1ZdOZDG0dGUCc56UGlwZRbZux/IHLKbAzN98Js=;
        b=N+rLFYWLgzMB5640QuFWj+NjWYaQMwul5t7MFQsdzvxdHLsDjib9MijhUyf2UhC6dD
         nipHj05nGz4sFDy5HnpT+64wXPDdn8EnpYn49j8AObae67LDPlE5T2U/JgpzzqZW2BW/
         qmabHlsB0Rs+heUXIlIpBLtmRsOVZOh/1T4seVhMU1RyIVRryzvgOxgXbYUSACX7fSHe
         15xDRKDyI6eVBNmfLmlHf0n7dOPqJAZWJ2xOoW96MxXK/Gyn8phtgLbpjF4VCxNb9FTY
         TP9jHkKv+sMIepY5FFKpxn2Jm+Fb3XFTw5brKoVoR4a9Lko/pbj4/8+4bi/b4fAxP3CA
         ZoBw==
X-Gm-Message-State: AJIora9XNKFynFif/vAft7SckU9ca1eiVa1KgN/lbat3HBiGwpGjBEtY
        +8SEu0KgYvBEcfBY4RIjoYyQuBlGVHYXOy2TJ0FSSQ==
X-Google-Smtp-Source: AGRyM1sNVUzqOT1mNnsuofu3XsFHxkgXs0ehkhiv3SeOIcmUkR73MU7bT2mshl83m+mxZRZwlMqFJSMZpSlgzKEnHTM=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr4443868wrx.343.1657139183331; Wed, 06
 Jul 2022 13:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <d1ff3c27-e248-56ff-89b8-7b75c0f817ba@gmail.com>
In-Reply-To: <d1ff3c27-e248-56ff-89b8-7b75c0f817ba@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Jul 2022 13:26:10 -0700
Message-ID: <CAP-5=fW+g85Mh19DdBPGKMzs+VMzEjhVvUX4R-5D+SZ2zpLuow@mail.gmail.com>
Subject: Re: [GIT PULL] tools/perf/pmu-events: Fix some typo (2022-07-05
 05:10:43 +0900)
To:     hayashizaki.masayuki@gmail.com, perfmon-discuss@lists.01.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
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

On Tue, Jul 5, 2022 at 1:09 AM Hayashizaki Masayuki
<hayashizaki.masayuki@gmail.com> wrote:
>
> Hello:
>
> I sent a pull request. Please review and merge.
>
> Reason:
> Fix some typo.
>
> Git repository URL:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> Branch name:
> pmu-events-fixes-5.19-5
>
> Pull request log:
> git request-pull origin/master pmu-events-fixes-5.19-5
> fatal: 'pmu-events-fixes-5.19-5' does not appear to be a git repository
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> warn: No match for commit 2a3f9ec126ba4bb036b638ede6794c3ce313c6c4 found
> at pmu-events-fixes-5.19-5
> warn: Are you sure you pushed 'HEAD' there?
> The following changes since commit c1084b6c5620a743f86947caca66d90f24060f56:
>
>    Merge tag 'soc-fixes-5.19-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2022-07-04
> 10:41:59 -0700)
>
> are available in the Git repository at:
>
>    pmu-events-fixes-5.19-5
>
> for you to fetch changes up to 2a3f9ec126ba4bb036b638ede6794c3ce313c6c4:
>
>    tools/perf/pmu-events: Fix some typo (2022-07-05 05:10:43 +0900)
>
> ----------------------------------------------------------------
> Hayashizaki Masayuki (1):
>        tools/perf/pmu-events: Fix some typo
>
>   tools/perf/pmu-events/arch/x86/broadwell/pipeline.json   | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json  | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/haswell/pipeline.json     | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/haswellx/pipeline.json    | 10 +++++-----
>   5 files changed, 25 insertions(+), 25 deletions(-)

These files are generated from json files here:
https://download.01.org/perfmon/
Using scripts here:
https://github.com/intel/event-converter-for-linux-perf
Fixing the spelling in the Linux tree will mean future updates will
need to manually also fix the spelling, it is better we fix the
spelling in the files on 01.org. I've added
perfmon-discuss@lists.01.org in the to-s of this e-mail, so hopefully
the files will be revised in the next 01.org update.

Thanks,
Ian

> Diff:
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> index 18d21b94a4b9..23e0c3fadc53 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> @@ -1133,7 +1133,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 0.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 0.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1153,7 +1153,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 1.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 1.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1213,7 +1213,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 4.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 4.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1233,7 +1233,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 5.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 5.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1253,7 +1253,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 6.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 6.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> index 7580b8af0d13..b67eba679844 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> @@ -1133,7 +1133,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 0.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 0.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1153,7 +1153,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 1.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 1.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1213,7 +1213,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 4.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 4.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1233,7 +1233,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 5.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 5.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1253,7 +1253,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 6.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 6.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> index 18d21b94a4b9..23e0c3fadc53 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> @@ -1133,7 +1133,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 0.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 0.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1153,7 +1153,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 1.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 1.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1213,7 +1213,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 4.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 4.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1233,7 +1233,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 5.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 5.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1253,7 +1253,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 6.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 6.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> index a53f28ec9270..06fbe7d34a8c 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> @@ -1035,7 +1035,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 0.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 0.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x1"
>       },
> @@ -1056,7 +1056,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 1.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 1.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x2"
>       },
> @@ -1117,7 +1117,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 4.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 4.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x10"
>       },
> @@ -1138,7 +1138,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 5.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 5.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x20"
>       },
> @@ -1159,7 +1159,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 6.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 6.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x40"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> index a53f28ec9270..06fbe7d34a8c 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> @@ -1035,7 +1035,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 0.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 0.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x1"
>       },
> @@ -1056,7 +1056,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 1.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 1.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x2"
>       },
> @@ -1117,7 +1117,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 4.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 4.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x10"
>       },
> @@ -1138,7 +1138,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 5.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 5.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x20"
>       },
> @@ -1159,7 +1159,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 6.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 6.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x40"
>       },
> --
> Hayashizaki Masayuki
> hayashizaki.masayuki@gmail.com
> AkariSpetification / Developer
> https://akari.mn
