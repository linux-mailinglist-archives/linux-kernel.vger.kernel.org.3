Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DEF51AE3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377747AbiEDTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377712AbiEDTsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:48:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F54ECEB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651693462; x=1683229462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WTb5GC+wtPQKXwhntbHeXjD55i7eY2G1j7J+D3En11o=;
  b=fulYl6x+es3j24QoIWg4lrfJjDRPEPyYSZgz0XlTN2dwgAJrR4MXKb6m
   PCz4CysYPyvkQXRHqF5ztDfnHfVefrOOIpJd2z1YVmvQ234jooovrFkKn
   KSESKC5FpuR2gQY4jqLxEumb8QlAzGN81xpU9WVjK14ZhY31EXTuymJ+Z
   9vcW3xZ0DrMFR3OgP+XVpRQrGNP9vuZTrTeRJug71L4dRxBryvdM7WroY
   6ZgY2+aOW7QU4LSxaIzhh60XR2njBCnahjgH7Up17aC9B+QEQP/FiK2Eg
   ZQ36r3Xm/PmkQ8A8elKIJZ8BGJI3HhxIvSTECT3cCac9/m/Ibme7GtEZV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248416188"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="248416188"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 12:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="549003456"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2022 12:44:21 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/5] perf/x86: Add new Alder Lake and Raptor Lake support
Date:   Wed,  4 May 2022 12:44:09 -0700
Message-Id: <20220504194413.1003071-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, there is no difference for the new Alder Lake N
and Raptor Lake P.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fc7f458eb3de..955ae91c56dc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6216,7 +6216,9 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
+	case INTEL_FAM6_RAPTORLAKE_P:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
-- 
2.35.1

