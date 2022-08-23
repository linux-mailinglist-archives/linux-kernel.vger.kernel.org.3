Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33D959D096
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiHWFfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiHWFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:34:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032745E316
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232895; x=1692768895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8jAYEVSz/my0EGpyxKbx0zqQQ5m40c9ePrDOY+8xfA=;
  b=KffjLmOxPnKwhJ3AnJVcpR9B7r18Dos5Ghpv1lRcFE7Vf4aSoz4ovQRU
   haVjLZ16pZnwqpMrhT3hIaF+rYLVoXqsfeMyAeCzMTLf2zA2jtzZiKQqB
   Yhnl4mIY4VvCytNFJIgMMXt0b+gE/Z9ytFAPvkCUHcJiUz9M1j6w7XOmC
   7CMixOlh+4F3+5Uiw6vkivFyLfiIFSY5uNETRv7Hl8L3mu17v4J00beHt
   z44i918A50ih8nKe7WbvkcWJbJVJuKJgNKq2dxLv3t2x5D/34urPd0Igw
   Ex68/+xI7wudBHv5RrhCqcv4aibpGPp8gIRWPchpk6ujW5Bvd5yDPkjG4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568560"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558255"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:53 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 02/11] soundwire: intel: regroup definitions for LCTL
Date:   Tue, 23 Aug 2022 13:38:37 +0800
Message-Id: <20220823053846.2684635-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
References: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No functionality change, just regroup offset and bitfield definitions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 49a3c265529b..d9f51f43e42c 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -19,7 +19,14 @@
 #define SDW_SHIM_LCAP			0x0
 #define SDW_SHIM_LCAP_LCOUNT_MASK	GENMASK(2, 0)
 
+/* LCTL */
 #define SDW_SHIM_LCTL			0x4
+
+#define SDW_SHIM_LCTL_SPA		BIT(0)
+#define SDW_SHIM_LCTL_SPA_MASK		GENMASK(3, 0)
+#define SDW_SHIM_LCTL_CPA		BIT(8)
+#define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
+
 #define SDW_SHIM_IPPTR			0x8
 #define SDW_SHIM_SYNC			0xC
 
@@ -39,11 +46,6 @@
 #define SDW_SHIM_WAKEEN			0x190
 #define SDW_SHIM_WAKESTS		0x192
 
-#define SDW_SHIM_LCTL_SPA		BIT(0)
-#define SDW_SHIM_LCTL_SPA_MASK		GENMASK(3, 0)
-#define SDW_SHIM_LCTL_CPA		BIT(8)
-#define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
-
 #define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
 #define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
 #define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
-- 
2.25.1

