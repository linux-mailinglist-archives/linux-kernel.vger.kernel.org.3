Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE0539380
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbiEaPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345439AbiEaPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:01:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9FA5C667
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:01:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d26so13472431wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6oF+ac2RUCAJQthxWVufUBZPDuIYEm4QP9/MDCMgGPQ=;
        b=B6Y5nFSdshQNJWu3PP3s96IHwuz4K9nULFh7O+Q7KnzPRD47YMoCSBjaNvMCNb/jpz
         e4Zme7RnOGuRkTOHJcj1XreJz/F1j3syZwnVTLl5Eof7A12RWLReHESfUKbRwjMHe/FQ
         mUnjo/bH52/4YPd999lCzKxcddXb4meFjuRVooarZzLZrqN5zVN1dxiuQX8+v888dUmh
         j6gJy+3/Ad130E1tFZO3yLeOoFhc/G9SVH810POFD8H1PBtgoqFp9Jiiub26mhBB5uWj
         rRVeMScJY2OYxtDHw9H3jVD8/oRKOTUPr5/28anwaXQkzki2xg/wuYh+IDlCJS7JH9yZ
         60Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6oF+ac2RUCAJQthxWVufUBZPDuIYEm4QP9/MDCMgGPQ=;
        b=Z7jHa1GJS3/9QbwQyYNvQVqZsWK6OVq0/kQ+CVZYXptYtIn6kyuTpKgEojnzzCVyIx
         iIH40tYHDGSefjMccfdF0wzYPeIQRaKYJlG0mG2KEDOQSeboKveb7hhG0HC+twBDg9n8
         1ikmadrdeUXwwOJSPD6oPzenJOB2kkatwPrH013piyaOa87CU5RsUIQrWnMRwRya2PWi
         fqNxEIMbh44Kvgl5/YPUrt5gve2u9qhH4sLDYUCo3j4fUtYJingTAcEqMVtOHpsRnrEA
         wIBiPdA+C+x2ZqIJVdB4tjj1eMTIx2PSpOkTRXYZ971Z3PN6sVUIMZrw3g7i6eqRLTOK
         2wqg==
X-Gm-Message-State: AOAM533rL0xnScMG7zvViS1UO8xzmXu0MhdclMgazEjN0BX4OL+T7rsh
        ++IKd9/eP09ujMKpcNXYqS8wlS98cJCR0CnyzIZvuw==
X-Google-Smtp-Source: ABdhPJyTKsCMdgkuWmBSCJvYu+0SB7g6GBnruruPQchmwOO6d7TA/5Cc6MrTmraWdjSt/NfRRVCcy94Qw2piB8svzNk=
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id
 i12-20020a0560001acc00b0020ff12aa535mr30843895wry.375.1654009295067; Tue, 31
 May 2022 08:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220531092706.1931503-1-tmricht@linux.ibm.com> <20220531092706.1931503-3-tmricht@linux.ibm.com>
