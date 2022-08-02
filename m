Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E25878AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiHBIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiHBIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:05:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD3D19285
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:05:32 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220802080531epoutp01c3d40b23eb35ea2959ceb0068f614d28~HeIw3Egqs2456524565epoutp01h
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:05:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220802080531epoutp01c3d40b23eb35ea2959ceb0068f614d28~HeIw3Egqs2456524565epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659427531;
        bh=SVmoLXbtKUB1vIM53WZ3qocmh/3HbPud77tuqhLKnLY=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=M/ZjmKuey0Nagm7wYbYbzBUiZGu5xn1x7C+JI040TqhFpAdxB/g2Ya6X3yOmgUFam
         gOOU45GMpOhFpn7wr5V/ERVuV9zM6mvU0zyyPLYdm6aV3ZQ5LEHYlB7xJ7X9uNyCy2
         sViMSZugmTP34RQ73dxVV+4iAwlVQBtxOio5Theo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220802080530epcas2p1a9b3fd9447d870098239e5c7f2e4364c~HeIwgqFGD0375803758epcas2p1R;
        Tue,  2 Aug 2022 08:05:30 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lxnbt2RQhz4x9Q9; Tue,  2 Aug
        2022 08:05:30 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-6c-62e8daca4b19
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.33.09642.ACAD8E26; Tue,  2 Aug 2022 17:05:30 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6 2/6] scsi: ufs: wb: Change functions name and modify
 parameter name
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220802080530epcms2p8a9bb540dc6f21957148088b7a9b8b6f4@epcms2p8>
Date:   Tue, 02 Aug 2022 17:05:30 +0900
X-CMS-MailID: 20220802080530epcms2p8a9bb540dc6f21957148088b7a9b8b6f4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmhe6pWy+SDM71ClqcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/JYunWm4wO3B6Xr3h7
        LN7zksljwqIDjB4tJ/ezeHxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAGZVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2Py8WesBa9kKi6f
        y29gnC/RxcjBISFgInFvcUYXIyeHkMAORokzJ11AwrwCghJ/dwiDhIUFIiTWr+9mgihRkji3
        ZhYjSImwgIHErV5zkDCbgJ7EzyUz2LoYuThEBNpYJI51bmUGSUgI8ErMaH/KAmFLS2xfvpUR
        xOYU8JOYeOMDVI2GxI9lvVC2qMTN1W/ZYez3x+YzQtgiEq33zkLVCEo8+LkbKi4pcejQVzaI
        T/IlNhwIhAjXSLxdfgCqRF/iWsdGsBN4BXwlfvw8B/YKi4CqxJWnO1ghWl0klrXWgISZBeQl
        tr+dwwwSZhbQlFi/Sx+iQlniyC0WmJ8aNv5mR2czC/BJdBz+CxffMe8JE0SrmsSiJiOIsIzE
        18Pz2ScwKs1CBPIsJGtnIaxdwMi8ilEstaA4Nz212KjAGB6pyfm5mxjB6VXLfQfjjLcf9A4x
        MnEwHmKU4GBWEuG94/I8SYg3JbGyKrUoP76oNCe1+BCjKdC/E5mlRJPzgQk+ryTe0MTSwMTM
        zNDcyNTAXEmc1ytlQ6KQQHpiSWp2ampBahFMHxMHp1QDE1/OstYpmb5PdOX9rkSl5Mrqfexe
        uTpsldLk1+VZHJnhl6U+LT25KCinOOXdz0pmvuoD5+RvnmuyMGi7YHhoyyvlo/9/Wpxjyg//
        /dCw7W56PeOC/ZophUreXv2ODzwPVS9jOvi7Na2XJ3ux8OvbX79GiLIezTCTnjSHf2JY1mkV
        zxbLaOOLHOe+Fix6Yb7LuTpT0Orj9M9/lt+zixa91PtHzdHm46KHF/VD1iuc1no7++tXxYfH
        dqkuOfzi/fbHTB5fhG8WpLlvK6nW/Fnp6DRv0o76JQeXvzh6zvxOZkxGmqHStoUuk2N+Piov
        TQhknPFRWrzlMr+SyjIXD/UpOvaNa5q9dH6XVSXdvPDjhRJLcUaioRZzUXEiADD6BPY4BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter name of ufshcd_wb_toggle_flush_during_h8() has been changed
in the same as other toggle functions.

Function names were ambiguous. So changed to suit the meaning.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b7e7c0c4eb75..df00441f89a1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -265,8 +265,9 @@ static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg);
 static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
-static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
+static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
+						 bool enable);
+static void ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
 
@@ -286,16 +287,16 @@ static inline void ufshcd_disable_irq(struct ufs_hba *hba)
 	}
 }
 
-static inline void ufshcd_wb_config(struct ufs_hba *hba)
+static void ufshcd_configure_wb(struct ufs_hba *hba)
 {
 	if (!ufshcd_is_wb_allowed(hba))
 		return;
 
 	ufshcd_wb_toggle(hba, true);
 
-	ufshcd_wb_toggle_flush_during_h8(hba, true);
+	ufshcd_wb_toggle_buf_flush_during_h8(hba, true);
 	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
-		ufshcd_wb_toggle_flush(hba, true);
+		ufshcd_wb_toggle_buf_flush(hba, true);
 }
 
 static void ufshcd_scsi_unblock_requests(struct ufs_hba *hba)
@@ -5748,22 +5749,23 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 	return ret;
 }
 
-static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set)
+static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
+						 bool enable)
 {
 	int ret;
 
-	ret = __ufshcd_wb_toggle(hba, set,
+	ret = __ufshcd_wb_toggle(hba, enable,
 			QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
 	if (ret) {
 		dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: %d\n",
-			__func__, set ? "enable" : "disable", ret);
+			__func__, enable ? "enable" : "disable", ret);
 		return;
 	}
 	dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
-			__func__, set ? "enabled" : "disabled");
+			__func__, enable ? "enabled" : "disabled");
 }
 
-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
+static void ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
@@ -5813,9 +5815,9 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
 	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
-		ufshcd_wb_toggle_flush(hba, false);
+		ufshcd_wb_toggle_buf_flush(hba, false);
 
-	ufshcd_wb_toggle_flush_during_h8(hba, false);
+	ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
 	ufshcd_wb_toggle(hba, false);
 	hba->caps &= ~UFSHCD_CAP_WB_EN;
 
@@ -8212,7 +8214,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	 */
 	ufshcd_set_active_icc_lvl(hba);
 
-	ufshcd_wb_config(hba);
+	/* Enable UFS Write Booster if supported */
+	ufshcd_configure_wb(hba);
+
 	if (hba->ee_usr_mask)
 		ufshcd_write_ee_control(hba);
 	/* Enable Auto-Hibernate if configured */
-- 
2.25.1
