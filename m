Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403385316E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbiEWSSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245307AbiEWSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:13:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B673576;
        Mon, 23 May 2022 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653328367; x=1684864367;
  h=from:to:cc:subject:date:message-id;
  bh=1iQx1L/TO5Z4oYL5mBV1IfDTUFqDyGqi52S1H9V4NhY=;
  b=UxY+c1OmfLzUCzW5vY0ffXxzGFnW8YnfN9WWDVN43sjtOT2vcoV0fL+B
   /SifPdslz7hrZMfJ0jPwGlTcM6wgt44OvVJYhQcS4fcMQSX9ikq97tBgy
   Vnf8/JEifjGjMzJCfdbKGTeu4ZW14EBMfP4VD7nFXPd7JJzxcYhqqrkSC
   Xy9pTsTEkldYulAhh79x8hwwTRu9jT98TWuProwixCdT4Ak2aRV+6PHBU
   xxp0GYmiEcB5YhEJbRVAQicBZ8y641Y4DoJbUWmYCmU1RPoRI9sOQn0xs
   olSrRFXccp3JvQaOvQ+7f+2CW5pMFS+nA3V2WC65wyyO0pzjpOkz3eRrC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="333950461"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="333950461"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="663550897"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by FMSMGA003.fm.intel.com with ESMTP; 23 May 2022 10:49:20 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, lenb@kernel.org,
        srinivas.pandruvada@linux.intel.com, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH v2] ACPI: DPTF: Support Meteor Lake
Date:   Mon, 23 May 2022 23:16:30 +0530
Message-Id: <20220523174630.30657-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Meteor Lake ACPI IDs for DPTF devices.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2: Replaced Signed-off-by with Reviewed-by as per comment from
    Srinivas Pandruvada.
---
 drivers/acpi/dptf/dptf_pch_fivr.c                       | 1 +
 drivers/acpi/dptf/dptf_power.c                          | 2 ++
 drivers/acpi/dptf/int340x_thermal.c                     | 6 ++++++
 drivers/acpi/fan.h                                      | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 6 files changed, 12 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index c0da24c9f8c3..4919e7abe93f 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -151,6 +151,7 @@ static int pch_fivr_remove(struct platform_device *pdev)
 static const struct acpi_device_id pch_fivr_device_ids[] = {
 	{"INTC1045", 0},
 	{"INTC1049", 0},
+	{"INTC1064", 0},
 	{"INTC10A3", 0},
 	{"", 0},
 };
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index dc1f52a5b3f4..a5f29d061b37 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -231,6 +231,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INTC1050", 0},
 	{"INTC1060", 0},
 	{"INTC1061", 0},
+	{"INTC1065", 0},
+	{"INTC1066", 0},
 	{"INTC10A4", 0},
 	{"INTC10A5", 0},
 	{"", 0},
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 42a556346548..b7113fa92fa6 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -27,6 +27,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3532"},
 	{"INTC1040"},
 	{"INTC1041"},
+	{"INTC1042"},
 	{"INTC1043"},
 	{"INTC1044"},
 	{"INTC1045"},
@@ -37,6 +38,11 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1050"},
 	{"INTC1060"},
 	{"INTC1061"},
+	{"INTC1062"},
+	{"INTC1063"},
+	{"INTC1064"},
+	{"INTC1065"},
+	{"INTC1066"},
 	{"INTC10A0"},
 	{"INTC10A1"},
 	{"INTC10A2"},
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 44728529a5b6..e7b4b4e4a55e 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -14,6 +14,7 @@
 	{"INT3404", }, /* Fan */ \
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
 	{"INTC1048", }, /* Fan for Alder Lake generation */ \
+	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
 	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
 	{"PNP0C0B", } /* Generic ACPI fan */
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 79931ddc582a..1ea861473cba 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -669,6 +669,7 @@ static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INT3400", 0},
 	{"INTC1040", 0},
 	{"INTC1041", 0},
+	{"INTC1042", 0},
 	{"INTC10A0", 0},
 	{}
 };
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 07e25321dfe3..71d084c4c456 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -285,6 +285,7 @@ static const struct acpi_device_id int3403_device_ids[] = {
 	{"INT3403", 0},
 	{"INTC1043", 0},
 	{"INTC1046", 0},
+	{"INTC1062", 0},
 	{"INTC10A1", 0},
 	{"", 0},
 };
-- 
2.17.1

