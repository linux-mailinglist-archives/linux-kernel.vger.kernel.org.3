Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F548D4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiAMJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:11:22 -0500
Received: from foss.arm.com ([217.140.110.172]:41440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233796AbiAMJLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:11:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE7D06D;
        Thu, 13 Jan 2022 01:11:18 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.35.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B9413F766;
        Thu, 13 Jan 2022 01:11:16 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        mike.leach@linaro.org
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 4/6] Documentation: coresight: Turn numbered subsections into real subsections
Date:   Thu, 13 Jan 2022 09:10:53 +0000
Message-Id: <20220113091056.1297982-5-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220113091056.1297982-1-james.clark@arm.com>
References: <20220113091056.1297982-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to allow them to be referenced in a later commit. There was
also a mistake where sysFS was introduced as section 2, but numbered
as section 1. And vice versa for 'Using perf framework'. This can't
happen with unnumbered sections.

Signed-off-by: James Clark <james.clark@arm.com>
---
 Documentation/trace/coresight/coresight.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index a15571d96cc8..db66ff45ff4c 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -339,7 +339,8 @@ Preference is given to the former as using the sysFS interface
 requires a deep understanding of the Coresight HW.  The following sections
 provide details on using both methods.
 
-1) Using the sysFS interface:
+Using the sysFS interface
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Before trace collection can start, a coresight sink needs to be identified.
 There is no limit on the amount of sinks (nor sources) that can be enabled at
@@ -446,7 +447,8 @@ wealth of possibilities that coresight provides.
     Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
     Timestamp                                       Timestamp: 17107041535
 
-2) Using perf framework:
+Using perf framework
+~~~~~~~~~~~~~~~~~~~~
 
 Coresight tracers are represented using the Perf framework's Performance
 Monitoring Unit (PMU) abstraction.  As such the perf framework takes charge of
@@ -495,7 +497,11 @@ More information on the above and other example on how to use Coresight with
 the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
 repository [#third]_.
 
-2.1) AutoFDO analysis using the perf tools:
+Advanced perf framework usage
+-----------------------------
+
+AutoFDO analysis using the perf tools
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 perf can be used to record and analyze trace of programs.
 
@@ -513,7 +519,8 @@ The --itrace option controls the type and frequency of synthesized events
 Note that only 64-bit programs are currently supported - further work is
 required to support instruction decode of 32-bit Arm programs.
 
-2.2) Tracing PID
+Tracing PID
+~~~~~~~~~~~
 
 The kernel can be built to write the PID value into the PE ContextID registers.
 For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.  A PE may
@@ -547,7 +554,7 @@ wants to trace PIDs for both host and guest, the two configs "contextid1" and
 
 
 Generating coverage files for Feedback Directed Optimization: AutoFDO
----------------------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 'perf inject' accepts the --itrace option in which case tracing data is
 removed and replaced with the synthesized events. e.g.
-- 
2.28.0

