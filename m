Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458E859D08E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiHWFfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbiHWFfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:35:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA75C976
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232901; x=1692768901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1O4ps/JcDGEt0+y9AM/kthsuna2tQ743pxsTQ1DC6mY=;
  b=DjwCI1oO2DFfGcDOR3JnIj0/+dh0/gHMph+1cBg0Oq3ZMLh0xAwXGlEL
   yq0j8OjDakOdpPTAo+a6fHwf6Bve1rHiDtBzR9WY1mfYVEbkKRq7J4OrK
   jJVyJVsBWIf2h/5SX3ska/+jBZ7W/zNN9+VXMLIHkt1K3jEIeeb8u3erF
   sx5JafxtDix7doXXH23bdmN8adPDDq+5VvIg0YFaedW6qP89OFRplO5MK
   nx5aKNLpD8EA3eCmY+Ae2LkuhOi3q0N8uck4whyOW+xskcS25FpBJAQE6
   N7D0gX2we/KLPSgKLGF8I5Ampsq1GldAXgPrwAJGtYapvEfE0Re3Nx9d9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568602"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568602"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:35:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558287"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:59 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 05/11] soundwire: intel: remove unused PDM capabilities
Date:   Tue, 23 Aug 2022 13:38:40 +0800
Message-Id: <20220823053846.2684635-6-yung-chuan.liao@linux.intel.com>
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

We removed PDM support a long time ago but kept the definitions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 3 +--
 include/linux/soundwire/sdw_intel.h | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c37121356e06..104baa29bf2c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -170,9 +170,8 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 			ret += intel_sprintf(s, false, buf, ret,
 					SDW_SHIM_PCMSYCHC(i, j));
 		}
-		ret += scnprintf(buf + ret, RD_BUF - ret, "\n PDMSCAP, IOCTL, CTMCTL\n");
+		ret += scnprintf(buf + ret, RD_BUF - ret, "\n IOCTL, CTMCTL\n");
 
-		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PDMSCAP(i));
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_IOCTL(i));
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTMCTL(i));
 	}
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 66503cf29f48..34af5bc010b3 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -47,7 +47,6 @@
 
 #define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * (x)) + (0x2 * (y)))
 #define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * (x)) + (0x2 * (y)))
-#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * (x))
 #define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
 #define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
 
@@ -63,11 +62,6 @@
 #define SDW_SHIM_PCMSYCM_STREAM		GENMASK(13, 8)
 #define SDW_SHIM_PCMSYCM_DIR		BIT(15)
 
-#define SDW_SHIM_PDMSCAP_ISS		GENMASK(3, 0)
-#define SDW_SHIM_PDMSCAP_OSS		GENMASK(7, 4)
-#define SDW_SHIM_PDMSCAP_BSS		GENMASK(12, 8)
-#define SDW_SHIM_PDMSCAP_CPSS		GENMASK(15, 13)
-
 #define SDW_SHIM_IOCTL_MIF		BIT(0)
 #define SDW_SHIM_IOCTL_CO		BIT(1)
 #define SDW_SHIM_IOCTL_COE		BIT(2)
-- 
2.25.1

