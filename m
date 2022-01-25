Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1B49BD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiAYVAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:00:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:39742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbiAYVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643144406; x=1674680406;
  h=from:to:cc:subject:date:message-id;
  bh=pjTMruYt8HNvr0EyVE1x+4FwecPYZSosdVWLs51Ftso=;
  b=ij6sQc8icNHzz1WQL84qsvzVU3pr2BCbzxkZdb/qvakhutqev73YyhSC
   J4xrM0S76w9YF29XOZLjohmVSTDp4EyBy2paZQ7CVAefA14PjmI+4SQqM
   GYn4lOL3gCub8G/9zBv9vSUr0XUKAqY7K+j8fvxy/xo/KPDAVCLDLObbo
   lsybtWv1Q7X4eDt7empP98tNCaB0bA0juBbhQ3i5TR/uT5wUfWPW0g6QJ
   U8nKXOx8mBXh9NFijG+y0/IlHIHQcdIid+Eb/cunHF/wO/XQ0K8k+0iVw
   1jTfoLGy9D9XB9PMKUpB13wFOgFwZVMxIUG+ikNx0zrryc9Fq8jW49/rq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244013710"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="244013710"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 13:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520545792"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 13:00:06 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf/x86: Add Intel Raptor Lake support
Date:   Tue, 25 Jan 2022 15:57:48 -0800
Message-Id: <1643155071-98900-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, Raptor Lake is the same as the Alder Lake. The
only difference is the event list, which will be supported in the perf
tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c914340..46ac451 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6178,6 +6178,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
-- 
2.7.4

