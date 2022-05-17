Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9552A254
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiEQM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347231AbiEQM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:58:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816BE4DF49
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:57:55 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220517125753epoutp048d3206aaf50a074573645d575bba502a~v5dDqD9Z-1581315813epoutp04R
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:57:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220517125753epoutp048d3206aaf50a074573645d575bba502a~v5dDqD9Z-1581315813epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792273;
        bh=iyrNms+qcdKhc8ovREJxsoI43jh/BUr5xeiyr3fzr+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7Y0l3eInckFgC1K59rUOsAUn43+OAoEF5/i9MvJTDTsve9rgeUGX1oqcVQtI2aY+
         YdPMSB78M10YMNZaBTq7UW1V0g2yKSfSuiX/3FjP9/oXl0dREeXtPVTtSTo3CZdXxX
         FN9ckxGIDHuZ8QKnE0gLIZjO59iHfAF6pNZCQnsY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125753epcas5p3b1ffb20bf2402d8630a95d76b83f6d20~v5dDCF0Fx0547205472epcas5p3k;
        Tue, 17 May 2022 12:57:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2bkh2JN4z4x9Ps; Tue, 17 May
        2022 12:57:48 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.CE.09827.CCB93826; Tue, 17 May 2022 21:57:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125605epcas5p44cbb77e6bc15ceb32a934e326fc777ef~v5bephFxT2591625916epcas5p4z;
        Tue, 17 May 2022 12:56:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125605epsmtrp2965331815c4ee528e6921e252d75c2d2~v5beocCdL0914309143epsmtrp2I;
        Tue, 17 May 2022 12:56:05 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-c8-62839bcc00ec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.AA.11276.56B93826; Tue, 17 May 2022 21:56:05 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125601epsmtip10938db560ea2547dba032f3cb9c85afa~v5bbbK1Qo1799717997epsmtip1M;
        Tue, 17 May 2022 12:56:01 +0000 (GMT)
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
Subject: [PATCH 05/20] media: s5p-mfc: Add initial support for MFCv12
Date:   Tue, 17 May 2022 18:25:33 +0530
Message-Id: <20220517125548.14746-6-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1DTZRzH7/nuu+/GrtEXJHmCg7ivx114/NhgjGcG/kjyvpIQmVF5FQ74
        tu0Y29x3BFY6UNYZAtF5MwH5kRAWosL4mY47nBg0pc4TJMr5A70jSclYEKBAWxv13+vzft7v
        5/Pc53kePsd/nAjiqzQGRq+RqylCgHdfingx6mrNoSzRjP0ZdKeum0CN85MYut3oxJGto4uH
        OkdqOOjUYD8X1Q/8yEU9Fydw1P6ba/ValQNHk/VnAXpQfYtAlns3uOju1Fvo+vkTBCpr6+Ki
        MwMOHvp67BqGmi1PMXSy6y8eMvUN8JDD2g1QyacD2OZAurWuFdC9jiZAjzXNcOjvqh08utH6
        AKMtLZ8R9M0bVoLuaDLSpsuLOF3R2QLo5YO1PLp0YIygnZZQ2j7r5KX77s5NVDLyHEYfxmiy
        tTkqjSKJevWNzK2Z8VKROEosQwlUmEaexyRRyTvSo7ap1K4JUGEfytX5LildzrJUzMZEvTbf
        wIQptawhiWJ0OWqdRBfNyvPYfI0iWsMYNohFoth4l3FPrrKp4gegazMWPjVfJIrA56pS4MOH
        pAS2n7uPlQIB35+8AODEV3/yPMUMgKNTS8BTzAHY3HUMX410FLd6I30AlixYvJESDNrnKjC3
        iyAj4dwfVwg3B5DFAN47bHAzh3zCgVUjoW5eQ74Cf2464vLz+TgZDs8cE7llISmD9vkyzNPs
        BXi6rZ/jtviQG2Dt8nseeYUP+4bTPJwMG3puEh5eA6cGO3keDoLO6T6vroC3nYeAh3WwtqjT
        u/0m2D9yAndvzyEj4LnzMR45BJrtZzHPgX1h+ZP7XrsQ9tatMgVPXh3ytoJw9FEX18M0NB+t
        846nHMCqcQdeCUKr/2/RAEALeJ7RsXkKho3XxWqYgv/uLFubZwH/vvH1Kb3g7p3H0TaA8YEN
        QD6HChCKCouy/IU58n0fMXptpj5fzbA2EO+a3hecoOeyta5PojFkiiUykUQqlUpkcVIxFSgk
        V4qz/EmF3MDkMoyO0a/mML5PUBFWsJfXrEUhCSbhurS+8qjYXW+qrFy9IPf0qZ0JKxkFfrL4
        4d2BpktlhEZavyXSN1hrFhlSJaPmdRnBPy0cDpfM1cbtTxosKNlnfN1y4PK4RCG3KYIVmCAo
        XGcqTiEDsHbQMPzJ1m8axt9xzpo2SZUT/ZMLeMza/exLx+M4D21v123bOFS4Y4UKuzI9z/tV
        LFq74IjcUrmzKPVL4x6jINkcAJcyKpbxRcK68HDvlGEePl7M/H3w5U71u5tz3scsE1Zl5fVd
        36Zayg7IBDU9jtes2K2/W59VzbLbRx9ZfvFTqIY/9ksZSgyJ3S49Wj/2wfTxC9OFs2lLkfbq
        79sP4hEUzirl4vUcPSv/B9MnWh1sBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTYRyG/c7OzjlKk9OyPBkaDDKMWi4sv27eqDwJgVEhWLGOelJRp22m
        JVG2Utq6eOnmXXOz2JxL521eKl2ToZkphStwlpXZzZLM8k5O6b+X3/Pwe/94CQ4/B3UjYiXJ
        rFTCxAswJ7ThqcBjE1t4KcLbosXgu5IGDKomRxD4VjWOQlNtPQ7rXhVy4ANLGxeWmnu4sLH9
        PQprPi/QvnwbCkdK9QB+KRjEoOFDPxcOfQ2DL5uLMHitup4Lq8w2HFZY+xB43zCLwPL63zjM
        eGTGoa21AcDLmWYkwJXWlegAbbSpAW1V/+LQTQU2nFa1fkFog1aB0QP9rRhdq75AZ3RMo/SN
        Oi2g5+XFOK00WzF63OBBd02M46HO4U67otj42BRWutnvhFOM+kYnSKq+cGb2djuWDrJilcCR
        oEgfqvaiDlECJ4JPtgDqtbaTuwQoSjOTC5byCkozP4IvSXKE+padtQgwciP15+czzA5cyAxA
        WTWKxVccMgelblmnOXZrBbmXeq2+ugAIAiXXUVV3vO1nHrmd6pq8hiw1rKUqq9s4dsWR3EEV
        zx+3R/6CMvwEZgPnMuCgBavZJFlCdIJMlCSSsKlCGZMgOy2JFkYmJhjA4mobvIygUTsmNAGE
        ACZAERyBC8/7THoEnxfFnE1jpYli6el4VmYCawhU4MrrVXaK+WQ0k8zGsWwSK/1PEcLRLR3R
        ZZ2XX9cUzBqGgjKPlnaMTW8rm473VDDZK7239t1s1kddrfdkpgzc4iPMREv+3BaH3v2S94Py
        dEV+mDlZn1e+Ly/0s+hW8c89bUJd+C9P/WM/WzMI8ZhpOyzC8/ipQ1O7g3py9ClxrgMhzslX
        lj+wxP3wOpVbJhAvi4G9B4tITHtgNHuup1boLywhS9Ok0Zbl3e1x2ib3+SLxd7eP7sPBuz5V
        qg7lRo713FXf23tyuMJzp0Z+McD3Ie+7ThXoem6ff7AywvnY/lUpFV5wVORT8mN9WnDRX2Of
        pfuNQpyp7L/tu25K8Vd3qmlirtL2fMKI14ym+r44FPjBwZhpahSgshhGtIEjlTH/AFTWF64k
        AwAA
