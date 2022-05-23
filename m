Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81146530AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiEWHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiEWHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:50:17 -0400
Received: from xppmailspam11.itap.purdue.edu (xppmailspam11.itap.purdue.edu [128.210.1.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C096356
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:50:04 -0700 (PDT)
IronPort-SDR: nnbxmAp3WC2w9hxp4UzB735Hd5mv9U4/fEVDZqIBp1zykMV6eu9D2T+Z0TZmNWhqWva1O872n1
 qEDrSkFFmUof2e5AvFAqgO4Fm64vuOOOY=
X-Ironport-AuthID: liu3101@purdue.edu
IronPort-Data: =?us-ascii?q?A9a23=3ASeMQq6MmfktlJivvrR2Nl8FynXyQoLVcMsEvi?=
 =?us-ascii?q?/4bfWQNrUolhmEEyjMYWG+CaPyKN2Hwfoh+OYnlp0wBuJSExtI1QHM5pCpnJ?=
 =?us-ascii?q?55oRWspJjg7wn8dt0p+F+WbJK6+x8lBONTGMu4uSXrQ+kWkPrT79CEuzbySS?=
 =?us-ascii?q?qfxTuPIJ3kpFwNjTS4gjzNlmvI43t4z2ITpU1vVtIOgudDbNX+kxyVwbjAe5?=
 =?us-ascii?q?ZWFpU49p//1oj4Z4gEzaKkT7l/TnnUYFrwFIqS1IyeqS4VYBLfiFf7e1r2k8?=
 =?us-ascii?q?yXU8wp0UoGplbPyc0srRL/OPFTe0SMKC/j62hUb/348yKc2MvYYeHx7sTTRk?=
 =?us-ascii?q?oAj0shJuLyxVRwtYv/GltMbXkQKCCp5J6BHpOLKLHXj48yey0rKLynlz/l0V?=
 =?us-ascii?q?hlkPIsU674qR2pVs+QFMjwQY1aOi//vmOC3Texlh8ICKsj3Pd9P4Sg8nWGBV?=
 =?us-ascii?q?ft2E4reR6jq5MND2GtijM55G/uDNdESbiBibUidbhATaE0bDokywLWhinXlK?=
 =?us-ascii?q?WUKqVSZtPJqpWPIihRsyrTwPZzYdsHTHZdZmUORp2Tn+WXlA01Kb4XDmWrdq?=
 =?us-ascii?q?n/81PXSmS7bWZ4JEOHq/PBdhlDOlHcYDwcbVAfmrPS04qJktwmzEGRJvHt3x?=
 =?us-ascii?q?UQO3BbzFIOlAkfi+CTsUiM0ArK8LcVrsGlh9YKLu251NkBcJtJwQIROWP0eH?=
 =?us-ascii?q?FTG5XfV9z/dPgGDhZXOIZ6r3urO8WniaXB9wVgqPkfoRSNdizXqTRpaYhjnF?=
 =?us-ascii?q?r6PG4bt5jH59K2ZL5lncUEDa7svYc4jj81X/HjGhT69/sWPRRVz/hjNUn+oq?=
 =?us-ascii?q?A51eeZJZaTxswidtK4Gdd3BCADf4xDomODHhAwKJZWMiXfUGLwlBKyz6+uId?=
 =?us-ascii?q?jDQnDaDGrF9qW/2oCb/Jdk4DDZWYR0B3tw/UTP3cVLQvh1565hUM3+nK6RwZ?=
 =?us-ascii?q?uqZAsIm16XxFtL7Utjba9NPZt56cwrv1DtpflKd03zFn08rnaQ+ItGca8nEJ?=
 =?us-ascii?q?XMbD6tg5CC7S+cUzfkgwSVW7WDaXpn9ihiqz5KRY3maTboKKlyTdvt/56SBy?=
 =?us-ascii?q?C3R8tBCJ46Jxg9ZXenWfCba68gQIEoMIHx9Aor5w+RTd/PYe1I/MHk8EfPMz?=
 =?us-ascii?q?PUsd5ENokj/vo8k5Vm8XENJkAe5jmaBMRiQZm1uLr7jQP5CQbsAFXREFT6VN?=
 =?us-ascii?q?7ILOO5DNJsiSqY=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AT6cH8q4Ny7Mp8E7PBwPXwHDXdLJyesId70?=
 =?us-ascii?q?hD6qkRc3Nom6Oj5rmTdZggpGfJYXMqNk3I+urtBED/ewK7yXcd2+B4VotKNz?=
 =?us-ascii?q?OKhILHFutfxLqn5DH8FiXi/qp00Kt6buxYANn9ZGIbse/KpC61Dtsp3dHC2q?=
 =?us-ascii?q?Ghnvq29QYPcShaL4Zt8gpwFw7eOEh/XhNHCpoyHIed4M0vnUvERV0nKuO2G3?=
 =?us-ascii?q?QMQuCGiNXOlJf3CCR2ZSIP2U2ogS6k4KPzVzmfxAp2aUIq/Z4StU/IjgHw+6?=
 =?us-ascii?q?3miPe/xnbnpgjuxqUTv9f9x9NfDIi3htcYMTXwmm+TBbhcZw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,245,1647316800"; 
   d="scan'208";a="463330401"
Received: from indy05.cs.purdue.edu ([128.10.130.167])
  by xppmailspam11.itap.purdue.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 02:30:58 -0400
From:   Congyu Liu <liu3101@purdue.edu>
To:     dvyukov@google.com, andreyknvl@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Congyu Liu <liu3101@purdue.edu>
Subject: [PATCH] tracing: disable kcov on trace_preemptirq.c
Date:   Mon, 23 May 2022 06:30:33 +0000
Message-Id: <20220523063033.1778974-1-liu3101@purdue.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions in trace_preemptirq.c could be invoked from early interrupt
code that bypasses kcov trace function's in_task() check. Disable kcov
on this file to reduce random code coverage.

Signed-off-by: Congyu Liu <liu3101@purdue.edu>
---
 kernel/trace/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index d77cd8032213..0d261774d6f3 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -31,6 +31,10 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
 
+# Functions in this file could be invoked from early interrupt
+# code and produce random code coverage.
+KCOV_INSTRUMENT_trace_preemptirq.o := n
+
 CFLAGS_bpf_trace.o := -I$(src)
 
 CFLAGS_trace_benchmark.o := -I$(src)
-- 
2.34.1

