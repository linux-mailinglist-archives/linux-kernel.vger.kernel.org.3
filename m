Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70805AFC83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiIGGgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIGGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:36:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A47FE5E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:36:04 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220907063602epoutp0151909feef494cf326fa33798bd0aaa27~SgI613ke_0439704397epoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:36:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220907063602epoutp0151909feef494cf326fa33798bd0aaa27~SgI613ke_0439704397epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532562;
        bh=bSqoKu2Y9TKJuVzNeVefJjhbFmXaFhMFgBAu50Gg5LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGk+XKa2iHKlSakaoriRfrU/X1F9RMIN3N4AGwe64f24DCHCkr0+xHhlqHKnCe6WA
         KsdGhdm3MprXiKmIw/koBDemCbqA3lCs5YAdgDP7xBZAhxGoVpiLoJaJ/Zxc2mHiQL
         ZGYbxdvaYWUyJuEeuWBgfn3A/6Ru7JWtVfatKaco=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220907063601epcas5p36a9377298b993fc9ebda5afe5cad4e19~SgI6AjJs90368303683epcas5p32;
        Wed,  7 Sep 2022 06:36:01 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MMsvz5mZzz4x9QN; Wed,  7 Sep
        2022 06:35:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.70.54060.CCB38136; Wed,  7 Sep 2022 15:35:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063328epcas5p12c01eb755e3ddfa4fdaee8e4c3bc9527~SgGquR0Mv2639926399epcas5p1u;
        Wed,  7 Sep 2022 06:33:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063328epsmtrp2edfccfb995ed004e4bce1d9ad1c42d76~SgGqtF9NR1916619166epsmtrp22;
        Wed,  7 Sep 2022 06:33:28 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-84-63183bccf1b8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.4F.18644.73B38136; Wed,  7 Sep 2022 15:33:27 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063323epsmtip140bf116fad99d198ae00ce133e08397a~SgGmWLZTY2432724327epsmtip1a;
        Wed,  7 Sep 2022 06:33:23 +0000 (GMT)
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
Subject: [Patch v2 04/15] media: s5p-mfc: Add initial support for MFCv12
Date:   Wed,  7 Sep 2022 12:17:04 +0530
Message-Id: <20220907064715.55778-5-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHc19fX4sT9lJxu5LBSKNuuPGj0OKFwTCTkWeYhsUYNralvLRv
        hVBeX/rKcMQgg6GOgcFF50AKRGAsKD8shbGKrNQK4pBAVkWdBUEcP+bUUV0QCFuhZfvve875
        fHPOPfdesUAySQSIM1kDo2dprZTYgHdeDnk9dPAtqIqoL9uCHnRVCNG96k4C1S1MY2i8zoUj
        W3uHCJkdZwSosd8qRDX2ISH6sXcSRxdm3NWRCieOpmtaAJqtHCOQ6f5NIZqYS0W/WqoIVNrW
        IUTNdqcINYyOYOh70zKGznY8FaHiS3YRcnZ3AvTlETu2C1Lnq88DqstZD6jR+nkB9VOlU0TV
        dc9ilKnpK4K6e7OboNrrD1PFVxZx6ri5CVArhUYRVWIfJSiXKYi69swlSvFLy4rLYGg1ow9m
        WJVOnclq4qXJ+5W7lYroCFmoLAbtlAazdDYTL018LyU0KVPrXoM0+DNam+NOpdA8Lw1/O06v
        yzEwwRk63hAvZTi1lpNzYTydzeewmjCWMcTKIiIiFW4wPSujr/dFrvoIODj31xBeAOp1JcBH
        DEk5nG7sxEvABrGEvAjg/O0eoSeYB/DZb+2YJ3ABWNrwHb5usT63ei0WAO8bK7xUEQZNjlbh
        KkWQb8K/H/9CrGp/8gs3dcywCgnIIhw6B5dEq4VNJAWXTxWuaZzcBqc6+tYMvmQMvDNQIfK0
        exWea7MKVrUPGQtHTl5dGxCSX/vAnj6LwAMlwkcWK/DoTXCu3+w1B0DXo0uER2vguKvIy3DQ
        WGDGPDoBWh1V7vOI3dOFwFZLuCcdCE9da1lDBKQfLFua8uK+sKt6XUvh2cGr3lYQ3vizQ+jR
        FPz2RJvAs5UyAF0TQ6AcBFX+36IWgCawheH4bA3DK7golsn9795UumwTWHvsO5K7wOS9J2E2
        gImBDUCxQOrvq+7yV0l81fTneYxep9TnaBneBhTuBZ4QBGxW6dy/hTUoZfKYCHl0dLQ8Jipa
        Jn3Z9+QbQCUhNbSByWIYjtGv+zCxT0ABVpJ3Y8+h0Vc0T7OUrCXuwOnknjb8mHDAtmTOfP8j
        f0U+BxVswsR1SeHGfkfj6dup/BW1dvtK7vhjO7E3sekDv/gyvOWTNtv+2gDJeL626ugdruz4
        TsfYw/Dt5rBeFJf/ML3y0HAkf+AwupW7YlRt7V4uaUmL1SQN762t8Qt5qRlm6w7WGnsc2DdB
        r+1r5nTnVE30u6Wjwb/Lh3+QZIqff5y0OHfBnB7pyipYXLh4ayElLVcdb5xRzWws//QPU2pr
        cjFdeCbVaSgNm1UmBOofbDNdR3cV1T+rynPfmQOOhoF/VnYpP2zet5nM64yy7T76gnBrxvKY
        2fHksmYPFjg1KcX5DFq2Q6Dn6X8BmUhjhnUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK65tUSywdc9FhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJVx7CB/wbw2xopX
        H8+xNDAuye9i5OSQEDCROPDzAEsXIxeHkMAORok7/z8xQSQkJFb+nsQIYQtLrPz3nB3EFhJo
        ZJLoOBEPYrMJ6Eh8e3+aDaRZRKCVUeL6yk4mEIdZYDaLxI9JB1hBqoQFPCT+TG0C62YRUJV4
        svUYG4jNK2ApcevkTHaIDfISqzccYAaxOQWsJC5OOcEKsc1S4vGMbewTGPkWMDKsYpRMLSjO
        Tc8tNiwwykst1ytOzC0uzUvXS87P3cQIjjwtrR2Me1Z90DvEyMTBeIhRgoNZSYQ3ZYdIshBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1Mx+7t2aTfoXL6
        s/qDesVpfunqbR/u2R28ZnIyKvbD+d6cYNsPGg5m2hOZA+2WOO5wfyDWKLlwl/+T8GRPvcoC
        50rRUMtuCYuTGSl59g0KOnFMIqE8Vtf+PNdj9dCX9HMo0ks6/Nbm2JaAyTbKXosf2nY67Pzc
        yT5ryfOv+y66vkt7voj/9NpD6r254gs9N7oeWdjN+39/8oy7PDaLHsbpiMTVLytzqZIx8WFM
        ijjjrPhOU5RRbN9itxltK6ymTHt5/92crKuMP7eaxBqGplfNbvqnwtm37Ol8FUcB8c3nbni+
        qkzNkD2vNDc20ORutXBeaeGB5/r7Eo5Mld+5I33z3E/pPZKizrNuXhdNk1ViKc5INNRiLipO
        BADWNDlTKwMAAA==
