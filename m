Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82357E020
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiGVKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiGVKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:38:19 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB3F0BA267;
        Fri, 22 Jul 2022 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qZA/V
        SBXMttJiclEn3xajTp90qDk6AxMWBxPRPF+xvo=; b=hFDJO2JEPI6xzsHZlDWe+
        pg7FRIkNCHsaWjT4EFEpnDJQGT04StiPcLRSdEJmKGyNzLoLniqsBdzsuaOnrF9Z
        DR75RkRoAojms3cv9B7NJkpLvSCzEbcFBS0OysZ6l7BTDi9cEpqv3V9G/VFw1qlB
        JwAAtuQYyKEiKp3Za3E+j0=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp3 (Coremail) with SMTP id G9xpCgA30ZLqfdpiFX2aQg--.5948S2;
        Fri, 22 Jul 2022 18:37:32 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, mike.leach@linaro.org,
        leo.yan@linaro.org, john.garry@huawei.com, will@kernel.org,
        james.clark@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] perf: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:37:28 +0800
Message-Id: <20220722103728.82854-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: G9xpCgA30ZLqfdpiFX2aQg--.5948S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1xJrW7ZryDtF1xCr13CFg_yoWxKrWDpF
        s7CwsIyr1kW3ZYq3Z5Aw4xXw1fu3yxAan8Kw1Sy3y7Zr43Xrn2qFWfKw1Yva47Xws5AFWa
        vws8WryUZFyrCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNjg2dUUUUU=
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJQxGZGAJpKgOWQAAs5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 tools/perf/Documentation/perf-diff.txt                        | 2 +-
 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json     | 2 +-
 tools/perf/util/cs-etm.c                                      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentat=
ion/perf-diff.txt
index be65bd55ab2a..b77957ac288b 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -285,7 +285,7 @@ If specified the 'Weighted diff' column is displayed wi=
th value 'd' computed as:
=20
   - period being the hist entry period value
=20
-  - WEIGHT-A/WEIGHT-B being user supplied weights in the the '-c' option
+  - WEIGHT-A/WEIGHT-B being user supplied weights in the '-c' option
     behind ':' separator like '-c wdiff:1,2'.
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index aa460d0c4851..59ab88de1b37 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -1923,7 +1923,7 @@
         "EventCode": "0x25",
         "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the the receive side (Rx)=
 of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a m=
ode where we disable 60% of the UPI lanes, decreasing our bandwidth in orde=
r to save power.",
+        "PublicDescription": "Counts cycles when the receive side (Rx) of =
the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode =
where we disable 60% of the UPI lanes, decreasing our bandwidth in order to=
 save power.",
         "Unit": "UPI LL"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 03a4c7f26698..3278c7d1654d 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -257,7 +257,7 @@
         "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
-        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the the front-end bandwidth.",
+        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the front-end bandwidth.",
         "SampleAfterValue": "200003",
         "UMask": "0x50"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index aa0f67613c4a..0c96e6924d62 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -1852,7 +1852,7 @@
         "EventCode": "0x25",
         "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the the receive side (Rx)=
 of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a m=
ode where we disable 60% of the UPI lanes, decreasing our bandwidth in orde=
r to save power.",
+        "PublicDescription": "Counts cycles when the receive side (Rx) of =
the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode =
where we disable 60% of the UPI lanes, decreasing our bandwidth in order to=
 save power.",
         "Unit": "UPI LL"
     },
     {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b95fb3c4d7b..16db965ac995 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1451,7 +1451,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * tidq->packet->instr_count represents the number of
 		 * instructions in the current etm packet.
 		 *
-		 * Period instructions (Pi) contains the the number of
+		 * Period instructions (Pi) contains the number of
 		 * instructions executed after the sample point(n) from the
 		 * previous etm packet.  This will always be less than
 		 * etm->instructions_sample_period.
--=20
2.25.1

