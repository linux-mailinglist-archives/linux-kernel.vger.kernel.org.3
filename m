Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C035A5820CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiG0HME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiG0HLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:11:48 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE966E088
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:11:46 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220727071145epoutp017e6990dd62f48a2ed18df2788ea19a57~FniG4dyp32198021980epoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:11:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220727071145epoutp017e6990dd62f48a2ed18df2788ea19a57~FniG4dyp32198021980epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905905;
        bh=aMAw6thkPoTeXrTfsk+Y/If2jxMbn2Y91W57A2JrNSA=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=mBsvF9IZartw/kNaSEDQeUs/SxAelbgybEgyvPI7Av+72Vr6R+eNTVEn1GZGRsoh1
         osx0LOooDcQN24F6HFNWAq81zgMWzdtj7QfsVnTG2z78TErWcsCtT4RFa6bEDO2oVQ
         NWgJVMrh53RhXaw3CH6hIIevUrX2FV5U9urlvnUc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220727071144epcas2p49fd10d35bbea551895b4200f80ddb18e~FniGSi4fq1781017810epcas2p4H;
        Wed, 27 Jul 2022 07:11:44 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lt4hc2jfDz4x9Pw; Wed, 27 Jul
        2022 07:11:44 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-7b-62e0e530b6dc
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.07.09642.035E0E26; Wed, 27 Jul 2022 16:11:44 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 6/7] scsi: ufs: wb: Modify messages
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
In-Reply-To: <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727071143epcms2p4936513ee2d020b914db53f438445801a@epcms2p4>
Date:   Wed, 27 Jul 2022 16:11:43 +0900
X-CMS-MailID: 20220727071143epcms2p4936513ee2d020b914db53f438445801a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmma7B0wdJBptPCFmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ37dsZS24L1mxcF8PewPjR5EuRk4O
        CQETiTm7TzN3MXJxCAnsYJS4M3UeexcjBwevgKDE3x3CIDXCAmYSW7u3MYLYQgJKEufWzGIE
        KREWMJC41WsOEmYT0JP4uWQGG8gYEYGzzBILH05hgpjPKzGj/SkLhC0tsX35VrA5nAJ+Er9+
        dbFCxDUkfizrZYawRSVurn7LDmO/PzafEcIWkWi9dxaqRlDiwc/dUHFJiUOHvrKB3CMhkC+x
        4UAgRLhG4u3yA1Al+hLXOjaCncAr4Cvx7uQ/sPEsAqoSqze1QJ3mInH7wn6wOLOAvMT2t3OY
        QUYyC2hKrN+lDzFdWeLILRaYpxo2/mZHZzML8El0HP4LF98x7wkTRKuaxKImI4iwjMTXw/PZ
        JzAqzUKE8iwka2chrF3AyLyKUSy1oDg3PbXYqMAYHrHJ+bmbGMEpVct9B+OMtx/0DjEycTAe
        YpTgYFYS4U2Ivp8kxJuSWFmVWpQfX1Sak1p8iNEU6OGJzFKiyfnApJ5XEm9oYmlgYmZmaG5k
        amCuJM7rlbIhUUggPbEkNTs1tSC1CKaPiYNTqoGJmzf4P/NMPw/Fto8bz30/cvzDNQub584W
        z4+yxb+fmv0tysxTaz3HL09FS+93n1fVfTB+WT3HuES885fN7+P9auvzPC9WBR9KMhT6s3H3
        f7n/VUp7K/OYy94LCh3jXJB91UnphtlP14eW2/amzk7N+7WdrfTh9QM+Ft/8b+wW3mrvFnzz
        x+72I4FPT+XyZZZbz1hTxXV42uoErztypmqpk0MOc8XysN/w7tuixRr9kSP6yBIxF7PlVX9X
        qpXE1yzbxTf7X4doZPi2p/vnrLr2NNraWUN62sdQhZMqrOv+rXi0dO2jqDvGGrmm1y7GCqsl
        vrvaZLj7kqiys8mdbdELp65g+j2xcXPAac9/NwsfK7EUZyQaajEXFScCANa5WjwyBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
        <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
        <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
        <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p4>
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
index 17a14b046c44..c91010fb2105 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5739,13 +5739,13 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 
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
@@ -5763,7 +5763,7 @@ static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 			__func__, enable ? "enable" : "disable", ret);
 		return;
 	}
-	dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
+	dev_info(hba->dev, "%s: WB-Buf Flush during H8 %s\n",
 			__func__, enable ? "enabled" : "disabled");
 }
 
@@ -5776,14 +5776,13 @@ int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
 
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
@@ -5801,7 +5800,7 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 					      QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE,
 					      index, 0, &cur_buf);
 	if (ret) {
-		dev_err(hba->dev, "%s dCurWriteBoosterBufferSize read failed %d\n",
+		dev_err(hba->dev, "%s: dCurWriteBoosterBufferSize read failed %d\n",
 			__func__, ret);
 		return false;
 	}
@@ -5886,7 +5885,7 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
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
