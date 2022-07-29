Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB0584D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiG2Im3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiG2Im0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:42:26 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0866249;
        Fri, 29 Jul 2022 01:42:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k29-20020a9d701d000000b0061c99652493so2396631otj.8;
        Fri, 29 Jul 2022 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FPjiDrwCCyuoiiGrl0sv/bvZvZ+cDgPDsabB34f8qCk=;
        b=cnqbFGKYbwkn6x+MhRSXs/a4n1mO/nteKrZYDdNJsoTIHZH/hVDNRJDi2tQAX62cz7
         drjR4jQe9rS4GaKRJ7qxpHfzYUqpyDQfxNpxL9Q1k1v8210aBE6to6jfkEFx9sYH5RTu
         T/svHsTff+1Mq64OU/XJbLbS1oz8xBaPV4DN1F47wRmbFqDeC6emHXkJsAkWYXdD3s9S
         OodeekJetShguAEKKw7S088pmCQXWAaqjZuqXVZMbkhRuqC6tGdCqM6nVnBrkS5Nj5Kq
         9lZi8AINPqGiF5cQjTURJ6el5c2mRCUF6XnWda9Noh4qITvwoKkK4hbD1sB/HHjZbMCd
         o2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FPjiDrwCCyuoiiGrl0sv/bvZvZ+cDgPDsabB34f8qCk=;
        b=OpCngaES2gT+isM0Iq2rxcUl2Hmr2qP9cWJSrpR4KO5OeXBBsTaaQP29BrOOzDGA5b
         3eS/CgdvFyHHI+sMc9KQV5uIY+1lO/2IRDmxQPdkhUrWXkGMLQQg6z95nf538IBq8cFW
         X623Iqhks337tmISRKKnf+NT/otlhdBygSMGlyYd/oj1mkChxsqzKzNc9h+gADCwyLY9
         ozqCiIm+qRMbQNrQXqmXhyubC0dCAra+zQFijZK2JdxALAx5qt1rpydLm1x35Mm30lRj
         C57FkLHiRWEejK7d3Ol9rf9h63yu1BAR/zE5SrpVqH3S0B1qoLE2LDAOqxcUWl/0mExo
         pXRQ==
X-Gm-Message-State: AJIora+z6QCup3Cdxm0OJn0hzPqFYlXBpcynNZ+CdMP8/HRFyb66ryW1
        qkKycuAvLQbKGJn4ltpE6SRQZ9/E7RYpe4bILZY=
X-Google-Smtp-Source: AGRyM1tfkhvP+YgcCNFw4PtucKo+awDDnI3jQKB1ftv2y+ywK2+rcohn4Ph4EV7DhKNflhiLkM7ozksHTpzoprySxbU=
X-Received: by 2002:a05:6830:650b:b0:61c:95e7:2118 with SMTP id
 cm11-20020a056830650b00b0061c95e72118mr1081309otb.367.1659084144594; Fri, 29
 Jul 2022 01:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com> <20220727220832.2865794-22-irogers@google.com>
In-Reply-To: <20220727220832.2865794-22-irogers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jul 2022 10:41:47 +0200
Message-ID: <CA+icZUU-AmzdkWqBCWw=izbWJfpw4GP+UUaOE6SRs3tiAtmKng@mail.gmail.com>
Subject: Re: [PATCH v3 21/30] perf vendor events: Update Intel sandybridge
To:     Ian Rogers <irogers@google.com>
Cc:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 12:09 AM Ian Rogers <irogers@google.com> wrote:
>
> Update to v17, the metrics are based on TMA 4.4 full.
>
> Use script at:
> https://github.com/intel/event-converter-for-linux-perf/blob/master/downl=
oad_and_gen.py
>
> to download and generate the latest events and metrics. Manually copy
> the sandybridge files into perf and update mapfile.csv.
>
> Tested on a non-sandybridge with 'perf test':
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>

Hi Ian,

thanks for v3 patchset.

I used latest perf/core Git branch from Arnaldo's tree plus some
custom patches (to fix binutils v2.38.90 and opennssl-v3 issues plus
gnu11 tools patches) and build with LLVM-14.

When I run on my Intel SandyBridge CPU...

$ ~/bin/perf test
...
 10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Ok
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
...

First time I ran perf with option test.

Looks that good to you?

