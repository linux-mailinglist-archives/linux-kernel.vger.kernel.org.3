Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560AC5815EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiGZPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiGZPEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:04:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2922E6A1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:04:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l15so16509077wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d62iRhJsBE8gihoV8LYMDZuvUneCUypE/tyaJuWYA+4=;
        b=tU/cyq5nHL5B4HPtfMhT82SrXE8DssFJnICWBAwGcy0SN7KjkG5/zdKCtU3YWNpyZC
         uLWTJOpa/hHm4JfU1D9lQdp+4RswJ5fGwLBC/drIyXsU55LstDo8WolHF4XMBsErZ0rn
         K9MspvXiOPNR7+v8XtxoC8fGrHDeZ9mgAy7OuIgq8f8uSyHkwXYuHp7GS68EWEYHoR1c
         ydeyk6fmegQsLGp+ro1t9HRzda3Q+tpIhfx6Al8CuasOk5g6aR/SthR6kPWnESWtoQbU
         i13XcoSlNmxKqZ4NY0XBFbe0auZFDjPmzFdAn97zjJCGlSrOkE4Ldx4hbyL46fsH5Q9q
         McRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d62iRhJsBE8gihoV8LYMDZuvUneCUypE/tyaJuWYA+4=;
        b=ijUq0WXLuJYUWGEfJ59gGK8VEaZgFUqYAG0ZZ8+q65bkVCmtD6OkAcNEvPvDEJGh2/
         AZQqhJT7AwLkiw4o+nhORJFpwVIcWgH1cLegoZD6y2FsKWsJyVsrgv1MaLqXNDfzvvUw
         oQj0O0BWMLmlfjiOCj84jpxeFYqhlyyNsnSB6f++hzYzqoD3MdB2XMgfd2lTAIOaCDxu
         OHgdfd1Hmpu/CJIMcP4qXB08MSiz3nL32WBluMosL0+9+ZQqaWoWsXrTEf8vCNBwmiym
         GepVl8439QrbF0xL5T4D2ykZ6+GgiLIYdsyR3fhkHtc6fG9dT1Wfv/LNdv2HzMyzB4SS
         YMog==
X-Gm-Message-State: AJIora/4owjQPAnexn+HIyg6FGBK/gY3TnveLgleRaDFrzLcmUFlHOwf
        FrwHpCZg3Jb+/tMNxJzmljdEamQQu6EHcHHBHFBG1w==
X-Google-Smtp-Source: AGRyM1tp+/6Hl7fo0jRX6p9QAA2mJOCbZznD5EmfQhXLjda5kyhEkl9FT4cEijP8XdlDqZ2RrdLWFwJ9yr1HKxM7uqI=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr10875569wri.300.1658847880006; Tue, 26
 Jul 2022 08:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220722103728.82854-1-slark_xiao@163.com>
In-Reply-To: <20220722103728.82854-1-slark_xiao@163.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Jul 2022 08:04:27 -0700
Message-ID: <CAP-5=fWhJse5xJzCS=zCCXQ_vjJWFKwSmkjfJLe0ArpLWWtjNw@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix typo 'the the' in comment
To:     Slark Xiao <slark_xiao@163.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, mike.leach@linaro.org,
        leo.yan@linaro.org, john.garry@huawei.com, will@kernel.org,
        james.clark@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 3:38 AM Slark Xiao <slark_xiao@163.com> wrote:
>
> Replace 'the the' with 'the' in the comment.

Thanks, these files are generated from files here:
https://download.01.org/perfmon/
I've added Intel folks to the e-mail, so they can update those files.

Thanks,
Ian

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  tools/perf/Documentation/perf-diff.txt                        | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json | 2 +-
>  tools/perf/pmu-events/arch/x86/silvermont/pipeline.json       | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json     | 2 +-
>  tools/perf/util/cs-etm.c                                      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Document=
ation/perf-diff.txt
> index be65bd55ab2a..b77957ac288b 100644
> --- a/tools/perf/Documentation/perf-diff.txt
> +++ b/tools/perf/Documentation/perf-diff.txt
> @@ -285,7 +285,7 @@ If specified the 'Weighted diff' column is displayed =
with value 'd' computed as:
>
>    - period being the hist entry period value
>
> -  - WEIGHT-A/WEIGHT-B being user supplied weights in the the '-c' option
> +  - WEIGHT-A/WEIGHT-B being user supplied weights in the '-c' option
>      behind ':' separator like '-c wdiff:1,2'.
>      - WEIGHT-A being the weight of the data file
>      - WEIGHT-B being the weight of the baseline data file
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> index aa460d0c4851..59ab88de1b37 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> @@ -1923,7 +1923,7 @@
>          "EventCode": "0x25",
>          "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts cycles when the the receive side (R=
x) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a=
 mode where we disable 60% of the UPI lanes, decreasing our bandwidth in or=