X-CMS-MailID: 20220517125605epcas5p44cbb77e6bc15ceb32a934e326fc777ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125605epcas5p44cbb77e6bc15ceb32a934e326fc777ef
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125605epcas5p44cbb77e6bc15ceb32a934e326fc777ef@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MFCv12, with a new register file and
necessary hw control, decoder, encoder and structural changes.
Add luma dbp, chroma dpb and mv sizes for each codec as per the
UM for MFCv12, along with appropriate alignment.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   | 49 +++++++++++
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 30 +++++++
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 13 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  6 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  8 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 84 +++++++++++++++++--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  2 +
 9 files changed, 178 insertions(+), 21 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
new file mode 100644
index 000000000000..efb77c2bf913
--- /dev/null
+++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
@@ -0,0 +1,49 @@
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
+#define MFC_H264_DEC_CTX_BUF_SIZE_V12   (2 * SZ_1M)
+#define MFC_OTHER_DEC_CTX_BUF_SIZE_V12  (30 * SZ_1K)
+#define MFC_H264_ENC_CTX_BUF_SIZE_V12   (100 * SZ_1K)
+#define MFC_HEVC_ENC_CTX_BUF_SIZE_V12	(40 * SZ_1K)
+#define MFC_OTHER_ENC_CTX_BUF_SIZE_V12  (25 * SZ_1K)
+
+/* MFCv12 variant defines */
+#define MAX_FW_SIZE_V12			(SZ_1M)
+#define MAX_CPB_SIZE_V12		(7 * SZ_1M)
+#define MFC_VERSION_V12			0xC0
+#define MFC_NUM_PORTS_V12		1
+
+/* Encoder buffer size for MFCv12 */
+#define ENC_V120_BASE_SIZE(x, y) \
+	(((x + 3) * (y + 3) * 8) \
+	+ (((y * 64) + 2304) * (x + 7) / 8))
+
+#define ENC_V120_H264_ME_SIZE(x, y) \
+	(ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 64) * 32))
+
+#define ENC_V120_MPEG4_ME_SIZE(x, y) \
+	(ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 128) * 16))
+
+#define ENC_V120_VP8_ME_SIZE(x, y) \
+	ENC_V120_BASE_SIZE(x, y)
+
+#define ENC_V120_HEVC_ME_SIZE(x, y)     \
+	(((x + 3) * (y + 3) * 32)       \
+	+ (((y * 128) + 2304) * (x + 3) / 4))
+
+#endif /*_REGS_MFC_V12_H*/
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 761341934925..a4e3df24b4ae 100644
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
+		.compatible = "samsung,mfc-v12",
+		.data = &mfc_drvdata_v12,
 	},
 	{},
 };
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index ae266d8518d1..eed4d8f71a3a 100644
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
 #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
 #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
 #define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0 ? 1 : 0)
