Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E075539379
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbiEaPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbiEaPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:00:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9E4163D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:00:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q21so7881493wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RUmAyq/lbNvciwfCraGSd4DO4fbRM9KkWd+gA0NCHkQ=;
        b=PpTfYGnJ0hbu71Y7zXzLxBBze4Y7F6r/WvmdG1d9PV8PCJbWQJQABOqaxRuj3gcl76
         8G+Fmi5RUv3Go5AVmQ+ZXEavBwWcBcBPlt1GeCtylrHVirkdBw1x3WEe4fH1dMEGBP71
         E/wLbtIF05Pvk6ALJTidQ9M++nsHV3PpFdqzTQbxHNJ0CBr51jmKiVODA5qYeA+aC6x1
         jTvuhh/oiBrma0CVbzZBpEheafWltRmukjVyY/1I2jI6LcuwjimVv8gjMcOK73i2b4je
         0aYPOY80U6JwISFHDjXBxzgliaLTpzt7KT7JHx86Ue6F3ZWj7p1rCaB8gIZv2sdg4J4b
         kw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RUmAyq/lbNvciwfCraGSd4DO4fbRM9KkWd+gA0NCHkQ=;
        b=UOedXEV01POyRcRG3iotZZ5gfOlvMbmiACSvh7lgidFbKebZ+oFB5UB56ctqsnXRYS
         da/pd/srZAEu6PQ5uuuETQfJRNslqfnihYMSQmnd/ddGBGoTIIgUD0jvXY3XPdzz81pv
         v2EWXUwmQkM+LiBsbOEQMMmuL1tETRk64iviRyHzDSN3wftORpDjYs3L+VhQ0T4payFH
         eFs8yMJmrFLMsMDgj/AQ2mH9RVyDcFFty4OXX7fdIDAzOvcWxj2Ps1FJnlmRaqq3DgRQ
         rVlAtfuboGjUd4f6VQ48gTMow6awp8XWhZ8uR/QnAHA5C5eSBftiVGMSpuyJKJNfQde7
         7jeQ==
X-Gm-Message-State: AOAM531SZR0+0LL0HNdrIb5sKErHgQlEqrRXYeLyGK87yMvzxbmiHnbw
        EpwjQbTBT+WVvhSqrsq0xB1MxG5fIA09UV/FTI64Mg==
X-Google-Smtp-Source: ABdhPJxqJnyL6s9LM1Tb/3Fdvqb3oena+HpCx5HwSWgLW7e7Mc+3ymsUUD8ZTTyBGhuheyjlAVwvld8xL3sA+tjW99A=
X-Received: by 2002:adf:eb91:0:b0:20f:fcc2:475c with SMTP id
 t17-20020adfeb91000000b0020ffcc2475cmr27163709wrn.40.1654009250063; Tue, 31
 May 2022 08:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220531092706.1931503-1-tmricht@linux.ibm.com> <20220531092706.1931503-2-tmricht@linux.ibm.com>
