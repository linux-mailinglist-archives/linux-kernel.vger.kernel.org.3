Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E149154EB12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378556AbiFPUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378299AbiFPUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:25:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184A5B89B;
        Thu, 16 Jun 2022 13:25:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x62so3662712ede.10;
        Thu, 16 Jun 2022 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QE0MYJUwogSBWJFF8vYBtgUrw6+DEPr+dnjgCy1KQbk=;
        b=SgOn8NY50HceKZAiBZ+Z9ohNnPwWQAY2lGLLGempd1U9lPYRxei39w2s7sS94H78FN
         yu5nPxvAspIRzGQyYcanK/zlfaynkxRs4jb3HRJNB4508sYgu2JOYeXakx91Pld8swP7
         Cpehii+c/RvlobGKSU3Q5VyVYJ78C86hsd1lgnYKDtPKK+/GB6cxtgDPF5d1CssVCP1r
         jkL8s6caBq+aJNlja2SQuFzggoO+ge6ghHBQMuMa07BH6n0mvXAmwSwZVRU7X1FOkK4C
         Lsl+DNHqvA2tDfYCl/vV9QcGVDK1ZkOPBRhDZ7TIh0bQEfgl3fjVbHJVgRy3WFm6rin9
         Zysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QE0MYJUwogSBWJFF8vYBtgUrw6+DEPr+dnjgCy1KQbk=;
        b=b2a6C158kSyo5xfOHtjggTymW+nfjyo0QssMw9s40kjYzGzhvoeFFqcVoVSzJ/JW7s
         x0CjxGic9LExz9iOe8E8GLfGpqdb19opDVzak6fcEal1lqrSXe6C7mE1Xx0HsatQH+oO
         PP3N6mEb2I7vFbpy2f1dp4OM1YgIR5XWYQRdy3QncMC/Y4JqiuoU0U7jEs5W3xabNIOw
         lgeaZ4F/zRZLnCCcH4Eh2gzw++dlu1CKyGqGm3MdgHNZ+JZPPprS98aMZKZyYvK1Q2pp
         isPyC6rnkdeo4YqGQnZUI8B4cj1xdCCk94zkVE2OHI8ynnASJuRpVrg6zkpYJqSsMYNf
         7JEQ==
X-Gm-Message-State: AJIora9z8S9CYm5+CbPCM+qLqX+jR6bfjPBUcXDRDYxQLUKbXjuxtqr8
        Viy7uu2LfAc0x1VgvKRv+IsZgj7DcjbWlA==
X-Google-Smtp-Source: AGRyM1v/mW4Dj69VCqINYQ+QCfhRUPkkmgyBgddx/rqzX+PtSvzrLplPksRObJi4l8gMhss94Bft8w==
X-Received: by 2002:a05:6402:61a:b0:433:406a:8d25 with SMTP id n26-20020a056402061a00b00433406a8d25mr8689705edv.276.1655411120447;
        Thu, 16 Jun 2022 13:25:20 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b006fe8a4ec62fsm1186760ejw.4.2022.06.16.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:25:20 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 1/7] media: Add P010 tiled format
Date:   Thu, 16 Jun 2022 22:25:07 +0200
Message-Id: <20220616202513.351039-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616202513.351039-1-jernej.skrabec@gmail.com>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
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

From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Add P010 tiled format

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
[rebased and updated pixel format name]
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 1 +
 drivers/media/v4l2-core/v4l2-ioctl.c  | 1 +
 include/uapi/linux/videodev2.h        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 1e38ad8906a2..e0fbe6ba4b6c 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -278,6 +278,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 
 		/* Tiled YUV formats */
 		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		/* YUV planar formats, non contiguous variant */
 		{ .format = V4L2_PIX_FMT_YUV420M, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e2526701294e..e24d38c0a178 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1310,6 +1310,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
+	case V4L2_PIX_FMT_P010_4L4:	descr = "P010 tiled"; break;
 	case V4L2_PIX_FMT_NV12M:	descr = "Y/CbCr 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV21M:	descr = "Y/CrCb 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV16M:	descr = "Y/CbCr 4:2:2 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5311ac4fde35..32bedeb04152 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -630,6 +630,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV12_4L4 v4l2_fourcc('V', 'T', '1', '2')   /* 12  Y/CbCr 4:2:0  4x4 tiles */
 #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
 #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y/CbCr 4:2:0 32x32 tiles */
+#define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/CbCr 4:2:0 10-bit 4x4 macroblocks */
 
 /* Tiled YUV formats, non contiguous planes */
 #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 64x32 tiles */
-- 
2.36.1

