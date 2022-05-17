Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5952452A269
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbiEQM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346886AbiEQM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:23 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783384ECE4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:58:26 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517125822epoutp02a1b87bc1af81cdcdc161897b3b9f5406~v5de3C3AH1207912079epoutp029
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:58:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517125822epoutp02a1b87bc1af81cdcdc161897b3b9f5406~v5de3C3AH1207912079epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792302;
        bh=9iq+mLgOWPSj2EdBDaSGOQv03zpF6lh9YWwwNyuwaU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHbC2lCwdro2rDAOqfKiHT/YnawjQhJNQgLrfFMvMREDoRD5wVqRrT40L0Cj/B1oL
         IUzfluZ0WfRFwag0vVk+q4BBdqFLOGg0Tct2V3tED9giNHGqggErcO/uGST7/wxeCh
         yK4GKAL5b+V4UdxZsjZ8J9SIrZJFxaugC8u/XvZc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220517125822epcas5p4c4a80e5ba36bdf5ec4b61927ae941b4a~v5deB_p7O2388723887epcas5p4K;
        Tue, 17 May 2022 12:58:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2blG069nz4x9Px; Tue, 17 May
        2022 12:58:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.3F.10063.9EB93826; Tue, 17 May 2022 21:58:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220517125622epcas5p324e57e1a7d76f77898d54eb01686945a~v5buZUfw70745207452epcas5p3E;
        Tue, 17 May 2022 12:56:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125622epsmtrp1be2fc9a23b6fc847c86b5406f6a41693~v5buYOrB33276532765epsmtrp1d;
        Tue, 17 May 2022 12:56:22 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-ca-62839be9f0af
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.AA.11276.67B93826; Tue, 17 May 2022 21:56:22 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125618epsmtip11b875d2dd7ae8e925fdc6d73f490bc34~v5brXePFF2352323523epsmtip1g;
        Tue, 17 May 2022 12:56:18 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 10/20] media: s5p-mfc: Add support for rate controls in
 MFCv12
