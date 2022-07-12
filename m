Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822B5570EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiGLANq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:13:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A3CFB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584821; x=1689120821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zL0sNIu0hR/7q129LGe91BkLQRpbxXeLJ8hwcGWo304=;
  b=FCrueAwGcPKHA9KuJhnC53wTe46ybQJTsZkOS1ugVJ345WZoKLnNre5f
   DouevFp6MatJA9cXHFKbP142w1JXBOH27hweeERNIlIqelqhXAcLwp6ye
   xTd+voMUVwBMmDhw+Tz25MTkpcDK6WRmWQhgbu95rRxSJVNZJSLYTFxmS
   L5FvXa0oXBy9GkjDmZpALfElHite12eCNTNPhjtDbCr61aiRg4c/LuCBt
   x+sIkxqF5mQQDrmvFPVb2u2qS0w4YffnXU+PgDnEkWoy2pqvLVhrKAS4E
   cYHuiNk9nkuEnG7X5k9mx3oi6g+0WBZSEDA2w4pUxVAI0Fpj9GOojPQGl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284827864"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284827864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445683"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:40 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] iommu/vt-d: Move trace/events/intel_iommu.h under iommu
Date:   Tue, 12 Jul 2022 08:08:44 +0800
Message-Id: <20220712000908.3431936-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file is private to the Intel IOMMU driver. Move it to the
driver folder.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-2-baolu.lu@linux.intel.com
---
 .../trace/events/intel_iommu.h => drivers/iommu/intel/trace.h | 4 ++++
 drivers/iommu/intel/dmar.c                                    | 2 +-
 drivers/iommu/intel/svm.c                                     | 2 +-
 drivers/iommu/intel/trace.c                                   | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (94%)

diff --git a/include/trace/events/intel_iommu.h b/drivers/iommu/intel/trace.h
similarity index 94%
rename from include/trace/events/intel_iommu.h
rename to drivers/iommu/intel/trace.h
index e5c1ca6d16ee..25cb7f88e1a2 100644
--- a/include/trace/events/intel_iommu.h
+++ b/drivers/iommu/intel/trace.h
@@ -91,4 +91,8 @@ TRACE_EVENT(prq_report,
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/iommu/intel/
+#define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 9699ca101c62..f91b45be1d92 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -30,10 +30,10 @@
 #include <linux/numa.h>
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
-#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 #include "perf.h"
+#include "trace.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7ee37d996e15..70b40d007a52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -21,11 +21,11 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
-#include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
+#include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/intel/trace.c b/drivers/iommu/intel/trace.c
index bfb6a6e37a88..117e626e3ea9 100644
--- a/drivers/iommu/intel/trace.c
+++ b/drivers/iommu/intel/trace.c
@@ -11,4 +11,4 @@
 #include <linux/types.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/intel_iommu.h>
+#include "trace.h"
-- 
2.25.1

