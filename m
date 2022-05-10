Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9752206F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiEJQCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347517AbiEJP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7142A3752;
        Tue, 10 May 2022 08:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B659615E2;
        Tue, 10 May 2022 15:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158C4C385C2;
        Tue, 10 May 2022 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652197827;
        bh=v4+7UtLUcHcQM9ppzLnV/5iEbc+CzSGxXWnLkTeIvbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMzYOgcFBU4gTQF2Zqkjx65mk6ev+Y+PGLacktRIKc8iKiLnTzZ69S596+m4CMzJ7
         lVK59onWfuc2bcuuC/84H48xE/Ni/h2KPFIPgbvl/YFzwNQitRbjQHAmydGOUNOz65
         VP7Muwk/T9O8e4NEpWH3QERPGFfDPfdYF9cyi+5heixwEIeAvd1GXdYwMkKlPg+hXp
         Jxqd6888uAY5a5mYoM2zsLVAG6xRkikKm87Jee+bW2HVH6aoJ4MEHetGrZlSF70cJ7
         DQYGu21qVaQ4NlflMqDu4DmASCXFwaT3K3wdaszLBc12uMgRYmYeBsF1kshhEAuJhM
         LBczjpIIWPKkg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB70B400B1; Tue, 10 May 2022 12:50:24 -0300 (-03)
Date:   Tue, 10 May 2022 12:50:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
Message-ID: <YnqJwMfi/bcDmN4H@kernel.org>
References: <20220510104758.64677-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510104758.64677-1-nick.forrington@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 10, 2022 at 11:47:38AM +0100, Nick Forrington escreveu:
> Add Performance Monitoring Unit event data for the Arm CPUs listed
> below.
> 
> Changesets are dependent due to incremental updates to the common events
> file and mapfile.csv.
> 
> Data is sourced from https://github.com/ARM-software/data

Waiting for reviews to merge this.

- Arnaldo
 
