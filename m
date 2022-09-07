Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA75AFC98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIGGiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIGGiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:38:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D00A025F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:38:05 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220907063706epoutp046815be13bb337b6d90e43b68fc3fb69e~SgJ2hvwsc1256812568epoutp04W
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:37:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220907063706epoutp046815be13bb337b6d90e43b68fc3fb69e~SgJ2hvwsc1256812568epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532627;
        bh=pebp5yhzcAp0RQ70IsF3Fog/Q377n/Hruoo7FPLqIqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ifp8MUQ+ZYi9SVcBcMts2/hXEoJe7dWrCuAAnw2ot/EnE4qIRnvk5o8PdATUkqa9A
         QUeZyObjSHKI5RpFoT8Md7VafCmpcPSH0Vdk13XwecrHm8I8afNFHZKKPC80U9j9+T
         vtqeEfII5SIwhUIAuQHnKqeDe4ssbC6zsYciISZY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220907063706epcas5p1c3a5dbd1254217814d578fc45116d976~SgJ19FYWt2134521345epcas5p17;
        Wed,  7 Sep 2022 06:37:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MMsx95WFhz4x9Q2; Wed,  7 Sep
        2022 06:37:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.77.59633.A0C38136; Wed,  7 Sep 2022 15:36:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220907063352epcas5p2deb747c1a6a293fcc7275aed05010552~SgHBQsIy70472404724epcas5p2D;
        Wed,  7 Sep 2022 06:33:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063352epsmtrp2f704ac93ae696291dc5efcbbd8ffcbbc~SgHBORNiY1916519165epsmtrp2L;
        Wed,  7 Sep 2022 06:33:52 +0000 (GMT)
