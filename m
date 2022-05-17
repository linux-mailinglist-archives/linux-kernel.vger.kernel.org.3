Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE752A4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbiEQOcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiEQOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:32:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA8726136;
        Tue, 17 May 2022 07:32:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04C951042;
        Tue, 17 May 2022 07:32:33 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271193F718;
        Tue, 17 May 2022 07:32:30 -0700 (PDT)
Message-ID: <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com>
Date:   Tue, 17 May 2022 15:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
Content-Language: en-GB
To:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220510104758.64677-1-nick.forrington@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 2022-05-10 11:47, Nick Forrington wrote:
> Add Performance Monitoring Unit event data for the Arm CPUs listed
> below.
> 
> Changesets are dependent due to incremental updates to the common events
> file and mapfile.csv.
> 
> Data is sourced from https://github.com/ARM-software/data
> 
> Nick Forrington (20):
>    perf vendors events arm64: Arm Cortex-A5
>    perf vendors events arm64: Arm Cortex-A7
>    perf vendors events arm64: Arm Cortex-A8
>    perf vendors events arm64: Arm Cortex-A9
>    perf vendors events arm64: Arm Cortex-A15
>    perf vendors events arm64: Arm Cortex-A17
>    perf vendors events arm64: Arm Cortex-A32

Obligatory question over anything relating to the above CPUs being in an 
"arch/arm64" directory... ;)

Cheers,
Robin.

