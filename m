Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB614DA195
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350742AbiCORwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350696AbiCORwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:52:37 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650065130A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647366685; x=1678902685;
  h=from:to:cc:subject:date:message-id;
  bh=ieGZVhI/VzY48Bcfet0/X/Fgn6U47WZ9MOR+fcSYFxE=;
  b=lR7c8dYn+e8uGeTwJEe0W3fghwGui+DESS4AQ5pzlQb7QnNyPBig4+8N
   6jXFRCdWHfBdUhG7eI0Tvb06dmFTNxFphjQxfUPHJV1aJQTwoLIG+c9eX
   wkoUH56S+HwSD/pDMw2t3l+91amTTwp0RN5h9B4qk0ehGLljFhZMuXovi
   p8RabhY9A+P8b3CdQAvz7kxlpD+nx3DFMAsz0Xj+t5QDL1nEmsczO2paP
   ZDZaqxu+aUA+idrv40JaUGq8L7NgAPFvY2He+jqF/2fyPEaMyNxmuVBh7
   RjkQ4mrP2UucpS/ZZUqy1Qbg47rfj+9V2UB+ZcX8F0fpg0vB8ZDp47Btl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317106855"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="317106855"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 10:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="613358387"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2022 10:46:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/4] perf/x86: Add Intel Raptor Lake support
Date:   Tue, 15 Mar 2022 10:45:57 -0700
Message-Id: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, Raptor Lake is the same as the Alder Lake. The
only difference is the event list, which will be supported in the perf
tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 88dcfb4..24a4a75 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6199,6 +6199,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
-- 
2.7.4