In-Reply-To: <20220531092706.1931503-2-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 May 2022 08:00:37 -0700
Message-ID: <CAP-5=fWBULDozZrDLtBAcE1tAD83S4XctDZoDEoAoj_p2aTTRQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] perf list: Update event description for IBM z10 to
 latest level
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 2:27 AM Thomas Richter <tmricht@linux.ibm.com> wrot=
e:
>
> Update IBM z10 event counter description to the latest level
> as described in the documents
> 1. SA23-2260-07:
>    "The Load-Program-Parameter and the CPU-Measurement Facilities."
>    released on May, 2022
> for the following counter sets:
>   * Basic counter set
>   * Problem counter set
>   * Crypto counter set
>
> 2. SA23-2261-07:
>    "The CPU-Measurement Facility Extended Counters Definition
>     for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15 and z16"
>     released on April 29, 2022
> for the following counter sets:
>   * Extended counter set
>   * MT-Diagnostic counter set
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/s390/cf_z10/basic.json    | 48 +++++++-------
>  .../pmu-events/arch/s390/cf_z10/crypto.json   | 64 +++++++++----------
>  .../pmu-events/arch/s390/cf_z10/extended.json | 36 +++++------
>  3 files changed, 74 insertions(+), 74 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/pe=
rf/pmu-events/arch/s390/cf_z10/basic.json
> index 783de7f1aeaa..9bd20a5f47af 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
> @@ -3,84 +3,84 @@
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "0",
>                 "EventName": "CPU_CYCLES",
> -               "BriefDescription": "CPU Cycles",
> -               "PublicDescription": "Cycle Count"
> +               "BriefDescription": "Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles, excluding the number of cycles while the CPU is in the wai=
t state."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "1",
>                 "EventName": "INSTRUCTIONS",
> -               "BriefDescription": "Instructions",
> -               "PublicDescription": "Instruction Count"
> +               "BriefDescription": "Instruction Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of instructions executed by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "2",
>                 "EventName": "L1I_DIR_WRITES",
> -               "BriefDescription": "L1I Directory Writes",
> -               "PublicDescription": "Level-1 I-Cache Directory Write Cou=
nt"
> +               "BriefDescription": "Level-1 I-Cache Directory Write Coun=
t",
> +               "PublicDescription": "This counter counts the total numbe=
r of level-1 instruction-cache or unified-cache directory writes."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "3",
>                 "EventName": "L1I_PENALTY_CYCLES",
> -               "BriefDescription": "L1I Penalty Cycles",
> -               "PublicDescription": "Level-1 I-Cache Penalty Cycle Count=
"
> +               "BriefDescription": "Level-1 I-Cache Penalty Cycle Count"=
,
> +               "PublicDescription": "This counter counts the total numbe=
r of cache penalty cycles for level-1 instruction cache or unified cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "4",
>                 "EventName": "L1D_DIR_WRITES",
> -               "BriefDescription": "L1D Directory Writes",
> -               "PublicDescription": "Level-1 D-Cache Directory Write Cou=
nt"
> +               "BriefDescription": "Level-1 D-Cache Directory Write Coun=
t",
> +               "PublicDescription": "This counter counts the total numbe=
r of level-1 data-cache directory writes."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "5",
>                 "EventName": "L1D_PENALTY_CYCLES",
> -               "BriefDescription": "L1D Penalty Cycles",
> -               "PublicDescription": "Level-1 D-Cache Penalty Cycle Count=
"
> +               "BriefDescription": "Level-1 D-Cache Penalty Cycle Count"=
,
> +               "PublicDescription": "This counter counts the total numbe=
r of cache penalty cycles for level-1 data cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "32",
>                 "EventName": "PROBLEM_STATE_CPU_CYCLES",
> -               "BriefDescription": "Problem-State CPU Cycles",
> -               "PublicDescription": "Problem-State Cycle Count"
> +               "BriefDescription": "Problem-State Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the CPU is in the problem state, excluding the number =
of cycles while the CPU is in the wait state."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "33",
>                 "EventName": "PROBLEM_STATE_INSTRUCTIONS",
> -               "BriefDescription": "Problem-State Instructions",
> -               "PublicDescription": "Problem-State Instruction Count"
> +               "BriefDescription": "Problem-State Instruction Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of instructions executed by the CPU while in the problem state."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "34",
>                 "EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
> -               "BriefDescription": "Problem-State L1I Directory Writes",
> -               "PublicDescription": "Problem-State Level-1 I-Cache Direc=
tory Write Count"
> +               "BriefDescription": "Problem-State Level-1 I-Cache Direct=
ory Write Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of level-1 instruction-cache or unified-cache directory writes while the =
CPU is in the problem state."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "35",
>                 "EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
> -               "BriefDescription": "Problem-State L1I Penalty Cycles",
> -               "PublicDescription": "Problem-State Level-1 I-Cache Penal=
ty Cycle Count"
> +               "BriefDescription": "Level-1 I-Cache Penalty Cycle Count"=
,
> +               "PublicDescription": "This counter counts the total numbe=
r of penalty cycles for level-1 instruction cache or unified cache while th=
e CPU is in the problem state."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "36",
>                 "EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
> -               "BriefDescription": "Problem-State L1D Directory Writes",
> -               "PublicDescription": "Problem-State Level-1 D-Cache Direc=
tory Write Count"
> +               "BriefDescription": "Problem-State Level-1 D-Cache Direct=
ory Write Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of level-1 data-cache directory writes while the CPU is in the problem st=
ate."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "37",
>                 "EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
> -               "BriefDescription": "Problem-State L1D Penalty Cycles",
> -               "PublicDescription": "Problem-State Level-1 D-Cache Penal=
ty Cycle Count"
> +               "BriefDescription": "Problem-State Level-1 D-Cache Penalt=
y Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of penalty cycles for level-1 data cache while the CPU is in the problem =
state."
>         }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/p=
erf/pmu-events/arch/s390/cf_z10/crypto.json
> index 3f28007d3892..a8d391ddeb8c 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
> @@ -3,112 +3,112 @@
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "64",
>                 "EventName": "PRNG_FUNCTIONS",
> -               "BriefDescription": "PRNG Functions",
> -               "PublicDescription": "Total number of the PRNG functions =
issued by the CPU"
> +               "BriefDescription": "PRNG Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the pseudorandom-number-generation functions issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "65",
>                 "EventName": "PRNG_CYCLES",
> -               "BriefDescription": "PRNG Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
> +               "BriefDescription": "PRNG Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the DEA/AES/SHA coprocessor is busy performing the pse=
udorandom- number-generation functions issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "66",
>                 "EventName": "PRNG_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "PRNG Blocked Functions",
> -               "PublicDescription": "Total number of the PRNG functions =
that are issued by the CPU and are blocked because the DEA/AES coprocessor =
is busy performing a function issued by another CPU"
> +               "BriefDescription": "PRNG Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the pseudorandom-number-generation functions that are issued by the CP=
U and are blocked because the DEA/AES/SHA coprocessor is busy performing a =
function issued by another CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "67",
>                 "EventName": "PRNG_BLOCKED_CYCLES",
> -               "BriefDescription": "PRNG Blocked Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the PRNG functions issued by the CPU because the DEA/AES coprocessor is=
 busy performing a function issued by another CPU"
