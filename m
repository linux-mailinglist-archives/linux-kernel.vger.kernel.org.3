Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF458F58E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiHKBZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiHKBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:25:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274BA61D97;
        Wed, 10 Aug 2022 18:25:42 -0700 (PDT)
X-UUID: 103c170f15d746f5b1693afdbef7461e-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=P6hP16VPEoUAkxarBzIpwl1a5NNw9mpNrl3hYIEoSIU=;
        b=QJ2ZZu+JAyICIQQTiBayDxh/+Ef7mqk7sDkLXvcoKQNBDqXjYFYvxs/XJfM2Cggf7i+ckyi2ijtyceVRytyWT8R0N9KUmiRyKaEkx3+JYuTHcJzm/NccNuMq7jl4Y4KZD6TqtalIusGE9hrxi4mMvCUkGQyaM3xVu5xS3VsTLRE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:240b4eae-bbcf-4d0b-83ab-a7e40f034189,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:25c6f7fc-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 103c170f15d746f5b1693afdbef7461e-20220811
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 950314937; Thu, 11 Aug 2022 09:25:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 09:25:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 09:25:34 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH v1] ufs: core: Unify function names for clk-scaling
Date:   Thu, 11 Aug 2022 09:25:33 +0800
Message-ID: <20220811012533.19761-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the naming style of clk-scaling related function is
not unified. Simply unify their names for better readability.

This patch does not change the functionality.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufs-sysfs.c |  3 +-
 drivers/ufs/core/ufshcd.c    | 56 ++++++++++++++++++------------------
 include/ufs/ufshcd.h         |  2 +-
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d557..a64d069db64c 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -225,7 +225,8 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	unsigned int wb_enable;
 	ssize_t res;
 
