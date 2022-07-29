Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B18584ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiG2Eyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiG2Eyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:54:38 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD77AC10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:54:36 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220729045435epoutp036dc0b2e2c8b1a4f87123a02a2a565748~GM86gTFTJ1166711667epoutp03p
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220729045435epoutp036dc0b2e2c8b1a4f87123a02a2a565748~GM86gTFTJ1166711667epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659070475;
        bh=QDiYBDTeTdIYKBU1cs/MPkuOSczpiCApYohCod9JSmE=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=L6GQkFuuu2Ks1BorW32XwQ5GjslGgzzsljtP1K1AtLyXwVpZfLNMmIKOy8bkYt1Xn
         Ar0y5hzd71PjaVQ0p/Wzp3976C5JnIc0Rs1jOwwdLzZX9OJmGB5f5WmMPmoOZpzXlU
         dseCpP1fbrrQ0PPcSzAttrqeTVe5ll5l/vxqJDlQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220729045434epcas2p3495ed2b92f2be067dadd9f4c671e2832~GM85hLFnv2727027270epcas2p3t;
        Fri, 29 Jul 2022 04:54:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LvFYP47kxz4x9QC; Fri, 29 Jul
        2022 04:54:33 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-b9-62e36809031e
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.42.09662.90863E26; Fri, 29 Jul 2022 13:54:33 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v5 2/6] scsi: ufs: wb: Change functions name and modify
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
Date:   Fri, 29 Jul 2022 13:54:33 +0900
X-CMS-MailID: 20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmuS5nxuMkg4+n5S1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8fkwOVx+Yq3x+I9L5k8
        Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0+LxJzqP9QDdTAEdUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMht0b2Ap+yVScWXKWtYFxvUQXIweH
        hICJxL2dwV2MXBxCAjsYJdZt3MUEEucVEJT4u0O4i5GTQ1ggQqLjRiMziC0koCRxbs0sRpAS
        YQEDiVu95iBhNgE9iZ9LZrCBjBEROMsssfDhFCaQhIQAr8SM9qcsELa0xPblWxlBbE4BP4lD
        73sZIeIaEj+W9TJD2KISN1e/ZYex3x+bD1UjItF67yxUjaDEg5+7oeKSEocOfWWDeCVfYsOB
        QIhwjcTb5QegSvQlrnVsBDuBV8BX4tqzBlaQchYBVYnLm2sgOl0kphzmAqlgFpCX2P52DjNI
        mFlAU2L9Ln2ICmWJI7dYYF5q2PibHZ3NLMAn0XH4L1x8x7wnTBCtahKLmowgwjISXw/PZ5/A
        qDQLEcazkKydhbB2ASPzKkax1ILi3PTUYqMCE3isJufnbmIEJ1Mtjx2Ms99+0DvEyMTBeIhR
        goNZSYRXIOBxkhBvSmJlVWpRfnxRaU5q8SFGU6B3JzJLiSbnA9N5Xkm8oYmlgYmZmaG5kamB
        uZI4r1fKhkQhgfTEktTs1NSC1CKYPiYOTqkGJnmDwC/Swp4ritp/zsm20GWxsrnLphNurLot
        Ju+3xZemA/cPOHCLbsqNtrXz/nI/2qojq3H/8qYI9zuzNP1mpy+5qOa5cUa1par+sVfPnvdN
        +yur3Fzg0P7VM67wN0Nhws4u9vXMHFOCzMxX+hzumbJPdWHVS6eZVntOTe2w4V2ozXco2EXa
        /HG+X9+x65f3fReVWbx6VWLAz0fWcnzf+3xWutx28X1w7ajoJjGPFAe5imSJDrcnYnl9lYcy
        90/qmMceLvZkyYLD2UeZxE04P3tculhQYiGzoGLyrobLal+c6lNfZr6d9CXixQfJE0wHd9Qf
        Tn36ddqmxTNld3gqTX2wh+2PFMvl5idJ7qyXlFiKMxINtZiLihMBt6ztyi8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p7>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index bbf12aa6a5ae..a14d3fe39570 100644
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
+	ufshcd_wb_set_default_flags(hba);
+
 	if (hba->ee_usr_mask)
 		ufshcd_write_ee_control(hba);
 	/* Enable Auto-Hibernate if configured */
-- 
2.25.1
