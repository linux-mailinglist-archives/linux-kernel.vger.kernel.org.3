Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2099152A251
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbiEQM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347153AbiEQM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:58:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B24D9D1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:57:50 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517125748epoutp0320c516af54101d4d067d40f106faf7ba~v5c_o7zP10460604606epoutp03x
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:57:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517125748epoutp0320c516af54101d4d067d40f106faf7ba~v5c_o7zP10460604606epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792268;
        bh=D+QZdhpWdN6ZoS+YwC+Jj5tOQJOml2CHInZXPoaxBok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CH3UTk7HQhG9vp7kAO9fWRdP3ZLe2Rtj+Do1u2q+BfUMl4KJDKVfYjDxOtfiAo72u
         Gu6oR40xm4DHK1k79ybQhWfQAqms3NYppITVg+DJVqk288BJOPbm1ol2d9fVjt8oj8
         kEfSXf98Ek2Q3yi5XnAjsp5KURV0c91TJJj1WFkQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220517125747epcas5p15d5fb841beab8f6fe8f622f2d00a8c07~v5c97IBe73158031580epcas5p1A;
        Tue, 17 May 2022 12:57:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bkb2zSmz4x9Q6; Tue, 17 May
        2022 12:57:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.CE.09827.7CB93826; Tue, 17 May 2022 21:57:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125601epcas5p47dfcac0c5e0c412eb0c335759c51c941~v5bbTQaZF2591625916epcas5p4w;
        Tue, 17 May 2022 12:56:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125601epsmtrp2389ee57055cba2a33ff5a4d40effd7de~v5bbSChwy0914309143epsmtrp2H;
        Tue, 17 May 2022 12:56:01 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-c2-62839bc755f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.36.08924.16B93826; Tue, 17 May 2022 21:56:01 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125558epsmtip13b54514922231292e87206ec898206a4~v5bYByPVj1800118001epsmtip1H;
        Tue, 17 May 2022 12:55:58 +0000 (GMT)
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
Subject: [PATCH 04/20] media: s5p-mfc: Rename IS_MFCV10 macro
Date:   Tue, 17 May 2022 18:25:32 +0530
Message-Id: <20220517125548.14746-5-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1DTZRzHe77f/SSn3wPLJ+5Abh6BXsCmYz4oZDDKr9V1eGWZ1OEGXwfC
        friNwq67+OUgCiK9zkDYGCy4EBAHLMBRMEdwECaJQBdLfngCeoSxLEVgbXyx/nt93s/n172f
        5+HgvuMsf06aUkdplNIMPsuHYb26MySs70KeTDD4tR+aNFhZqObhLIZu1bgYyN7SxkatIxdw
        VNfXzURGxzUm+q5nmoEuz3lOh8ucDDRrbAJovvx3FrLMjDLR1N130I3OChb6vLmNiRodTjb6
        ZmwYQ7WWFQxVt/3FRme6HGzktFkBytc7sJe2kQ2GBkC2O82AHDMv4WRHuZNN1tjmMdJS/ymL
        nBi1scgW8yfkmd5lBlnSWg/ItdxKNlnkGGORLksgOfDAxU7YfCw9OpWSplCaIEqZrEpJU8pj
        +K+9mSRJihQLhGHCKLSXH6SUKqgYfvzrCWGvpGV4HOAHfSDNyPRICVKtlh/xYrRGlamjglJV
        Wl0Mn1KnZKhF6nCtVKHNVMrDlZRun1Ag2B3pSTyenvpF7SRDbdqbdaW/A2SDq+FFgMuBhAhW
        3+kARcCH40tcATB/1cmggyUAJzpbcTpwAfhDyTK7CHDWSzquHaX1TgDnxsvYdJCPweKpiwxv
        XxbxAvx7cZDl5a1EDoAzhTov48RjHJaNBHrZj4iBs7824N6mDCIYrv520ivziChYeNaA0+tt
        hxebu9dTuMQ+WLn2vncUJPK4UN8zgNE58dBqMrFp9oN3+1o32B+6/uhi0SyHt1x5gGY1rMxu
        3ag9ALtHKhje/jixE17qjKDlAPjVQBNGb7wZFj++vZHOg+2GJ8yH1T/1b4yC8OZCG5O2h4R2
        YxztSDGAhf02dikILP9/QhUA9eA5Sq1VyCltpHq3kvrwvytLViksYP2J73q1HUxN3g+3A4wD
        7ABycP5WniArW+bLS5Ge/ojSqJI0mRmU1g4iPe59ifs/k6zy/BGlLkkoihKIxGKxKGqPWMjf
        xiPcOTJfQi7VUekUpaY0T+owDtc/GxPvvycLjR/Kdf2o/17CORhSOyQoLbVquqbd9cMSx+DK
        6rKk+sSe/jStVV3YW6coOJw241fFVdWAxNPOCXWpfr9KY17QJ38ca7cs76jb9KzEYouL4Lhn
        AmYChs4deZTr94tpu+z29Ub9yWXjQeN79xLfeiRwXEr57JS5RdQ0Xzxn8Tlf9W1I/J+Xebo4
        fYHBfFRkdQWvvZy8xRBqf7rD5D4gK9ixJDfC8CMPoiffiJ3gjZ6rW/H9+e1joQurs1tuTDR2
        HT5x6lBJw9lN8l7UXVkx/TxzetSkyLter8t5d9Fa0MP5J64lT/LwqVTFkJt7/KY7ITjxTlbz
        1PjifXuTLdbIZ2hTpcJduEYr/ReNuSqrawQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnG7i7OYkg3/35CwezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7PY
        9Pgaq8XDV+EWl3fNYbPo2bCV1WLtkbvsFkuvX2SyWLbpD5PFoq1f2C1a9x5ht7i7ZxujRUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3qP16C8Wj74t
        qxg9/jXNZffoOnKdzePzJjmPU18/swfwRXHZpKTmZJalFunbJXBl9C97wFKw0Lxi94mdjA2M
        h/W6GDk4JARMJHaei+hi5OIQEtjBKHF62iKmLkZOoLiExMrfkxghbGGJlf+es0MUNTFJXPl4
        mRUkwSagI/Ht/Wk2kISIQCujxPWVnUwgDrPARBaJKdd/MYNUCQvYSjy/uYYZZB2LgKrE39tZ
        IGFeAUuJjknzmCE2yEus3nAArIRTwEpi7r9YEFMIqOTpfosJjHwLGBlWMUqmFhTnpucWGxYY
        5aWW6xUn5haX5qXrJefnbmIER5qW1g7GPas+6B1iZOJgPMQowcGsJMJrUNGQJMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTjvAVT8H2pStLT+a8d3GK
        z3A+LmtwK3Hyv3O3720wypfI+jf9xWpLhucpTU9PT5xZ7xD8/MzLZ3Nlfe0nLueu33NM2PHg
        khJ1M6/Sfeu55/7gkzi/6MAC/uvJphvMZnw0NAswmnHx9+an8hMDRTcaddp3qums+vy33dZX
        19VA4cfPfrEZ+2f1J07yO3P3ycmcuYeEzruFKCzbLVChpnYkfIrB2W2pW/4at90RVv7fN3Oq
        p8zNcz6C+WIlx3x0V+/byfIr53G5ufXFoE/G75v2ZP9WnSgU82lJtMJai+pliw9N0OVfGiYo
        t9t35fQfszwnLjkY/3L/KrFg1Zuvfi83WhMhJHs2r6AoZIGulGSnohJLcUaioRZzUXEiAPOB
        6a0jAwAA
X-CMS-MailID: 20220517125601epcas5p47dfcac0c5e0c412eb0c335759c51c941
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125601epcas5p47dfcac0c5e0c412eb0c335759c51c941
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125601epcas5p47dfcac0c5e0c412eb0c335759c51c941@epcas5p4.samsung.com>
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

Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10
code can be resued for MFCv12 support. Since some part of MFCv10
specific code holds good for MFCv12 also.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  4 +--
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 5304f42c8c72..ae266d8518d1 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -774,8 +774,8 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60 ? 1 : 0)
 #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
 #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
-#define IS_MFCV10(dev)		(dev->variant->version >= 0xA0 ? 1 : 0)
-#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10(dev))
+#define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0 ? 1 : 0)
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

