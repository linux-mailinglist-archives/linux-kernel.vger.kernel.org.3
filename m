Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44848F2FC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiANXYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:24:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:33182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbiANXYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642202687; x=1673738687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aERjaKJcO3q8+3VbJzmZCF3NJVD1CcvNJXZcgR8QX+U=;
  b=ntrahYGI8zhCmegsTzs8LC31d1ti/hKVVPAfkVVT2vXsiG8HjMIPC2q/
   stVVknEqXBkj+KFhxRZcCJVdGeGhGcOfRsnApwALldz2hFmp4jBUxxe9c
   dn2ykGPIkwgawUw0hgRtX5BtXtGkM+j5va3GEDGjE/upf49SxmmMC5sKB
   1vcQ/eLzz+Nk+yT09i8WJsNrbeJllQNwX5jp+qMgFM7hm27X5ISGh6uaK
   8hCqeYk+8UUb23Og8ELljlXfa1P2oOunPYWQXlW3FHPdKiVkPHBgug/po
   PrrQoDxOmqPacP3kUTcyXwq+Yz7eRWLqbKuzcB8Ydj+OHghiuR8OIso6o
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268718352"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268718352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="491682056"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2022 15:24:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] thermal: int340x: Add Raptor Lake PCI device id
Date:   Fri, 14 Jan 2022 15:24:35 -0800
Message-Id: <20220114232435.448340-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
References: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Raptor Lake PCI ID for processor thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
 .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 9b2a64ef55d0..49932a68abac 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -24,6 +24,7 @@
 #define PCI_DEVICE_ID_INTEL_HSB_THERMAL	0x0A03
 #define PCI_DEVICE_ID_INTEL_ICL_THERMAL	0x8a03
 #define PCI_DEVICE_ID_INTEL_JSL_THERMAL	0x4E03
+#define PCI_DEVICE_ID_INTEL_RPL_THERMAL	0xA71D
 #define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
 #define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index b4bcd3fe9eb2..ca40b0967cdd 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -358,6 +358,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
+	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
 	{ },
 };
 
-- 
2.34.1

