Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897395691CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiGFS33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiGFS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:29:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE20FE6;
        Wed,  6 Jul 2022 11:29:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d16so16901686wrv.10;
        Wed, 06 Jul 2022 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Ng520tfT/9dnjqNSA5HxUd0fXaeQJf409msGmKJXxE=;
        b=QSGqlueQamjDuyg6EZa3X4lckicOrxLkBSe/7TAyQdhDhiPLG+QwhYvM28E7VewXGi
         FpxnSAscazmX38EOzgzJJMvWbA2HU1NnBhj9c1nU/HAVK5aK7iqBv0/soD0YOUI3WN2U
         FfkRKaTlORIj9P8bDOshunF6VvhSszvEAcRoYoFCkGtM9Kv5MCkNYHnrrfVsXqgON6DU
         CLWvD2qcfPc/WgES8Bo9vod2QQnbtzOAehXHmXSarL4nxcfjt6nY6OLzegZ9wJglZhQ4
         ozUE6jmQYdt2GVhuQ7cQW/qoCSg1MZabvz0HIFpm82PRWjXE6klk4MkR7146In7cD1wf
         rnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Ng520tfT/9dnjqNSA5HxUd0fXaeQJf409msGmKJXxE=;
        b=Qrz8BUqtZ4/L2DJgLWBNiw5Om3aGRx69um3gTjjruCHSw+aQrUmVNEE2DGeNeXf9vb
         hBUsBZ37TnOIhwuNxeqgLFVRYCL1beqqWrkvx8W2dElP52C2cPziO8eFdB/geX8RSDyJ
         cWQR0QRcL0EzhxUZlRStRHPBTru7b517eZcjrJ91yvjPyaKm1r5EHhxUzzHJb9RmC3p1
         Wh7a57gsavVcT6YPZqHAkXwabZa0JpLIPtd8+GCbIhBXGfAVd7kOOiDJEjiHtz6UKSgU
         sfgcgaFIZtLpnAW5mbKWDVYm3pk/TvuY8QW9UUgMcorUnyQg9x+hgnQuqaA/x6GgVkFC
         Fmtw==
X-Gm-Message-State: AJIora9IKa259uWS9fphPFGyQP6I5G4yn7PzwUJA+SOHBSTbiWsh3W7I
        mzNu/LApGYM339gnbjq1Al0=
X-Google-Smtp-Source: AGRyM1s/r/lLwDka7D3KXMQF65LRPr8LVbQmfB0CAHva2jwjYZmYhq6Ifu8oEswmnJGw2DbnRpDNOg==
X-Received: by 2002:a5d:5c0c:0:b0:21b:c9cb:f973 with SMTP id cc12-20020a5d5c0c000000b0021bc9cbf973mr37430152wrb.424.1657132155439;
        Wed, 06 Jul 2022 11:29:15 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm5142406wru.28.2022.07.06.11.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:29:14 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 3/7] media: hantro: postproc: Fix buffer size calculation
Date:   Wed,  6 Jul 2022 20:28:57 +0200
Message-Id: <20220706182901.78949-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220706182901.78949-1-jernej.skrabec@gmail.com>
References: <20220706182901.78949-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating aux buffers for postprocessing, it's assumed that base
buffer size is the same as that of output. Coincidentally, that's true
most of the time, but not always. 10-bit source also needs aux buffer
size which is appropriate for 10-bit native format, even if the output
format is 8-bit. Similarly, mv sizes and other extra buffer size also
depends on source width/height, not destination.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../staging/media/hantro/hantro_postproc.c    | 24 +++++++++++++------
 drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
 drivers/staging/media/hantro/hantro_v4l2.h    |  2 ++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
index ab168c1c0d28..b77cc55e43ea 100644
--- a/drivers/staging/media/hantro/hantro_postproc.c
+++ b/drivers/staging/media/hantro/hantro_postproc.c
@@ -12,6 +12,7 @@
 #include "hantro_hw.h"
 #include "hantro_g1_regs.h"
 #include "hantro_g2_regs.h"
+#include "hantro_v4l2.h"
 
 #define HANTRO_PP_REG_WRITE(vpu, reg_name, val) \
 { \
@@ -174,18 +175,27 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
 	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
 	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
 	unsigned int num_buffers = cap_queue->num_buffers;
+	struct v4l2_pix_format_mplane pix_mp;
+	const struct hantro_fmt *fmt;
 	unsigned int i, buf_size;
 
-	buf_size = ctx->dst_fmt.plane_fmt[0].sizeimage;
+	/* this should always pick native format */
+	fmt = hantro_get_default_fmt(ctx, false);
+	if (!fmt)
+		return -EINVAL;
+	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
+			    ctx->src_fmt.height);
+
+	buf_size = pix_mp.plane_fmt[0].sizeimage;
 	if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE)
-		buf_size += hantro_h264_mv_size(ctx->dst_fmt.width,
-						ctx->dst_fmt.height);
+		buf_size += hantro_h264_mv_size(pix_mp.width,
+						pix_mp.height);
 	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_VP9_FRAME)
-		buf_size += hantro_vp9_mv_size(ctx->dst_fmt.width,
-					       ctx->dst_fmt.height);
+		buf_size += hantro_vp9_mv_size(pix_mp.width,
+					       pix_mp.height);
 	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_HEVC_SLICE)
-		buf_size += hantro_hevc_mv_size(ctx->dst_fmt.width,
-						ctx->dst_fmt.height);
+		buf_size += hantro_hevc_mv_size(pix_mp.width,
+						pix_mp.height);
 
 	for (i = 0; i < num_buffers; ++i) {
 		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index 334f18a4120d..2c7a805289e7 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -118,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
 	return NULL;
 }
 
-static const struct hantro_fmt *
+const struct hantro_fmt *
 hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
 {
 	const struct hantro_fmt *formats;
diff --git a/drivers/staging/media/hantro/hantro_v4l2.h b/drivers/staging/media/hantro/hantro_v4l2.h
index b17e84c82582..64f6f57e9d7a 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.h
+++ b/drivers/staging/media/hantro/hantro_v4l2.h
@@ -23,5 +23,7 @@ extern const struct vb2_ops hantro_queue_ops;
 
 void hantro_reset_fmts(struct hantro_ctx *ctx);
 int hantro_get_format_depth(u32 fourcc);
+const struct hantro_fmt *
+hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
 
 #endif /* HANTRO_V4L2_H_ */
-- 
2.37.0

