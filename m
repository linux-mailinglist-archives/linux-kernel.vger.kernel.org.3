Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3366C59D08B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiHWFfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbiHWFe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:34:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803855D139
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232894; x=1692768894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NjbgRtY4CRKo0B1Ls4RwO/1jHQ9pLx+pwvGEVEf/TqI=;
  b=XMirI6/PTYEzrRGEwq58tAXGQeVuWI6YMBynt1X8dKI7+EuTixaelnfH
   +SMQYP9HwxsVFhYsYQxjR/fYmNVKeSVlrPABX1kM/lHG/PGWQKne5f4bR
   Aidl+c0B5iv7quW65TvdwNArqxi2QYyGUwvCq0Cd5gqMRfJvH7shBbuDB
   ToWOhgC0FI3pz6MFvUeaGf5dD/VBi1rzJyGBqq4NhhUXDAxCkaB2v7kfM
   JgVM/ia+zj4FF5GytcaZZqcWskdpLeZ36o49IdzC38jHUgYDEB7mzS3C8
   826RYsRtH0I5fcI/qUGInGxHYNxnbiC8NQZH1NKuMBr2/JFHKSZkVThRu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568556"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568556"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558238"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:52 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 01/11] soundwire: intel: cleanup definition of LCOUNT
Date:   Tue, 23 Aug 2022 13:38:36 +0800
Message-Id: <20220823053846.2684635-2-yung-chuan.liao@linux.intel.com>
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

Add definition in header file rather than hidden in code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 2 +-
 drivers/soundwire/intel_init.c      | 2 +-
 include/linux/soundwire/sdw_intel.h | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0c6e674dbf85..c37121356e06 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -138,7 +138,7 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 	if (!buf)
 		return -ENOMEM;
 
-	links = intel_readl(s, SDW_SHIM_LCAP) & GENMASK(2, 0);
+	links = intel_readl(s, SDW_SHIM_LCAP) & SDW_SHIM_LCAP_LCOUNT_MASK;
 
 	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
 	ret += scnprintf(buf + ret, RD_BUF - ret, "\nShim\n");
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 824f4f32d4dc..d091513919df 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -306,7 +306,7 @@ sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
 
 	/* Check SNDWLCAP.LCOUNT */
 	caps = ioread32(ctx->mmio_base + ctx->shim_base + SDW_SHIM_LCAP);
-	caps &= GENMASK(2, 0);
+	caps &= SDW_SHIM_LCAP_LCOUNT_MASK;
 
 	/* Check HW supported vs property value */
 	if (caps < ctx->count) {
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index ec16ae49e6a4..49a3c265529b 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -15,7 +15,10 @@
 #define SDW_LINK_SIZE			0x10000
 
 /* Intel SHIM Registers Definition */
+/* LCAP */
 #define SDW_SHIM_LCAP			0x0
+#define SDW_SHIM_LCAP_LCOUNT_MASK	GENMASK(2, 0)
+
 #define SDW_SHIM_LCTL			0x4
 #define SDW_SHIM_IPPTR			0x8
 #define SDW_SHIM_SYNC			0xC
-- 
2.25.1

