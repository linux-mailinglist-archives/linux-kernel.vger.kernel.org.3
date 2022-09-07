Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA685AFC84
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIGGgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiIGGgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:36:06 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F567F267
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:36:02 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220907063600epoutp03ab8aec54fe1393a468ba71c045b3e64f~SgI48G_he2016920169epoutp03f
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:36:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220907063600epoutp03ab8aec54fe1393a468ba71c045b3e64f~SgI48G_he2016920169epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532560;
        bh=HjcTUMoyWdaHPnCmLOh8kNcuQ6iwuc0XrpPsUqipoMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJN9HRYkzLmP5DWIyoFWN0i0Si7exVZviV3TYbYBmNM4UeYq27Zw6uFK109baSLOX
         q55ID4AJsb6rmyH5UGnEXD/iDonPRExXg51+Tbd7xstRaGIFni2PPsI/mziGy7tvBf
         U6aye7OA8kShIXLVIJZREca7Cot+6b0k5g/00Vm8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220907063559epcas5p34f25559f9201b75b8f31ac743b67a57a~SgI3vM33u0209402094epcas5p3H;
        Wed,  7 Sep 2022 06:35:59 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MMsvl48jxz4x9QX; Wed,  7 Sep
        2022 06:35:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.23.53458.3CB38136; Wed,  7 Sep 2022 15:35:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220907063323epcas5p37b1a06b0c0ba5ac685284bf68b40a205~SgGmTu0jz1698316983epcas5p3o;
        Wed,  7 Sep 2022 06:33:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907063323epsmtrp1366ecc663baf3b5ba10ddfe80e7fdb87~SgGmSZ9RB0506905069epsmtrp1w;
        Wed,  7 Sep 2022 06:33:23 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-50-63183bc3d88e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.CC.14392.33B38136; Wed,  7 Sep 2022 15:33:23 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063319epsmtip19a37f3b3c6ee9845a5d1ec6a33d283ea~SgGiqp9B02638126381epsmtip1A;
        Wed,  7 Sep 2022 06:33:19 +0000 (GMT)
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
Subject: [Patch v2 03/15] media: s5p-mfc: Rename IS_MFCV10 macro
Date:   Wed,  7 Sep 2022 12:17:03 +0530
Message-Id: <20220907064715.55778-4-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfVDTdRzH77uH3wY1/R1QfKGLdr8uT1Bwo218mUDcQfZL6eIuyJ4OWtsv
        IMZva79Nw4pWPKgTU1BTiQfjQU4elGDAlGE050kKdjznHRMQjSA7BoRHYtbYRv33+nw+78/3
        8/D9fvlsvwksmJ9F6ykdrVATmC+n40ro5vAr26FSZFzE0D3LaS6arOzAUM3KDAtN1CxxkK2t
        nYfMw9+yUf21Hi6qst/kos4f73DQ97+5ogOnHRw0U3UeoNmy2xhqnR7loqm53WjoUjmGilva
        uajZ7uChurEBFjrb+oiFqtv/5KHCbjsPOawdABUU2VnxkGyqbAKkxVELyLHaRTZ5sczBI2us
        syyyteEgRo6PWjGyrfYLsvDqQw75tbkBkI+/quCRJvsYRi61hpDXl5d4yRveyY7JpBQqSiek
        aKVGlUVnxBK73khPSJfKROJwcTSKIoS0IoeKJRKTksN3ZKldayCEexRqg8uVrGAYYltcjE5j
        0FPCTA2jjyUorUqtlWgjGEUOY6AzImhKLxeLRJFSl/D97MyF72rY2kfRn9y/IDMCp8gEfPgQ
        l8B/Jqd5a+yHdwHYMvuxCfi6eBFAc48NeIwHAFavHAPrGSs3nJgn0A2g6X4fy2Pks6B99KBb
        heFb4YP5G9gaB+BfAjh9QL8mYuP5HOjoW3UX9MfjYf/fZvYac/AX4LHFNneCAI+G+5tquJ5y
        z8HGlh63xgeXw4HjvV5/vg98fFLi4UR4ebyB5WF/OHfNzPNwMJw9UuTlDDixlO8dQQsrjGav
        /iXYM1zOMQG+q7lQeOHSNo/7WXji+nm3hI1vgIdX73rlAmipXGcCVvf1eo+HcOSPdm9rJGxe
        rmJ7lnIYwPnuLu5REFL2f4kzADSAIErL5GRQjFQbSVN7/7s0pSanFbhfethOC5iadEbYAIsP
        bADy2USAQGUJUPoJVIrcfZROk64zqCnGBqSu/ZWwg59SalxfhdaniyXRIolMJpNEvygTE4GC
        41uA0g/PUOipbIrSUrr1PBbfJ9jIevK9kpyzGkrmhx+1bRcqUi6eG255InRLXLPvYKI87c13
        r6bk6gxJzbXn7loXgyLlnGee/gU/Yy9wxoR8hKtRUmT8N8R+/9KZINvGuh3+sbn19wKSdCmn
        LK90LjQGb4oKaSyqit18+cMPwMuBsP/Ovp9PZuH95f3COCtHl8BLOyTa05kWduLt18rmpZ+W
        PBzZ9Xvqr5TeOPtqVi1denMr1ZtUGribLBgaKlnl3zpiNn1eutAZZTxQnPeDZrUwNW9uajA3
        bWoF+ZTUdymFw5mpt6wF8kGBoTTF1llhmvTfSD+/HKVLcMrT/tpZNyK9Tb/+kyqPHJ9K3lte
        TLzlZMo+o3sJDpOpEIexdYziX/VyiqVyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK6xtUSywdQrQhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJXxceFi5oI/lhVv
        1ps1MH4w6GLk5JAQMJH4cfoDWxcjF4eQwG5GiY3/lzJDJCQkVv6exAhhC0us/PecHaKokUmi
        f3MXO0iCTUBH4tv702DdIgKtjBLXV3YygTjMArNZJH5MOsAKUiUs4CBx9u8WsLEsAqoSkz9t
        ZgOxeQUsJdrXLGaFWCEvsXrDAbAaTgEriYtTToDFhYBqHs/Yxj6BkW8BI8MqRsnUguLc9Nxi
        wwLDvNRyveLE3OLSvHS95PzcTYzgyNPS3MG4fdUHvUOMTByMhxglOJiVRHhTdogkC/GmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDkL7K+6aqfFe+C+zpn
        ujofWrAJJvbXpr/7Y5N3VrExfivPp7JO25gSvWkfrgQ/YVhmm7KzRi3DestlqXJNHaYpVvkH
        9l3I7us7rqbAe0XrUezEsMc8EvVfG+1r5lc3+3uqb7zWOH/LmcOfuf2qYn98uRqxqWrybd8M
        oVNxM7fm/fo0p7OgXfHt7UBL5erFIk+nNYrNOlJxvnidT1v9qVeRanlfmaeI/VCJ5bmos1xe
        vTnqyy4e9h+LnKSLVEJMHnVY5fmayjz/7X1D4Fv3+xn6CpyO2+9ODPg3KyH49VLv9SxPWlgW
        OzW/ytE6v1Kxd/tvmWXP+j5F87C3O/wNC6/z7Hy9yDdkY3/2/XlWm5VYijMSDbWYi4oTAdUh
        dhErAwAA