X-CMS-MailID: 20220907063328epcas5p12c01eb755e3ddfa4fdaee8e4c3bc9527
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063328epcas5p12c01eb755e3ddfa4fdaee8e4c3bc9527
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063328epcas5p12c01eb755e3ddfa4fdaee8e4c3bc9527@epcas5p1.samsung.com>
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

Add support for MFCv12, with a new register file and necessary hw
control, decoder, encoder and structural changes. Add luma dbp, chroma
dpb and mv sizes for each codec as per the UM for MFCv12, along with
appropriate alignment.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   | 50 +++++++++++
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 30 +++++++
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 13 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  6 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  8 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 85 ++++++++++++++++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  6 +-
 9 files changed, 175 insertions(+), 30 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
new file mode 100644
index 000000000000..6c68a45082d0
--- /dev/null
+++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Register definition file for Samsung MFC V12.x Interface (FIMV) driver
+ *
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *     http://www.samsung.com/
+ */
+
+#ifndef _REGS_MFC_V12_H
+#define _REGS_MFC_V12_H
+
+#include <linux/sizes.h>
+#include "regs-mfc-v10.h"
+
+/* MFCv12 Context buffer sizes */
+#define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
+#define MFC_H264_DEC_CTX_BUF_SIZE_V12	(2 * SZ_1M)
+#define MFC_OTHER_DEC_CTX_BUF_SIZE_V12	(30 * SZ_1K)
+#define MFC_H264_ENC_CTX_BUF_SIZE_V12	(100 * SZ_1K)
+#define MFC_HEVC_ENC_CTX_BUF_SIZE_V12	(40 * SZ_1K)
+#define MFC_OTHER_ENC_CTX_BUF_SIZE_V12	(25 * SZ_1K)
+
+/* MFCv12 variant defines */
+#define MAX_FW_SIZE_V12			(SZ_1M)
+#define MAX_CPB_SIZE_V12		(7 * SZ_1M)
+#define MFC_VERSION_V12			0xC0
+#define MFC_NUM_PORTS_V12		1
+#define S5P_FIMV_CODEC_VP9_ENC		27
+
+/* Encoder buffer size for MFCv12 */
+#define ENC_V120_BASE_SIZE(x, y) \
+	(((x + 3) * (y + 3) * 8) \
+	+ (((y * 64) + 2304) * (x + 7) / 8))
+
+#define ENC_V120_H264_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 64) * 32)), 256)
+
+#define ENC_V120_MPEG4_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 128) * 16)), 256)
+
+#define ENC_V120_VP8_ME_SIZE(x, y) \
+	ALIGN(ENC_V120_BASE_SIZE(x, y), 256)
+
+#define ENC_V120_HEVC_ME_SIZE(x, y)     \
+	ALIGN((((x + 3) * (y + 3) * 32)       \
+	+ (((y * 128) + 2304) * (x + 3) / 4)), 256)
+
+#endif /*_REGS_MFC_V12_H*/
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 761341934925..c483a95d5e92 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -775,6 +775,8 @@ static int s5p_mfc_open(struct file *file)
 	INIT_LIST_HEAD(&ctx->dst_queue);
 	ctx->src_queue_cnt = 0;
 	ctx->dst_queue_cnt = 0;
