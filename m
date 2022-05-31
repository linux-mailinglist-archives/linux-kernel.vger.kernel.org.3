Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02508539387
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbiEaPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245030AbiEaPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:03:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24208994E6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:03:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t13so19084430wrg.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t0MXpTKdOkse2wRe1Wsa2PUDLDRghqcsYK8XyOS0NDE=;
        b=ABG2XxNUZf3D97eEhyWcS6Jq/Gf6ay5K9iOhUwzMkcy5Gi+JxuSQqmW1LlNRB1aGmN
         arrd1i8Co+DSRkUd7ZsfaDFugEW3EI09cHL/3BdXTzHN6Y+gEARhjCMrX+6Jhq/GgOWk
         tMzQjFUfnRweGpZLaTn4Jah3HPTxZYqzmxRDCtu0J8OLiafzJIzi3fsgb0yf4UAZYHh9
         QBJVpQ9EU+C1IEjoZ3XxdkYWGppvtNGm4Seeb4PSY5t/58e0Ia8+08B/XRILNwxoS+Rl
         mD+QAKmlncv91+kwDIR/V7kHhueverVYOK4aUKWzSv6cgcs2c6HNbjcJHkfWs5jiNfLj
         Koyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t0MXpTKdOkse2wRe1Wsa2PUDLDRghqcsYK8XyOS0NDE=;
        b=IaqetiX8e//yWzM208dCacMeX5OqbsRkL9spnAhP7uio977neFbHhf+1D/y7H4r+UW
         zQvWkQCT2vq3sd+w7OCilDUL+1xyFB+27lxNSyYWJ6DjVYYYPHNyXOYRm6qjJ9JuWmLh
         LTPuJhR5UvMeDf4O9gQNS47ZQw1NLwRFubT9gz1H26g3VVX8ao/Ms5/+rwAR4JsACd4+
         9IQZfdHSj6nUqQTM+Tteqnynp+U53fkmqzy1FJj68tzjrUgooKPMD5A4K6Qge5ywlke1
         /qNDqj54PTS05gBFnmpPRJKR3RsftKSiqR/OMzqFMXx2cFgWkNKB5DNy4CIFQ5Tc8m5X
         T1vg==
X-Gm-Message-State: AOAM532n1K00vIqkI1wvRo+71byCKDbWMZqAbJmTuh1gLHsKc7k/0FzF
        3UFQe+06MS81XHoks3g6TtAFCdSI9B2nrh+5GZjlyw==
X-Google-Smtp-Source: ABdhPJydxzHlmh79T3ch7FxPbGoYT6i+BwVN+l5J9KedAD6G3ekINgoAST+hZxQ5OUf1lUu3BzErIPgiQx9jc0RJszs=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr51222873wri.343.1654009401740; Tue, 31
 May 2022 08:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220531092706.1931503-1-tmricht@linux.ibm.com> <20220531092706.1931503-5-tmricht@linux.ibm.com>
