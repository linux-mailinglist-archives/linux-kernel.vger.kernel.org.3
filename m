Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4F52A40C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348200AbiEQN7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348126AbiEQN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:58:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEEBA3C4B4;
        Tue, 17 May 2022 06:58:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AF991042;
        Tue, 17 May 2022 06:58:15 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C14B3F718;
        Tue, 17 May 2022 06:58:12 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
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
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/1] perf vendors events arm64: Update Cortex A57/A72
Date:   Tue, 17 May 2022 14:58:04 +0100
Message-Id: <20220517135805.313184-1-nick.forrington@arm.com>
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

Update Perf PMU events for Cortex-A57 and Cortex-A72 CPUs.

This adds missing events to existing event data, and splits events in to
separate files/groups for categorisation.

This improves consistency with recently submitted events for Cortex-A
CPUs:
https://lore.kernel.org/lkml/61141530-7d4a-ed6a-f8b7-933bd550f3c2@arm.com/

(This should be independent of above patches as no mapfile / common
event updates are required)

Nick Forrington (1):
  perf vendors events arm64: Update Cortex A57/A72

 .../arch/arm64/arm/cortex-a57-a72/branch.json |  17 ++
 .../arch/arm64/arm/cortex-a57-a72/bus.json    |  29 +++
 .../arch/arm64/arm/cortex-a57-a72/cache.json  |  80 ++++++++
 .../arm/cortex-a57-a72/core-imp-def.json      | 179 ------------------
 .../arm64/arm/cortex-a57-a72/exception.json   |  47 +++++
 .../arm64/arm/cortex-a57-a72/instruction.json |  68 +++++++
 .../arch/arm64/arm/cortex-a57-a72/memory.json |  20 ++
 7 files changed, 261 insertions(+), 179 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json

-- 
2.25.1