X-CMS-MailID: 20220907063323epcas5p37b1a06b0c0ba5ac685284bf68b40a205
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063323epcas5p37b1a06b0c0ba5ac685284bf68b40a205
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063323epcas5p37b1a06b0c0ba5ac685284bf68b40a205@epcas5p3.samsung.com>
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

Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10 code can
be resued for MFCv12 support. Since some part of MFCv10 specific code
holds good for MFCv12 also.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 10 +++----
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 5304f42c8c72..e6ec4a43b290 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -771,11 +771,11 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define HAS_PORTNUM(dev)	(dev ? (dev->variant ? \
 				(dev->variant->port_num ? 1 : 0) : 0) : 0)
 #define IS_TWOPORT(dev)		(dev->variant->port_num == 2 ? 1 : 0)
-#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60 ? 1 : 0)
-#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
-#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
-#define IS_MFCV10(dev)		(dev->variant->version >= 0xA0 ? 1 : 0)
-#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10(dev))
+#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60)
+#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
+#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
+#define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
+#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
 
 #define MFC_V5_BIT	BIT(0)
 #define MFC_V6_BIT	BIT(1)
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index 72d70984e99a..ffe9f7e79eca 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -236,7 +236,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 	else
 		mfc_write(dev, 0x3ff, S5P_FIMV_SW_RESET);
 
-	if (IS_MFCV10(dev))
+	if (IS_MFCV10_PLUS(dev))
 		mfc_write(dev, 0x0, S5P_FIMV_MFC_CLOCK_OFF_V10);
 
 	mfc_debug(2, "Will now wait for completion of firmware transfer\n");
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 8227004f6746..728d255e65fc 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -72,9 +72,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			  ctx->luma_size, ctx->chroma_size, ctx->mv_size);
 		mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
 	} else if (ctx->type == MFCINST_ENCODER) {
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev))
 			ctx->tmv_buffer_size = 0;
-		} else if (IS_MFCV8_PLUS(dev))
+		else if (IS_MFCV8_PLUS(dev))
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
@@ -82,7 +82,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
 			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
 			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
@@ -133,7 +133,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	switch (ctx->codec_mode) {
 	case S5P_MFC_CODEC_H264_DEC:
 	case S5P_MFC_CODEC_H264_MVC_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
@@ -152,7 +152,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			(ctx->mv_count * ctx->mv_size);
 		break;
 	case S5P_MFC_CODEC_MPEG4_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV7_PLUS(dev)) {
 			ctx->scratch_buf_size =
@@ -172,7 +172,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_VC1RCV_DEC:
 	case S5P_MFC_CODEC_VC1_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else
 			ctx->scratch_buf_size =
@@ -189,7 +189,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_H263_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else
 			ctx->scratch_buf_size =
@@ -201,7 +201,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank1.size = ctx->scratch_buf_size;
 		break;
 	case S5P_MFC_CODEC_VP8_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
@@ -230,7 +230,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			DEC_VP9_STATIC_BUFFER_SIZE;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
@@ -254,7 +254,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
@@ -273,7 +273,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
@@ -452,7 +452,7 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
 					ctx->img_height);
 		} else {
@@ -668,7 +668,7 @@ static int s5p_mfc_set_enc_ref_buffer_v6(struct s5p_mfc_ctx *ctx)
 
 	mfc_debug(2, "Buf1: %p (%d)\n", (void *)buf_addr1, buf_size1);
 
-	if (IS_MFCV10(dev)) {
+	if (IS_MFCV10_PLUS(dev)) {
 		/* start address of per buffer is aligned */
 		for (i = 0; i < ctx->pb_count; i++) {
 			writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
@@ -2455,7 +2455,7 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
 	R(e_h264_options, S5P_FIMV_E_H264_OPTIONS_V8);
 	R(e_min_scratch_buffer_size, S5P_FIMV_E_MIN_SCRATCH_BUFFER_SIZE_V8);
 
-	if (!IS_MFCV10(dev))
+	if (!IS_MFCV10_PLUS(dev))
 		goto done;
 
 	/* Initialize registers used in MFC v10 only.
-- 
2.17.1