In-Reply-To: <20220531092706.1931503-5-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 May 2022 08:03:08 -0700
Message-ID: <CAP-5=fU5ONfE6u=Kq+F0nGLEV85qfH=oV_4bn8C59n-N7gEWzw@mail.gmail.com>
Subject: Re: [PATCH 5/7] perf list: Update event description for IBM z15 to
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 2:27 AM Thomas Richter <tmricht@linux.ibm.com> wrot=
e:
>
> Update IBM z15 event counter description to the latest level
> as described in the documents
> 1. SA23-2260-07:
>    "The Load-Program-Parameter and the CPU-Measurement Facilities."
>    released on May, 2022
> for the following counter sets:
>    * Basic counter set
>    * Problem counter set
>    * Crypto counter set
>
> 2. SA23-2261-07:
>    "The CPU-Measurement Facility Extended Counters Definition
>    for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15 and z16"
>    released on April 29, 2022
> for the following counter sets:
>    * Extended counter set
>    * MT-Diagnostic counter set
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/s390/cf_z15/basic.json    |  32 ++---
>  .../pmu-events/arch/s390/cf_z15/crypto.json   | 114 ------------------
>  .../pmu-events/arch/s390/cf_z15/crypto6.json  | 112 +++++++++++++++++
>  .../pmu-events/arch/s390/cf_z15/extended.json | 108 ++++++++---------
>  4 files changed, 182 insertions(+), 184 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json b/tools/pe=
rf/pmu-events/arch/s390/cf_z15/basic.json
> index fc762e9f1d6e..1023d47028ce 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
> @@ -3,56 +3,56 @@
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
>         }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json b/tools/p=
erf/pmu-events/arch/s390/cf_z15/crypto.json
> deleted file mode 100644
> index 3f28007d3892..000000000000
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
> +++ /dev/null
> @@ -1,114 +0,0 @@
> -[
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "64",
> -               "EventName": "PRNG_FUNCTIONS",
> -               "BriefDescription": "PRNG Functions",
> -               "PublicDescription": "Total number of the PRNG functions =
issued by the CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "65",
> -               "EventName": "PRNG_CYCLES",
> -               "BriefDescription": "PRNG Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "66",
> -               "EventName": "PRNG_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "PRNG Blocked Functions",
> -               "PublicDescription": "Total number of the PRNG functions =
that are issued by the CPU and are blocked because the DEA/AES coprocessor =
is busy performing a function issued by another CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "67",
> -               "EventName": "PRNG_BLOCKED_CYCLES",
> -               "BriefDescription": "PRNG Blocked Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the PRNG functions issued by the CPU because the DEA/AES coprocessor is=
 busy performing a function issued by another CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "68",
> -               "EventName": "SHA_FUNCTIONS",
> -               "BriefDescription": "SHA Functions",
> -               "PublicDescription": "Total number of SHA functions issue=
d by the CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "69",
> -               "EventName": "SHA_CYCLES",
> -               "BriefDescription": "SHA Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 SHA coprocessor is busy performing the SHA functions issued by the CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "70",
> -               "EventName": "SHA_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "SHA Blocked Functions",
> -               "PublicDescription": "Total number of the SHA functions t=
hat are issued by the CPU and are blocked because the SHA coprocessor is bu=
sy performing a function issued by another CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "71",
> -               "EventName": "SHA_BLOCKED_CYCLES",
> -               "BriefDescription": "SHA Bloced Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the SHA functions issued by the CPU because the SHA coprocessor is busy=
 performing a function issued by another CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "72",
> -               "EventName": "DEA_FUNCTIONS",
> -               "BriefDescription": "DEA Functions",
> -               "PublicDescription": "Total number of the DEA functions i=
ssued by the CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "73",
> -               "EventName": "DEA_CYCLES",
> -               "BriefDescription": "DEA Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 DEA/AES coprocessor is busy performing the DEA functions issued by the CPU=
"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "74",
> -               "EventName": "DEA_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "DEA Blocked Functions",
> -               "PublicDescription": "Total number of the DEA functions t=
hat are issued by the CPU and are blocked because the DEA/AES coprocessor i=
s busy performing a function issued by another CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "75",
> -               "EventName": "DEA_BLOCKED_CYCLES",
> -               "BriefDescription": "DEA Blocked Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the DEA functions issued by the CPU because the DEA/AES coprocessor is =
busy performing a function issued by another CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "76",
> -               "EventName": "AES_FUNCTIONS",
> -               "BriefDescription": "AES Functions",
> -               "PublicDescription": "Total number of AES functions issue=
d by the CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "77",
> -               "EventName": "AES_CYCLES",
> -               "BriefDescription": "AES Cycles",
> -               "PublicDescription": "Total number of CPU cycles when the=
 DEA/AES coprocessor is busy performing the AES functions issued by the CPU=
"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "78",
> -               "EventName": "AES_BLOCKED_FUNCTIONS",
> -               "BriefDescription": "AES Blocked Functions",
> -               "PublicDescription": "Total number of AES functions that =
are issued by the CPU and are blocked because the DEA/AES coprocessor is bu=
sy performing a function issued by another CPU"
> -       },
> -       {
> -               "Unit": "CPU-M-CF",
> -               "EventCode": "79",
> -               "EventName": "AES_BLOCKED_CYCLES",
> -               "BriefDescription": "AES Blocked Cycles",
> -               "PublicDescription": "Total number of CPU cycles blocked =
for the AES functions issued by the CPU because the DEA/AES coprocessor is =
busy performing a function issued by another CPU"
> -       }
> -]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json b/tools/=
perf/pmu-events/arch/s390/cf_z15/crypto6.json
> index ad79189050a0..8b4380b8e489 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
> @@ -1,4 +1,116 @@
>  [
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "64",
> +               "EventName": "PRNG_FUNCTIONS",
> +               "BriefDescription": "PRNG Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the pseudorandom-number-generation functions issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "65",
> +               "EventName": "PRNG_CYCLES",
> +               "BriefDescription": "PRNG Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the DEA/AES/SHA coprocessor is busy performing the pse=
udorandom- number-generation functions issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "66",
> +               "EventName": "PRNG_BLOCKED_FUNCTIONS",
> +               "BriefDescription": "PRNG Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the pseudorandom-number-generation functions that are issued by the CP=
U and are blocked because the DEA/AES/SHA coprocessor is busy performing a =
function issued by another CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "67",
> +               "EventName": "PRNG_BLOCKED_CYCLES",
> +               "BriefDescription": "PRNG Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the pseudorandom-number-generation functions is=
sued by the CPU because the DEA/AES/SHA coprocessor is busy performing a fu=
nction issued by another CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "68",
> +               "EventName": "SHA_FUNCTIONS",
> +               "BriefDescription": "SHA Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the SHA functions issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "69",
> +               "EventName": "SHA_CYCLES",
> +               "BriefDescription": "SHA Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the SHA coprocessor is busy performing the SHA functio=
ns issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "70",
> +               "EventName": "SHA_BLOCKED_FUNCTIONS",
> +               "BriefDescription": "SHA Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the SHA functions that are issued by the CPU and are blocked because t=
he SHA coprocessor is busy performing a function issued by another CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "71",
> +               "EventName": "SHA_BLOCKED_CYCLES",
> +               "BriefDescription": "SHA Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the SHA functions issued by the CPU because the=
 SHA coprocessor is busy performing a function issued by another CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "72",
> +               "EventName": "DEA_FUNCTIONS",
> +               "BriefDescription": "DEA Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the DEA functions issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "73",
> +               "EventName": "DEA_CYCLES",
> +               "BriefDescription": "DEA Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the DEA/AES coprocessor is busy performing the DEA fun=
ctions issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "74",
> +               "EventName": "DEA_BLOCKED_FUNCTIONS",
> +               "BriefDescription": "DEA Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the DEA functions that are issued by the CPU and are blocked because t=
he DEA/AES coprocessor is busy performing a function issued by another CPU.=
"
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "75",
> +               "EventName": "DEA_BLOCKED_CYCLES",
> +               "BriefDescription": "DEA Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the DEA functions issued by the CPU because the=
 DEA/AES coprocessor is busy performing a function issued by another CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "76",
> +               "EventName": "AES_FUNCTIONS",
> +               "BriefDescription": "AES Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the AES functions issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "77",
> +               "EventName": "AES_CYCLES",
> +               "BriefDescription": "AES Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles when the DEA/AES coprocessor is busy performing the AES fun=
ctions issued by the CPU."
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "78",
> +               "EventName": "AES_BLOCKED_FUNCTIONS",
> +               "BriefDescription": "AES Blocked Function Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of the AES functions that are issued by the CPU and are blocked because t=
he DEA/AES coprocessor is busy performing a function issued by another CPU.=
"
> +       },
> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "79",
> +               "EventName": "AES_BLOCKED_CYCLES",
> +               "BriefDescription": "AES Blocked Cycle Count",
> +               "PublicDescription": "This counter counts the total numbe=
r of CPU cycles blocked for the AES functions issued by the CPU because the=
 DEA/AES coprocessor is busy performing a function issued by another CPU."
