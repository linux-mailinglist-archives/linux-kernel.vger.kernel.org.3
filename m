Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4D52A27B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346942AbiEQNBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346990AbiEQM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:42 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146184EDDF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:58:34 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517125829epoutp02c40a9337bd4c7974c3b1bb025b8d86f6~v5dlMnp4a1344913449epoutp02P
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:58:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517125829epoutp02c40a9337bd4c7974c3b1bb025b8d86f6~v5dlMnp4a1344913449epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792309;
        bh=UaUnqHztRkuZ9ODDtfRk9jp4qglgayWYabGzgPoxivo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQHZpBiAQYf/6t1965J7ww9l+UOtj8EWy42GhFDNNOPwJLSf9lNoBb0nfbRpO8XhQ
         fqG00UP20kfSOBC5U+zy4kLCSSab2ESo2/nSFlYbgChiB9S8iJA668CG9qz+FYQRhl
         jbQQKClxqEdQ4w1ie/ZyxE9X0x/fBPPTZ5YvpvPA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125828epcas5p3e0333ee7f1a7c8468f4470da0292bacc~v5dkgKnFe0661806618epcas5p3v;
        Tue, 17 May 2022 12:58:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2blN4nLGz4x9Px; Tue, 17 May
        2022 12:58:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.3C.09762.0FB93826; Tue, 17 May 2022 21:58:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220517125625epcas5p3a5d6e217570e2e2f4e11b4c099d45767~v5bxjtzBM0744707447epcas5p37;
        Tue, 17 May 2022 12:56:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125625epsmtrp19864d6aa5a140cadabf0e56cf9cfb6d6~v5bxiwNpa3276532765epsmtrp1e;
        Tue, 17 May 2022 12:56:25 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-f0-62839bf0d742
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.AA.11276.97B93826; Tue, 17 May 2022 21:56:25 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125622epsmtip1349af073d55ce068853372881a21b00c~v5buhHb3O1797117971epsmtip1I;
        Tue, 17 May 2022 12:56:22 +0000 (GMT)
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
Subject: [PATCH 11/20] media: s5p-mfc: Add support for UHD encoding.
Date:   Tue, 17 May 2022 18:25:39 +0530
Message-Id: <20220517125548.14746-12-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTeVBTVxTGe99LXh4yoa9ghwsKMqGiWIGkhHihQGUK9lk6lU7pMG1HMZDX
        sIQkzQsu2AUqUANIcUZbRMHKZgfZGkhKAZXGOHSg4wyWpUxlk8qmVMpWqIJNTGj/+51zv3O+
        M+feS+LOg4Q7mazUMhqlVCEgNnGMN319/eYunEwQtj70RKNlRgJVrExiaKRigYNMTQYeau69
        gKMrnR1cdMl8m4t++OkeB30/ZTntOT/EQZOX6gGaLhkmkH68n4vGZuLQr60XCVTQaOCiOvMQ
        D1UN9GCoWv8EQ+WGRR7KuWbmoaF2I0DZuWZsrytdW1YL6JahSkAPVM7j9I8lQzy6on0ao/U1
        OoK+299O0E2Vn9M5t/7h0IXNNYBe/6KUR+eZBwh6Qe9Jdy0t8GKcPkgNTWKkMkbjxSgTVbJk
        pTxMEP1u/OvxQRKhyE8UjPYIvJTSNCZMEPlWjN++ZIVlAwKvI1JFuiUVI2VZQUB4qEaVrmW8
        klSsNkzAqGUKtVjtz0rT2HSl3F/JaENEQuErQRbh4dSkopUwtfn5Y/k93Vgm0PHzgAMJKTG8
        M9WJ54FNpDPVBmBbRzVmC+YBLM4f5FlVztQygGf1H25U5K+t2SuuAVgz12EPsjH455Ny3Koi
        qN1w+VE3YeXNVBaA46e0Vsapxzg83+tpZRcqEk7XVj9z4FDb4dJqDmZlPhUCJx7c5drctsGr
        jVYDknSw5EvXD1q9IPWUhMU3jIRNEwlbxi4DG7vAmc5mno3d4fRXuXaWw5GFk3aNGpZmNmM2
        fg129F7kWPvjlC9saA2wpT3gua56zDayEzz9+A+7nA9byjZYAMt/+dneHsK+WYN9ZBpW1Ro4
        tp2cBtA8f4YoAp4l/1t8C0ANcGPUbJqcYYPUgUrm6H93lqhK04Nnb3xXdAu4NzrnbwIYCUwA
        krhgM194LDPBmS+THs9gNKp4TbqCYU0gyLK/M7j7i4kqyydRauNF4mChWCKRiIMDJSKBK596
        mpXgTMmlWiaVYdSMZqMOIx3cMzHvnZmxDeibkVJ9NnXWuIjnRgkfPld4vWExdHrp/S9dONdX
        01/uK96/+29u/8xMLzvsk7pocttKFn5StDUwtg6mZHs6RtyeHx/NitpinH/bsUJ34FPvmfIt
        U59NREZLCnLWPloQO6aoFN0HPFZLMlQnfu9sc5mdUa7NroXj6wXyWx5/fR13o+pwvi4g6lDp
        3r7J2D2tfU2Fy7qbPViDSpdy4txg3dzBuDdmNWPtL2yr63rpaKPsY2/TIZmo7cGKeDC5LaJX
        R1ZO/JblumPnUkG9W9mREINk3yMXp4KMdy5Ld0S8FztcuT/syvHvOvsj7/B9XlXfx6bkV9ny
        +35vdjPhodtNPgIOmyQV7cI1rPRfikRGf2wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnG7l7OYkg50tMhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVls
        enyN1eLhq3CLy7vmsFn0bNjKarH2yF12i6XXLzJZLNv0h8li0dYv7Bate4+wW9zds43RoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYwe/5rmsnt0HbnO5vF5k5zHqa+f2QP4orhsUlJzMstSi/TtErgyJvywLTjCX9F98TRTA2Mn
        bxcjJ4eEgIlE99+/zF2MXBxCArsZJR7MmMAOkZCQWPl7EiOELSyx8t9zsLiQQBOTxLk7YDab
        gI7Et/en2UCaRQRaGSWur+xkAnGYBSaySEy5/osZpEpYwEXi5ZplYB0sAqoSX3+2MoHYvAJW
        Es9e32GF2CAvsXrDAaB6Dg5OoPjcf7EgppCApcTT/RYTGPkWMDKsYpRMLSjOTc8tNiwwzEst
        1ytOzC0uzUvXS87P3cQIjjQtzR2M21d90DvEyMTBeIhRgoNZSYTXoKIhSYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamVg7LKtbmlYIF/aJd+4KKJuQL
        zqlW25qZOuEip5fOJK3Mdulbk7+59UxIKntbd+TLjvMb5h2wjJFZIN6w5nGMlGqEpQZL9Gyx
        nPo5Ll7fm+6/XJIgf9+s2XbRGZNvbez8UZIzvwfd8lnGct/qXcL80trE+DNK/3bufaqplKQ2
        QeN+5Tafx3MsfxZU/pb/Y1KzvOWKDdshpr28U/LNNX6xmJ0/ultzzrHK0nsrnH+VHJb6MmnK
        mQd3+ddPL+/2SS4wNdYLcyi6qaMcVPaS6c3n0Ny+r6vK7Y+wz97taNJ3dq6odmSU5ftAtaIs
        eb+i3J/28+b06Zt8ZU2e/4BZ/O4yJSfuyMN9zLmPljJYv1RiKc5INNRiLipOBACWsEw8IwMA
        AA==
