Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C05310C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiEWNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiEWNQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C97CC2;
        Mon, 23 May 2022 06:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDD761353;
        Mon, 23 May 2022 13:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1350EC385A9;
        Mon, 23 May 2022 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311761;
        bh=DChpO1K/BOvk8A0z5ckknPp3sJ3pHmYvfwFYxZCP2Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAFjnmangS7S+JYemF+kdvXnNDMfMeF4nKxkxJesxcP56bHz7UQFNxLM6FIeDVUxT
         +oEDP+kcWiLPE9wXJ4+ND2qMbOpd2pVzVCapWOCJ3MzxV9zr1bX+HRKTTL97exV3b9
         sLAlNrS/SaMRsU6wTwEsHT5/OqVPZIh8w5PnuNGLK5WpFb7stSS7OuBHB1JvEP5K5Z
         4gYSFfFTpnUa63u8qz9ALi6oH1EjnP/HV1H+YSAdYTFi7PRK0PW36Z1PUAFIpUS/js
         aTa/56bSFWbc0sxZ8iHdpofPywHgwXkAo0Db7ny1iSaexI1WDDEnIt6STspgbIKUd4
         j7HPKat/+FwrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B4B4400B1; Mon, 23 May 2022 10:15:58 -0300 (-03)
Date:   Mon, 23 May 2022 10:15:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/13] perf vendors events arm64: Multiple Arm CPUs
Message-ID: <YouJDhyKYmRBO0hl@kernel.org>
References: <20220520181455.340344-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520181455.340344-1-nick.forrington@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 20, 2022 at 07:14:42PM +0100, Nick Forrington escreveu:
> Add Performance Monitoring Unit event data for the Arm CPUs listed
> below.
> 
> Changesets are dependent due to incremental updates to the common events
> file and mapfile.csv.
> 
> Data is sourced from https://github.com/ARM-software/data
> 
> Changes since v1:
> * No longer includes AArch32-only CPUs [1]. (Subsequent patch contents
> * unchanged)

Thanks, applied.

- Arnaldo

 
> [1]: https://lore.kernel.org/all/2d73146a-86fc-e0d1-11b9-432c7431d58a@huawei.com/
> 
> Nick Forrington (13):
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
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |  13 +
>  102 files changed, 4851 insertions(+)
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
