Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E9D5898A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiHDHvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHDHvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:51:05 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D72A972
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:51:04 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220804075059epoutp03ea8669dc193a9b7c96b565f5902f4b8b~IFOp2YmNo1428214282epoutp03J
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:50:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220804075059epoutp03ea8669dc193a9b7c96b565f5902f4b8b~IFOp2YmNo1428214282epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659599459;
        bh=mmkQk1MvcKM6LM6o3wuPJ6XeZO8ObXnjiobggSDJbjc=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Irdx4ssLeg/UDv5nOqj3rGQOabR/dA1fP9Rt1qTGiLViF8wvhFcXiWuOfiWNxqQhd
         XT2YpelPoKo2d7wRgM7oSsrmyWspN6tfW5z27+ThWypr/TH7dR+bTbsIPOLtQYK3nW
         cXvpgIFC4LT8Xdo68kcXzme3WfB6d4/f6q/KGEZg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220804075059epcas2p4ed93af3e4205706b189f842167a382ef~IFOpZzh5X2016720167epcas2p4Z;
        Thu,  4 Aug 2022 07:50:59 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lz1BB6Xdcz4x9Q4; Thu,  4 Aug
        2022 07:50:58 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-57-62eb7a623ccd
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.51.09650.26A7BE26; Thu,  4 Aug 2022 16:50:58 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v7 2/6] scsi: ufs: wb: Change functions name and modify
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
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220804074928epcms2p86582693a39597501b491400a28543a92@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804075058epcms2p550c578d743fe0a94888b3d71cc9076d4@epcms2p5>
Date:   Thu, 04 Aug 2022 16:50:58 +0900
X-CMS-MailID: 20220804075058epcms2p550c578d743fe0a94888b3d71cc9076d4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmmW5S1eskg7lTTCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8dksXTrTUYHbo/LV7w9
        Fu95yeQxYdEBRo+Wk/tZPL6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrgjMq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndHRfJetYK5sxY4Z
        59gbGM9IdDFyckgImEjcWHGSqYuRi0NIYAejxJ/t7xi7GDk4eAUEJf7uEAapERaIkHj/7iUT
        iC0koCRxbs0ssBJhAQOJW73mIGE2AT2Jn0tmsIHYIgJtLBLrT7NDjOeVmNH+lAXClpbYvnwr
        I4jNKeAnMevXUSaIuIbEj2W9zBC2qMTN1W/ZYez3x+YzQtgiEq33zkLVCEo8+LkbKi4pcejQ
        VzaQcyQE8iU2HAiECNdIvF1+AKpEX+Jax0YWiKd8JZadB7uSRUBVYmfjMaiJLhLLZ2wHu4ZZ
        QF5i+9s5zCDlzAKaEut36UMMV5Y4cosF5qeGjb/Z0dnMAnwSHYf/wsV3zHvCBNGqJrGoyQgi
        LCPx9fB89gmMSrMQYTwLydpZCGsXMDKvYhRLLSjOTU8tNiowgkdrcn7uJkZwitVy28E45e0H
        vUOMTByMhxglOJiVRHhXWL5OEuJNSaysSi3Kjy8qzUktPsRoCvTwRGYp0eR8YJLPK4k3NLE0
        MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAVL0rLf1azarMtlki6zatNuBY
        +/H3p79S7+/Jxx6VKet0sXl+21DCJ+uUoxObZFxv3kSxybukjuyI50o8mWC0R6mydv4/Fr79
        S3/d49b9Yf9wSVAHyypzT51UGTUjbcYEn/ncr5grW9pqNre4cxm75TxSrTNIU3GpuJ3Cu6A5
        YO4f3/ToUy+O7e5Qebl5g1p57oX4y55sd049vG29Wv9ea93rua0dv/ImBv7qf3Zc/GLInT/c
        b5lSTzz+WO1qf+9lcKrhNF7X0NOMdp0R6n5eDFHSfLIuPC8F+L3OZORmdc/bO23nJUuR+Kwl
        z6d6FAhLM7j+jne+pbSpy1g+32CdyY15F1bYLlbjvqTTnaLEUpyRaKjFXFScCACQz8ehOgQA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
References: <20220804074928epcms2p86582693a39597501b491400a28543a92@epcms2p8>
        <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p5>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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