> +       },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "80",
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json b/tools=
/perf/pmu-events/arch/s390/cf_z15/extended.json
> index 8ac61f8f286b..9c691c391086 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
> @@ -4,357 +4,357 @@
>                 "EventCode": "128",
>                 "EventName": "L1D_RO_EXCL_WRITES",
>                 "BriefDescription": "L1D Read-only Exclusive Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache where the line was originally in a Read-Only state in the cache bu=
t has been updated to be in the Exclusive state that allows stores to the c=
ache line"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache where the line was originally in a Read-Only state in the cache bu=
t has been updated to be in the Exclusive state that allows stores to the c=
ache line."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "129",
>                 "EventName": "DTLB2_WRITES",
>                 "BriefDescription": "DTLB2 Writes",
> -               "PublicDescription": "A translation has been written into=
 The Translation Lookaside Buffer 2 (TLB2) and the request was made by the =
data cache"
> +               "PublicDescription": "A translation has been written into=
 The Translation Lookaside Buffer 2 (TLB2) and the request was made by the =
data cache. This is a replacement for what was provided for the DTLB on pri=
or machines."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "130",
>                 "EventName": "DTLB2_MISSES",
>                 "BriefDescription": "DTLB2 Misses",
> -               "PublicDescription": "A TLB2 miss is in progress for a re=
quest made by the data cache. Incremented by one for every TLB2 miss in pro=
gress for the Level-1 Data cache on this cycle"
> +               "PublicDescription": "A TLB2 miss is in progress for a re=
quest made by the data cache. Incremented by one for every TLB2 miss in pro=
gress for the Level-1 Data cache on this cycle. This is a replacement for w=
hat was provided for the DTLB on prior machines."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "131",
>                 "EventName": "DTLB2_HPAGE_WRITES",
>                 "BriefDescription": "DTLB2 One-Megabyte Page Writes",
> -               "PublicDescription": "A translation entry was written int=
o the Combined Region and Segment Table Entry array in the Level-2 TLB for =
a one-megabyte page"
> +               "PublicDescription": "A translation entry was written int=
o the Combined Region and Segment Table Entry array in the Level-2 TLB for =
a one-megabyte page."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "132",
>                 "EventName": "DTLB2_GPAGE_WRITES",
>                 "BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
> -               "PublicDescription": "A translation entry for a two-gigab=
yte page was written into the Level-2 TLB"
> +               "PublicDescription": "A translation entry for a two-gigab=
yte page was written into the Level-2 TLB."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "133",
>                 "EventName": "L1D_L2D_SOURCED_WRITES",
>                 "BriefDescription": "L1D L2D Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from the Level=
-2 Data cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from the Level=
-2 Data cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "134",
>                 "EventName": "ITLB2_WRITES",
>                 "BriefDescription": "ITLB2 Writes",
> -               "PublicDescription": "A translation entry has been writte=
n into the Translation Lookaside Buffer 2 (TLB2) and the request was made b=
y the instruction cache"
> +               "PublicDescription": "A translation entry has been writte=
n into the Translation Lookaside Buffer 2 (TLB2) and the request was made b=
y the instruction cache. This is a replacement for what was provided for th=
e ITLB on prior machines."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "135",
>                 "EventName": "ITLB2_MISSES",
>                 "BriefDescription": "ITLB2 Misses",
> -               "PublicDescription": "A TLB2 miss is in progress for a re=
quest made by the instruction cache. Incremented by one for every TLB2 miss=
 in progress for the Level-1 Instruction cache in a cycle"
