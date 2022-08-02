Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5C85878BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiHBIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiHBIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:09:31 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98314192B5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:09:29 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220802080928epoutp01990457f5ed9678bf4d37421576b85b2b~HeMNXZxmL2687226872epoutp01o
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:09:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220802080928epoutp01990457f5ed9678bf4d37421576b85b2b~HeMNXZxmL2687226872epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659427768;
        bh=3jLix4T4XgSy7myOUsJb8gZNbmWtNDyABXmcfSgtTyM=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Sa/6jJcnkcSvqnxRFQaZ8EChCJBVIVs6VZOv7kptHjbv8drbX0TWe/eeTXU61Wa3W
         lyzoEHRpfDfRXQ1g723Xvnk5UsIm2XNlEdBsXwQF1tSjN5B3XuwbB5XREFEx7Oc2Oh
         IqtS26WcxTUM6AZvQ83ondOQolmROwV/Zr13BgH8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220802080927epcas2p12304cfdf89a96bbe75b6859fda206d29~HeMM8a6I_0083000830epcas2p1b;
        Tue,  2 Aug 2022 08:09:27 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LxnhR2Fymz4x9Q2; Tue,  2 Aug
        2022 08:09:27 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-62-62e8dbb7ef20
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.D7.09650.7BBD8E26; Tue,  2 Aug 2022 17:09:27 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6 5/6] scsi: ufs: wb: Modify messages
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
Message-ID: <20220802080927epcms2p1d0d89c32a9bd07c07f233801bb954807@epcms2p1>
Date:   Tue, 02 Aug 2022 17:09:27 +0900
X-CMS-MailID: 20220802080927epcms2p1d0d89c32a9bd07c07f233801bb954807
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmqe722y+SDB63CFqcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/JYunWm4wO3B6Xr3h7
        LN7zksljwqIDjB4tJ/ezeHxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAGZVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PTvJOsBWtlK46/
        esLYwPhRvIuRk0NCwETi2ObtjF2MXBxCAjsYJa4dW8rUxcjBwSsgKPF3hzBIjbCAmcTO41PY
        QGwhASWJc2tmMYKUCAsYSNzqNQcJswnoSfxcMoMNZIyIQBuLxLHOrcwQ83klZrQ/ZYGwpSW2
        L9/KCGJzCvhJTLzxAapGQ+LHsl4oW1Ti5uq37DD2+2PzGSFsEYnWe2ehagQlHvzcDRWXlDh0
        6CsbyD0SAvkSGw4EQoRrJN4uPwBVoi9xrWMj2Am8Ar4SJ2Y2soOUswioSixYIwdR4iLRfrKF
        FcRmFpCX2P52DjNICbOApsT6XfoQw5UljtxigfmpYeNvdnQ2swCfRMfhv3DxHfOeMEG0qkks
        ajKCCMtIfD08n30Co9IsRCDPQrJ2FsLaBYzMqxjFUguKc9NTi40KjODxmpyfu4kRnGS13HYw
        Tnn7Qe8QIxMH4yFGCQ5mJRHeOy7Pk4R4UxIrq1KL8uOLSnNSiw8xmgL9O5FZSjQ5H5jm80ri
        DU0sDUzMzAzNjUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB9DFxcEo1MG38O+FLp7uImajknkeH
        t7kuP/vpQbWBRZ157h/bFmnZJZc1a1Wj+cOTmhYWKCe7mR/+ON/x+yENieRfO48cEWrI+da9
        yOrTIiX3+E/7q6pcuKb3HTB4mKTy/hKH/6+TC7kcu6Qcu2d+D6+9kKhXnd24zobHpJfz1Mqa
        m7uKtwfGZFVxGOxdq6Hgs5pzncWbya8maL/+sfNGR3CCnGWv+e5I4R3vP384M/nLbEGbgnI2
        Zv+n934dvXSjsWqJ01nfb8fquy/XbD7/yHTRCZuz0xNO7mN9nssqvHKi0vS0uXM0/6jONV3z
        gZsteZOkYfznMzkzD8ldu1l058z9Pon3239PlvzA7sHoKXT42uaMllwlluKMREMt5qLiRADr
        C0cbOwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2c0b7f45de4b..117272cf7d61 100644
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
index 5099d161f115..dcd7f03db2a2 100644
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
+	dev_info(hba->dev, "%s: Write Booster %s\n",
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
+	dev_info(hba->dev, "%s: WB-Buf Flush during H8 %s\n",
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
+	dev_info(hba->dev, "%s: WB-Buf Flush %s\n",
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