> +               "BriefDescription": "PRNG Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the pseudorandom-number-generation functions is=
sued by the CPU because the DEA/AES/SHA coprocessor is busy performing a fu=
nction issued by another CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "68",
>                 "EventName": "SHA_FUNCTIONS",
> -               "BriefDescription": "SHA Functions",
> -               "PublicDescription": "Total number of SHA functions issue=
d by the CPU"
> +               "BriefDescription": "SHA Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the SHA functions issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "69",
>                 "EventName": "SHA_CYCLES",
> -               "BriefDescription": "SHA Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 SHA coprocessor is busy performing the SHA functions issued by the CPU"
> +               "BriefDescription": "SHA Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the SHA coprocessor is busy performing the SHA functio=
ns issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "70",
>                 "EventName": "SHA_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "SHA Blocked Functions",
> -               "PublicDescription": "Total number of the SHA functions t=
hat are issued by the CPU and are blocked because the SHA coprocessor is bu=
sy performing a function issued by another CPU"
> +               "BriefDescription": "SHA Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the SHA functions that are issued by the CPU and are blocked because t=
he SHA coprocessor is busy performing a function issued by another CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "71",
>                 "EventName": "SHA_BLOCKED_CYCLES",
> -               "BriefDescription": "SHA Bloced Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the SHA functions issued by the CPU because the SHA coprocessor is busy=
 performing a function issued by another CPU"
> +               "BriefDescription": "SHA Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the SHA functions issued by the CPU because the=
 SHA coprocessor is busy performing a function issued by another CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "72",
>                 "EventName": "DEA_FUNCTIONS",
> -               "BriefDescription": "DEA Functions",
> -               "PublicDescription": "Total number of the DEA functions i=
ssued by the CPU"
> +               "BriefDescription": "DEA Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the DEA functions issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "73",
>                 "EventName": "DEA_CYCLES",
> -               "BriefDescription": "DEA Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 DEA/AES coprocessor is busy performing the DEA functions issued by the CPU=
"
> +               "BriefDescription": "DEA Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the DEA/AES coprocessor is busy performing the DEA fun=
ctions issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "74",
>                 "EventName": "DEA_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "DEA Blocked Functions",
> -               "PublicDescription": "Total number of the DEA functions t=
hat are issued by the CPU and are blocked because the DEA/AES coprocessor i=
s busy performing a function issued by another CPU"
> +               "BriefDescription": "DEA Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the DEA functions that are issued by the CPU and are blocked because t=
he DEA/AES coprocessor is busy performing a function issued by another CPU.=
"
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "75",
>                 "EventName": "DEA_BLOCKED_CYCLES",
> -               "BriefDescription": "DEA Blocked Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the DEA functions issued by the CPU because the DEA/AES coprocessor is =
busy performing a function issued by another CPU"
> +               "BriefDescription": "DEA Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the DEA functions issued by the CPU because the=
 DEA/AES coprocessor is busy performing a function issued by another CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "76",
