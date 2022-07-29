Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D7584AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiG2E6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiG2E6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:58:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20177B7A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:58:18 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220729045817epoutp02c9d0839bff082512cd4eef12a9854460~GNAJZQWOs1124411244epoutp02D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220729045817epoutp02c9d0839bff082512cd4eef12a9854460~GNAJZQWOs1124411244epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659070697;
        bh=C+qSLm27xL/o9+bgBetSUvgtuKdhEToUNH31soKQtxs=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=cyi5z6S+dJNaAAcZAD8EIUkR27xhBe96YXAfBnH1P4DScTkM+2Nt1fGJIpUTMq+sV
         d2yH8n/YFlxiQDqAqLraWUBlW8YC4vIc4xKM74+MY946xTAnk9x22IqHlyWDe5/Q22
         dkCkmUFhGF6s2U8eRMJOrpzNXfLd5UINn6NA/8bs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220729045817epcas2p3c3b6e7d56f8b7d37d5a9342fe5289bc8~GNAJAv0k01591215912epcas2p3B;
        Fri, 29 Jul 2022 04:58:16 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LvFdh4KBMz4x9QR; Fri, 29 Jul
        2022 04:58:16 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-91-62e368d49efd
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.81.09650.4D863E26; Fri, 29 Jul 2022 13:57:57 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v5 5/6] scsi: ufs: wb: Modify messages
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
In-Reply-To: <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a@epcms2p4>
Date:   Fri, 29 Jul 2022 13:57:56 +0900
X-CMS-MailID: 20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmme6LjMdJBusfKVicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZh3fvYCy4L1nx50xJA+NHkS5GTg4J
        AROJu3dPsnUxcnEICexglDgzaxJzFyMHB6+AoMTfHcIgNcICZhI71+1hBbGFBJQkzq2ZxQhS
        IixgIHGr1xwkzCagJ/FzyQywMSICZ5klFj6cwgQxn1diRvtTFghbWmL78q2MIDangJ/E018L
        GCHiGhI/lvUyQ9iiEjdXv2WHsd8fmw9VIyLReu8sVI2gxIOfu6HikhKHDn1lA7lHQiBfYsOB
        QIhwjcTb5QegSvQlrnVsBDuBV8BXYt/dJUwg5SwCqhLH5kFd5iLx6s1GsIuZBeQltr+dAw4E
        ZgFNifW79CGGK0scucUC81PDxt/s6GxmAT6JjsN/4eI75j1hgmhVk1jUZAQRlpH4eng++wRG
        pVmIQJ6FZO0shLULGJlXMYqlFhTnpqcWGxUYwaM1OT93EyM4nWq57WCc8vaD3iFGJg7GQ4wS
        HMxKIrwCAY+ThHhTEiurUovy44tKc1KLDzGaAv07kVlKNDkfmNDzSuINTSwNTMzMDM2NTA3M
        lcR5vVI2JAoJpCeWpGanphakFsH0MXFwSjUwCU44LBPgvuRi+cKM3hnhOW999q5mUVabWyCa
        //Ie/85v1tW72a6vKs6ynVd5ZgHDczc/Bft4Tz9Wj2zXpNIZYRn+SxK/ZRnbfryy7H6g1d0d
        jrHCsz6EG7Md631U9+fsY4PKXqt9H5Y0v7PUKJjpN8vofYDY627R+c+7tSSf/bltfGrBFINV
        HKKaSjODC7tOPFSMWSxQXB3x9YyV7JqQz7LOvzdWeEjeik0/L1a4aOlPTbnfbBcmK6y+8q35
        a3nB9d1RNVymzT/LzKs7OJ8c/7o/dAXvnR9V3lMO9f6fHmGgEie48MvNow9c73y5Z13M9Y/5
        mdTvO7XfmXlO7jdyd5UrOxvMGXhOSnX5Px5eJZbijERDLeai4kQAgfNBmjAEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
        <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
        <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
        <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p4>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Messages are modified to fit the format of others.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c |  2 +-
 drivers/ufs/core/ufshcd.c    | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 63b02b2541c8..35e4f0056de6 100644
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
index 584e246c769a..309f93122078 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5737,13 +5737,13 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
 	if (ret) {
-		dev_err(hba->dev, "%s Write Booster %s failed %d\n",
+		dev_err(hba->dev, "%s: Write Booster %s failed %d\n",
 			__func__, enable ? "enable" : "disable", ret);
 		return ret;
 	}
 
 	hba->dev_info.wb_enabled = enable;
-	dev_info(hba->dev, "%s Write Booster %s\n",
+	dev_info(hba->dev, "%s: Write Booster %s\n",
 			__func__, enable ? "enabled" : "disabled");
 
 	return ret;
@@ -5761,7 +5761,7 @@ static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 			__func__, enable ? "enable" : "disable", ret);
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
+		dev_err(hba->dev, "%s: WB-Buf Flush %s failed %d\n", __func__,
 			enable ? "enable" : "disable", ret);
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
