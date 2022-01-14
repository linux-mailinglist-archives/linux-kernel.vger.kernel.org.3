Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D494C48F2FB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiANXYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:24:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:33182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbiANXYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642202687; x=1673738687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYiQJoCHac+p7l76fSC/rzt2/E84pBNzxfz461aHqNU=;
  b=iDGXUqng3OUtGsB3AeoBEr1NycpAPU5dE2ickpKTaj+H1VH2mob3dxVQ
   E9gXqvEdsBL0KCxAutlgWHNgfxy7RCvZGcXzhhvDYN1RRCZw4Wjf/5VfE
   //aUjijGTFr25Zg35DBffSts7gxmezB2r+sMDnplmKYyrEBQ+B0Mz8E6B
   83rMo8j800x58RAXNOpURYgf2pQVCbRlxl1oAwAEyNEYRODpWAHhdDpL+
   eV+p8ctThUXsmfILJDBMnucpg1cnpKiZZBObx1gcbpPiHrZQ12mN7rz+1
   YqYusSUMdh1sEOkjd0a+knPqYvAmdJDaNNxNEezsRqjDhz0W6K6zcd/BK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268718350"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268718350"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="491682055"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2022 15:24:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: int340x: Support Raptor Lake
Date:   Fri, 14 Jan 2022 15:24:34 -0800
Message-Id: <20220114232435.448340-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
References: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Raptor Lake ACPI IDs for DPTF devices.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 8502b7d8df89..72acb1f61849 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -596,6 +596,7 @@ static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INT3400", 0},
 	{"INTC1040", 0},
 	{"INTC1041", 0},
+	{"INTC10A0", 0},
 	{}
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index c3c4c4d34542..07e25321dfe3 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -285,6 +285,7 @@ static const struct acpi_device_id int3403_device_ids[] = {
 	{"INT3403", 0},
 	{"INTC1043", 0},
 	{"INTC1046", 0},
+	{"INTC10A1", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
-- 
2.34.1