>                 "EventName": "AES_FUNCTIONS",
> -               "BriefDescription": "AES Functions",
> -               "PublicDescription": "Total number of AES functions issue=
d by the CPU"
> +               "BriefDescription": "AES Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the AES functions issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "77",
>                 "EventName": "AES_CYCLES",
> -               "BriefDescription": "AES Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 DEA/AES coprocessor is busy performing the AES functions issued by the CPU=
"
> +               "BriefDescription": "AES Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the DEA/AES coprocessor is busy performing the AES fun=
ctions issued by the CPU."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "78",
>                 "EventName": "AES_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "AES Blocked Functions",
> -               "PublicDescription": "Total number of AES functions that =
are issued by the CPU and are blocked because the DEA/AES coprocessor is bu=
sy performing a function issued by another CPU"
> +               "BriefDescription": "AES Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the AES functions that are issued by the CPU and are blocked because t=
he DEA/AES coprocessor is busy performing a function issued by another CPU.=
"
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "79",
>                 "EventName": "AES_BLOCKED_CYCLES",
> -               "BriefDescription": "AES Blocked Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the AES functions issued by the CPU because the DEA/AES coprocessor is =
busy performing a function issued by another CPU"
> +               "BriefDescription": "AES Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the AES functions issued by the CPU because the=
 DEA/AES coprocessor is busy performing a function issued by another CPU."
>         }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json b/tools=
/perf/pmu-events/arch/s390/cf_z10/extended.json
> index 86bd8ba9391d..bf6a9811e014 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
> @@ -4,125 +4,125 @@
>                 "EventCode": "128",
>                 "EventName": "L1I_L2_SOURCED_WRITES",
>                 "BriefDescription": "L1I L2 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 I-=
Cache directory where the returned cache line was sourced from the Level-2 =
(L1.5) cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction Cache directory where the returned cache line was sourced from th=
e Level-2 (L1.5) cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "129",
>                 "EventName": "L1D_L2_SOURCED_WRITES",
>                 "BriefDescription": "L1D L2 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 D-=
Cache directory where the installed cache line was sourced from the Level-2=
 (L1.5) cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta Cache directory where the installed cache line was sourced from the Leve=
l-2 (L1.5) cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "130",
>                 "EventName": "L1I_L3_LOCAL_WRITES",
>                 "BriefDescription": "L1I L3 Local Writes",
> -               "PublicDescription": "A directory write to the Level-1 I-=
Cache directory where the installed cache line was sourced from the Level-3=
 cache that is on the same book as the Instruction cache (Local L2 cache)"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction Cache directory where the installed cache line was sourced from t=
he Level-3 cache that is on the same book as the Instruction cache (Local L=
2 cache)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "131",
>                 "EventName": "L1D_L3_LOCAL_WRITES",
>                 "BriefDescription": "L1D L3 Local Writes",
> -               "PublicDescription": "A directory write to the Level-1 D-=
Cache directory where the installtion cache line was source from the Level-=
3 cache that is on the same book as the Data cache (Local L2 cache)"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta Cache directory where the installed cache line was source from the Level=
-3 cache that is on the same book as the Data cache (Local L2 cache)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "132",
>                 "EventName": "L1I_L3_REMOTE_WRITES",
>                 "BriefDescription": "L1I L3 Remote Writes",
> -               "PublicDescription": "A directory write to the Level-1 I-=
Cache directory where the installed cache line was sourced from a Level-3 c=
ache that is not on the same book as the Instruction cache (Remote L2 cache=
)"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction Cache directory where the installed cache line was sourced from a=
 Level-3 cache that is not on the same book as the Instruction cache (Remot=
e L2 cache)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "133",
>                 "EventName": "L1D_L3_REMOTE_WRITES",
>                 "BriefDescription": "L1D L3 Remote Writes",
> -               "PublicDescription": "A directory write to the Level-1 D-=
Cache directory where the installed cache line was sourced from a Level-3 c=
ache that is not on the same book as the Data cache (Remote L2 cache)"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta Cache directory where the installed cache line was sourced from a Level-=
3 cache that is not on the same book as the Data cache (Remote L2 cache)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "134",
>                 "EventName": "L1D_LMEM_SOURCED_WRITES",
>                 "BriefDescription": "L1D Local Memory Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 D-=
Cache directory where the installed cache line was sourced from memory that=
 is attached to the same book as the Data cache (Local Memory)"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta Cache directory where the installed cache line was sourced from memory t=