Regards,
-Sedat-

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/arch/x86/mapfile.csv            |  2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/cache.json |  2 +-
>  .../arch/x86/sandybridge/floating-point.json          |  2 +-
>  .../pmu-events/arch/x86/sandybridge/frontend.json     |  4 ++--
>  .../perf/pmu-events/arch/x86/sandybridge/memory.json  |  2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/other.json |  2 +-
>  .../pmu-events/arch/x86/sandybridge/pipeline.json     | 10 +++++-----
>  .../pmu-events/arch/x86/sandybridge/snb-metrics.json  | 11 +++++++++--
>  .../pmu-events/arch/x86/sandybridge/uncore-other.json |  2 +-
>  .../arch/x86/sandybridge/virtual-memory.json          |  2 +-
>  10 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index 2f9419ee2d29..0b56c4a8a3a8 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -19,12 +19,12 @@ GenuineIntel-6-(57|85),v9,knightslanding,core
>  GenuineIntel-6-AA,v1.00,meteorlake,core
>  GenuineIntel-6-1[AEF],v3,nehalemep,core
>  GenuineIntel-6-2E,v3,nehalemex,core
> +GenuineIntel-6-2A,v17,sandybridge,core
>  GenuineIntel-6-[4589]E,v24,skylake,core
>  GenuineIntel-6-A[56],v24,skylake,core
>  GenuineIntel-6-37,v13,silvermont,core
>  GenuineIntel-6-4D,v13,silvermont,core
>  GenuineIntel-6-4C,v13,silvermont,core
> -GenuineIntel-6-2A,v15,sandybridge,core
>  GenuineIntel-6-2C,v2,westmereep-dp,core
>  GenuineIntel-6-25,v2,westmereep-sp,core
>  GenuineIntel-6-2F,v2,westmereex,core
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/tool=
s/perf/pmu-events/arch/x86/sandybridge/cache.json
> index 92a7269eb444..a1d622352131 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> @@ -1876,4 +1876,4 @@
>          "SampleAfterValue": "100003",
>          "UMask": "0x10"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> index 713878fd062b..eb2ff2cfdf6b 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> @@ -135,4 +135,4 @@
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json b/t=
ools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> index fa22f9463b66..e2c82e43a2de 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> @@ -176,7 +176,7 @@
>          "CounterMask": "1",
>          "EventCode": "0x79",
>          "EventName": "IDQ.MS_CYCLES",
> -        "PublicDescription": "This event counts cycles during which the =
microcode sequencer assisted the front-end in delivering uops.  Microcode a=
ssists are used for complex instructions or scenarios that can't be handled=
 by the standard decoder.  Using other instructions, if possible, will usua=
lly improve performance.  See the Intel 64 and IA-32 Architectures Optimiza=
tion Reference Manual for more information.",
> +        "PublicDescription": "This event counts cycles during which the =
microcode sequencer assisted the front-end in delivering uops.  Microcode a=
ssists are used for complex instructions or scenarios that can't be handled=
 by the standard decoder.  Using other instructions, if possible, will usua=
