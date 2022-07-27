Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E865820AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiG0HHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiG0HH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:07:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDC313A0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:07:27 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220727070725epoutp0352d8868656b6d21330ee812fbb860c42~FneVFYOOn2479124791epoutp03w
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:07:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220727070725epoutp0352d8868656b6d21330ee812fbb860c42~FneVFYOOn2479124791epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905645;
        bh=pFDs8N3oHmGo6gWocH4YoHqcmEMLBNY95qrWeadYc8Y=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=ZyTQBB9U5MEBQhEGS7DQV9HXcLG3iedHG/XA6NYDOTcqGD4URB/Q1cDOm44BLVjjK
         BHWngYbkP7HZGatsm2yDt+4jx64IjvvX/m7QW7Iv+B5ZJmlPz8dYaFeg8Rv0CVKXm/
         gc8NipvcyATpUQwsAbGGp/nPU1vhu8Ygx9RBeymY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220727070725epcas2p235d37d9273cd19d4be71c22a8f93643a~FneUgxaxw1101911019epcas2p2j;
        Wed, 27 Jul 2022 07:07:25 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lt4bc4160z4x9Pv; Wed, 27 Jul
        2022 07:07:24 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-9e-62e0e42c7677
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.65.09662.C24E0E26; Wed, 27 Jul 2022 16:07:24 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 3/7] scsi: ufs: wb: Change functions name and modify
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
Date:   Wed, 27 Jul 2022 16:07:24 +0900
X-CMS-MailID: 20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmha7OkwdJBqemyVucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZa/c8Yyv4JVNx6nppA+N6iS5GTg4J
        AROJOZ0tjF2MXBxCAjsYJW6sfgHkcHDwCghK/N0hDFIjLOAu8avpMROILSSgJHFuzSywEmEB
        A4lbveYgYTYBPYmfS2awgYwRETjLLLHw4RQmiPm8EjPan7JA2NIS25dvZQSxOQX8JHpenGCF
        iGtI/FjWywxhi0rcXP2WHcZ+f2w+I4QtItF67yxUjaDEg5+7oeKSEocOfWUDuUdCIF9iw4FA
        iHCNxNvlB6BK9CWudWwEO4FXwFdiy8zFbCA2i4CqxNWNd9kgalwkJt49BlbPLCAvsf3tHGaQ
        kcwCmhLrd+lDTFeWOHKLBeapho2/2dHZzAJ8Eh2H/8LFd8x7wgTRqiaxqMkIIiwj8fXwfPYJ
        jEqzEKE8C8naWQhrFzAyr2IUSy0ozk1PLTYqMIHHa3J+7iZGcELV8tjBOPvtB71DjEwcjIcY
        JTiYlUR4E6LvJwnxpiRWVqUW5ccXleakFh9iNAV6eCKzlGhyPjCl55XEG5pYGpiYmRmaG5ka
        mCuJ83qlbEgUEkhPLEnNTk0tSC2C6WPi4JRqYNqxpOHqcsZf5wPrTVfkPtafkJ30e+rvB5zc
        0l626TWlAcJSXX6aOvJTpayKlytvVSxd8U5lkxm39pv3Lh8Xxv1lCeSSXqGu/+TPs61Kzxtm
        rH693o9X74WmjkuZvrRg+MUpP1ZO26AZaa59ot62y/vT7Cud3mIHIkRns0i8UxXRciw25/vu
        msIdO0XUuvjlgUqN08VTvb4btko56bYstfplEbiZ8fzOJOlpK+4qrvAK/vQs7iJ/WIr9fsVt
        Kw9PLusRefMydnZ/eTsLm8/8K/NOHEj81fM5NyV7lV+e27qVtQHzuSzevuQpKwvdaHf7kZ1e
        5IwTb/LOOrU5N/fzhm1X1/KMlN/HxlRnojVXiaU4I9FQi7moOBEAjbzAJjEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 48ba109e29f7..52377fedae49 100644
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
+static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)
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
@@ -5750,22 +5751,23 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
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
 
@@ -5814,9 +5816,9 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
 	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
-		ufshcd_wb_toggle_flush(hba, false);
+		ufshcd_wb_toggle_buf_flush(hba, false);
 
-	ufshcd_wb_toggle_flush_during_h8(hba, false);
+	ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
 	ufshcd_wb_toggle(hba, false);
 	hba->caps &= ~UFSHCD_CAP_WB_EN;
 
@@ -8213,7 +8215,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	 */
 	ufshcd_set_active_icc_lvl(hba);
 
-	ufshcd_wb_config(hba);
+	/* Enable UFS Write Booster if supported */
+	ufshcd_wb_set_default_flags(hba);
+
 	if (hba->ee_usr_mask)
 		ufshcd_write_ee_control(hba);
 	/* Enable Auto-Hibernate if configured */
-- 
2.25.1