X-AuditID: b6c32a49-dfdff7000000e8f1-58-63183c0a9910
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.DC.14392.05B38136; Wed,  7 Sep 2022 15:33:52 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063348epsmtip1175500c4c56e238da9991a56fd227f41~SgG98Bvrg2482524825epsmtip1k;
        Wed,  7 Sep 2022 06:33:48 +0000 (GMT)
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
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v2 10/15] media: s5p-mfc: Add support for UHD encoding.
Date:   Wed,  7 Sep 2022 12:17:10 +0530
Message-Id: <20220907064715.55778-11-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTeVBTVxTGvS/JS2AafCKOVypL3+hUKGBSyeOydUGnPIswdOw+tfAmeQJD
        tuYF3KhlqRUYWTpjZUSBDiAySCkNSwChIk0GFGuHFo2ljYBAU2g1rQG6UNsmJLT//c4537nf
        vefeK+L5TuP+oiy1ntWpGSWJe/O7vwgJDfeOg3LJYl0Qmus5K0BTtd04avjdhqHJBgcfDXV0
        CVHn+Dkeujg8KEB1ppsCZLx6j48++9FZHTtr5SNbXRtA89V3cWSYuS1A0wuvoW/6zuPoVHuX
        AH1isgrRBcsYhpoMf2GovmtRiE4MmITI2t8N0PsfmLDnIN1a2wroHmsjoC2ND3l0b7VVSDf0
        z2O0oaUEp7+/3Y/THY3v0SfMf/Lp8s4WQP9dWCOkS00WnHYYAunrSw5hqs+b2XGZLKNgdcGs
        Wq5RZKkz4smk/Wm702SURBoujUZRZLCaUbHx5J59qeEvZCmdYyCDcxlljjOVynAcufOZOJ0m
        R88GZ2o4fTzJahVKbaQ2gmNUXI46I0LN6mOkEsnTMqcwPTuzb9iMaSs3HL5mMeP5oNWnFHiJ
        IBEJLw4+wkuBt8iXuAxg7VUjzx08BLDtjhm4g2UA+4drwFqLpdfIdxcGAFwpb8TcQREGS6vc
        KpwIg8v2UdzFfkQBgDPFepeIRxTxofXGitBV2EgkwnxLvsDFfGI7/Nw+4lxWJBITMdA+T7nd
        guCl9kGei72c6bHTIwLXOpA46QXrpn/C3KI9sKBsTuDmjXBhuFPoZn/oeDCAuzkDTjqKPEfQ
        wpr8Tk/vs3Bw/PyqL48IgZ/27XSnA+BH19tWJTzCB5atzHrkYthTu8YkrL8x4rGC8Nb9Ls8W
        aFg50O6ZUBmA31aUCCtBYPX/Fh8D0AK2sFpOlcFyMq1UzR7679rkGpUBrL710L09wDr1S8QQ
        wERgCEARj/QTK3r85L5iBXPkKKvTpOlylCw3BGTO+X3I898k1zg/i1qfJo2MlkRSFBUZvYuS
        kpvFp58Ccl8ig9Gz2SyrZXVrfZjIyz8fox7/rWmUAOozdEjVlic1UfslFXdHKTwl7aZ3coG3
        TXmS4i4sv52XWdoc2HzvOLGtuLmlq2r7I1nBLJWs3THoVx+/HhXWR7GtZFbUV6oUERVuU73M
        HApKwqYTjr14UFGRsG63X1jxtfEExbmFK7mSAp9yu3JdSuDh2eipy/ZNwol9ARMbwBOyr2PX
        12pmytWFhu9yE81L8i8PNL5jtD7I+oHdu9l8/634xwrbbPyQV429MaOTnQdfbzJRAXeYreVz
        fAG7Lbkj98zMlV9fiv0HyLVi0Slu17utjtgSo+2P7rylxe6jK0eiOo7xJlDLree3Jh1/Jf2N
        dHvez5cSzWG+B3aQfC6TkYbydBzzL2UdkdB0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG6AtUSywcIdHBZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJWx6/hRpoIJghUn
        rx9la2Bcw9fFyMkhIWAicX3ndpYuRi4OIYHdjBKL7u9ng0hISKz8PYkRwhaWWPnvOTtEUSOT
        xOE7U8ASbAI6Et/en2YDSYgItDJKXF/ZyQTiMAvMZpH4MekAK0iVsIC7RMP1BjCbRUBVYt/7
        E0D7ODh4Bawk3r80g9ggL7F6wwFmEJsTKHxxygmwciEBS4nHM7axT2DkW8DIsIpRMrWgODc9
        t9iwwDAvtVyvODG3uDQvXS85P3cTIzjytDR3MG5f9UHvECMTB+MhRgkOZiUR3pQdIslCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MLHE2P9NNr7oETph
        oa6dYT9v/fvZEnb2bJ/37V5aGBjTIbC7S1/kysnlOx7ONTX8OiX+deKDeVwH82Xc5aInCGtd
        dY+4788uypXf3vPnZKRd+NP1G2/9fu4ae8PUqE+Y7fk15e/iG277aN65zXKvXnxdo2336o3v
        gzYtXZkeJsCkKif5e7XSnetCmU7sQmf2fFv87JulDpPm73tfHn4KuXI4jmF+57vaz+qN3rOV
        TY9P+H5m0g2BzFMCzmu0jLfqP9ghc7Y25vyXX8e/dpV5Wxnae3tMtumMf6plf3B//7QzAZwd
        nrsm5lh35P3jChbj17hxparmmrpj+Mvl8ZNsF575tq6uOyxJxdC5v531tRJLcUaioRZzUXEi
        AIbg8hkrAwAA
X-CMS-MailID: 20220907063352epcas5p2deb747c1a6a293fcc7275aed05010552
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063352epcas5p2deb747c1a6a293fcc7275aed05010552
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063352epcas5p2deb747c1a6a293fcc7275aed05010552@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFC driver had restriction on max resolution of 1080p, updated it for
UHD. Added corresponding support to set recommended profile and level
for H264 in UHD scenario.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c |  9 ++++++---
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  | 12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 3eac592f369f..119e55c6f759 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1627,9 +1627,12 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			mfc_err("Unsupported format by this MFC version.\n");
 			return -EINVAL;
 		}
-
-		v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
-			&pix_fmt_mp->height, 4, 1080, 1, 0);
+		if (IS_MFCV12(dev))
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 3840, 1,
+					&pix_fmt_mp->height, 4, 2160, 1, 0);
+		else
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
+					&pix_fmt_mp->height, 4, 1080, 1, 0);
 	} else {
 		mfc_err("invalid buf type\n");
 		return -EINVAL;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index c0b8434812e0..db06e3387d14 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1118,6 +1118,18 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
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

