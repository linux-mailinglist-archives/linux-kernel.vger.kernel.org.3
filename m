Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9E5898D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiHDHzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbiHDHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:55:24 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A63963A3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:55:22 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220804075520epoutp013a9cf9efb66b8844f9c3e015441c1e14~IFSczMoep1800818008epoutp01P
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:55:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220804075520epoutp013a9cf9efb66b8844f9c3e015441c1e14~IFSczMoep1800818008epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659599720;
        bh=mRoo2+RxB2FCJcuy7yBWNotnojgpEK0MxUVIWL+IP08=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=VzIVcW+59r59qvgcArd2WecbWhyCNWnqzAtO+oGiYTRwaSmsEuN8t3CnthDuJZuyL
         Yx5ibqysJVAaFB+AOmOp/Rc7ksb79/fp39Sx7gYFKg5M2RbPkYhuvo2SNTNrZSR1PF
         hUoglK1yfcDuu/axxC3LAoKsdvq6MItlcSTQfG04=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220804075520epcas2p4af89c0e99659108a6869eb9419155928~IFSchrjLM0583705837epcas2p4D;
        Thu,  4 Aug 2022 07:55:20 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lz1HD17C0z4x9QD; Thu,  4 Aug
        2022 07:55:20 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-d7-62eb7b68d7c6
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.94.09666.86B7BE26; Thu,  4 Aug 2022 16:55:20 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v7 5/6] scsi: ufs: wb: Modify messages
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
In-Reply-To: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804075519epcms2p148b6ae956b172925b26304b50d6a0da9@epcms2p1>
Date:   Thu, 04 Aug 2022 16:55:19 +0900
X-CMS-MailID: 20220804075519epcms2p148b6ae956b172925b26304b50d6a0da9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmuW5G9eskg1tH2CxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8dksXTrTUYHbo/LV7w9
        Fu95yeQxYdEBRo+Wk/tZPL6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrgjMq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndFwcwtzwSrZitZ5
        xxgbGN+JdzFycEgImEgcXKnRxcjFISSwg1Fi2apJLCBxXgFBib87hLsYOTmEBcwkvj1exwZi
        CwkoSZxbM4sRpERYwEDiVq85SJhNQE/i55IZYCUiAm0sEutPs4PYEgK8EjPan7JA2NIS25dv
        BWvlFPCTuH84CyKsIfFjWS8zhC0qcXP1W3YY+/2x+YwQtohE672zUDWCEg9+7oaKS0ocOvSV
        DeKRfIkNBwIhwjUSb5cfgCrRl7jWsRHsAl4BX4k/MxaDxVkEVCWmv14ANdJFouHBAlYQm1lA
        XmL72znMICOZBTQl1u/Sh5iuLHHkFgvMTw0bf7Ojs5kF+CQ6Dv+Fi++Y94QJolVNYlGTEURY
        RuLr4fnsExiVZiHCeBaStbMQ1i5gZF7FKJZaUJybnlpsVGAIj9Xk/NxNjOAEq+W6g3Hy2w96
        hxiZOBgPMUpwMCuJ8K6wfJ0kxJuSWFmVWpQfX1Sak1p8iNEU6OGJzFKiyfnAFJ9XEm9oYmlg
        YmZmaG5kamCuJM7rlbIhUUggPbEkNTs1tSC1CKaPiYNTqoGJZT/nobV2xRs2uxTVM/jxBjDM
        2PwmQXRfqfP7Qim74Pi6DR/CNV92ZYu77/3wyDn+6JK9USEG0fxPV/W4/cpW8U3KfiHQYfN9
        y8fD5i5Rhjz6m4MDrtS9T9uivWv+01TrG/bPpts4KiSE73mSvsTsQZpG4tytSx8WKkQyrna4
        6tf9Ma3fcv5hoDOrdLav8Be8s5kv0vKZQ4P+Vam9xpXn90jGx3xXZzXLXlN4Z5PcsV0fu3Ln
        FyTGmC/pTTW6lOSqZnD+3d9o8cn12j5XFh8JvfX8wl6bCxb3Mtc5lZ4yE/oXVSqydmvTQkm/
        fYybDTN3+nocsY4zkPscLP1hnUBW91aja2/OrZrWl6dhpsRSnJFoqMVcVJwIAKiu7fo5BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
References: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Messages are modified to fit the format of others.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c |  2 +-
 drivers/ufs/core/ufshcd.c    | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 5a571960c93a..efdfa74b4c1b 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -230,7 +230,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 		 * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
 		 * on/off will be done while clock scaling up/down.
 		 */
-		dev_warn(dev, "To control WB through wb_on is not allowed!\n");
+		dev_warn(dev, "It is not allowed to configure WB!\n");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5099d161f115..6460e3c643fa 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5737,13 +5737,13 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
 	if (ret) {
-		dev_err(hba->dev, "%s Write Booster %s failed %d\n",
-			__func__, enable ? "enable" : "disable", ret);
+		dev_err(hba->dev, "%s: Write Booster %s failed %d\n",
+			__func__, enable ? "enabling" : "disabling", ret);
 		return ret;
 	}
 
 	hba->dev_info.wb_enabled = enable;
-	dev_info(hba->dev, "%s Write Booster %s\n",
+	dev_dbg(hba->dev, "%s: Write Booster %s\n",
 			__func__, enable ? "enabled" : "disabled");
 
 	return ret;
@@ -5757,11 +5757,11 @@ static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 	ret = __ufshcd_wb_toggle(hba, enable,
 			QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
 	if (ret) {
-		dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: %d\n",
-			__func__, enable ? "enable" : "disable", ret);
+		dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed %d\n",
+			__func__, enable ? "enabling" : "disabling", ret);
 		return;
 	}
-	dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
+	dev_dbg(hba->dev, "%s: WB-Buf Flush during H8 %s\n",
 			__func__, enable ? "enabled" : "disabled");
 }
 
@@ -5775,14 +5775,13 @@ int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
 	if (ret) {
-		dev_err(hba->dev, "%s WB-Buf Flush %s failed %d\n", __func__,
-			enable ? "enable" : "disable", ret);
+		dev_err(hba->dev, "%s: WB-Buf Flush %s failed %d\n",
+			__func__, enable ? "enabling" : "disabling", ret);
 		return ret;
 	}
 
 	hba->dev_info.wb_buf_flush_enabled = enable;
-
-	dev_dbg(hba->dev, "%s WB-Buf Flush %s\n",
+	dev_dbg(hba->dev, "%s: WB-Buf Flush %s\n",
 			__func__, enable ? "enabled" : "disabled");
 
 	return ret;
@@ -5800,7 +5799,7 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 					      QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE,
 					      index, 0, &cur_buf);
 	if (ret) {
-		dev_err(hba->dev, "%s dCurWriteBoosterBufferSize read failed %d\n",
+		dev_err(hba->dev, "%s: dCurWriteBoosterBufferSize read failed %d\n",
 			__func__, ret);
 		return false;
 	}
@@ -5885,7 +5884,7 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
 				      QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE,
 				      index, 0, &avail_buf);
 	if (ret) {
-		dev_warn(hba->dev, "%s dAvailableWriteBoosterBufferSize read failed %d\n",
+		dev_warn(hba->dev, "%s: dAvailableWriteBoosterBufferSize read failed %d\n",
 			 __func__, ret);
 		return false;
 	}
-- 
2.25.1
