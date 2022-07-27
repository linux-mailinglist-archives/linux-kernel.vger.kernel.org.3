Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1D5820D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiG0HM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiG0HMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:12:53 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F207E0A7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:12:52 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220727071250epoutp031a5811c4afec0b13c837f01f107497ba~FnjDxuW732964829648epoutp038
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:12:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220727071250epoutp031a5811c4afec0b13c837f01f107497ba~FnjDxuW732964829648epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905970;
        bh=l0Bgpxh4TlvdrkA1gLCilMGgdoJi0qUAAhSNhvZnPXg=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=nStfzfYopHWZ6rbznG4J3lV8gkZX0KVeFxtRgJ6QD63vjyis0isTWp7WQ2p6J8+EV
         gCDaiQKJWm3NWNbe2vW1h7ibI5feoceTEzZczmbiEGH4I+4bJ65xYME9JLdUlmX4Ey
         51JYO1eVqZCx8ysbX1sqVIKYDUHUmvgIh4XJoHzQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220727071250epcas2p3778c09190e5c5250eeac8e237aa36882~FnjDLMhmf2750027500epcas2p3G;
        Wed, 27 Jul 2022 07:12:50 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lt4js5lQ1z4x9Q1; Wed, 27 Jul
        2022 07:12:49 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-98-62e0e571d589
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.87.09642.175E0E26; Wed, 27 Jul 2022 16:12:49 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 7/7] scsi: ufs: wb: Move the comment to the right
 position
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
In-Reply-To: <20220727071143epcms2p4936513ee2d020b914db53f438445801a@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727071249epcms2p4f014deb4b3eef7d37f810bc26b1160e7@epcms2p4>
Date:   Wed, 27 Jul 2022 16:12:49 +0900
X-CMS-MailID: 20220727071249epcms2p4f014deb4b3eef7d37f810bc26b1160e7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmmW7h0wdJBo9WaFucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZiyf3MhYsZatYdfY1awPjLNYuRk4O
        CQETicMzDgHZXBxCAjsYJY79fc3YxcjBwSsgKPF3hzBIjbCAv8TNe+/B6oUElCTOrZkFViIs
        YCBxq9ccJMwmoCfxc8kMNpAxIgJnmSUWPpzCBDGfV2JG+1MWCFtaYvvyrYwgNqeAn8TMqQfY
        IOIaEj+W9TJD2KISN1e/ZYex3x+bzwhhi0i03jsLVSMo8eDnbqi4pMShQ1/ZQO6REMiX2HAg
        ECJcI/F2+QGoEn2Jax0bwU7gFfCVmP9nEth4FgFViWU9W6BOc5E4tfkwWJxZQF5i+9s5zCAj
        mQU0Jdbv0oeYrixx5BYLzFMNG3+zo7OZBfgkOg7/hYvvmPeECaJVTWJRkxFEWEbi6+H57BMY
        lWYhQnkWkrWzENYuYGRexSiWWlCcm55abFRgDI/Y5PzcTYzglKrlvoNxxtsPeocYmTgYDzFK
        cDArifAmRN9PEuJNSaysSi3Kjy8qzUktPsRoCvTwRGYp0eR8YFLPK4k3NLE0MDEzMzQ3MjUw
        VxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAJHlN5uZSFt8Av0t6XfvvLJ3+XXsvt96BU5kf
        b0w+81fmnoB9auIRIcUzXzh4158q/mj07vl7g/9LLPO/h0/cYnetXKv7818V0bvP5wX26lq7
        GH35sXNxlm3hmwCDO49Y51l21NfIPf76xZlpw/33RSIvYte02Pe9ChPb+3qPed2L3a511S8S
        ruqc1tkbKL1AI9J5/SRdRS+7oN4XDa9edzStXbiHe1HnigDzuyz/rNx/ON/T9BG8av1D9Vfe
        BMGkfTl/Nzr2Xb2wjyt6ZvnO5Vzr72Vpm68Q6bR98Det/4mb9H0P49XbXzQG7qwztJicetrk
        xNZjGqGxD34wCtVE/Klzvf3JYTeP5x3lCOvZZkosxRmJhlrMRcWJAF0fKEAyBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <20220727071143epcms2p4936513ee2d020b914db53f438445801a@epcms2p4>
        <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
        <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
        <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
        <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p4>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of the comment is wrong. so fix it.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c91010fb2105..cc149f78f38f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1298,9 +1298,10 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 		}
 	}
 
-	/* Enable Write Booster if we have scaled up else disable it */
 	downgrade_write(&hba->clk_scaling_lock);
 	is_writelock = false;
+
+	/* Enable Write Booster if we have scaled up else disable it */
 	ufshcd_wb_toggle(hba, scale_up);
 
 out_unprepare:
-- 
2.25.1