Date:   Tue, 17 May 2022 18:25:38 +0530
Message-Id: <20220517125548.14746-11-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHPb19XGQlN8DCoYusu5MsEB7tBnhKKIpTdhlEyJaFhMywAneU
        tbRdH8rcMpEqKoxNZ0TeMIHBAJmUloGAVIbigMAMCImhoyJG24yxgSgDhmtt2f77/L6/5/md
        c3DM+x6bh+cotLRaIZGT7J3Mrp+D3gi1VeozBH8VRCNrTRcb1a89YqC5+hUmGuw0cZBxqhJD
        TcNmFqodGmehn27MM1HHY4f3TrmFiR7VtgNkq/iNjQwPplnovj0VTV6rYqOvrppY6MqQhYMa
        Z+4w0PeGTQa6bHrCQaf6hzjI0tcF0MnCIcY+P6qtpg1Q3ZYGQM00LGNUT4WFQ9X32RiUoeUs
        m5qd7mNTnQ3HqVM315nU18YWQG0VVHOooqEZNrViCKBGVlc4KV5pshgpLcmi1XxakanMylFk
        i8nE99PfTo+MEghDhSK0h+QrJLm0mDyQlBIanyN3bIDkH5HIdQ4pRaLRkOGxMWqlTkvzpUqN
        VkzSqiy5KkIVppHkanSK7DAFrY0WCgRvRjoCP5JJ6zb7mCozkdcw+jfIB1ZuEfDAIREB50u7
        2UVgJ+5N9AJYWNcEXMYygGdr29zGUwDPn/kFbKdMFI25Hf0AjpraMZdxkgEfb7UznVFsIgQ+
        XRplO9mXOAHggzNaJ2PEBgbLpwKc7EOkwJ7CXpaTmUQgvH6h5AVziWg4M38ac3V7FbZeNTsY
        xz0cevXWYZf8HIeXHiIXH4CVo2MsF/tA+7CR42IetH1T6OZsOLeidx9ABavzjQwX74XmqSqm
        szxGBMEfr4W75F3w4kg7wzWxFyzZWHCHc2F3zTaT8PLYbXd5CO8umtwjUHB28iLHtZISAK36
        FnAOBFT836IOgBbgT6s0udm0JlIlVNBH/7u0TGWuAbx45MEJ3cBi/TNsEDBwMAggjpG+XEFe
        foY3N0vy2TFarUxX6+S0ZhBEOtZ3HuO9nKl0/BKFNl0YIRJEREVFRYjeihKSflzi+YkMbyJb
        oqVlNK2i1dt5DNyDl88QYa2itJ7rp3Ufeu7+dkeZt3ZrpLLxtnlt4FnRkQ/2+beurpQ03wsp
        sO9fFywdtDwRTJSNfQnxOF2qNuggKW1qPGb4Z2GZYA5YCwLy+e++puTs8UqqG+7hvpT1ir7j
        7q5PzTHNvKO/i2/tTvr15o28aZnfdyFfVHZ4re3wWuya0NKpvSX+/Z5lS6uRU6HvvB4v9zz3
        efm470PW/h/kCYnx9tb3ktWBWnvteuzxycWFReNg4hV+YLNuObZYtDkQn3wovrS4whB8QRDH
        TR63Hu4Ubxh5tk/ygvEk/q16mW3vePglmenjzVhxX8KccNYK9WlVf3Ds9w9h0tzhZz7F+jj/
        UpKpkUqEwZhaI/kXOVfY2m0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTYRjG+87OzjlTJqdl9Gn3QYVi6iroK8oSik4GtihXWaIzD1q6tTbt
        ZpHlJZyX0pLMe86STRNdXmuZzaWkUdnFlblKY60tMlELsxi5pP9+z/N74P3jpTiCPNybOixP
        ZJVyaYKQcMObO4WLVh4vTo0OHCjgoo9lzQTSTNow9EEzjiPjnSYSNb4q5qDq7g4uKjc95aKW
        h8M4avgybfuuW3BkK68DyF70nkD6T/1cNOTYi17eLSFQdn0TF902WUh009yHoVv6PxiqbJog
        Ufp9E4kshmaA0jJM2OZ5TG1ZLWBaLVWAMVeNcZi2IgvJaAx2jNHrMglmsN9AMHeqzjHpj6Zw
        JrdRBxjnhVKSUZvMBDOuX8T0/BgnxR7hbhti2ITDx1llQFCUW1zFHwOu6KBPVvX+AingI18N
        eBSk18Bn6ifAxQL6HoDG8u0zPYTa3/lghudArdNGqoHb9OYCBhsmRzkuQdB+8Of3XsIlPOl0
        AM3aTMwVOHQeDq+ap/6t5tChMPtWIe5inF4G26/kcF3Mp9dD8/BFzsyJxbCmvmOaKYo33Zc6
        I1wooNdB6wN0GXhUgFk64MUqVLJYmUqkEMnZE/4qqUyVJI/1P3RUpgf/vubr0wpadKP+RoBR
        wAggxRF68gNPpkQL+DHSU6dZ5dFIZVICqzKC+RQunMd/rn4cKaBjpYlsPMsqWOV/i1E87xQs
        bUARH1Pm0Hjn2w86iid9CXKt9VvwkLtulxyVbNVah4/sXtHu9yMvZK5YLtZ4bq58kUS/rrNJ
        t8D7o56yzqj+zznV/Je9he5heGBGafLbswkhAtu1M6t3JkXkKEtsS8f69vhtut7j19Uxuyz4
        UkFM4IKsFNtjempLavQ2stXZZXFIBpLDisTCybM3jr0olGzkc6O+ROxw2r1UBl4PIJaEZsmy
        dgWIwZlVdS2/85Nrgo0fHCN6ET9Pd3tk8dp7J3iNWp/i58PnQx1IFLQ87lRypL00l/EZsa68
        ufrNV9/B7k7Juvh9EndD+Luw/v2zHh1QtNXhE7KphRGZRc2SNiGuipOKfDlKlfQvlPK6/yQD
        AAA=
X-CMS-MailID: 20220517125622epcas5p324e57e1a7d76f77898d54eb01686945a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125622epcas5p324e57e1a7d76f77898d54eb01686945a
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125622epcas5p324e57e1a7d76f77898d54eb01686945a@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MFCv12, the rc configs are changed with support for
CBR loose, CBR tight and Variable Bitrate (VBR) added.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 22 +++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 425c708eddcc..7db7945ea80f 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1048,10 +1048,24 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 
 	/* reaction coefficient */
 	if (p->rc_frame) {
-		if (p->rc_reaction_coeff < TIGHT_CBR_MAX) /* tight CBR */
-			writel(1, mfc_regs->e_rc_mode);
-		else					  /* loose CBR */
-			writel(2, mfc_regs->e_rc_mode);
+		if (IS_MFCV12(dev)) {
+			/* loose CBR */
+			if (p->rc_reaction_coeff < LOOSE_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* tight CBR */
+			else if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(0, mfc_regs->e_rc_mode);
+			/* VBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		} else {
+			/* tight CBR */
+			if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* loose CBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		}
 	}
 
 	/* seq header ctrl */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index ee2018ee95cc..f09499ba153d 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -44,6 +44,7 @@
 #define ENC_H264_LEVEL_MAX		42
 #define ENC_MPEG4_VOP_TIME_RES_MAX	((1 << 16) - 1)
 #define FRAME_DELTA_H264_H263		1
+#define LOOSE_CBR_MAX			5
 #define TIGHT_CBR_MAX			10
 #define ENC_HEVC_RC_FRAME_RATE_MAX	((1 << 16) - 1)
 #define ENC_HEVC_QP_INDEX_MIN		-12
-- 
2.17.1