+	ctx->is_422 = 0;
+	ctx->is_10bit = 0;
 	/* Get context number */
 	ctx->num = 0;
 	while (dev->ctx[ctx->num]) {
@@ -1638,6 +1640,31 @@ static struct s5p_mfc_variant mfc_drvdata_v10 = {
 	.fw_name[0]     = "s5p-mfc-v10.fw",
 };
 
+static struct s5p_mfc_buf_size_v6 mfc_buf_size_v12 = {
+	.dev_ctx        = MFC_CTX_BUF_SIZE_V12,
+	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V12,
+	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V12,
+	.h264_enc_ctx   = MFC_H264_ENC_CTX_BUF_SIZE_V12,
+	.hevc_enc_ctx   = MFC_HEVC_ENC_CTX_BUF_SIZE_V12,
+	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V12,
+};
+
+static struct s5p_mfc_buf_size buf_size_v12 = {
+	.fw     = MAX_FW_SIZE_V12,
+	.cpb    = MAX_CPB_SIZE_V12,
+	.priv   = &mfc_buf_size_v12,
+};
+
+static struct s5p_mfc_variant mfc_drvdata_v12 = {
+	.version        = MFC_VERSION_V12,
+	.version_bit    = MFC_V12_BIT,
+	.port_num       = MFC_NUM_PORTS_V12,
+	.buf_size       = &buf_size_v12,
+	.fw_name[0]     = "s5p-mfc-v12.fw",
+	.clk_names	= {"mfc"},
+	.num_clocks	= 1,
+};
+
 static const struct of_device_id exynos_mfc_match[] = {
 	{
 		.compatible = "samsung,mfc-v5",
@@ -1657,6 +1684,9 @@ static const struct of_device_id exynos_mfc_match[] = {
 	}, {
 		.compatible = "samsung,mfc-v10",
 		.data = &mfc_drvdata_v10,
+	}, {
+		.compatible = "samsung,fsd-mfc",
+		.data = &mfc_drvdata_v12,
 	},
 	{},
 };
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index e6ec4a43b290..088fd1c96b96 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -19,7 +19,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-v4l2.h>
 #include "regs-mfc.h"
-#include "regs-mfc-v10.h"
+#include "regs-mfc-v12.h"
 
 #define S5P_MFC_NAME		"s5p-mfc"
 
@@ -720,6 +720,8 @@ struct s5p_mfc_ctx {
 	struct v4l2_ctrl *ctrls[MFC_MAX_CTRLS];
 	struct v4l2_ctrl_handler ctrl_handler;
 	size_t scratch_buf_size;
+	int is_10bit;
+	int is_422;
 };
 
 /*
@@ -775,6 +777,7 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
 #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
 #define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
+#define IS_MFCV12(dev)		(dev->variant->version >= 0xC0)
 #define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
 
 #define MFC_V5_BIT	BIT(0)
@@ -782,11 +785,13 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define MFC_V7_BIT	BIT(2)
 #define MFC_V8_BIT	BIT(3)
 #define MFC_V10_BIT	BIT(5)
+#define MFC_V12_BIT	BIT(7)
 
 #define MFC_V5PLUS_BITS		(MFC_V5_BIT | MFC_V6_BIT | MFC_V7_BIT | \
-					MFC_V8_BIT | MFC_V10_BIT)
+					MFC_V8_BIT | MFC_V10_BIT | MFC_V12_BIT)
 #define MFC_V6PLUS_BITS		(MFC_V6_BIT | MFC_V7_BIT | MFC_V8_BIT | \
-					MFC_V10_BIT)
-#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT)
+					MFC_V10_BIT | MFC_V12_BIT)
+#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT | \
+					MFC_V12_BIT)
 
 #endif /* S5P_MFC_COMMON_H_ */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index ffe9f7e79eca..877e5bceb75b 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -130,7 +130,7 @@ int s5p_mfc_reset(struct s5p_mfc_dev *dev)
 			mfc_write(dev, 0, S5P_FIMV_REG_CLEAR_BEGIN_V6 + (i*4));
 
 		/* check bus reset control before reset */
-		if (dev->risc_on)
+		if (dev->risc_on && !IS_MFCV12(dev))
 			if (s5p_mfc_bus_reset(dev))
 				return -EIO;
 		/* Reset
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 268ffe4da53c..411ca1e81a6f 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -146,7 +146,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_HEVC_DEC,
 		.type		= MFC_FMT_DEC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10_BIT | MFC_V12_BIT,
 		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION |
 				  V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM,
 	},
@@ -155,7 +155,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_VP9_DEC,
 		.type		= MFC_FMT_DEC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10_BIT | MFC_V12_BIT,
 		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION,
 	},
 };
@@ -355,7 +355,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		pix_mp->width = ctx->buf_width;
 		pix_mp->height = ctx->buf_height;
 		pix_mp->field = V4L2_FIELD_NONE;
-		pix_mp->num_planes = 2;
+		pix_mp->num_planes = ctx->dst_fmt->num_planes;
 		/* Set pixelformat to the format in which MFC
 		   outputs the decoded frame */
 		pix_mp->pixelformat = ctx->dst_fmt->fourcc;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index b65e506665af..26e3ed2e2b6f 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -92,7 +92,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_HEVC_ENC,
 		.type		= MFC_FMT_ENC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10_BIT | MFC_V12_BIT,
 	},
 };
 