der to save power.",
> +        "PublicDescription": "Counts cycles when the receive side (Rx) o=
f the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mod=
e where we disable 60% of the UPI lanes, decreasing our bandwidth in order =
to save power.",
>          "Unit": "UPI LL"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/silvermont/pipeline.json
> index 03a4c7f26698..3278c7d1654d 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
> @@ -257,7 +257,7 @@
>          "Counter": "0,1",
>          "EventCode": "0xCA",
>          "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
> -        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is=
 used to measure front-end inefficiencies, i.e. when front-end of the machi=
ne is not delivering micro-ops to the back-end and the back-end is not stal=
led. This event can be used to identify if the machine is truly front-end b=
ound.  When this event occurs, it is an indication that the front-end of th=
e machine is operating at less than its theoretical peak performance.  Back=
ground: We can think of the processor pipeline as being divided into 2 broa=
der parts: Front-end and Back-end. Front-end is responsible for fetching th=
e instruction, decoding into micro-ops (uops) in machine understandable for=
mat and putting them into a micro-op queue to be consumed by back end. The =
back-end then takes these micro-ops, allocates the required resources.  Whe=
n all resources are ready, micro-ops are executed. If the back-end is not r=
eady to accept micro-ops from the front-end, then we do not want to count t=
hese as front-end bottlenecks.  However, whenever we have bottlenecks in th=
e back-end, we will have allocation unit stalls and eventually forcing the =
front-end to wait until the back-end is ready to receive more UOPS. This ev=
ent counts the cycles only when back-end is requesting more uops and front-=
end is not able to provide them. Some examples of conditions that cause fro=
nt-end efficiencies are: Icache misses, ITLB misses, and decoder restrictio=
ns that limit the the front-end bandwidth.",
> +        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is=
 used to measure front-end inefficiencies, i.e. when front-end of the machi=
ne is not delivering micro-ops to the back-end and the back-end is not stal=
led. This event can be used to identify if the machine is truly front-end b=
ound.  When this event occurs, it is an indication that the front-end of th=
e machine is operating at less than its theoretical peak performance.  Back=
ground: We can think of the processor pipeline as being divided into 2 broa=
der parts: Front-end and Back-end. Front-end is responsible for fetching th=
e instruction, decoding into micro-ops (uops) in machine understandable for=
mat and putting them into a micro-op queue to be consumed by back end. The =
back-end then takes these micro-ops, allocates the required resources.  Whe=
n all resources are ready, micro-ops are executed. If the back-end is not r=
eady to accept micro-ops from the front-end, then we do not want to count t=
hese as front-end bottlenecks.  However, whenever we have bottlenecks in th=
e back-end, we will have allocation unit stalls and eventually forcing the =
front-end to wait until the back-end is ready to receive more UOPS. This ev=
ent counts the cycles only when back-end is requesting more uops and front-=
end is not able to provide them. Some examples of conditions that cause fro=
nt-end efficiencies are: Icache misses, ITLB misses, and decoder restrictio=
ns that limit the front-end bandwidth.",
>          "SampleAfterValue": "200003",
>          "UMask": "0x50"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> index aa0f67613c4a..0c96e6924d62 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> @@ -1852,7 +1852,7 @@
>          "EventCode": "0x25",
>          "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts cycles when the the receive side (R=
x) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a=
 mode where we disable 60% of the UPI lanes, decreasing our bandwidth in or=
der to save power.",
> +        "PublicDescription": "Counts cycles when the receive side (Rx) o=
f the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mod=
e where we disable 60% of the UPI lanes, decreasing our bandwidth in order =
to save power.",
>          "Unit": "UPI LL"
>      },
>      {
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8b95fb3c4d7b..16db965ac995 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1451,7 +1451,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq=
,
>                  * tidq->packet->instr_count represents the number of
>                  * instructions in the current etm packet.
>                  *
> -                * Period instructions (Pi) contains the the number of
> +                * Period instructions (Pi) contains the number of
>                  * instructions executed after the sample point(n) from t=
he
>                  * previous etm packet.  This will always be less than
>                  * etm->instructions_sample_period.
> --
> 2.25.1
>
