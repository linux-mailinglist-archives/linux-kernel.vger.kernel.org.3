Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C784B3FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiBNC7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:59:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbiBNC7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:59:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD84950B17
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807532; x=1676343532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VfnNiH0iyPcpYrZNt/OHwIGhAD5IQG518T5a6b0/BPU=;
  b=E2+KSTbfs/+lFim55V7AgqbZjgGzROcoLVxxycGZY7eD0I7rd9qai8cE
   NrXslQTgmV/cPaMrwS3VjIzJjvqEVXAV4+hIHVjT2aVIHcgv4z23wTMDJ
   QsaH9POzMpc+B45NTDO1s3VLdjh8PbHi105e7gGsv+ZFYxln+9VZw3EIA
   ilLTalEGtA5FdD+5Oujg5Lw6+k+imm3bLwBrcLiAbsywbEbYqI/Zubdki
   RfcbMyiNYpHncRWgZZ52mX9463JZm3lQYnbg09slUTaN89wT1SokoGVrA
   tzyW25VsV4CAFE4exPYQTMeyiJJZSAfpxMCUZi3iq8jSZ9tfjN4/rY3j8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280425"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280425"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501514991"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:49 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 06/11] iommu/vt-d: Remove unnecessary includes
Date:   Mon, 14 Feb 2022 10:56:59 +0800
Message-Id: <20220214025704.3184654-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary include files and sort the remaining alphabetically.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d9965e72d9a8..b6a6fea8525d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -13,38 +13,18 @@
 #define pr_fmt(fmt)     "DMAR: " fmt
 #define dev_fmt(fmt)    pr_fmt(fmt)
 
-#include <linux/init.h>
-#include <linux/bitmap.h>
-#include <linux/debugfs.h>
-#include <linux/export.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/pci.h>
-#include <linux/dmar.h>
-#include <linux/dma-map-ops.h>
-#include <linux/mempool.h>
-#include <linux/memory.h>
-#include <linux/cpu.h>
-#include <linux/timer.h>
-#include <linux/io.h>
-#include <linux/iova.h>
-#include <linux/iommu.h>
+#include <linux/crash_dump.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
+#include <linux/dmi.h>
 #include <linux/intel-iommu.h>
 #include <linux/intel-svm.h>
+#include <linux/memory.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
+#include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
-#include <linux/dmi.h>
-#include <linux/pci-ats.h>
-#include <linux/memblock.h>
-#include <linux/dma-direct.h>
-#include <linux/crash_dump.h>
-#include <linux/numa.h>
-#include <asm/irq_remapping.h>
-#include <asm/cacheflush.h>
-#include <asm/iommu.h>
 
 #include "../irq_remapping.h"
 #include "../iommu-sva-lib.h"
-- 
2.25.1

