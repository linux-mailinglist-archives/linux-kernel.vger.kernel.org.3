Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB77F5358CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 07:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiE0FiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 01:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0Fh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 01:37:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C84474D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653629873; x=1685165873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B0StCX6RwQbyJoVE+z/qrjWGVToT35XUEx5CRooJFdQ=;
  b=i3p0i+F8fBhR8cohqE8S4cM6pBbqOnZoYkUBP85jrbge55DCsB5yU7vG
   Km7+e4h+SfXjcIfyja654ECRXSrcmC4vCYhv+qGY6dOLsv5NFE2fy1c+M
   73BWtTXqWfnKma+Mkn9TLdSQe1qT7+eBab8xM/AYA4o+/uizPX1x7mP69
   /7Dext9agrDMr0vi4re3FbazLxYf62bqa5lxghxmI6fxtF8L8DUSuJToA
   f7MNEIOyxSLD3bnBthRhOmN1iXnD72mhxKx9pmVUbm+jriQ0TWNGe5PgT
   ITyaOKriALj439snK8OiRes35pt/iX4Xo9oN7xGKjNC6iKNzxoOBlHRYF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="360772399"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="360772399"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 22:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718604566"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 22:37:51 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove unused iovad from dmar_domain
Date:   Fri, 27 May 2022 13:34:24 +0800
Message-Id: <20220527053424.3111186-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used anywhere. Cleanup it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 0f9df5a19ef7..a22adfbdf870 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -543,7 +543,6 @@ struct dmar_domain {
 	u8 set_pte_snp:1;
 
 	struct list_head devices;	/* all devices' list */
-	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
-- 
2.25.1

