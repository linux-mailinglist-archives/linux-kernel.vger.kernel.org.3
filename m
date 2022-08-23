Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FFE59D044
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiHWE6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbiHWE6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:58:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5465A15D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661230687; x=1692766687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkEjonl0/2et2qJwC2dIvmsqgJ093c9yFXVqNZmKbQs=;
  b=UIgswNu2z0wDdeGyWR1Lm4/ZCMfGo+m6/NwGvqkwfhTah758rMTAu1Hx
   8MdQ1YrsWJwLicmVYJ+XYiTRtWIRmsd6u8kYpvWna1vyC7JbHe4MmliEV
   2L48Suv5Z4ZPWRvXMfiWYY/Woo7obTUj1la0BG/JQMYPQEr0fW1vG19bY
   lUleQHO1Rj05S5jTiuGD7rsiPIcKmlsb1PqHJsFPZ75uUaIIbK5HbbyLI
   t48H2znd/zA6Eq3kKw7PKQ0t9kxQ7dW7A9KB/BguGNWr7Oep3+d+QmPzI
   BTES68LqQ4jo5jm+Qlcg96fXyu8OQ55fdSD7vNiIvUMvzHzD9qxuHe0hM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291148303"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291148303"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:58:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="605536651"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:58:04 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: intel: remove use of __func__ in dev_dbg
Date:   Tue, 23 Aug 2022 13:01:58 +0800
Message-Id: <20220823050158.2671245-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823050158.2671245-1-yung-chuan.liao@linux.intel.com>
References: <20220823050158.2671245-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 3e372599a8c3..25ec9c272239 100644
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
@@ -1557,11 +1557,11 @@ static int intel_resume_child_device(struct device *dev, void *data)
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
 
@@ -1647,7 +1647,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 	}
 
 	if (pm_runtime_suspended(dev)) {
-		dev_dbg(dev, "%s: pm_runtime status: suspended\n", __func__);
+		dev_dbg(dev, "pm_runtime status: suspended\n");
 
 		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
@@ -1768,7 +1768,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
 
 	if (pm_runtime_suspended(dev)) {
-		dev_dbg(dev, "%s: pm_runtime status was suspended, forcing active\n", __func__);
+		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
 
 		/* follow required sequence from runtime_pm.rst */
 		pm_runtime_disable(dev);
-- 
2.25.1

