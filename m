Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5044359EDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiHWVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiHWVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:01:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0971E7E838
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661288510; x=1692824510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+ChPF7qdSV5GBDSnQpAfoD+W29jGyOYLG91l5gHBPyY=;
  b=WWNYKxCKEgedqk/3vMRTUdSpTqVEBrkFkCPcPUvyofCuRxHrUJ91SiyT
   /eHIC+vYLiHKvzamkhqXUBxv5u6gn7vrP2JYTjhxtpMlUV/clcLIoHa3k
   rNms+ZzU07EZ1FKT819Z71yy4PCyK1gne4WIgpQ/fCMDNMosBhVL+Dl5R
   v466sVVoUJ/7UtCOKzJkbc0zgaGuR5k4TDxn1lWOC7mia8ybbI6aFAzRU
   UAvwkjkfiHEQEwHLoIrr4gx27xpCM10Wn+hGdG92iMsaIRENujXY3YomK
   msoXOlvrJRX3wpy4vi/BygT/pAfLmCUI+avLEZy7QiRsBUU6n7/N0l74S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357769296"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="357769296"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="698812588"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2022 14:01:48 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf/x86: Add new Raptor Lake S support
Date:   Tue, 23 Aug 2022 14:01:26 -0700
Message-Id: <20220823210129.979394-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From the PMU's perspective, the new Raptor Lake S is the same as the
other {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The series must be on top of commit ea902bcc1943 ("x86/cpu: Add new
Raptor Lake CPU model number")

 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db93498ff71..3b21f068fcce 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6321,6 +6321,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
-- 
2.35.1