-	if (!ufshcd_is_wb_allowed(hba) || ufshcd_is_clkscaling_supported(hba)) {
+	if (!ufshcd_is_wb_allowed(hba) ||
+	    ufshcd_is_clk_scaling_supported(hba)) {
 		/*
 		 * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
 		 * on/off will be done while clock scaling up/down.
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 581d88af07ab..d2bff2b1bdff 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -253,9 +253,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params);
 static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
 static int ufshcd_host_reset_and_restore(struct ufs_hba *hba);
-static void ufshcd_resume_clkscaling(struct ufs_hba *hba);
-static void ufshcd_suspend_clkscaling(struct ufs_hba *hba);
-static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba);
+static void __ufshcd_clk_scaling_resume(struct ufs_hba *hba);
+static void __ufshcd_clk_scaling_suspend(struct ufs_hba *hba);
+static void ufshcd_devfreq_suspend(struct ufs_hba *hba);
 static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
 static irqreturn_t ufshcd_intr(int irq, void *__hba);
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
@@ -1321,7 +1321,7 @@ static void ufshcd_clk_scaling_suspend_work(struct work_struct *work)
 	hba->clk_scaling.is_suspended = true;
 	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
-	__ufshcd_suspend_clkscaling(hba);
+	ufshcd_devfreq_suspend(hba);
 }
 
 static void ufshcd_clk_scaling_resume_work(struct work_struct *work)
@@ -1352,7 +1352,7 @@ static int ufshcd_devfreq_target(struct device *dev,
 	struct ufs_clk_info *clki;
 	unsigned long irq_flags;
 
-	if (!ufshcd_is_clkscaling_supported(hba))
+	if (!ufshcd_is_clk_scaling_supported(hba))
 		return -EINVAL;
 
 	clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
@@ -1409,7 +1409,7 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	struct ufs_clk_info *clki;
 	ktime_t curr_t;
 
-	if (!ufshcd_is_clkscaling_supported(hba))
+	if (!ufshcd_is_clk_scaling_supported(hba))
 		return -EINVAL;
 
 	memset(stat, 0, sizeof(*stat));
@@ -1498,7 +1498,7 @@ static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 	dev_pm_opp_remove(hba->dev, clki->max_freq);
 }
 
-static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
+static void ufshcd_devfreq_suspend(struct ufs_hba *hba)
 {
 	unsigned long flags;
 
@@ -1508,7 +1508,7 @@ static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 
-static void ufshcd_suspend_clkscaling(struct ufs_hba *hba)
+static void __ufshcd_clk_scaling_suspend(struct ufs_hba *hba)
 {
 	unsigned long flags;
 	bool suspend = false;
@@ -1524,10 +1524,10 @@ static void ufshcd_suspend_clkscaling(struct ufs_hba *hba)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	if (suspend)
-		__ufshcd_suspend_clkscaling(hba);
+		ufshcd_devfreq_suspend(hba);
 }
 
-static void ufshcd_resume_clkscaling(struct ufs_hba *hba)
+static void __ufshcd_clk_scaling_resume(struct ufs_hba *hba)
 {
 	unsigned long flags;
 	bool resume = false;
@@ -1543,7 +1543,7 @@ static void ufshcd_resume_clkscaling(struct ufs_hba *hba)
 		devfreq_resume_device(hba->devfreq);
 }
 
-static ssize_t ufshcd_clkscale_enable_show(struct device *dev,
+static ssize_t ufshcd_clk_scaling_enable_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -1551,7 +1551,7 @@ static ssize_t ufshcd_clkscale_enable_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", hba->clk_scaling.is_enabled);
 }
 
-static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
+static ssize_t ufshcd_clk_scaling_enable_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -1577,9 +1577,9 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 	hba->clk_scaling.is_enabled = value;
 
 	if (value) {
-		ufshcd_resume_clkscaling(hba);
+		__ufshcd_clk_scaling_resume(hba);
 	} else {
-		ufshcd_suspend_clkscaling(hba);
+		__ufshcd_clk_scaling_suspend(hba);
 		err = ufshcd_devfreq_scale(hba, true);
 		if (err)
 			dev_err(hba->dev, "%s: failed to scale clocks up %d\n",
@@ -1595,8 +1595,8 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 
 static void ufshcd_init_clk_scaling_sysfs(struct ufs_hba *hba)
 {
-	hba->clk_scaling.enable_attr.show = ufshcd_clkscale_enable_show;
-	hba->clk_scaling.enable_attr.store = ufshcd_clkscale_enable_store;
+	hba->clk_scaling.enable_attr.show = ufshcd_clk_scaling_enable_show;
+	hba->clk_scaling.enable_attr.store = ufshcd_clk_scaling_enable_store;
 	sysfs_attr_init(&hba->clk_scaling.enable_attr.attr);
 	hba->clk_scaling.enable_attr.attr.name = "clkscale_enable";
 	hba->clk_scaling.enable_attr.attr.mode = 0644;
@@ -1614,7 +1614,7 @@ static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
 {
 	char wq_name[sizeof("ufs_clkscaling_00")];
 
-	if (!ufshcd_is_clkscaling_supported(hba))
+	if (!ufshcd_is_clk_scaling_supported(hba))
 		return;
 
 	if (!hba->clk_scaling.min_gear)
@@ -2016,7 +2016,7 @@ static void ufshcd_clk_scaling_start_busy(struct ufs_hba *hba)
 	ktime_t curr_t = ktime_get();
 	unsigned long flags;
 
-	if (!ufshcd_is_clkscaling_supported(hba))
+	if (!ufshcd_is_clk_scaling_supported(hba))
 		return;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -2050,7 +2050,7 @@ static void ufshcd_clk_scaling_update_busy(struct ufs_hba *hba)
 	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
 	unsigned long flags;
 
-	if (!ufshcd_is_clkscaling_supported(hba))
+	if (!ufshcd_is_clk_scaling_supported(hba))
 		return;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -6055,12 +6055,12 @@ static void ufshcd_clk_scaling_suspend(struct ufs_hba *hba, bool suspend)
 {
 	if (suspend) {
 		if (hba->clk_scaling.is_enabled)
-			ufshcd_suspend_clkscaling(hba);
+			__ufshcd_clk_scaling_suspend(hba);
 		ufshcd_clk_scaling_allow(hba, false);
 	} else {
 		ufshcd_clk_scaling_allow(hba, true);
 		if (hba->clk_scaling.is_enabled)
-			ufshcd_resume_clkscaling(hba);
+			__ufshcd_clk_scaling_resume(hba);
 	}
 }
 
@@ -6089,9 +6089,9 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
 		ufshcd_hold(hba, false);
-		if (ufshcd_is_clkscaling_supported(hba) &&
+		if (ufshcd_is_clk_scaling_supported(hba) &&
 		    hba->clk_scaling.is_enabled)
-			ufshcd_suspend_clkscaling(hba);
+			__ufshcd_clk_scaling_suspend(hba);
 		ufshcd_clk_scaling_allow(hba, false);
 	}
 	ufshcd_scsi_block_requests(hba);
@@ -6104,7 +6104,7 @@ static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 {
 	ufshcd_scsi_unblock_requests(hba);
 	ufshcd_release(hba);
-	if (ufshcd_is_clkscaling_supported(hba))
+	if (ufshcd_is_clk_scaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
 	ufshcd_rpm_put(hba);
 }
@@ -8111,7 +8111,7 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 		goto out;
 
 	/* Initialize devfreq after UFS device is detected */
-	if (ufshcd_is_clkscaling_supported(hba)) {
+	if (ufshcd_is_clk_scaling_supported(hba)) {
 		memcpy(&hba->clk_scaling.saved_pwr_info.info,
 			&hba->pwr_info,
 			sizeof(struct ufs_pa_layer_attr));
@@ -8955,7 +8955,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ufshcd_hold(hba, false);
 	hba->clk_gating.is_suspended = true;
 
-	if (ufshcd_is_clkscaling_supported(hba))
+	if (ufshcd_is_clk_scaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, true);
 
 	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
@@ -9061,7 +9061,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (!ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE))
 		ufshcd_disable_auto_bkops(hba);
 enable_scaling:
-	if (ufshcd_is_clkscaling_supported(hba))
+	if (ufshcd_is_clk_scaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
 
 	hba->dev_info.b_rpm_dev_flush_capable = false;
@@ -9144,7 +9144,7 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (hba->ee_usr_mask)
 		ufshcd_write_ee_control(hba);
 
-	if (ufshcd_is_clkscaling_supported(hba))
+	if (ufshcd_is_clk_scaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
 
 	if (hba->dev_info.b_rpm_dev_flush_capable) {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7fe1a926cd99..5fd99a9cacb7 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -976,7 +976,7 @@ static inline bool ufshcd_can_hibern8_during_gating(struct ufs_hba *hba)
 {
 	return hba->caps & UFSHCD_CAP_HIBERN8_WITH_CLK_GATING;
 }
-static inline int ufshcd_is_clkscaling_supported(struct ufs_hba *hba)
+static inline int ufshcd_is_clk_scaling_supported(struct ufs_hba *hba)
 {
 	return hba->caps & UFSHCD_CAP_CLK_SCALING;
 }
-- 
2.18.0