lly improve performance.  See the Intel(R) 64 and IA-32 Architectures Optim=
ization Reference Manual for more information.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x30"
>      },
> @@ -311,4 +311,4 @@
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json b/too=
ls/perf/pmu-events/arch/x86/sandybridge/memory.json
> index 931892d34076..3c283ca309f3 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> @@ -442,4 +442,4 @@
>          "SampleAfterValue": "100003",
>          "UMask": "0x1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/other.json b/tool=
s/perf/pmu-events/arch/x86/sandybridge/other.json
> index e251f535ec09..2f873ab14156 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/other.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
> @@ -55,4 +55,4 @@
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> index b9a3f194a00a..2c3b6c92aa6b 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> @@ -609,7 +609,7 @@
>          "UMask": "0x3"
>      },
>      {
> -        "BriefDescription": "Number of occurences waiting for the checkp=
oints in Resource Allocation Table (RAT) to be recovered after Nuke due to =
all other cases except JEClear (e.g. whenever a ucode assist is needed like=
 SSE exception, memory disambiguation, etc...).",
> +        "BriefDescription": "Number of occurrences waiting for the check=
points in Resource Allocation Table (RAT) to be recovered after Nuke due to=
 all other cases except JEClear (e.g. whenever a ucode assist is needed lik=
e SSE exception, memory disambiguation, etc...).",
>          "Counter": "0,1,2,3",
>          "CounterHTOff": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
> @@ -652,7 +652,7 @@
>          "CounterHTOff": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.STORE_FORWARD",
> -        "PublicDescription": "This event counts loads that followed a st=
ore to the same address, where the data could not be forwarded inside the p=
ipeline from the store to the load.  The most common reason why store forwa=
rding would be blocked is when a load's address range overlaps with a prece=
eding smaller uncompleted store.  See the table of not supported store forw=
ards in the Intel 64 and IA-32 Architectures Optimization Reference Manual.=
  The penalty for blocked store forwarding is that the load must wait for t=
he store to complete before it can be issued.",
> +        "PublicDescription": "This event counts loads that followed a st=
ore to the same address, where the data could not be forwarded inside the p=
ipeline from the store to the load.  The most common reason why store forwa=
rding would be blocked is when a load's address range overlaps with a prece=
eding smaller uncompleted store.  See the table of not supported store forw=
ards in the Intel(R) 64 and IA-32 Architectures Optimization Reference Manu=
al.  The penalty for blocked store forwarding is that the load must wait fo=
r the store to complete before it can be issued.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x2"
>      },
> @@ -778,7 +778,7 @@
>          "CounterMask": "1",
>          "EventCode": "0x59",
>          "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES",
> -        "PublicDescription": "This event counts the number of cycles spe=
nt executing performance-sensitive flags-merging uops. For example, shift C=
L (merge_arith_flags). For more details, See the Intel 64 and IA-32 Archite=
ctures Optimization Reference Manual.",
> +        "PublicDescription": "This event counts the number of cycles spe=
nt executing performance-sensitive flags-merging uops. For example, shift C=
L (merge_arith_flags). For more details, See the Intel(R) 64 and IA-32 Arch=
itectures Optimization Reference Manual.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x20"
>      },
> @@ -797,7 +797,7 @@
>          "CounterHTOff": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x59",
>          "EventName": "PARTIAL_RAT_STALLS.SLOW_LEA_WINDOW",
> -        "PublicDescription": "This event counts the number of cycles wit=
h at least one slow LEA uop being allocated. A uop is generally considered =
as slow LEA if it has three sources (for example, two sources and immediate=
) regardless of whether it is a result of LEA instruction or not. Examples =
of the slow LEA uop are or uops with base, index, and offset source operand=
s using base and index reqisters, where base is EBR/RBP/R13, using RIP rela=
tive or 16-bit addressing modes. See the Intel 64 and IA-32 Architectures O=
ptimization Reference Manual for more details about slow LEA instructions."=
,
> +        "PublicDescription": "This event counts the number of cycles wit=
h at least one slow LEA uop being allocated. A uop is generally considered =
as slow LEA if it has three sources (for example, two sources and immediate=
) regardless of whether it is a result of LEA instruction or not. Examples =
of the slow LEA uop are or uops with base, index, and offset source operand=
s using base and index reqisters, where base is EBR/RBP/R13, using RIP rela=
tive or 16-bit addressing modes. See the Intel(R) 64 and IA-32 Architecture=
s Optimization Reference Manual for more details about slow LEA instruction=
s.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x40"
>      },
> @@ -1209,4 +1209,4 @@
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json =
b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> index c8e7050d9c26..ae7ed267b2a2 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> @@ -124,7 +124,7 @@
>          "MetricName": "FLOPc_SMT"
>      },
>      {
> -        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is at least 1 uop executed)",
> +        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is execution) per-core",
>          "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.C=
ORE\\,cmask\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=
=3D1@)",
>          "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
>          "MetricName": "ILP"
> @@ -141,6 +141,12 @@
>          "MetricGroup": "Summary;TmaL1",
>          "MetricName": "Instructions"
>      },
> +    {
> +        "BriefDescription": "Average number of Uops retired in cycles wh=
ere at least one uop has retired.",
> +        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETI=
RE_SLOTS\\,cmask\\=3D1@",
> +        "MetricGroup": "Pipeline;Ret",
> +        "MetricName": "Retire"
> +    },
>      {
>          "BriefDescription": "Fraction of Uops delivered by the DSB (aka =
Decoded ICache; or Uop Cache)",
>          "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.M=
ITE_UOPS + IDQ.MS_UOPS ) )",
> @@ -163,7 +169,8 @@
>          "BriefDescription": "Giga Floating Point Operations Per Second",
>          "MetricExpr": "( ( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_=
COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + =
4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 *=
 SIMD_FP_256.PACKED_SINGLE ) / 1000000000 ) / duration_time",
>          "MetricGroup": "Cor;Flops;HPC",
> -        "MetricName": "GFLOPs"
> +        "MetricName": "GFLOPs",
> +        "PublicDescription": "Giga Floating Point Operations Per Second.=
 Aggregate across all supported options of: FP precisions, scalar and vecto=
r instructions, vector-width and AMX engine."
>      },
>      {
>          "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json=
 b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
> index 6278068908cf..88f1e326205f 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
> @@ -82,10 +82,10 @@
>      {
>          "BriefDescription": "This 48-bit fixed counter counts the UCLK c=
ycles.",
>          "Counter": "Fixed",
> +        "EventCode": "0xff",
>          "EventName": "UNC_CLOCK.SOCKET",
>          "PerPkg": "1",
>          "PublicDescription": "This 48-bit fixed counter counts the UCLK =
cycles.",
> -        "UMask": "0x01",
>          "Unit": "ARB"
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> index 4dd136d00a10..98362abba1a7 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> @@ -146,4 +146,4 @@
>          "SampleAfterValue": "100007",
>          "UMask": "0x20"
>      }
> -]
> \ No newline at end of file
> +]
> --
> 2.37.1.359.gd136c6c3e2-goog
>
