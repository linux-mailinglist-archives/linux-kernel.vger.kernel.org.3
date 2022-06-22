Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD4555335
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377679AbiFVSSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377624AbiFVSRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:17:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12F03EAB7;
        Wed, 22 Jun 2022 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655921866; x=1687457866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4w+G98hAtmvimBUATH9wqRh6U1vIpTCGqGsLMHPPA8=;
  b=Oj9D0QUl6rs4FhNfkJUXZY9qCuh2WiaP7YwLyVVZyZ7UJdnpeuKdj/KO
   cnucczxzO3o4JB/+Pof1Vxf4R7rd3NwF2V/0GQuPhCHGtf9t3iQ0q3JvV
   1PZJ6P+Vgu3HXZrzCoiNrFQhmN+mwN3DEzuhbXwi3Vnk4hjFA6idkkaIx
   tbDTT7BTeVY5ZZppx5juIXTQzg1cUEZG9psgT9C2RN+fcRK3WjcISH39T
   25DbS+JcvUTQ23CCyfyPBVCWz8mImgHi1CLv9onuhCe34xMzzvBcM/Rba
   S7c5XFhqgPuR8u8fDi8+5d8xuw5lLyxNIsd7SGIi+Y9sFUoA1VtUz6y1N
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260319692"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260319692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592301764"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2022 10:53:41 -0700
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.39.82])
        by linux.intel.com (Postfix) with ESMTP id 1ED8F580A31;
        Wed, 22 Jun 2022 10:53:41 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH v2] platform/x86: intel/pmc: Add Alder Lake N support to PMC core driver
Date:   Wed, 22 Jun 2022 10:53:31 -0700
Message-Id: <20220622175331.2520187-1-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alder Lake N (ADL-N) to the list of the platforms that Intel's
PMC core driver supports. Alder Lake N reuses all the TigerLake PCH IPs.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
Changes since v1:
Fixed a typo pointed out by Rajneesh.

 drivers/platform/x86/intel/pmc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 40183bda7894..a1fe1e0dcf4a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1911,6 +1911,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
 	{}

base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.25.1