> +               "PublicDescription": "A TLB2 miss is in progress for a re=
quest made by the instruction cache. Incremented by one for every TLB2 miss=
 in progress for the Level-1 Instruction cache in a cycle. This is a replac=
ement for what was provided for the ITLB on prior machines."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "136",
>                 "EventName": "L1I_L2I_SOURCED_WRITES",
>                 "BriefDescription": "L1I L2I Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from th=
e Level-2 Instruction cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from th=
e Level-2 Instruction cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "137",
>                 "EventName": "TLB2_PTE_WRITES",
>                 "BriefDescription": "TLB2 PTE Writes",
> -               "PublicDescription": "A translation entry was written int=
o the Page Table Entry array in the Level-2 TLB"
> +               "PublicDescription": "A translation entry was written int=
o the Page Table Entry array in the Level-2 TLB."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "138",
>                 "EventName": "TLB2_CRSTE_WRITES",
>                 "BriefDescription": "TLB2 CRSTE Writes",
> -               "PublicDescription": "Translation entries were written in=
to the Combined Region and Segment Table Entry array and the Page Table Ent=
ry array in the Level-2 TLB"
> +               "PublicDescription": "Translation entries were written in=
to the Combined Region and Segment Table Entry array and the Page Table Ent=
ry array in the Level-2 TLB."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "139",
>                 "EventName": "TLB2_ENGINES_BUSY",
>                 "BriefDescription": "TLB2 Engines Busy",
> -               "PublicDescription": "The number of Level-2 TLB translati=
on engines busy in a cycle"
> +               "PublicDescription": "The number of Level-2 TLB translati=
on engines busy in a cycle."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "140",
>                 "EventName": "TX_C_TEND",
>                 "BriefDescription": "Completed TEND instructions in const=
rained TX mode",
> -               "PublicDescription": "A TEND instruction has completed in=
 a constrained transactional-execution mode"