@@ -1179,7 +1179,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
 			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
 					get_e_min_scratch_buf_size, dev);
-			ctx->bank1.size += ctx->scratch_buf_size;
+			if (!IS_MFCV12(dev))
+				ctx->bank1.size += ctx->scratch_buf_size;
 		}
 		ctx->state = MFCINST_HEAD_PRODUCED;
 	}
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
index b9831275f3ab..87ac56756a16 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
@@ -166,9 +166,9 @@ struct s5p_mfc_regs {
 	void __iomem *d_decoded_third_addr;/* only v7 */
 	void __iomem *d_used_dpb_flag_upper;/* v7 and v8 */
 	void __iomem *d_used_dpb_flag_lower;/* v7 and v8 */
-	void __iomem *d_min_scratch_buffer_size; /* v10 */
-	void __iomem *d_static_buffer_addr; /* v10 */
-	void __iomem *d_static_buffer_size; /* v10 */
+	void __iomem *d_min_scratch_buffer_size; /* v10 and v12 */
+	void __iomem *d_static_buffer_addr; /* v10 and v12 */
+	void __iomem *d_static_buffer_size; /* v10 and v12 */
 
 	/* encoder registers */
 	void __iomem *e_frame_width;
@@ -268,7 +268,7 @@ struct s5p_mfc_regs {
 	void __iomem *e_vp8_hierarchical_qp_layer0;/* v7 and v8 */
 	void __iomem *e_vp8_hierarchical_qp_layer1;/* v7 and v8 */
 	void __iomem *e_vp8_hierarchical_qp_layer2;/* v7 and v8 */
-	void __iomem *e_min_scratch_buffer_size; /* v10 */
+	void __iomem *e_min_scratch_buffer_size; /* v10 and v12 */
 	void __iomem *e_num_t_layer; /* v10 */
 	void __iomem *e_hier_qp_layer0; /* v10 */
 	void __iomem *e_hier_bit_rate_layer0; /* v10 */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 728d255e65fc..db8ecc2740d7 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -60,12 +60,14 @@ static void s5p_mfc_release_dec_desc_buffer_v6(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	unsigned int mb_width, mb_height;
+	unsigned int mb_width, mb_height, width64, height32;
 	unsigned int lcu_width = 0, lcu_height = 0;
 	int ret;
 
 	mb_width = MB_WIDTH(ctx->img_width);
 	mb_height = MB_HEIGHT(ctx->img_height);
+	width64 = ALIGN(ctx->img_width, 64);
+	height32 = ALIGN(ctx->img_height, 32);
 
 	if (ctx->type == MFCINST_DECODER) {
 		mfc_debug(2, "Luma size:%d Chroma size:%d MV size:%d\n",
@@ -82,7 +84,46 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
+			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
+			if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC &&
+								ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					width64 * height32 +
+					ALIGN(DIV_ROUND_UP(lcu_width * 32, 4),
+							16) * height32 + 128;
+				if (ctx->is_422) {
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				} else {
+					ctx->chroma_dpb_size =
+						width64 * height32 / 2 +
+						ALIGN(DIV_ROUND_UP(lcu_width *
+						32, 4), 16) * height32 / 2 + 128;
+				}
+			} else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC &&
+					ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					height32 + 64;
+				ctx->chroma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					height32 / 2 + 64;
+			} else {
+				ctx->luma_dpb_size =
+					width64 * height32 + 64;
+				if (ctx->is_422) {
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				} else {
+					ctx->chroma_dpb_size =
+						width64 * height32 / 2 + 64;
+				}
+			}
+			ctx->luma_dpb_size = ALIGN(ctx->luma_dpb_size + 256, SZ_2K);
+			ctx->chroma_dpb_size = ALIGN(ctx->chroma_dpb_size + 256, SZ_2K);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
 			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
 			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
@@ -230,7 +271,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			DEC_VP9_STATIC_BUFFER_SIZE;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_H264_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
@@ -254,7 +299,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_MPEG4_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
@@ -273,7 +322,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_VP8_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
@@ -297,9 +350,14 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_HEVC_ENC:
+		if (IS_MFCV12(dev))
+			ctx->me_buffer_size =
+				ENC_V120_HEVC_ME_SIZE(lcu_width, lcu_height);
+		else
+			ctx->me_buffer_size =
+				ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
+							lcu_height), 16);
 		mfc_debug(2, "Use min scratch buffer size\n");
-		ctx->me_buffer_size =
-			ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width, lcu_height), 16);
 		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
 		ctx->bank1.size =
 			ctx->scratch_buf_size + ctx->tmv_buffer_size +
@@ -452,12 +510,15 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10_PLUS(dev)) {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
-					ctx->img_height);
+		if (IS_MFCV12(dev)) {
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 1024);
+		} else if (IS_MFCV10_PLUS(dev)) {
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 512);
 		} else {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V6(ctx->img_width,
-					ctx->img_height);
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 128);
 		}
 	} else if (ctx->codec_mode == S5P_MFC_CODEC_HEVC_DEC) {
 		ctx->mv_size = s5p_mfc_dec_hevc_mv_size(ctx->img_width,
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index e4dd03c5454c..30269f3e68e8 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -19,10 +19,8 @@
 
 #define MB_WIDTH(x_size)		DIV_ROUND_UP(x_size, 16)
 #define MB_HEIGHT(y_size)		DIV_ROUND_UP(y_size, 16)
-#define S5P_MFC_DEC_MV_SIZE_V6(x, y)	(MB_WIDTH(x) * \
-					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 128)
-#define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * \
-					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 512)
+#define S5P_MFC_DEC_MV_SIZE(x, y, offset)	(MB_WIDTH(x) * \
+					(((MB_HEIGHT(y)+1)/2)*2) * 64 + offset)
 #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
 #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
 
-- 
2.17.1