X-CMS-MailID: 20220517125625epcas5p3a5d6e217570e2e2f4e11b4c099d45767
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125625epcas5p3a5d6e217570e2e2f4e11b4c099d45767
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125625epcas5p3a5d6e217570e2e2f4e11b4c099d45767@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFC driver had restriction on max resolution of 1080p,
updated it for UHD. Added corresponding support to
set recommended profile and level for H264 in UHD scenario.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c |  4 ++--
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 456edcfebba7..9b624f17e32b 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1630,8 +1630,8 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			return -EINVAL;
 		}
 
-		v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
-			&pix_fmt_mp->height, 4, 1080, 1, 0);
+		v4l_bound_align_image(&pix_fmt_mp->width, 8, 3840, 1,
+			&pix_fmt_mp->height, 4, 2160, 1, 0);
 	} else {
 		mfc_err("invalid buf type\n");
 		return -EINVAL;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 7db7945ea80f..2b6d6259a209 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1127,6 +1127,18 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 	reg |= ((p->num_b_frame & 0x3) << 16);
 	writel(reg, mfc_regs->e_gop_config);
 
+	/* UHD encoding case */
+	if ((ctx->img_width == 3840) && ctx->img_height == 2160) {
+		if (p_h264->level < 51) {
+			mfc_debug(2, "Set Level 5.1 for UHD\n");
+			p_h264->level = 51;
+		}
+		if (p_h264->profile != 0x2) {
+			mfc_debug(2, "Set High profile for UHD\n");
+			p_h264->profile = 0x2;
+		}
+	}
+
 	/* profile & level */
 	reg = 0;
 	/** level */
-- 
2.17.1

