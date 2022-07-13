Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634795738D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGMO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGMO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:29:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A92275ED
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657722589; x=1689258589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79R+cGH+W8fdanIcU1gar7tgsMfMkUvcNYAcmuJq6rY=;
  b=Lh6EuTddLGO/SEAhiOF2IR+U3S9BUHxBcJUrm7UnV4FH9pcn7NV2k+T6
   q1fBdbN7QAaex5NtR8EJVA4O+JZF06oA2GFAT5CWAxp2hUeOEakwqK0e3
   f6+nCAcG1QDCP1d+NdIBNCt8K2vKMLm/LJGULtUjWtAy28edbIKYAOqgd
   RAQxfAsvSGs9g80eeVNHtRmaNatvj69ufTGhd6/5B44MrEKVBdmum1FWB
   AQzmiR83EHai6pAGJht/zinysj0P3NTmYM+5TFIPOWhLh51ef5Gg5WPIx
   k7HkZGTin5IVceyNYpCqHlwKu9l+vI4ATDnRmWR44yYYBBkwZ8IjZcjg9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285251402"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285251402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:29:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="622966734"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:29:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        gregkh@linuxfoundation.org
Subject: [PATCH 2/2] soundwire: intel: remove use of __func__ in dev_dbg
Date:   Wed, 13 Jul 2022 22:29:37 +0800
Message-Id: <20220713142937.17562-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713142937.17562-1-yung-chuan.liao@linux.intel.com>
References: <20220713142937.17562-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The module and function information can be added with
'modprobe foo dyndbg=+pmf'

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 85d4268eea65..25b27cd1be1d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -293,11 +293,11 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
 
 	if (!*shim_mask) {
-		dev_dbg(sdw->cdns.dev, "%s: powering up all links\n", __func__);
+		dev_dbg(sdw->cdns.dev, "powering up all links\n");
 
 		/* we first need to program the SyncPRD/CPU registers */
 		dev_dbg(sdw->cdns.dev,
-			"%s: first link up, programming SYNCPRD\n", __func__);
+			"first link up, programming SYNCPRD\n");
 
 		/* set SyncPRD period */
 		sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
@@ -479,7 +479,7 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 
 	if (!*shim_mask) {
 
-		dev_dbg(sdw->cdns.dev, "%s: powering down all links\n", __func__);
+		dev_dbg(sdw->cdns.dev, "powering down all links\n");
 
 		/* Link power down sequence */
 		link_control = intel_readl(shim, SDW_SHIM_LCTL);
@@ -1547,11 +1547,11 @@ static int intel_resume_child_device(struct device *dev, void *data)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 
 	if (!slave->probed) {
-		dev_dbg(dev, "%s: skipping device, no probed driver\n", __func__);
+		dev_dbg(dev, "skipping device, no probed driver\n");
 		return 0;
 	}
 	if (!slave->dev_num_sticky) {
-		dev_dbg(dev, "%s: skipping device, never detected on bus\n", __func__);
+		dev_dbg(dev, "skipping device, never detected on bus\n");
 		return 0;
 	}
 
@@ -1637,7 +1637,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 	}
 
 	if (pm_runtime_suspended(dev)) {
-		dev_dbg(dev, "%s: pm_runtime status: suspended\n", __func__);
+		dev_dbg(dev, "pm_runtime status: suspended\n");
 
 		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
@@ -1758,7 +1758,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
 
 	if (pm_runtime_suspended(dev)) {
-		dev_dbg(dev, "%s: pm_runtime status was suspended, forcing active\n", __func__);
+		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
 
 		/* follow required sequence from runtime_pm.rst */
 		pm_runtime_disable(dev);
-- 
2.25.1

