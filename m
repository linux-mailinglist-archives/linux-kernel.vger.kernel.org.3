Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B75691D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiGFS3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiGFS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:29:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99134DA8;
        Wed,  6 Jul 2022 11:29:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s1so23219940wra.9;
        Wed, 06 Jul 2022 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRhpgcalr07YkEQC06e4quRgCbSsA86eLkAqCnDRLp8=;
        b=pcydag+pErwwrdcsmjf+nFIVxjSqKs3nSu05sEc+DitNQRoW43UAfrWUOvZR5eJbGU
         XiE5mJ2bYJ+uqPX+b6HKuNlkKSZ8SzLTaugHjQgkcOmwONArnOB0T8++e71Lti63s8Nt
         NMO95ub8vty+cf7GwftldTDIx+6zgB9/9LC92KBVy/UVMlYotWQBrlAbC70r15BU9oSM
         sYfr+n9/93qVCTRXS1I7tbqY2SaacHWmGwYnmm51IqDpuZHDCiw+8dFoekXyiinSQMES
         Lp1IEXFlwhXbJEHpKVbM1Y2LAYKKVuTxdP+C/lBxjgRZrDfnEat17Qzxq7G4Ghwl7FUn
         3sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRhpgcalr07YkEQC06e4quRgCbSsA86eLkAqCnDRLp8=;
        b=G6aC6oij9bC2tt2qFT5TDZ1cc0xIrQ8614PI9l9Tjc8M+Fve/vFqFXppiFDCNzz62h
         9z6Hm57ILGe3o1AAkphURvfpIbA0dUC0zCW6QD/suj03CYQetJO8WA4Qw6qK4+08wpeD
         w7h3oi+v9loFPtU/Hra6KF2NKCXlmSwGIiazGdqfD7u65x32w0EkuTTQDtt12pg5selQ
         Lln+sZz6wBuTBmkmw0Xr+YD38fk1uRZASJVLOUpifltdj9Ds64ru2rKEG/hksh0/GvkU
         3dGFcAAH5hpfwW1tI+tDyAr3H4xzPeBWTdwbLzzaac8mYDsjTM3LLEOgXAq61wdCgiuQ
         fA9A==
X-Gm-Message-State: AJIora+D/FqeGBzmnfW5GLm7PKRp38YjSUj4tSx0RmmUIbY7SbA+out0
        hWPIcqDV+BxpF7lU6QIHdIg=
X-Google-Smtp-Source: AGRyM1vqDJph0zXaYU+mKDtrGOKYY+x7Ui4yKgelPc1/miuilxQ3TdUsAbj7Z1VEKJsMxiRYhuCZ9w==
X-Received: by 2002:adf:dd82:0:b0:21d:62e3:a51 with SMTP id x2-20020adfdd82000000b0021d62e30a51mr21961682wrl.324.1657132159236;
        Wed, 06 Jul 2022 11:29:19 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm5142406wru.28.2022.07.06.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:29:18 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 6/7] media: hantro: Store VP9 bit depth in context
Date:   Wed,  6 Jul 2022 20:29:00 +0200
Message-Id: <20220706182901.78949-7-jernej.skrabec@gmail.com>
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

Now that we have proper infrastructure for postprocessing 10-bit
formats, store VP9 bit depth in context.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 01d33dcb0467..afddf7ac0731 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -324,6 +324,24 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct hantro_ctx *ctx;
+
+	ctx = container_of(ctrl->handler,
+			   struct hantro_ctx, ctrl_handler);
+
+	switch (ctrl->id) {
+	case V4L2_CID_STATELESS_VP9_FRAME:
+		ctx->bit_depth = ctrl->p_new.p_vp9_frame->bit_depth;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
 	.try_ctrl = hantro_try_ctrl,
 };
@@ -336,6 +354,10 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
 	.s_ctrl = hantro_hevc_s_ctrl,
 };
 
+static const struct v4l2_ctrl_ops hantro_vp9_ctrl_ops = {
+	.s_ctrl = hantro_vp9_s_ctrl,
+};
+
 #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
 					 V4L2_JPEG_ACTIVE_MARKER_COM | \
 					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
@@ -503,6 +525,7 @@ static const struct hantro_ctrl controls[] = {
 		.codec = HANTRO_VP9_DECODER,
 		.cfg = {
 			.id = V4L2_CID_STATELESS_VP9_FRAME,
+			.ops = &hantro_vp9_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_VP9_DECODER,
-- 
2.37.0

