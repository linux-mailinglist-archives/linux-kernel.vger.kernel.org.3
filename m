Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC7570EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiGLAOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiGLANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:13:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2807CDEBB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584826; x=1689120826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/6SSeJyFt4HtQDZKoE6TalrVcffk6vqEeNrwtMJkjI=;
  b=AnsT8QdFU+arUduJSTKz5chnGji3HyvUMymLVZ28VAh7ld+GJxR77MHZ
   i7hNJ+oZ7oqj/piJ8xZf3eCx3gFuLZ9grkg/EY39iNkfm826lUbhcIJh8
   ZFUJ/gkzNCGf23NOGzNfRdzFiieMbyHFyUohXUe6sjg8cx6t+G9v12Fvw
   BVvLAdvegjvr2tg6lylHgPfVSdyCtICx7xgdMIUynscNNzGaAQjJX8bv3
   4PR/AlNFZ2iMN84imvx8k5/iaY4COvCKWTSXHpie4EDrqykSj03pFkgeb
   wBG+Vm9aQDm4529l/FQqApJsOnXFGlhQdiB534SwAlMv+Lm3pZSBCM3IC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284827896"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284827896"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445701"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] KVM: x86: Remove unnecessary include
Date:   Tue, 12 Jul 2022 08:08:48 +0800
Message-Id: <20220712000908.3431936-6-baolu.lu@linux.intel.com>
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

intel-iommu.h is not needed in kvm/x86 anymore. Remove its include.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-6-baolu.lu@linux.intel.com
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1910e1e78b15..f7ec1e39eec7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -41,7 +41,6 @@
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
-#include <linux/intel-iommu.h>
 #include <linux/cpufreq.h>
 #include <linux/user-return-notifier.h>
 #include <linux/srcu.h>
-- 
2.25.1