>    perf vendors events arm64: Arm Cortex-A34
>    perf vendors events arm64: Arm Cortex-A35
>    perf vendors events arm64: Arm Cortex-A55
>    perf vendors events arm64: Arm Cortex-A510
>    perf vendors events arm64: Arm Cortex-A65
>    perf vendors events arm64: Arm Cortex-A73
>    perf vendors events arm64: Arm Cortex-A75
>    perf vendors events arm64: Arm Cortex-A77
>    perf vendors events arm64: Arm Cortex-A78
>    perf vendors events arm64: Arm Cortex-A710
>    perf vendors events arm64: Arm Cortex-X1
>    perf vendors events arm64: Arm Cortex-X2
>    perf vendors events arm64: Arm Neoverse E1
> 
>   .../arch/arm64/arm/cortex-a15/branch.json     |  17 ++
>   .../arch/arm64/arm/cortex-a15/bus.json        |  29 +++
>   .../arch/arm64/arm/cortex-a15/cache.json      |  80 ++++++
>   .../arch/arm64/arm/cortex-a15/exception.json  |   8 +
>   .../arm64/arm/cortex-a15/instruction.json     |  59 +++++
>   .../arch/arm64/arm/cortex-a15/memory.json     |  20 ++
>   .../arch/arm64/arm/cortex-a17/branch.json     |  17 ++
>   .../arch/arm64/arm/cortex-a17/bus.json        |  26 ++
>   .../arch/arm64/arm/cortex-a17/cache.json      |  53 ++++
>   .../arch/arm64/arm/cortex-a17/exception.json  |  11 +
>   .../arm64/arm/cortex-a17/instruction.json     |  56 +++++
>   .../arch/arm64/arm/cortex-a17/memory.json     |  20 ++
>   .../arch/arm64/arm/cortex-a32/branch.json     |  11 +
>   .../arch/arm64/arm/cortex-a32/bus.json        |  17 ++
>   .../arch/arm64/arm/cortex-a32/cache.json      |  32 +++
>   .../arch/arm64/arm/cortex-a32/exception.json  |  14 ++
>   .../arm64/arm/cortex-a32/instruction.json     |  29 +++
>   .../arch/arm64/arm/cortex-a32/memory.json     |   8 +
>   .../arch/arm64/arm/cortex-a34/branch.json     |  11 +
>   .../arch/arm64/arm/cortex-a34/bus.json        |  17 ++
>   .../arch/arm64/arm/cortex-a34/cache.json      |  32 +++
>   .../arch/arm64/arm/cortex-a34/exception.json  |  14 ++
>   .../arm64/arm/cortex-a34/instruction.json     |  29 +++
>   .../arch/arm64/arm/cortex-a34/memory.json     |   8 +
>   .../arch/arm64/arm/cortex-a35/branch.json     |  11 +
>   .../arch/arm64/arm/cortex-a35/bus.json        |  17 ++
>   .../arch/arm64/arm/cortex-a35/cache.json      |  32 +++
>   .../arch/arm64/arm/cortex-a35/exception.json  |  14 ++
>   .../arm64/arm/cortex-a35/instruction.json     |  44 ++++
>   .../arch/arm64/arm/cortex-a35/memory.json     |   8 +
>   .../arch/arm64/arm/cortex-a5/branch.json      |   8 +
>   .../arch/arm64/arm/cortex-a5/cache.json       |  23 ++
>   .../arch/arm64/arm/cortex-a5/exception.json   |  11 +
>   .../arch/arm64/arm/cortex-a5/instruction.json |  29 +++
>   .../arch/arm64/arm/cortex-a5/memory.json      |   8 +
>   .../arch/arm64/arm/cortex-a510/branch.json    |  59 +++++
>   .../arch/arm64/arm/cortex-a510/bus.json       |  17 ++
>   .../arch/arm64/arm/cortex-a510/cache.json     | 182 ++++++++++++++
>   .../arch/arm64/arm/cortex-a510/exception.json |  14 ++
>   .../arm64/arm/cortex-a510/instruction.json    |  95 +++++++
>   .../arch/arm64/arm/cortex-a510/memory.json    |  32 +++
>   .../arch/arm64/arm/cortex-a510/pipeline.json  | 107 ++++++++
>   .../arch/arm64/arm/cortex-a510/pmu.json       |   8 +
>   .../arch/arm64/arm/cortex-a510/trace.json     |  32 +++
>   .../arch/arm64/arm/cortex-a55/branch.json     |  59 +++++
>   .../arch/arm64/arm/cortex-a55/bus.json        |  17 ++
>   .../arch/arm64/arm/cortex-a55/cache.json      | 188 ++++++++++++++
>   .../arch/arm64/arm/cortex-a55/exception.json  |  20 ++
>   .../arm64/arm/cortex-a55/instruction.json     |  65 +++++
>   .../arch/arm64/arm/cortex-a55/memory.json     |  17 ++
>   .../arch/arm64/arm/cortex-a55/pipeline.json   |  80 ++++++
>   .../arch/arm64/arm/cortex-a65/branch.json     |  17 ++
>   .../arch/arm64/arm/cortex-a65/bus.json        |  17 ++
>   .../arch/arm64/arm/cortex-a65/cache.json      | 236 ++++++++++++++++++
>   .../arch/arm64/arm/cortex-a65/dpu.json        |  32 +++
>   .../arch/arm64/arm/cortex-a65/exception.json  |  14 ++
>   .../arch/arm64/arm/cortex-a65/ifu.json        | 122 +++++++++
>   .../arm64/arm/cortex-a65/instruction.json     |  71 ++++++
>   .../arch/arm64/arm/cortex-a65/memory.json     |  35 +++
>   .../arch/arm64/arm/cortex-a65/pipeline.json   |   8 +
>   .../arch/arm64/arm/cortex-a7/branch.json      |   8 +
>   .../arch/arm64/arm/cortex-a7/bus.json         |  17 ++
>   .../arch/arm64/arm/cortex-a7/cache.json       |  32 +++
>   .../arch/arm64/arm/cortex-a7/exception.json   |  11 +
>   .../arch/arm64/arm/cortex-a7/instruction.json |  29 +++
>   .../arch/arm64/arm/cortex-a7/memory.json      |   8 +
>   .../arch/arm64/arm/cortex-a710/branch.json    |  17 ++
>   .../arch/arm64/arm/cortex-a710/bus.json       |  20 ++
>   .../arch/arm64/arm/cortex-a710/cache.json     | 155 ++++++++++++
>   .../arch/arm64/arm/cortex-a710/exception.json |  47 ++++
>   .../arm64/arm/cortex-a710/instruction.json    | 134 ++++++++++
>   .../arch/arm64/arm/cortex-a710/memory.json    |  41 +++
>   .../arch/arm64/arm/cortex-a710/pipeline.json  |  23 ++
>   .../arch/arm64/arm/cortex-a710/trace.json     |  29 +++
>   .../arch/arm64/arm/cortex-a73/branch.json     |  11 +
>   .../arch/arm64/arm/cortex-a73/bus.json        |  23 ++
>   .../arch/arm64/arm/cortex-a73/cache.json      | 107 ++++++++
>   .../arch/arm64/arm/cortex-a73/etm.json        |  14 ++
>   .../arch/arm64/arm/cortex-a73/exception.json  |  14 ++
>   .../arm64/arm/cortex-a73/instruction.json     |  65 +++++
>   .../arch/arm64/arm/cortex-a73/memory.json     |  14 ++
>   .../arch/arm64/arm/cortex-a73/mmu.json        |  44 ++++
>   .../arch/arm64/arm/cortex-a73/pipeline.json   |  38 +++
>   .../arch/arm64/arm/cortex-a75/branch.json     |  11 +
>   .../arch/arm64/arm/cortex-a75/bus.json        |  17 ++
>   .../arch/arm64/arm/cortex-a75/cache.json      | 164 ++++++++++++
>   .../arch/arm64/arm/cortex-a75/etm.json        |  14 ++
>   .../arch/arm64/arm/cortex-a75/exception.json  |  17 ++
>   .../arm64/arm/cortex-a75/instruction.json     |  74 ++++++
>   .../arch/arm64/arm/cortex-a75/memory.json     |  17 ++
>   .../arch/arm64/arm/cortex-a75/mmu.json        |  44 ++++
>   .../arch/arm64/arm/cortex-a75/pipeline.json   |  44 ++++
>   .../arch/arm64/arm/cortex-a77/branch.json     |  17 ++
>   .../arch/arm64/arm/cortex-a77/bus.json        |  17 ++
>   .../arch/arm64/arm/cortex-a77/cache.json      | 143 +++++++++++
>   .../arch/arm64/arm/cortex-a77/exception.json  |  47 ++++
>   .../arm64/arm/cortex-a77/instruction.json     |  77 ++++++
>   .../arch/arm64/arm/cortex-a77/memory.json     |  23 ++
>   .../arch/arm64/arm/cortex-a77/pipeline.json   |   8 +
>   .../arch/arm64/arm/cortex-a78/branch.json     |  17 ++
>   .../arch/arm64/arm/cortex-a78/bus.json        |  20 ++
>   .../arch/arm64/arm/cortex-a78/cache.json      | 155 ++++++++++++
>   .../arch/arm64/arm/cortex-a78/exception.json  |  47 ++++
>   .../arm64/arm/cortex-a78/instruction.json     |  80 ++++++
>   .../arch/arm64/arm/cortex-a78/memory.json     |  23 ++
>   .../arch/arm64/arm/cortex-a78/pipeline.json   |  23 ++
>   .../arch/arm64/arm/cortex-a8/branch.json      |   8 +
>   .../arch/arm64/arm/cortex-a8/cache.json       |  77 ++++++
>   .../arch/arm64/arm/cortex-a8/exception.json   |   5 +
>   .../arch/arm64/arm/cortex-a8/instruction.json |  38 +++
>   .../arch/arm64/arm/cortex-a8/memory.json      |   5 +
>   .../arch/arm64/arm/cortex-a9/branch.json      |   8 +
>   .../arch/arm64/arm/cortex-a9/cache.json       |  17 ++
>   .../arch/arm64/arm/cortex-a9/exception.json   |   5 +
>   .../arch/arm64/arm/cortex-a9/instruction.json |  29 +++
>   .../arch/arm64/arm/cortex-a9/memory.json      |   5 +
>   .../arch/arm64/arm/cortex-x1/branch.json      |  17 ++
>   .../arch/arm64/arm/cortex-x1/bus.json         |  20 ++
>   .../arch/arm64/arm/cortex-x1/cache.json       | 155 ++++++++++++
>   .../arch/arm64/arm/cortex-x1/exception.json   |  47 ++++
>   .../arch/arm64/arm/cortex-x1/instruction.json |  80 ++++++
>   .../arch/arm64/arm/cortex-x1/memory.json      |  23 ++
>   .../arch/arm64/arm/cortex-x1/pipeline.json    |  23 ++
>   .../arch/arm64/arm/cortex-x2/branch.json      |  17 ++
>   .../arch/arm64/arm/cortex-x2/bus.json         |  20 ++
>   .../arch/arm64/arm/cortex-x2/cache.json       | 155 ++++++++++++
>   .../arch/arm64/arm/cortex-x2/exception.json   |  47 ++++
>   .../arch/arm64/arm/cortex-x2/instruction.json | 134 ++++++++++
>   .../arch/arm64/arm/cortex-x2/memory.json      |  41 +++
>   .../arch/arm64/arm/cortex-x2/pipeline.json    |  23 ++
>   .../arch/arm64/arm/cortex-x2/trace.json       |  29 +++
>   .../arch/arm64/arm/neoverse-e1/branch.json    |  17 ++
>   .../arch/arm64/arm/neoverse-e1/bus.json       |  17 ++
>   .../arch/arm64/arm/neoverse-e1/cache.json     | 107 ++++++++
>   .../arch/arm64/arm/neoverse-e1/exception.json |  14 ++
>   .../arm64/arm/neoverse-e1/instruction.json    |  65 +++++
>   .../arch/arm64/arm/neoverse-e1/memory.json    |  23 ++
>   .../arch/arm64/arm/neoverse-e1/pipeline.json  |   8 +
>   .../arch/arm64/arm/neoverse-e1/spe.json       |  14 ++
>   .../arch/arm64/common-and-microarch.json      |  66 +++++
>   tools/perf/pmu-events/arch/arm64/mapfile.csv  |  20 ++
>   141 files changed, 5746 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/trace.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/trace.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
> 
