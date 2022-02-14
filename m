Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF64B3FED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiBNC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:59:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiBNC7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:59:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728EB50E3B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807538; x=1676343538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XnFH65FFxEQ3hwhwcysUPS97E/4r4ucJNSpMglRXUwU=;
  b=kiKKtsoxAdD51ViJcJHPYcWyH5qKKfIEZ3LD3GaO+cRs4nJCWlG0AlDD
   8kJXGNa0h1rgUEP+dDmGtyWqTqjHQ0vbxG1jLlA9COmE2W05ly6AJa4+X
   jphTLB5UY59v8jTroa6qoIudxn4q5qsgLpO2rjLDNVx7vBROmT66OHxLr
   9xsHcxeoZ3RDkOd9DJ/e43McaJgS/tpPfZieKymI62H26Gnw+fxkRvjr9
   LieZb6Pzf/fiNdPU5WPvc3RCZbcNqPpJe3JdvAzVhkXMRLECq5XV5fAnu
   +7EofKL/WyfjCRH2YpPEOH5IZBcDAGGk1hzLOEg3GxNigJGUMfnsCmhrU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280431"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280431"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501515020"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:55 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 08/11] iommu/vt-d: Fix indentation of goto labels
Date:   Mon, 14 Feb 2022 10:57:01 +0800
Message-Id: <20220214025704.3184654-9-baolu.lu@linux.intel.com>
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

Remove blanks before goto labels.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dfd3698406fa..d7fac0a1761d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -827,7 +827,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 		}
 
 		if (pdev && drhd->include_all) {
-		got_pdev:
+got_pdev:
 			if (bus && devfn) {
 				*bus = pdev->bus->number;
 				*devfn = pdev->devfn;
@@ -836,7 +836,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 		}
 	}
 	iommu = NULL;
- out:
+out:
 	if (iommu_is_dummy(iommu, dev))
 		iommu = NULL;
 
-- 
2.25.1

