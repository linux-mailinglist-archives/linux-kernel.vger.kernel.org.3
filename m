Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3146C4B3FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiBNC7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:59:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiBNC7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:59:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21C50E19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807541; x=1676343541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WEno40C7jLT1PSOtcxME8RVxUTyrL0WdeC6F3m6ZqJM=;
  b=Id+zggKw6z+c9xh2UZBSdgYeHXPS1isgk0dq63jwMv/VTmETLVyDgpyT
   aRABAo9MLYbzHU/b33AfTjDQI+YWWp+R46jcPfHvIOYmQaiZVCyztdjRM
   ky7hURm5Yi18Lx6jg6+duupHygZzg/AdBt7i1Wfs3MX4T8VDA+zPCpYgQ
   7qOSOZR+U3JdCWqEstfY5BXEyeC4+2jlmfH0BQ7Ti41KrmEAq0vfHUs/q
   Z9uCt9KioFbAUpRiMsIwf7jipUEiiWWGgml9pGiA11A70ysMa3dxuDkPk
   7wVx36H/bQ82FgjoFpeyEHvCfb0IrEhGXuDUT0QywhDLj0Kg93nchCKZX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280433"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280433"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501515031"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:58 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Date:   Mon, 14 Feb 2022 10:57:02 +0800
Message-Id: <20220214025704.3184654-10-baolu.lu@linux.intel.com>
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

This removes unnecessary commented code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d7fac0a1761d..fb17ed8c08f3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1407,15 +1407,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 	default:
 		BUG();
 	}
-	/* Note: set drain read/write */
-#if 0
-	/*
-	 * This is probably to be super secure.. Looks like we can
-	 * ignore it without any impact.
-	 */
-	if (cap_read_drain(iommu->cap))
-		val |= DMA_TLB_READ_DRAIN;
-#endif
+
 	if (cap_write_drain(iommu->cap))
 		val |= DMA_TLB_WRITE_DRAIN;
 
-- 
2.25.1

