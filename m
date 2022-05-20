Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562F352F257
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352510AbiETSPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiETSPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:15:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3024C18FF15;
        Fri, 20 May 2022 11:15:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 875231477;
        Fri, 20 May 2022 11:15:08 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0782E3F718;
        Fri, 20 May 2022 11:15:05 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
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
Subject: [PATCH v2 00/13] perf vendors events arm64: Multiple Arm CPUs
Date:   Fri, 20 May 2022 19:14:42 +0100
Message-Id: <20220520181455.340344-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Performance Monitoring Unit event data for the Arm CPUs listed
below.

Changesets are dependent due to incremental updates to the common events
file and mapfile.csv.

Data is sourced from https://github.com/ARM-software/data

Changes since v1:
* No longer includes AArch32-only CPUs [1]. (Subsequent patch contents
* unchanged)

[1]: https://lore.kernel.org/all/2d73146a-86fc-e0d1-11b9-432c7431d58a@huawei.com/

Nick Forrington (13):
  perf vendors events arm64: Arm Cortex-A34
  perf vendors events arm64: Arm Cortex-A35
  perf vendors events arm64: Arm Cortex-A55
  perf vendors events arm64: Arm Cortex-A510
  perf vendors events arm64: Arm Cortex-A65
  perf vendors events arm64: Arm Cortex-A73
  perf vendors events arm64: Arm Cortex-A75
  perf vendors events arm64: Arm Cortex-A77
  perf vendors events arm64: Arm Cortex-A78
  perf vendors events arm64: Arm Cortex-A710
  perf vendors events arm64: Arm Cortex-X1
  perf vendors events arm64: Arm Cortex-X2
  perf vendors events arm64: Arm Neoverse E1

 .../arch/arm64/arm/cortex-a34/branch.json     |  11 +
 .../arch/arm64/arm/cortex-a34/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a34/cache.json      |  32 +++
 .../arch/arm64/arm/cortex-a34/exception.json  |  14 ++
 .../arm64/arm/cortex-a34/instruction.json     |  29 +++
 .../arch/arm64/arm/cortex-a34/memory.json     |   8 +
 .../arch/arm64/arm/cortex-a35/branch.json     |  11 +
 .../arch/arm64/arm/cortex-a35/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a35/cache.json      |  32 +++
 .../arch/arm64/arm/cortex-a35/exception.json  |  14 ++
 .../arm64/arm/cortex-a35/instruction.json     |  44 ++++
 .../arch/arm64/arm/cortex-a35/memory.json     |   8 +
 .../arch/arm64/arm/cortex-a510/branch.json    |  59 +++++
 .../arch/arm64/arm/cortex-a510/bus.json       |  17 ++
 .../arch/arm64/arm/cortex-a510/cache.json     | 182 ++++++++++++++
 .../arch/arm64/arm/cortex-a510/exception.json |  14 ++
 .../arm64/arm/cortex-a510/instruction.json    |  95 +++++++
 .../arch/arm64/arm/cortex-a510/memory.json    |  32 +++
 .../arch/arm64/arm/cortex-a510/pipeline.json  | 107 ++++++++
 .../arch/arm64/arm/cortex-a510/pmu.json       |   8 +
 .../arch/arm64/arm/cortex-a510/trace.json     |  32 +++
 .../arch/arm64/arm/cortex-a55/branch.json     |  59 +++++
 .../arch/arm64/arm/cortex-a55/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a55/cache.json      | 188 ++++++++++++++
 .../arch/arm64/arm/cortex-a55/exception.json  |  20 ++
 .../arm64/arm/cortex-a55/instruction.json     |  65 +++++
 .../arch/arm64/arm/cortex-a55/memory.json     |  17 ++
 .../arch/arm64/arm/cortex-a55/pipeline.json   |  80 ++++++
 .../arch/arm64/arm/cortex-a65/branch.json     |  17 ++
 .../arch/arm64/arm/cortex-a65/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a65/cache.json      | 236 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a65/dpu.json        |  32 +++
 .../arch/arm64/arm/cortex-a65/exception.json  |  14 ++
 .../arch/arm64/arm/cortex-a65/ifu.json        | 122 +++++++++
 .../arm64/arm/cortex-a65/instruction.json     |  71 ++++++
 .../arch/arm64/arm/cortex-a65/memory.json     |  35 +++
 .../arch/arm64/arm/cortex-a65/pipeline.json   |   8 +
 .../arch/arm64/arm/cortex-a710/branch.json    |  17 ++
 .../arch/arm64/arm/cortex-a710/bus.json       |  20 ++
 .../arch/arm64/arm/cortex-a710/cache.json     | 155 ++++++++++++
 .../arch/arm64/arm/cortex-a710/exception.json |  47 ++++
 .../arm64/arm/cortex-a710/instruction.json    | 134 ++++++++++
 .../arch/arm64/arm/cortex-a710/memory.json    |  41 +++
 .../arch/arm64/arm/cortex-a710/pipeline.json  |  23 ++
 .../arch/arm64/arm/cortex-a710/trace.json     |  29 +++
 .../arch/arm64/arm/cortex-a73/branch.json     |  11 +
 .../arch/arm64/arm/cortex-a73/bus.json        |  23 ++
 .../arch/arm64/arm/cortex-a73/cache.json      | 107 ++++++++
 .../arch/arm64/arm/cortex-a73/etm.json        |  14 ++
 .../arch/arm64/arm/cortex-a73/exception.json  |  14 ++
 .../arm64/arm/cortex-a73/instruction.json     |  65 +++++
 .../arch/arm64/arm/cortex-a73/memory.json     |  14 ++
 .../arch/arm64/arm/cortex-a73/mmu.json        |  44 ++++
 .../arch/arm64/arm/cortex-a73/pipeline.json   |  38 +++
 .../arch/arm64/arm/cortex-a75/branch.json     |  11 +
 .../arch/arm64/arm/cortex-a75/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a75/cache.json      | 164 ++++++++++++
 .../arch/arm64/arm/cortex-a75/etm.json        |  14 ++
 .../arch/arm64/arm/cortex-a75/exception.json  |  17 ++
 .../arm64/arm/cortex-a75/instruction.json     |  74 ++++++
 .../arch/arm64/arm/cortex-a75/memory.json     |  17 ++
 .../arch/arm64/arm/cortex-a75/mmu.json        |  44 ++++
 .../arch/arm64/arm/cortex-a75/pipeline.json   |  44 ++++
 .../arch/arm64/arm/cortex-a77/branch.json     |  17 ++
 .../arch/arm64/arm/cortex-a77/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a77/cache.json      | 143 +++++++++++
 .../arch/arm64/arm/cortex-a77/exception.json  |  47 ++++
 .../arm64/arm/cortex-a77/instruction.json     |  77 ++++++
 .../arch/arm64/arm/cortex-a77/memory.json     |  23 ++
 .../arch/arm64/arm/cortex-a77/pipeline.json   |   8 +
 .../arch/arm64/arm/cortex-a78/branch.json     |  17 ++
 .../arch/arm64/arm/cortex-a78/bus.json        |  20 ++
 .../arch/arm64/arm/cortex-a78/cache.json      | 155 ++++++++++++
 .../arch/arm64/arm/cortex-a78/exception.json  |  47 ++++
 .../arm64/arm/cortex-a78/instruction.json     |  80 ++++++
 .../arch/arm64/arm/cortex-a78/memory.json     |  23 ++
 .../arch/arm64/arm/cortex-a78/pipeline.json   |  23 ++
 .../arch/arm64/arm/cortex-x1/branch.json      |  17 ++
 .../arch/arm64/arm/cortex-x1/bus.json         |  20 ++
 .../arch/arm64/arm/cortex-x1/cache.json       | 155 ++++++++++++
 .../arch/arm64/arm/cortex-x1/exception.json   |  47 ++++
 .../arch/arm64/arm/cortex-x1/instruction.json |  80 ++++++
 .../arch/arm64/arm/cortex-x1/memory.json      |  23 ++
 .../arch/arm64/arm/cortex-x1/pipeline.json    |  23 ++
 .../arch/arm64/arm/cortex-x2/branch.json      |  17 ++
 .../arch/arm64/arm/cortex-x2/bus.json         |  20 ++
 .../arch/arm64/arm/cortex-x2/cache.json       | 155 ++++++++++++
 .../arch/arm64/arm/cortex-x2/exception.json   |  47 ++++
 .../arch/arm64/arm/cortex-x2/instruction.json | 134 ++++++++++
 .../arch/arm64/arm/cortex-x2/memory.json      |  41 +++
 .../arch/arm64/arm/cortex-x2/pipeline.json    |  23 ++
 .../arch/arm64/arm/cortex-x2/trace.json       |  29 +++
 .../arch/arm64/arm/neoverse-e1/branch.json    |  17 ++
 .../arch/arm64/arm/neoverse-e1/bus.json       |  17 ++
 .../arch/arm64/arm/neoverse-e1/cache.json     | 107 ++++++++
 .../arch/arm64/arm/neoverse-e1/exception.json |  14 ++
 .../arm64/arm/neoverse-e1/instruction.json    |  65 +++++
 .../arch/arm64/arm/neoverse-e1/memory.json    |  23 ++
 .../arch/arm64/arm/neoverse-e1/pipeline.json  |   8 +
 .../arch/arm64/arm/neoverse-e1/spe.json       |  14 ++
 .../arch/arm64/common-and-microarch.json      |  66 +++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  13 +
 102 files changed, 4851 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json

-- 
2.25.1