> +               "PublicDescription": "A TEND instruction has completed in=
 a constrained transactional-execution mode."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "141",
>                 "EventName": "TX_NC_TEND",
>                 "BriefDescription": "Completed TEND instructions in non-c=
onstrained TX mode",
> -               "PublicDescription": "A TEND instruction has completed in=
 a non-constrained transactional-execution mode"
> +               "PublicDescription": "A TEND instruction has completed in=
 a non-constrained transactional-execution mode."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "143",
>                 "EventName": "L1C_TLB2_MISSES",
>                 "BriefDescription": "L1C TLB2 Misses",
> -               "PublicDescription": "Increments by one for any cycle whe=
re a level-1 cache or level-2 TLB miss is in progress"
> +               "PublicDescription": "Increments by one for any cycle whe=
re a level-1 cache or level-2 TLB miss is in progress."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "144",
>                 "EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Chip L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Chi=
p Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Chi=
p Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "145",
>                 "EventName": "L1D_ONCHIP_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Chip Memory Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Chip m=
emory"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Chip m=
emory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "146",
>                 "EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D On-Chip L3 Sourced Writes with I=
ntervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Chi=
p Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Chi=
p Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "147",
>                 "EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Cluster L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Cluste=
r Level-3 cache withountervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Cluste=
r Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "148",
>                 "EventName": "L1D_ONCLUSTER_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Cluster Memory Sourced Writes=
",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Clu=
ster memory"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Clu=
ster memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "149",
>                 "EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D On-Cluster L3 Sourced Writes wit=
h Intervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Clu=
ster Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Clu=
ster Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "150",
>                 "EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Cluster L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Cl=
uster Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Cl=
uster Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "151",
>                 "EventName": "L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Cluster Memory Sourced Write=
s",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from Off-Clust=
er memory"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from Off-Clust=
er memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "152",
>                 "EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D Off-Cluster L3 Sourced Writes wi=
th Intervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Cl=
uster Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Cl=
uster Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "153",
>                 "EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "154",
>                 "EventName": "L1D_OFFDRAWER_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer Memory Sourced Writes=
",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from Off-Drawe=
r memory"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from Off-Drawe=
r memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "155",
>                 "EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D Off-Drawer L3 Sourced Writes wit=
h Intervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "156",
>                 "EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Drawer L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Drawer=
 Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Drawer=
 Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "157",
>                 "EventName": "L1D_OFFDRAWER_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from Off-Drawe=
r Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from Off-Drawe=
r Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "158",
>                 "EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_RO",
>                 "BriefDescription": "L1D On-Chip L3 Sourced Writes read-o=
nly",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Chip L=
3 but a read-only invalidate was done to remove other copies of the cache l=
ine"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Chip L=
3 but a read-only invalidate was done to remove other copies of the cache l=
ine."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "162",
>                 "EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Chip L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache ine was sourced from an =
On-Chip Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache ine was sourced from an =
On-Chip Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "163",
>                 "EventName": "L1I_ONCHIP_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Chip Memory Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache ine was sourced from On-=
Chip memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache ine was sourced from On-=
Chip memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "164",
>                 "EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I On-Chip L3 Sourced Writes with I=
ntervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache ine was sourced from an =
On-Chip Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache ine was sourced from an =
On-Chip Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "165",
>                 "EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Cluster L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Cluster Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Cluster Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "166",
>                 "EventName": "L1I_ONCLUSTER_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Cluster Memory Sourced Writes=
",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Cluster memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Cluster memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "167",
>                 "EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I On-Cluster L3 Sourced Writes wit=
h Intervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Cluster Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Cluster Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "168",
>                 "EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Cluster L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Cluster Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Cluster Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "169",
>                 "EventName": "L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Cluster Memory Sourced Write=
s",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from Of=
f-Cluster memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from Of=
f-Cluster memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "170",
>                 "EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I Off-Cluster L3 Sourced Writes wi=
th Intervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Cluster Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Cluster Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "171",
>                 "EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "172",
>                 "EventName": "L1I_OFFDRAWER_MEMORY_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer Memory Sourced Writes=
",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from Of=
f-Drawer memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from Of=
f-Drawer memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "173",
>                 "EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I Off-Drawer L3 Sourced Writes wit=
h Intervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "174",
>                 "EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Drawer L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Drawer Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Drawer Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "175",
>                 "EventName": "L1I_OFFDRAWER_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from Of=
f-Drawer Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from Of=
f-Drawer Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "224",
>                 "EventName": "BCD_DFP_EXECUTION_SLOTS",
>                 "BriefDescription": "BCD DFP Execution Slots",
> -               "PublicDescription": "Count of floating point execution s=
lots used for finished Binary Coded Decimal to Decimal Floating Point conve=
rsions. Instructions: CDZT, CXZT, CZDT, CZXT"
> +               "PublicDescription": "Count of floating point execution s=
lots used for finished Binary Coded Decimal to Decimal Floating Point conve=
rsions. Instructions: CDZT, CXZT, CZDT, CZXT."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "225",
>                 "EventName": "VX_BCD_EXECUTION_SLOTS",
>                 "BriefDescription": "VX BCD Execution Slots",
> -               "PublicDescription": "Count of floating point execution s=
lots used for finished vector arithmetic Binary Coded Decimal instructions.=
 Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP=
, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG"
> +               "PublicDescription": "Count of floating point execution s=
lots used for finished vector arithmetic Binary Coded Decimal instructions.=
 Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP=
, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "226",
>                 "EventName": "DECIMAL_INSTRUCTIONS",
>                 "BriefDescription": "Decimal Instructions",
> -               "PublicDescription": "Decimal instructions dispatched. In=
structions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP"
> +               "PublicDescription": "Decimal instructions dispatched. In=
structions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "232",
>                 "EventName": "LAST_HOST_TRANSLATIONS",
>                 "BriefDescription": "Last host translation done",
> -               "PublicDescription": "Last Host Translation done"
> +               "PublicDescription": "Last Host Translation done."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "243",
>                 "EventName": "TX_NC_TABORT",
>                 "BriefDescription": "Aborted transactions in non-constrai=
ned TX mode",
> -               "PublicDescription": "A transaction abort has occurred in=
 a non-constrained transactional-execution mode"
> +               "PublicDescription": "A transaction abort has occurred in=
 a non-constrained transactional-execution mode."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "244",
>                 "EventName": "TX_C_TABORT_NO_SPECIAL",
>                 "BriefDescription": "Aborted transactions in constrained =
TX mode not using special completion logic",
> -               "PublicDescription": "A transaction abort has occurred in=
 a constrained transactional-execution mode and the CPU is not using any sp=
ecial logic to allow the transaction to complete"
> +               "PublicDescription": "A transaction abort has occurred in=
 a constrained transactional-execution mode and the CPU is not using any sp=
ecial logic to allow the transaction to complete."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "245",
>                 "EventName": "TX_C_TABORT_SPECIAL",
>                 "BriefDescription": "Aborted transactions in constrained =
TX mode using special completion logic",
> -               "PublicDescription": "A transaction abort has occurred in=
 a constrained transactional-execution mode and the CPU is using special lo=
gic to allow the transaction to complete"
> +               "PublicDescription": "A transaction abort has occurred in=
 a constrained transactional-execution mode and the CPU is using special lo=
gic to allow the transaction to complete."
>         },
>         {
>                 "Unit": "CPU-M-CF",
> @@ -374,15 +374,15 @@
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "264",
>                 "EventName": "DFLT_CC",
> -               "BriefDescription": "Increments by one for every DEFLATE =
CONVERSION CALL instruction executed",
> +               "BriefDescription": "Increments DEFLATE CONVERSION CALL",
>                 "PublicDescription": "Increments by one for every DEFLATE=
 CONVERSION CALL instruction executed"
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "265",
>                 "EventName": "DFLT_CCFINISH",
> -               "BriefDescription": "Increments by one for every DEFLATE =
CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or =
2",
> -               "PublicDescription": "Increments by one for every DEFLATE=
 CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or=
 2"
> +               "BriefDescription": "Increments completed DEFLATE CONVERS=
ION CALL",
> +               "PublicDescription": " Increments by one for every DEFLAT=
E CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 o=
r 2 complete. "
>         },
>         {
>                 "Unit": "CPU-M-CF",
> --
> 2.36.1
>