In-Reply-To: <20220531092706.1931503-3-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 May 2022 08:01:19 -0700
Message-ID: <CAP-5=fV93hnqmuoGfpeD-rADt-wDc7aRwfGbLZD6zv-28wePFA@mail.gmail.com>
Subject: Re: [PATCH 3/7] perf list: Update event description for IBM z13 to
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
> Update IBM z13 event counter description to the latest level
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
>  .../pmu-events/arch/s390/cf_z13/basic.json    |  48 ++++-----
>  .../pmu-events/arch/s390/cf_z13/crypto.json   |  64 +++++------
>  .../pmu-events/arch/s390/cf_z13/extended.json | 100 +++++++++---------
>  3 files changed, 106 insertions(+), 106 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json b/tools/pe=
rf/pmu-events/arch/s390/cf_z13/basic.json
> index 783de7f1aeaa..9bd20a5f47af 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
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
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json b/tools/p=
erf/pmu-events/arch/s390/cf_z13/crypto.json
> index 3f28007d3892..a8d391ddeb8c 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
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
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools=
/perf/pmu-events/arch/s390/cf_z13/extended.json
> index 1a5e4f89c57e..99c1b93a7e36 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
> @@ -11,7 +11,7 @@
>                 "EventCode": "129",
>                 "EventName": "DTLB1_WRITES",
>                 "BriefDescription": "DTLB1 Writes",
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Data Translation Lookaside Buffer"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Data Translation Lookaside Buffer (DTLB1)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
> @@ -25,7 +25,7 @@
>                 "EventCode": "131",
>                 "EventName": "DTLB1_HPAGE_WRITES",
>                 "BriefDescription": "DTLB1 One-Megabyte Page Writes",
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page.=
"
>         },
>         {
>                 "Unit": "CPU-M-CF",
> @@ -39,63 +39,63 @@
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
>                 "EventName": "ITLB1_WRITES",
>                 "BriefDescription": "ITLB1 Writes",
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Instruction Translation Lookaside Buffer"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-1 Instruction Translation Lookaside Buffer (ITLB1)."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "135",
>                 "EventName": "ITLB1_MISSES",
>                 "BriefDescription": "ITLB1 Misses",
> -               "PublicDescription": "Level-1 Instruction TLB miss in pro=
gress. Incremented by one for every cycle an ITLB1 miss is in progress"
> +               "PublicDescription": "Level-1 Instruction TLB miss in pro=
gress. Incremented by one for every cycle an ITLB1 miss is in progress."
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
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Page Table Entry arrays"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Page Table Entry arrays."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "138",
>                 "EventName": "TLB2_CRSTE_HPAGE_WRITES",
>                 "BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes"=
,
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Combined Region Segment Table Entry arrays for a one-m=
egabyte large page translation"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Combined Region Segment Table Entry arrays for a one-m=
egabyte large page translation."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "139",
>                 "EventName": "TLB2_CRSTE_WRITES",
>                 "BriefDescription": "TLB2 CRSTE Writes",
> -               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Combined Region Segment Table Entry arrays"
> +               "PublicDescription": "A translation entry has been writte=
n to the Level-2 TLB Combined Region Segment Table Entry arrays."
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
> @@ -109,273 +109,273 @@
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
>                 "EventCode": "146",
>                 "EventName": "L1D_ONNODE_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Node L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Nod=
e Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Nod=
e Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "147",
>                 "EventName": "L1D_ONNODE_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D On-Node L3 Sourced Writes with I=
ntervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Nod=
e Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Nod=
e Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "148",
>                 "EventName": "L1D_ONNODE_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Node L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Nod=
e Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Nod=
e Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "149",
>                 "EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Drawer L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Dra=
wer Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Dra=
wer Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "150",
>                 "EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D On-Drawer L3 Sourced Writes with=
 Intervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Dra=
wer Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Dra=
wer Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "151",
>                 "EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Drawer L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Dra=
wer Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an On-Dra=
wer Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "152",
>                 "EventName": "L1D_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer Same-Column L4 Source=
d Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Same-Column Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Same-Column Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "153",
>                 "EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D Off-Drawer Same-Column L3 Source=
d Writes with Intervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Same-Column Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Same-Column Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "154",
>                 "EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer Same-Column L3 Source=
d Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Same-Column Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Same-Column Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "155",
>                 "EventName": "L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced=
 Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Far-Column Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Far-Column Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "156",
>                 "EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced=
 Writes with Intervention",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Far-Column Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Far-Column Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "157",
>                 "EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced=
 Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Far-Column Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from an Off-Dr=
awer Far-Column Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "158",
>                 "EventName": "L1D_ONNODE_MEM_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Node Memory Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Node m=
emory"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Node m=
emory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "159",
>                 "EventName": "L1D_ONDRAWER_MEM_SOURCED_WRITES",
>                 "BriefDescription": "L1D On-Drawer Memory Sourced Writes"=
,
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Drawer=
 memory"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Drawer=
 memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "160",
>                 "EventName": "L1D_OFFDRAWER_MEM_SOURCED_WRITES",
>                 "BriefDescription": "L1D Off-Drawer Memory Sourced Writes=
",
> -               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from On-Drawer=
 memory"
> +               "PublicDescription": "A directory write to the Level-1 Da=
ta cache directory where the returned cache line was sourced from Off-Drawe=
r memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "161",
>                 "EventName": "L1D_ONCHIP_MEM_SOURCED_WRITES",
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
>                 "EventCode": "162",
>                 "EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Chip L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Chip Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Chip Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "163",
>                 "EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I On-Chip L3 Sourced Writes with I=
ntervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On Chip Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On Chip Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "164",
>                 "EventName": "L1I_ONNODE_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Chip L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Node Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Node Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "165",
>                 "EventName": "L1I_ONNODE_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I On-Node L3 Sourced Writes with I=
ntervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Node Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Node Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "166",
>                 "EventName": "L1I_ONNODE_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Node L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Node Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Node Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "167",
>                 "EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Drawer L4 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Drawer Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Drawer Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "168",
>                 "EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I On-Drawer L3 Sourced Writes with=
 Intervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Drawer Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Drawer Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "169",
>                 "EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Drawer L3 Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Drawer Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 On-Drawer Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "170",
>                 "EventName": "L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer Same-Column L4 Source=
d Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Same-Column Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Same-Column Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "171",
>                 "EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I Off-Drawer Same-Column L3 Source=
d Writes with Intervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Same-Column Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Same-Column Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "172",
>                 "EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer Same-Column L3 Source=
d Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Same-Column Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Same-Column Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "173",
>                 "EventName": "L1I_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer Far-Column L4 Sourced=
 Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Far-Column Level-4 cache"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Far-Column Level-4 cache."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "174",
>                 "EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
>                 "BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced=
 Writes with Intervention",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Far-Column Level-3 cache with intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Far-Column Level-3 cache with intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "175",
>                 "EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced=
 Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Far-Column Level-3 cache without intervention"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from an=
 Off-Drawer Far-Column Level-3 cache without intervention."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "176",
>                 "EventName": "L1I_ONNODE_MEM_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Node Memory Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Node memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Node memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "177",
>                 "EventName": "L1I_ONDRAWER_MEM_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Drawer Memory Sourced Writes"=
,
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Drawer memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Drawer memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "178",
>                 "EventName": "L1I_OFFDRAWER_MEM_SOURCED_WRITES",
>                 "BriefDescription": "L1I Off-Drawer Memory Sourced Writes=
",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Drawer memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Drawer memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "179",
>                 "EventName": "L1I_ONCHIP_MEM_SOURCED_WRITES",
>                 "BriefDescription": "L1I On-Chip Memory Sourced Writes",
> -               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Chip memory"
> +               "PublicDescription": "A directory write to the Level-1 In=
struction cache directory where the returned cache line was sourced from On=
-Chip memory."
>         },
>         {
>                 "Unit": "CPU-M-CF",
>                 "EventCode": "218",
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
>                 "EventCode": "219",
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
>                 "EventCode": "220",
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
> --
> 2.36.1
>
