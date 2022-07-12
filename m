Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AB570EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiGLAOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGLANt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:13:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9335E09D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584828; x=1689120828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M97alGPHahpFMJq5hktdoW+S1aLfwbqCfek6UlykYlk=;
  b=RWF02nTk6WoZTW36N7kAH0h2ZPsfie7DYpJySJI3XT4JFpsRZpEJ3viG
   8mRDP1yUvzSS9rEjk/OgF37LBT+dMbrWaXwpHZwLXZnKDJ37fC88LX3LX
   G0HckOIih54Mr/dcxrS5bU4x0e0IC8r4dNfn+26UlFhGFKK06v4098A1h
   srzGRQupv0IlifPcgwHd1WzHSQpdqb1QOuea8ybmUGtxtDusR14TAVRbS
   /Snfc85gawxKcmW8Qxpk/Lq9MunKNjC2i3OxPCt2uPZevgWczJ4GXQI2S
   j1U9H1ou/1OnLBRTL492m+OUUHxo0G2H9fiB4XhkWsCcOyzrCDM7qaInR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284827913"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284827913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445705"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/25] iommu/vt-d: Move include/linux/intel-iommu.h under iommu
Date:   Tue, 12 Jul 2022 08:08:50 +0800
Message-Id: <20220712000908.3431936-8-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20220514014322.2927339-8-baolu.lu@linux.intel.com
---
 include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h | 0
 drivers/iommu/intel/trace.h                                | 3 ++-
 drivers/iommu/intel/cap_audit.c                            | 2 +-
 drivers/iommu/intel/debugfs.c                              | 2 +-
 drivers/iommu/intel/dmar.c                                 | 2 +-
 drivers/iommu/intel/iommu.c                                | 2 +-
 drivers/iommu/intel/irq_remapping.c                        | 2 +-
 drivers/iommu/intel/pasid.c                                | 2 +-
 drivers/iommu/intel/perf.c                                 | 2 +-
 drivers/iommu/intel/svm.c                                  | 2 +-
 MAINTAINERS                                                | 1 -
 11 files changed, 10 insertions(+), 10 deletions(-)
 rename include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h (100%)

diff --git a/include/linux/intel-iommu.h b/drivers/iommu/intel/iommu.h
similarity index 100%
rename from include/linux/intel-iommu.h
rename to drivers/iommu/intel/iommu.h
diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 25cb7f88e1a2..93d96f93a89b 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -13,7 +13,8 @@
 #define _TRACE_INTEL_IOMMU_H
 
 #include <linux/tracepoint.h>
-#include <linux/intel-iommu.h>
+
+#include "iommu.h"
 
 #define MSG_MAX		256
 
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 71596fc62822..3ee68393122f 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -10,7 +10,7 @@
 
 #define pr_fmt(fmt)	"DMAR: " fmt
 
-#include <linux/intel-iommu.h>
+#include "iommu.h"
 #include "cap_audit.h"
 
 static u64 intel_iommu_cap_sanity;
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index ed796eea4581..d927ef10641b 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -10,11 +10,11 @@
 
 #include <linux/debugfs.h>
 #include <linux/dmar.h>
-#include <linux/intel-iommu.h>
 #include <linux/pci.h>
 
 #include <asm/irq_remapping.h>
 
+#include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f91b45be1d92..2a5e0f91e647 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -19,7 +19,6 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/iova.h>
-#include <linux/intel-iommu.h>
 #include <linux/timer.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -31,6 +30,7 @@
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "perf.h"
 #include "trace.h"
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c70948021e8e..10bda4bec8fe 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -17,7 +17,6 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
 #include <linux/dmi.h>
-#include <linux/intel-iommu.h>
 #include <linux/intel-svm.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
@@ -26,6 +25,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-sva-lib.h"
 #include "pasid.h"
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a67319597884..2e9683e970f8 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -10,7 +10,6 @@
 #include <linux/hpet.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
-#include <linux/intel-iommu.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/crash_dump.h>
@@ -21,6 +20,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "cap_audit.h"
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 17cad7c1f62d..43f090381ec7 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -12,13 +12,13 @@
 #include <linux/bitops.h>
 #include <linux/cpufeature.h>
 #include <linux/dmar.h>
-#include <linux/intel-iommu.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/spinlock.h>
 
+#include "iommu.h"
 #include "pasid.h"
 
 /*
diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 0e8e03252d92..94ee70ac38e3 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -9,8 +9,8 @@
  */
 
 #include <linux/spinlock.h>
-#include <linux/intel-iommu.h>
 
+#include "iommu.h"
 #include "perf.h"
 
 static DEFINE_SPINLOCK(latency_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 70b40d007a52..580713aa9e07 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -5,7 +5,6 @@
  * Authors: David Woodhouse <dwmw2@infradead.org>
  */
 
-#include <linux/intel-iommu.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -22,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/fpu/api.h>
 
+#include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index ead381fdfc5a..fa2cde7dc644 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9998,7 +9998,6 @@ L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
-F:	include/linux/intel-iommu.h
 F:	include/linux/intel-svm.h
 
 INTEL IOP-ADMA DMA DRIVER
-- 
2.25.1