> Nick Forrington (20):
>   perf vendors events arm64: Arm Cortex-A5
>   perf vendors events arm64: Arm Cortex-A7
>   perf vendors events arm64: Arm Cortex-A8
>   perf vendors events arm64: Arm Cortex-A9
>   perf vendors events arm64: Arm Cortex-A15
>   perf vendors events arm64: Arm Cortex-A17
>   perf vendors events arm64: Arm Cortex-A32
>   perf vendors events arm64: Arm Cortex-A34
>   perf vendors events arm64: Arm Cortex-A35
>   perf vendors events arm64: Arm Cortex-A55
>   perf vendors events arm64: Arm Cortex-A510
>   perf vendors events arm64: Arm Cortex-A65
>   perf vendors events arm64: Arm Cortex-A73
>   perf vendors events arm64: Arm Cortex-A75
>   perf vendors events arm64: Arm Cortex-A77
>   perf vendors events arm64: Arm Cortex-A78
>   perf vendors events arm64: Arm Cortex-A710
>   perf vendors events arm64: Arm Cortex-X1
>   perf vendors events arm64: Arm Cortex-X2
>   perf vendors events arm64: Arm Neoverse E1
> 
>  .../arch/arm64/arm/cortex-a15/branch.json     |  17 ++
>  .../arch/arm64/arm/cortex-a15/bus.json        |  29 +++
>  .../arch/arm64/arm/cortex-a15/cache.json      |  80 ++++++
>  .../arch/arm64/arm/cortex-a15/exception.json  |   8 +
>  .../arm64/arm/cortex-a15/instruction.json     |  59 +++++
>  .../arch/arm64/arm/cortex-a15/memory.json     |  20 ++
>  .../arch/arm64/arm/cortex-a17/branch.json     |  17 ++
>  .../arch/arm64/arm/cortex-a17/bus.json        |  26 ++
>  .../arch/arm64/arm/cortex-a17/cache.json      |  53 ++++
>  .../arch/arm64/arm/cortex-a17/exception.json  |  11 +
>  .../arm64/arm/cortex-a17/instruction.json     |  56 +++++
>  .../arch/arm64/arm/cortex-a17/memory.json     |  20 ++
>  .../arch/arm64/arm/cortex-a32/branch.json     |  11 +
>  .../arch/arm64/arm/cortex-a32/bus.json        |  17 ++
>  .../arch/arm64/arm/cortex-a32/cache.json      |  32 +++
>  .../arch/arm64/arm/cortex-a32/exception.json  |  14 ++
>  .../arm64/arm/cortex-a32/instruction.json     |  29 +++
>  .../arch/arm64/arm/cortex-a32/memory.json     |   8 +
>  .../arch/arm64/arm/cortex-a34/branch.json     |  11 +
>  .../arch/arm64/arm/cortex-a34/bus.json        |  17 ++
>  .../arch/arm64/arm/cortex-a34/cache.json      |  32 +++
>  .../arch/arm64/arm/cortex-a34/exception.json  |  14 ++
>  .../arm64/arm/cortex-a34/instruction.json     |  29 +++
>  .../arch/arm64/arm/cortex-a34/memory.json     |   8 +
>  .../arch/arm64/arm/cortex-a35/branch.json     |  11 +
>  .../arch/arm64/arm/cortex-a35/bus.json        |  17 ++
>  .../arch/arm64/arm/cortex-a35/cache.json      |  32 +++
>  .../arch/arm64/arm/cortex-a35/exception.json  |  14 ++
>  .../arm64/arm/cortex-a35/instruction.json     |  44 ++++
>  .../arch/arm64/arm/cortex-a35/memory.json     |   8 +
>  .../arch/arm64/arm/cortex-a5/branch.json      |   8 +
>  .../arch/arm64/arm/cortex-a5/cache.json       |  23 ++
>  .../arch/arm64/arm/cortex-a5/exception.json   |  11 +
>  .../arch/arm64/arm/cortex-a5/instruction.json |  29 +++
>  .../arch/arm64/arm/cortex-a5/memory.json      |   8 +
>  .../arch/arm64/arm/cortex-a510/branch.json    |  59 +++++
>  .../arch/arm64/arm/cortex-a510/bus.json       |  17 ++
>  .../arch/arm64/arm/cortex-a510/cache.json     | 182 ++++++++++++++
>  .../arch/arm64/arm/cortex-a510/exception.json |  14 ++
>  .../arm64/arm/cortex-a510/instruction.json    |  95 +++++++
>  .../arch/arm64/arm/cortex-a510/memory.json    |  32 +++
>  .../arch/arm64/arm/cortex-a510/pipeline.json  | 107 ++++++++
>  .../arch/arm64/arm/cortex-a510/pmu.json       |   8 +
>  .../arch/arm64/arm/cortex-a510/trace.json     |  32 +++
>  .../arch/arm64/arm/cortex-a55/branch.json     |  59 +++++
>  .../arch/arm64/arm/cortex-a55/bus.json        |  17 ++
>  .../arch/arm64/arm/cortex-a55/cache.json      | 188 ++++++++++++++
>  .../arch/arm64/arm/cortex-a55/exception.json  |  20 ++
>  .../arm64/arm/cortex-a55/instruction.json     |  65 +++++
>  .../arch/arm64/arm/cortex-a55/memory.json     |  17 ++
>  .../arch/arm64/arm/cortex-a55/pipeline.json   |  80 ++++++
>  .../arch/arm64/arm/cortex-a65/branch.json     |  17 ++
>  .../arch/arm64/arm/cortex-a65/bus.json        |  17 ++
>  .../arch/arm64/arm/cortex-a65/cache.json      | 236 ++++++++++++++++++
>  .../arch/arm64/arm/cortex-a65/dpu.json        |  32 +++
>  .../arch/arm64/arm/cortex-a65/exception.json  |  14 ++
>  .../arch/arm64/arm/cortex-a65/ifu.json        | 122 +++++++++
>  .../arm64/arm/cortex-a65/instruction.json     |  71 ++++++
>  .../arch/arm64/arm/cortex-a65/memory.json     |  35 +++
>  .../arch/arm64/arm/cortex-a65/pipeline.json   |   8 +
>  .../arch/arm64/arm/cortex-a7/branch.json      |   8 +
>  .../arch/arm64/arm/cortex-a7/bus.json         |  17 ++
>  .../arch/arm64/arm/cortex-a7/cache.json       |  32 +++
>  .../arch/arm64/arm/cortex-a7/exception.json   |  11 +
>  .../arch/arm64/arm/cortex-a7/instruction.json |  29 +++
>  .../arch/arm64/arm/cortex-a7/memory.json      |   8 +
>  .../arch/arm64/arm/cortex-a710/branch.json    |  17 ++
>  .../arch/arm64/arm/cortex-a710/bus.json       |  20 ++
>  .../arch/arm64/arm/cortex-a710/cache.json     | 155 ++++++++++++
>  .../arch/arm64/arm/cortex-a710/exception.json |  47 ++++
>  .../arm64/arm/cortex-a710/instruction.json    | 134 ++++++++++
>  .../arch/arm64/arm/cortex-a710/memory.json    |  41 +++
>  .../arch/arm64/arm/cortex-a710/pipeline.json  |  23 ++
>  .../arch/arm64/arm/cortex-a710/trace.json     |  29 +++
>  .../arch/arm64/arm/cortex-a73/branch.json     |  11 +
>  .../arch/arm64/arm/cortex-a73/bus.json        |  23 ++
>  .../arch/arm64/arm/cortex-a73/cache.json      | 107 ++++++++
>  .../arch/arm64/arm/cortex-a73/etm.json        |  14 ++
>  .../arch/arm64/arm/cortex-a73/exception.json  |  14 ++
>  .../arm64/arm/cortex-a73/instruction.json     |  65 +++++
>  .../arch/arm64/arm/cortex-a73/memory.json     |  14 ++
>  .../arch/arm64/arm/cortex-a73/mmu.json        |  44 ++++
>  .../arch/arm64/arm/cortex-a73/pipeline.json   |  38 +++
>  .../arch/arm64/arm/cortex-a75/branch.json     |  11 +
>  .../arch/arm64/arm/cortex-a75/bus.json        |  17 ++
>  .../arch/arm64/arm/cortex-a75/cache.json      | 164 ++++++++++++
>  .../arch/arm64/arm/cortex-a75/etm.json        |  14 ++
>  .../arch/arm64/arm/cortex-a75/exception.json  |  17 ++
>  .../arm64/arm/cortex-a75/instruction.json     |  74 ++++++
>  .../arch/arm64/arm/cortex-a75/memory.json     |  17 ++
>  .../arch/arm64/arm/cortex-a75/mmu.json        |  44 ++++
>  .../arch/arm64/arm/cortex-a75/pipeline.json   |  44 ++++
>  .../arch/arm64/arm/cortex-a77/branch.json     |  17 ++
>  .../arch/arm64/arm/cortex-a77/bus.json        |  17 ++
>  .../arch/arm64/arm/cortex-a77/cache.json      | 143 +++++++++++
>  .../arch/arm64/arm/cortex-a77/exception.json  |  47 ++++
>  .../arm64/arm/cortex-a77/instruction.json     |  77 ++++++
>  .../arch/arm64/arm/cortex-a77/memory.json     |  23 ++
>  .../arch/arm64/arm/cortex-a77/pipeline.json   |   8 +
>  .../arch/arm64/arm/cortex-a78/branch.json     |  17 ++
>  .../arch/arm64/arm/cortex-a78/bus.json        |  20 ++
>  .../arch/arm64/arm/cortex-a78/cache.json      | 155 ++++++++++++
>  .../arch/arm64/arm/cortex-a78/exception.json  |  47 ++++
>  .../arm64/arm/cortex-a78/instruction.json     |  80 ++++++
>  .../arch/arm64/arm/cortex-a78/memory.json     |  23 ++
>  .../arch/arm64/arm/cortex-a78/pipeline.json   |  23 ++
>  .../arch/arm64/arm/cortex-a8/branch.json      |   8 +
>  .../arch/arm64/arm/cortex-a8/cache.json       |  77 ++++++
>  .../arch/arm64/arm/cortex-a8/exception.json   |   5 +
>  .../arch/arm64/arm/cortex-a8/instruction.json |  38 +++
>  .../arch/arm64/arm/cortex-a8/memory.json      |   5 +
>  .../arch/arm64/arm/cortex-a9/branch.json      |   8 +
>  .../arch/arm64/arm/cortex-a9/cache.json       |  17 ++
>  .../arch/arm64/arm/cortex-a9/exception.json   |   5 +
>  .../arch/arm64/arm/cortex-a9/instruction.json |  29 +++
>  .../arch/arm64/arm/cortex-a9/memory.json      |   5 +
>  .../arch/arm64/arm/cortex-x1/branch.json      |  17 ++
>  .../arch/arm64/arm/cortex-x1/bus.json         |  20 ++
>  .../arch/arm64/arm/cortex-x1/cache.json       | 155 ++++++++++++
>  .../arch/arm64/arm/cortex-x1/exception.json   |  47 ++++
>  .../arch/arm64/arm/cortex-x1/instruction.json |  80 ++++++
>  .../arch/arm64/arm/cortex-x1/memory.json      |  23 ++
>  .../arch/arm64/arm/cortex-x1/pipeline.json    |  23 ++
>  .../arch/arm64/arm/cortex-x2/branch.json      |  17 ++
>  .../arch/arm64/arm/cortex-x2/bus.json         |  20 ++
>  .../arch/arm64/arm/cortex-x2/cache.json       | 155 ++++++++++++
>  .../arch/arm64/arm/cortex-x2/exception.json   |  47 ++++
>  .../arch/arm64/arm/cortex-x2/instruction.json | 134 ++++++++++
>  .../arch/arm64/arm/cortex-x2/memory.json      |  41 +++
>  .../arch/arm64/arm/cortex-x2/pipeline.json    |  23 ++
>  .../arch/arm64/arm/cortex-x2/trace.json       |  29 +++
>  .../arch/arm64/arm/neoverse-e1/branch.json    |  17 ++
>  .../arch/arm64/arm/neoverse-e1/bus.json       |  17 ++
>  .../arch/arm64/arm/neoverse-e1/cache.json     | 107 ++++++++
>  .../arch/arm64/arm/neoverse-e1/exception.json |  14 ++
>  .../arm64/arm/neoverse-e1/instruction.json    |  65 +++++
>  .../arch/arm64/arm/neoverse-e1/memory.json    |  23 ++
>  .../arch/arm64/arm/neoverse-e1/pipeline.json  |   8 +
>  .../arch/arm64/arm/neoverse-e1/spe.json       |  14 ++
>  .../arch/arm64/common-and-microarch.json      |  66 +++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |  20 ++
>  141 files changed, 5746 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a17/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/trace.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a8/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a9/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/trace.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
> 
> -- 
> 2.25.1

-- 

- Arnaldo
