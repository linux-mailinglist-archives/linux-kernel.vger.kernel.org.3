Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433835317A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiEWR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbiEWRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:31:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B873E644DB;
        Mon, 23 May 2022 10:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653326817; x=1684862817;
  h=from:to:cc:subject:date:message-id;
  bh=M6F2O+s0jMQ7ZCsSYUNBJ1oe1calqhqjLZFVNEsEBjE=;
  b=L2jReUn3AWIj8nPk5387gTLOJECnKyNxqQ3sAof4d8V8WnbJMbcyDn1F
   0hkuI4yZpw5lPyRVmUJzkCmWzp4IXRKNlbc5t+XX99gCObGApE1pUB8vJ
   Jj+ikO+U5MT11ErBkYNNAoSe+gdEmBz4BTM/rPgJJwD8v3CLEQmhzy9CU
   IqIaKDitk2jgo4RYibF7lnOHSM2FkRIahaXqwdQWFp2G3L17eVTddbu7d
   OTS5bA7eToKlGpqdapF+mXixh97biTRRnsjz+sPv8th65sPBxF/RjUudC
   NOBnSXSb0UObZEFm5QnYq/K+M8IB8M2AgdZAle0bQYdlfM+qowLq/C2d+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273289487"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="273289487"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="703115895"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga004.jf.intel.com with ESMTP; 23 May 2022 10:25:31 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        atenart@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] thermal: int340x: Add Meteor Lake PCI device id
Date:   Mon, 23 May 2022 22:52:42 +0530
Message-Id: <20220523172242.30378-1-sumeet.r.pawnikar@intel.com>
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

Add Meteor Lake PCI ID for processor thermal device.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
 .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 49932a68abac..7d52fcff4937 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -24,6 +24,7 @@
 #define PCI_DEVICE_ID_INTEL_HSB_THERMAL	0x0A03
 #define PCI_DEVICE_ID_INTEL_ICL_THERMAL	0x8a03
 #define PCI_DEVICE_ID_INTEL_JSL_THERMAL	0x4E03
+#define PCI_DEVICE_ID_INTEL_MTLP_THERMAL	0x7D03
 #define PCI_DEVICE_ID_INTEL_RPL_THERMAL	0xA71D
 #define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
 #define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index ca40b0967cdd..c2dc4c158b9d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -358,6 +358,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
+	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
 	{ },
 };
-- 
2.17.1