hat is attached to the same book as the Data cache (Local Memory)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "135",
>                 "EventName": "L1I_LMEM_SOURCED_WRITES",
>                 "BriefDescription": "L1I Local Memory Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 I-=
Cache where the installed cache line was sourced from memory that is attach=
ed to the s ame book as the Instruction cache (Local Memory)"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction Cache where the installed cache line was sourced from memory that=
 is attached to the s ame book as the Instruction cache (Local Memory)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "136",
>                 "EventName": "L1D_RO_EXCL_WRITES",
>                 "BriefDescription": "L1D Read-only Exclusive Writes",
> -               "PublicDescription": "A directory write to the Level-1 D-=
Cache where the line was originally in a Read-Only state in the cache but h=
as been updated to be in the Exclusive state that allows stores to the cach=
e line"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta Cache where the line was originally in a Read-Only state in the cache bu=
t has been updated to be in the Exclusive state that allows stores to the c=
ache line."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "137",
>                 "EventName": "L1I_CACHELINE_INVALIDATES",
>                 "BriefDescription": "L1I Cacheline Invalidates",
> -               "PublicDescription": "A cache line in the Level-1 I-Cache=
 has been invalidated by a store on the same CPU as the Level-1 I-Cache"
> +               "PublicDescription": "A cache line in the Level-1 Instruc=
tion Cache has been invalidated by a store on the same CPU as the Level-1 I=
nstruction Cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "138",
>                 "EventName": "ITLB1_WRITES",
>                 "BriefDescription": "ITLB1 Writes",
> -               "PublicDescription": "A translation entry has been writte=
n into the Level-1 Instruction Translation Lookaside Buffer"
> +               "PublicDescription": "A translation entry has been writte=
n into the Level-1 Instruction Translation Lookaside Buffer (ITLB1)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "139",
>                 "EventName": "DTLB1_WRITES",
>                 "BriefDescription": "DTLB1 Writes",
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Data Translation Lookaside Buffer"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Data Translation Lookaside Buffer (DTLB1)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "140",
>                 "EventName": "TLB2_PTE_WRITES",
>                 "BriefDescription": "TLB2 PTE Writes",
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Page Table Entry arrays"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Page Table Entry arrays."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "141",
>                 "EventName": "TLB2_CRSTE_WRITES",
>                 "BriefDescription": "TLB2 CRSTE Writes",
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Common Region Segment Table Entry arrays"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Common Region Segment Table Entry arrays."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "142",
>                 "EventName": "TLB2_CRSTE_HPAGE_WRITES",
>                 "BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes"=
,
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Common Region Segment Table Entry arrays for a one-meg=
abyte large page translation"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Common Region Segment Table Entry arrays for a one-meg=
abyte large page translation."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "145",
>                 "EventName": "ITLB1_MISSES",
>                 "BriefDescription": "ITLB1 Misses",
> -               "PublicDescription": "Level-1 Instruction TLB miss in pro=
gress. Incremented by one for every cycle an ITLB1 miss is in progress"
> +               "PublicDescription": "Level-1 Instruction TLB miss in pro=
gress. Incremented by one for every cycle an ITLB1 miss is in progress."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "146",
>                 "EventName": "DTLB1_MISSES",
>                 "BriefDescription": "DTLB1 Misses",
> -               "PublicDescription": "Level-1 Data TLB miss in progress. =
Incremented by one for every cycle an DTLB1 miss is in progress"
> +               "PublicDescription": "Level-1 Data TLB miss in progress. =
Incremented by one for every cycle an DTLB1 miss is in progress."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "147",
>                 "EventName": "L2C_STORES_SENT",
>                 "BriefDescription": "L2C Stores Sent",
> -               "PublicDescription": "Incremented by one for every store =
sent to Level-2 (L1.5) cache"
> +               "PublicDescription": "Incremented by one for every store =
sent to Level-2 (L1.5) cache."
>         }
>  ]
> --
> 2.36.1
>