+#define IS_MFCV12(dev)		(dev->variant->version >= 0xC0 ? 1 : 0)
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
index 4b89df8bfd18..37f6c8a80871 100644
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
@@ -357,7 +357,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		pix_mp->width = ctx->buf_width;
 		pix_mp->height = ctx->buf_height;
 		pix_mp->field = V4L2_FIELD_NONE;
-		pix_mp->num_planes = 2;
+		pix_mp->num_planes = ctx->dst_fmt->num_planes;
 		/* Set pixelformat to the format in which MFC
 		   outputs the decoded frame */
 		pix_mp->pixelformat = ctx->dst_fmt->fourcc;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index a8877d805b29..ae2c0977b24e 100644
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
index 728d255e65fc..98c524688b45 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -82,7 +82,53 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
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
+					ALIGN(ctx->img_width, 64) *
+					ALIGN(ctx->img_height, 32) +
+					ALIGN(DIV_ROUND_UP(lcu_width * 32, 4),
+					16) * ALIGN(ctx->img_height, 32) + 128;
+				if (ctx->is_422) {
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				} else {
+					ctx->chroma_dpb_size =
+						ALIGN(ctx->img_width, 64) *
+						ALIGN(ctx->img_height, 32) / 2 +
+						ALIGN(DIV_ROUND_UP(lcu_width *
+						32, 4), 16) *
+						ALIGN(ctx->img_height, 32) / 2 +
+						128;
+				}
+			} else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC &&
+					ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					ALIGN(ctx->img_height, 32) + 64;
+				ctx->chroma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					(ALIGN(ctx->img_height, 32) / 2) + 64;
+			} else {
+				ctx->luma_dpb_size =
+					ALIGN(ctx->img_width, 64) *
+					ALIGN(ctx->img_height, 32) + 64;
+				if (ctx->is_422) {
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				} else {
+					ctx->chroma_dpb_size =
+						ALIGN(ctx->img_width, 64) *
+						(ALIGN(ctx->img_height, 32) / 2)
+						+ 64;
+				}
+			}
+			ctx->luma_dpb_size = ALIGN(ctx->luma_dpb_size + 256, SZ_2K);
+			ctx->chroma_dpb_size = ALIGN(ctx->chroma_dpb_size + 256, SZ_2K);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
 			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
 			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
@@ -230,7 +276,12 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			DEC_VP9_STATIC_BUFFER_SIZE;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ALIGN(ENC_V120_H264_ME_SIZE(mb_width,
+							mb_height), 256);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
@@ -254,7 +305,12 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ALIGN(ENC_V120_MPEG4_ME_SIZE(mb_width,
+							mb_height), 256);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
@@ -273,7 +329,12 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ALIGN(ENC_V120_VP8_ME_SIZE(mb_width, mb_height),
+						256);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
@@ -297,9 +358,15 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_HEVC_ENC:
+		if (IS_MFCV12(dev))
+			ctx->me_buffer_size =
+				ALIGN(ENC_V120_HEVC_ME_SIZE(lcu_width,
+							lcu_height), 256);
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
@@ -452,7 +519,10 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V12(ctx->img_width,
+					ctx->img_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
 					ctx->img_height);
 		} else {
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index e4dd03c5454c..ee2018ee95cc 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -23,6 +23,8 @@
 					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 128)
 #define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * \
 					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 512)
+#define S5P_MFC_DEC_MV_SIZE_V12(x, y)	(MB_WIDTH(x) * \
+					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 1024)
 #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
 #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
 
-- 
2.17.1

