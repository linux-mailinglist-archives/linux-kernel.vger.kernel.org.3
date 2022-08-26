Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419775A2EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbiHZSfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344976AbiHZSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:47 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E2E5885;
        Fri, 26 Aug 2022 11:33:28 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6A990FF803;
        Fri, 26 Aug 2022 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ungGunLwG1JNVVqyabMQSKwTUnCQFrmuvwotoNsY+I=;
        b=TfPJ2jkfyp9lCI1AlYmAiUQWSdcnvmEiNRhgAI2kZThlZp2PliYHYZBlhmszXAaxnZhEce
        8B01GvAE+V8oGoZi2miHqSu/TGP4yP4lok9m+YbWHcnQYwS/EMHKVsKzUNJ8mlqJk5ndiq
        LQS32Or/vZDsONlFcWZr8wDlc2Xw5dMLlfJTv/xCi7xKyDtXR6/tRVB/p8yrel49Kt6oS3
        IH5WBglyWuIheCcu4EpVSOvhA1d76gC8poRjDyQDJvjSjR5VfmiJAYmmjnbxM//DDtRnh0
        VPbmmKCVfHI146s2tKvy+5hiCTsmAf9/os7Feuv9307WYIBA9AlORP++KxCEmw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v6 17/43] media: sun6i-csi: Rename sun6i_video to sun6i_csi_capture
Date:   Fri, 26 Aug 2022 20:32:14 +0200
Message-Id: <20220826183240.604834-18-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to distinguish between the core csi engine (to be
represented as the bridge) and the dma engine (the capture video
device), rename the video component to capture, with the appropriate
prefix. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 .../media/platform/sunxi/sun6i-csi/Makefile   |   2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |   6 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |   4 +-
 .../{sun6i_video.c => sun6i_csi_capture.c}    | 342 +++++++++---------
 .../{sun6i_video.h => sun6i_csi_capture.h}    |  14 +-
 5 files changed, 186 insertions(+), 182 deletions(-)
 rename drivers/media/platform/sunxi/sun6i-csi/{sun6i_video.c => sun6i_csi_capture.c} (58%)
 rename drivers/media/platform/sunxi/sun6i-csi/{sun6i_video.h => sun6i_csi_capture.h} (64%)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/Makefile b/drivers/media/platform/sunxi/sun6i-csi/Makefile
index 7a699580a641..87e7a715140a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Makefile
+++ b/drivers/media/platform/sunxi/sun6i-csi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-sun6i-csi-y += sun6i_video.o sun6i_csi.o sun6i_csi_bridge.o
+sun6i-csi-y += sun6i_csi.o sun6i_csi_bridge.o sun6i_csi_capture.o
 
 obj-$(CONFIG_VIDEO_SUN6I_CSI) += sun6i-csi.o
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 49f1218b0b28..cffd664cbc0b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -662,7 +662,7 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 	}
 
 	if (status & CSI_CH_INT_STA_FD_PD)
-		sun6i_video_frame_done(csi_dev);
+		sun6i_csi_capture_frame_done(csi_dev);
 
 	regmap_write(regmap, CSI_CH_INT_STA_REG, status);
 
@@ -841,7 +841,7 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
 	if (ret)
 		goto error_v4l2;
 
-	ret = sun6i_video_setup(csi_dev);
+	ret = sun6i_csi_capture_setup(csi_dev);
 	if (ret)
 		goto error_bridge;
 
@@ -863,7 +863,7 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 {
 	struct sun6i_csi_device *csi_dev = platform_get_drvdata(pdev);
 
-	sun6i_video_cleanup(csi_dev);
+	sun6i_csi_capture_cleanup(csi_dev);
 	sun6i_csi_bridge_cleanup(csi_dev);
 	sun6i_csi_v4l2_cleanup(csi_dev);
 	sun6i_csi_resources_cleanup(csi_dev);
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index af3f48a32d5b..a4e93cc2bdfe 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -13,7 +13,7 @@
 #include <media/videobuf2-v4l2.h>
 
 #include "sun6i_csi_bridge.h"
-#include "sun6i_video.h"
+#include "sun6i_csi_capture.h"
 
 #define SUN6I_CSI_NAME		"sun6i-csi"
 #define SUN6I_CSI_DESCRIPTION	"Allwinner A31 CSI Device"
@@ -57,7 +57,7 @@ struct sun6i_csi_device {
 	struct sun6i_csi_config		config;
 	struct sun6i_csi_v4l2		v4l2;
 	struct sun6i_csi_bridge		bridge;
-	struct sun6i_video		video;
+	struct sun6i_csi_capture	capture;
 
 	struct regmap			*regmap;
 	struct clk			*clock_mod;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
similarity index 58%
rename from drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
rename to drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 7254565cbbcf..de8ce116ee63 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -15,7 +15,7 @@
 #include <media/videobuf2-v4l2.h>
 
 #include "sun6i_csi.h"
-#include "sun6i_video.h"
+#include "sun6i_csi_capture.h"
 
 /* This is got from BSP sources. */
 #define MIN_WIDTH	(32)
@@ -26,7 +26,7 @@
 /* Helpers */
 
 static struct v4l2_subdev *
-sun6i_video_remote_subdev(struct sun6i_video *video, u32 *pad)
+sun6i_csi_capture_remote_subdev(struct sun6i_csi_capture *capture, u32 *pad)
 {
 	struct media_pad *remote;
 
@@ -43,7 +43,7 @@ sun6i_video_remote_subdev(struct sun6i_video *video, u32 *pad)
 
 /* Format */
 
-static const u32 sun6i_video_formats[] = {
+static const u32 sun6i_csi_capture_formats[] = {
 	V4L2_PIX_FMT_SBGGR8,
 	V4L2_PIX_FMT_SGBRG8,
 	V4L2_PIX_FMT_SGRBG8,
@@ -73,51 +73,52 @@ static const u32 sun6i_video_formats[] = {
 	V4L2_PIX_FMT_JPEG,
 };
 
-static bool sun6i_video_format_check(u32 format)
+static bool sun6i_csi_capture_format_check(u32 format)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun6i_video_formats); i++)
-		if (sun6i_video_formats[i] == format)
+	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_formats); i++)
+		if (sun6i_csi_capture_formats[i] == format)
 			return true;
 
 	return false;
 }
 
-/* Video */
+/* Capture */
 
-static void sun6i_video_buffer_configure(struct sun6i_csi_device *csi_dev,
-					 struct sun6i_csi_buffer *csi_buffer)
+static void
+sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
+				   struct sun6i_csi_buffer *csi_buffer)
 {
 	csi_buffer->queued_to_csi = true;
 	sun6i_csi_update_buf_addr(csi_dev, csi_buffer->dma_addr);
 }
 
-static void sun6i_video_configure(struct sun6i_csi_device *csi_dev)
+static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct sun6i_csi_config config = { 0 };
 
-	config.pixelformat = video->format.fmt.pix.pixelformat;
-	config.code = video->mbus_code;
-	config.field = video->format.fmt.pix.field;
-	config.width = video->format.fmt.pix.width;
-	config.height = video->format.fmt.pix.height;
+	config.pixelformat = capture->format.fmt.pix.pixelformat;
+	config.code = capture->mbus_code;
+	config.field = capture->format.fmt.pix.field;
+	config.width = capture->format.fmt.pix.width;
+	config.height = capture->format.fmt.pix.height;
 
 	sun6i_csi_update_config(csi_dev, &config);
 }
 
 /* Queue */
 
-static int sun6i_video_queue_setup(struct vb2_queue *queue,
-				   unsigned int *buffers_count,
-				   unsigned int *planes_count,
-				   unsigned int sizes[],
-				   struct device *alloc_devs[])
+static int sun6i_csi_capture_queue_setup(struct vb2_queue *queue,
+					 unsigned int *buffers_count,
+					 unsigned int *planes_count,
+					 unsigned int sizes[],
+					 struct device *alloc_devs[])
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
-	struct sun6i_video *video = &csi_dev->video;
-	unsigned int size = video->format.fmt.pix.sizeimage;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	unsigned int size = capture->format.fmt.pix.sizeimage;
 
 	if (*planes_count)
 		return sizes[0] < size ? -EINVAL : 0;
@@ -128,15 +129,15 @@ static int sun6i_video_queue_setup(struct vb2_queue *queue,
 	return 0;
 }
 
-static int sun6i_video_buffer_prepare(struct vb2_buffer *buffer)
+static int sun6i_csi_capture_buffer_prepare(struct vb2_buffer *buffer)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(buffer->vb2_queue);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
 	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
 	struct sun6i_csi_buffer *csi_buffer =
 		container_of(v4l2_buffer, struct sun6i_csi_buffer, v4l2_buffer);
-	unsigned long size = video->format.fmt.pix.sizeimage;
+	unsigned long size = capture->format.fmt.pix.sizeimage;
 
 	if (vb2_plane_size(buffer, 0) < size) {
 		v4l2_err(v4l2_dev, "buffer too small (%lu < %lu)\n",
@@ -147,62 +148,62 @@ static int sun6i_video_buffer_prepare(struct vb2_buffer *buffer)
 	vb2_set_plane_payload(buffer, 0, size);
 
 	csi_buffer->dma_addr = vb2_dma_contig_plane_dma_addr(buffer, 0);
-	v4l2_buffer->field = video->format.fmt.pix.field;
+	v4l2_buffer->field = capture->format.fmt.pix.field;
 
 	return 0;
 }
 
-static void sun6i_video_buffer_queue(struct vb2_buffer *buffer)
+static void sun6i_csi_capture_buffer_queue(struct vb2_buffer *buffer)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(buffer->vb2_queue);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
 	struct sun6i_csi_buffer *csi_buffer =
 		container_of(v4l2_buffer, struct sun6i_csi_buffer, v4l2_buffer);
 	unsigned long flags;
 
-	spin_lock_irqsave(&video->dma_queue_lock, flags);
+	spin_lock_irqsave(&capture->dma_queue_lock, flags);
 	csi_buffer->queued_to_csi = false;
-	list_add_tail(&csi_buffer->list, &video->dma_queue);
-	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
+	list_add_tail(&csi_buffer->list, &capture->dma_queue);
+	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
 }
 
-static int sun6i_video_start_streaming(struct vb2_queue *queue,
-				       unsigned int count)
+static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
+					     unsigned int count)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
-	struct sun6i_video *video = &csi_dev->video;
-	struct video_device *video_dev = &video->video_dev;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct video_device *video_dev = &capture->video_dev;
 	struct sun6i_csi_buffer *buf;
 	struct sun6i_csi_buffer *next_buf;
 	struct v4l2_subdev *subdev;
 	unsigned long flags;
 	int ret;
 
-	video->sequence = 0;
+	capture->sequence = 0;
 
 	ret = media_pipeline_start(&video_dev->entity, &video_dev->pipe);
 	if (ret < 0)
 		goto error_dma_queue_flush;
 
-	if (video->mbus_code == 0) {
+	if (capture->mbus_code == 0) {
 		ret = -EINVAL;
 		goto error_media_pipeline;
 	}
 
-	subdev = sun6i_video_remote_subdev(video, NULL);
+	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
 	if (!subdev) {
 		ret = -EINVAL;
 		goto error_media_pipeline;
 	}
 
-	sun6i_video_configure(csi_dev);
+	sun6i_csi_capture_configure(csi_dev);
 
-	spin_lock_irqsave(&video->dma_queue_lock, flags);
+	spin_lock_irqsave(&capture->dma_queue_lock, flags);
 
-	buf = list_first_entry(&video->dma_queue,
+	buf = list_first_entry(&capture->dma_queue,
 			       struct sun6i_csi_buffer, list);
-	sun6i_video_buffer_configure(csi_dev, buf);
+	sun6i_csi_capture_buffer_configure(csi_dev, buf);
 
 	sun6i_csi_set_stream(csi_dev, true);
 
@@ -224,9 +225,9 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	 * would also drop frame when lacking of queued buffer.
 	 */
 	next_buf = list_next_entry(buf, list);
-	sun6i_video_buffer_configure(csi_dev, next_buf);
+	sun6i_csi_capture_buffer_configure(csi_dev, next_buf);
 
-	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
+	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
 
 	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD)
@@ -241,52 +242,52 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	media_pipeline_stop(&video_dev->entity);
 
 error_dma_queue_flush:
-	spin_lock_irqsave(&video->dma_queue_lock, flags);
-	list_for_each_entry(buf, &video->dma_queue, list)
+	spin_lock_irqsave(&capture->dma_queue_lock, flags);
+	list_for_each_entry(buf, &capture->dma_queue, list)
 		vb2_buffer_done(&buf->v4l2_buffer.vb2_buf,
 				VB2_BUF_STATE_QUEUED);
-	INIT_LIST_HEAD(&video->dma_queue);
-	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
+	INIT_LIST_HEAD(&capture->dma_queue);
+	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
 
 	return ret;
 }
 
-static void sun6i_video_stop_streaming(struct vb2_queue *queue)
+static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct v4l2_subdev *subdev;
 	unsigned long flags;
 	struct sun6i_csi_buffer *buf;
 
-	subdev = sun6i_video_remote_subdev(video, NULL);
+	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
 	if (subdev)
 		v4l2_subdev_call(subdev, video, s_stream, 0);
 
 	sun6i_csi_set_stream(csi_dev, false);
 
-	media_pipeline_stop(&video->video_dev.entity);
+	media_pipeline_stop(&capture->video_dev.entity);
 
 	/* Release all active buffers */
-	spin_lock_irqsave(&video->dma_queue_lock, flags);
-	list_for_each_entry(buf, &video->dma_queue, list)
+	spin_lock_irqsave(&capture->dma_queue_lock, flags);
+	list_for_each_entry(buf, &capture->dma_queue, list)
 		vb2_buffer_done(&buf->v4l2_buffer.vb2_buf, VB2_BUF_STATE_ERROR);
-	INIT_LIST_HEAD(&video->dma_queue);
-	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
+	INIT_LIST_HEAD(&capture->dma_queue);
+	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
 }
 
-void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev)
+void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct sun6i_csi_buffer *buf;
 	struct sun6i_csi_buffer *next_buf;
 	struct vb2_v4l2_buffer *v4l2_buffer;
 
-	spin_lock(&video->dma_queue_lock);
+	spin_lock(&capture->dma_queue_lock);
 
-	buf = list_first_entry(&video->dma_queue,
+	buf = list_first_entry(&capture->dma_queue,
 			       struct sun6i_csi_buffer, list);
-	if (list_is_last(&buf->list, &video->dma_queue)) {
+	if (list_is_last(&buf->list, &capture->dma_queue)) {
 		dev_dbg(csi_dev->dev, "Frame dropped!\n");
 		goto complete;
 	}
@@ -298,7 +299,7 @@ void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev)
 	 * for next ISR call.
 	 */
 	if (!next_buf->queued_to_csi) {
-		sun6i_video_buffer_configure(csi_dev, next_buf);
+		sun6i_csi_capture_buffer_configure(csi_dev, next_buf);
 		dev_dbg(csi_dev->dev, "Frame dropped!\n");
 		goto complete;
 	}
@@ -306,39 +307,39 @@ void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev)
 	list_del(&buf->list);
 	v4l2_buffer = &buf->v4l2_buffer;
 	v4l2_buffer->vb2_buf.timestamp = ktime_get_ns();
-	v4l2_buffer->sequence = video->sequence;
+	v4l2_buffer->sequence = capture->sequence;
 	vb2_buffer_done(&v4l2_buffer->vb2_buf, VB2_BUF_STATE_DONE);
 
 	/* Prepare buffer for next frame but one.  */
-	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
+	if (!list_is_last(&next_buf->list, &capture->dma_queue)) {
 		next_buf = list_next_entry(next_buf, list);
-		sun6i_video_buffer_configure(csi_dev, next_buf);
+		sun6i_csi_capture_buffer_configure(csi_dev, next_buf);
 	} else {
 		dev_dbg(csi_dev->dev, "Next frame will be dropped!\n");
 	}
 
 complete:
-	video->sequence++;
-	spin_unlock(&video->dma_queue_lock);
+	capture->sequence++;
+	spin_unlock(&capture->dma_queue_lock);
 }
 
-static const struct vb2_ops sun6i_video_queue_ops = {
-	.queue_setup		= sun6i_video_queue_setup,
-	.buf_prepare		= sun6i_video_buffer_prepare,
-	.buf_queue		= sun6i_video_buffer_queue,
-	.start_streaming	= sun6i_video_start_streaming,
-	.stop_streaming		= sun6i_video_stop_streaming,
+static const struct vb2_ops sun6i_csi_capture_queue_ops = {
+	.queue_setup		= sun6i_csi_capture_queue_setup,
+	.buf_prepare		= sun6i_csi_capture_buffer_prepare,
+	.buf_queue		= sun6i_csi_capture_buffer_queue,
+	.start_streaming	= sun6i_csi_capture_start_streaming,
+	.stop_streaming		= sun6i_csi_capture_stop_streaming,
 	.wait_prepare		= vb2_ops_wait_prepare,
 	.wait_finish		= vb2_ops_wait_finish,
 };
 
 /* V4L2 Device */
 
-static int sun6i_video_querycap(struct file *file, void *private,
-			   struct v4l2_capability *capability)
+static int sun6i_csi_capture_querycap(struct file *file, void *private,
+				      struct v4l2_capability *capability)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct video_device *video_dev = &csi_dev->video.video_dev;
+	struct video_device *video_dev = &csi_dev->capture.video_dev;
 
 	strscpy(capability->driver, SUN6I_CSI_NAME, sizeof(capability->driver));
 	strscpy(capability->card, video_dev->name, sizeof(capability->card));
@@ -348,38 +349,38 @@ static int sun6i_video_querycap(struct file *file, void *private,
 	return 0;
 }
 
-static int sun6i_video_enum_fmt(struct file *file, void *private,
-				struct v4l2_fmtdesc *fmtdesc)
+static int sun6i_csi_capture_enum_fmt(struct file *file, void *private,
+				      struct v4l2_fmtdesc *fmtdesc)
 {
 	u32 index = fmtdesc->index;
 
-	if (index >= ARRAY_SIZE(sun6i_video_formats))
+	if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
 		return -EINVAL;
 
-	fmtdesc->pixelformat = sun6i_video_formats[index];
+	fmtdesc->pixelformat = sun6i_csi_capture_formats[index];
 
 	return 0;
 }
 
-static int sun6i_video_g_fmt(struct file *file, void *private,
-			     struct v4l2_format *format)
+static int sun6i_csi_capture_g_fmt(struct file *file, void *private,
+				   struct v4l2_format *format)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 
-	*format = video->format;
+	*format = capture->format;
 
 	return 0;
 }
 
-static int sun6i_video_format_try(struct sun6i_video *video,
-				  struct v4l2_format *format)
+static int sun6i_csi_capture_format_try(struct sun6i_csi_capture *capture,
+					struct v4l2_format *format)
 {
 	struct v4l2_pix_format *pix_format = &format->fmt.pix;
 	int bpp;
 
-	if (!sun6i_video_format_check(pix_format->pixelformat))
-		pix_format->pixelformat = sun6i_video_formats[0];
+	if (!sun6i_csi_capture_format_check(pix_format->pixelformat))
+		pix_format->pixelformat = sun6i_csi_capture_formats[0];
 
 	v4l_bound_align_image(&pix_format->width, MIN_WIDTH, MAX_WIDTH, 1,
 			      &pix_format->height, MIN_HEIGHT, MAX_WIDTH, 1, 1);
@@ -403,43 +404,43 @@ static int sun6i_video_format_try(struct sun6i_video *video,
 	return 0;
 }
 
-static int sun6i_video_format_set(struct sun6i_video *video,
-				  struct v4l2_format *format)
+static int sun6i_csi_capture_format_set(struct sun6i_csi_capture *capture,
+					struct v4l2_format *format)
 {
 	int ret;
 
-	ret = sun6i_video_format_try(video, format);
+	ret = sun6i_csi_capture_format_try(capture, format);
 	if (ret)
 		return ret;
 
-	video->format = *format;
+	capture->format = *format;
 
 	return 0;
 }
 
-static int sun6i_video_s_fmt(struct file *file, void *private,
-			     struct v4l2_format *format)
+static int sun6i_csi_capture_s_fmt(struct file *file, void *private,
+				   struct v4l2_format *format)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 
-	if (vb2_is_busy(&video->queue))
+	if (vb2_is_busy(&capture->queue))
 		return -EBUSY;
 
-	return sun6i_video_format_set(video, format);
+	return sun6i_csi_capture_format_set(capture, format);
 }
 
-static int sun6i_video_try_fmt(struct file *file, void *private,
-			       struct v4l2_format *format)
+static int sun6i_csi_capture_try_fmt(struct file *file, void *private,
+				     struct v4l2_format *format)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 
-	return sun6i_video_format_try(video, format);
+	return sun6i_csi_capture_format_try(capture, format);
 }
 
-static int sun6i_video_enum_input(struct file *file, void *private,
-			     struct v4l2_input *input)
+static int sun6i_csi_capture_enum_input(struct file *file, void *private,
+					struct v4l2_input *input)
 {
 	if (input->index != 0)
 		return -EINVAL;
@@ -450,16 +451,16 @@ static int sun6i_video_enum_input(struct file *file, void *private,
 	return 0;
 }
 
-static int sun6i_video_g_input(struct file *file, void *private,
-			       unsigned int *index)
+static int sun6i_csi_capture_g_input(struct file *file, void *private,
+				     unsigned int *index)
 {
 	*index = 0;
 
 	return 0;
 }
 
-static int sun6i_video_s_input(struct file *file, void *private,
-			       unsigned int index)
+static int sun6i_csi_capture_s_input(struct file *file, void *private,
+				     unsigned int index)
 {
 	if (index != 0)
 		return -EINVAL;
@@ -467,17 +468,17 @@ static int sun6i_video_s_input(struct file *file, void *private,
 	return 0;
 }
 
-static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
-	.vidioc_querycap		= sun6i_video_querycap,
+static const struct v4l2_ioctl_ops sun6i_csi_capture_ioctl_ops = {
+	.vidioc_querycap		= sun6i_csi_capture_querycap,
 
-	.vidioc_enum_fmt_vid_cap	= sun6i_video_enum_fmt,
-	.vidioc_g_fmt_vid_cap		= sun6i_video_g_fmt,
-	.vidioc_s_fmt_vid_cap		= sun6i_video_s_fmt,
-	.vidioc_try_fmt_vid_cap		= sun6i_video_try_fmt,
+	.vidioc_enum_fmt_vid_cap	= sun6i_csi_capture_enum_fmt,
+	.vidioc_g_fmt_vid_cap		= sun6i_csi_capture_g_fmt,
+	.vidioc_s_fmt_vid_cap		= sun6i_csi_capture_s_fmt,
+	.vidioc_try_fmt_vid_cap		= sun6i_csi_capture_try_fmt,
 
-	.vidioc_enum_input		= sun6i_video_enum_input,
-	.vidioc_g_input			= sun6i_video_g_input,
-	.vidioc_s_input			= sun6i_video_s_input,
+	.vidioc_enum_input		= sun6i_csi_capture_enum_input,
+	.vidioc_g_input			= sun6i_csi_capture_g_input,
+	.vidioc_s_input			= sun6i_csi_capture_s_input,
 
 	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
 	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
@@ -492,20 +493,20 @@ static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
 
 /* V4L2 File */
 
-static int sun6i_video_open(struct file *file)
+static int sun6i_csi_capture_open(struct file *file)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	int ret = 0;
 
-	if (mutex_lock_interruptible(&video->lock))
+	if (mutex_lock_interruptible(&capture->lock))
 		return -ERESTARTSYS;
 
 	ret = v4l2_fh_open(file);
 	if (ret < 0)
 		goto error_lock;
 
-	ret = v4l2_pipeline_pm_get(&video->video_dev.entity);
+	ret = v4l2_pipeline_pm_get(&capture->video_dev.entity);
 	if (ret < 0)
 		goto error_v4l2_fh;
 
@@ -516,7 +517,7 @@ static int sun6i_video_open(struct file *file)
 			goto error_v4l2_fh;
 	}
 
-	mutex_unlock(&video->lock);
+	mutex_unlock(&capture->lock);
 
 	return 0;
 
@@ -524,37 +525,37 @@ static int sun6i_video_open(struct file *file)
 	v4l2_fh_release(file);
 
 error_lock:
-	mutex_unlock(&video->lock);
+	mutex_unlock(&capture->lock);
 
 	return ret;
 }
 
-static int sun6i_video_close(struct file *file)
+static int sun6i_csi_capture_close(struct file *file)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	bool last_close;
 
-	mutex_lock(&video->lock);
+	mutex_lock(&capture->lock);
 
 	last_close = v4l2_fh_is_singular_file(file);
 
 	_vb2_fop_release(file, NULL);
-	v4l2_pipeline_pm_put(&video->video_dev.entity);
+	v4l2_pipeline_pm_put(&capture->video_dev.entity);
 
 	/* Power off at last close. */
 	if (last_close)
 		sun6i_csi_set_power(csi_dev, false);
 
-	mutex_unlock(&video->lock);
+	mutex_unlock(&capture->lock);
 
 	return 0;
 }
 
-static const struct v4l2_file_operations sun6i_video_fops = {
+static const struct v4l2_file_operations sun6i_csi_capture_fops = {
 	.owner		= THIS_MODULE,
-	.open		= sun6i_video_open,
-	.release	= sun6i_video_close,
+	.open		= sun6i_csi_capture_open,
+	.release	= sun6i_csi_capture_close,
 	.unlocked_ioctl	= video_ioctl2,
 	.mmap		= vb2_fop_mmap,
 	.poll		= vb2_fop_poll
@@ -562,8 +563,9 @@ static const struct v4l2_file_operations sun6i_video_fops = {
 
 /* Media Entity */
 
-static int sun6i_video_link_validate_get_format(struct media_pad *pad,
-						struct v4l2_subdev_format *fmt)
+static int
+sun6i_csi_capture_link_validate_get_format(struct media_pad *pad,
+					   struct v4l2_subdev_format *fmt)
 {
 	if (is_media_entity_v4l2_subdev(pad->entity)) {
 		struct v4l2_subdev *sd =
@@ -577,72 +579,74 @@ static int sun6i_video_link_validate_get_format(struct media_pad *pad,
 	return -EINVAL;
 }
 
-static int sun6i_video_link_validate(struct media_link *link)
+static int sun6i_csi_capture_link_validate(struct media_link *link)
 {
 	struct video_device *vdev = container_of(link->sink->entity,
 						 struct video_device, entity);
 	struct sun6i_csi_device *csi_dev = video_get_drvdata(vdev);
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct v4l2_subdev_format source_fmt;
 	int ret;
 
-	video->mbus_code = 0;
+	capture->mbus_code = 0;
 
 	if (!media_pad_remote_pad_first(link->sink->entity->pads)) {
-		dev_info(csi_dev->dev, "video node %s pad not connected\n",
+		dev_info(csi_dev->dev, "capture node %s pad not connected\n",
 			 vdev->name);
 		return -ENOLINK;
 	}
 
-	ret = sun6i_video_link_validate_get_format(link->source, &source_fmt);
+	ret = sun6i_csi_capture_link_validate_get_format(link->source,
+							 &source_fmt);
 	if (ret < 0)
 		return ret;
 
 	if (!sun6i_csi_is_format_supported(csi_dev,
-					   video->format.fmt.pix.pixelformat,
+					   capture->format.fmt.pix.pixelformat,
 					   source_fmt.format.code)) {
 		dev_err(csi_dev->dev,
 			"Unsupported pixformat: 0x%x with mbus code: 0x%x!\n",
-			video->format.fmt.pix.pixelformat,
+			capture->format.fmt.pix.pixelformat,
 			source_fmt.format.code);
 		return -EPIPE;
 	}
 
-	if (source_fmt.format.width != video->format.fmt.pix.width ||
-	    source_fmt.format.height != video->format.fmt.pix.height) {
+	if (source_fmt.format.width != capture->format.fmt.pix.width ||
+	    source_fmt.format.height != capture->format.fmt.pix.height) {
 		dev_err(csi_dev->dev,
 			"Wrong width or height %ux%u (%ux%u expected)\n",
-			video->format.fmt.pix.width, video->format.fmt.pix.height,
+			capture->format.fmt.pix.width,
+			capture->format.fmt.pix.height,
 			source_fmt.format.width, source_fmt.format.height);
 		return -EPIPE;
 	}
 
-	video->mbus_code = source_fmt.format.code;
+	capture->mbus_code = source_fmt.format.code;
 
 	return 0;
 }
 
-static const struct media_entity_operations sun6i_video_media_ops = {
-	.link_validate = sun6i_video_link_validate
+static const struct media_entity_operations sun6i_csi_capture_media_ops = {
+	.link_validate = sun6i_csi_capture_link_validate
 };
 
-/* Video */
+/* Capture */
 
-int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
+int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
 	struct v4l2_subdev *bridge_subdev = &csi_dev->bridge.subdev;
-	struct video_device *video_dev = &video->video_dev;
-	struct vb2_queue *queue = &video->queue;
-	struct media_pad *pad = &video->pad;
+	struct video_device *video_dev = &capture->video_dev;
+	struct vb2_queue *queue = &capture->queue;
+	struct media_pad *pad = &capture->pad;
 	struct v4l2_format format = { 0 };
 	struct v4l2_pix_format *pix_format = &format.fmt.pix;
 	int ret;
 
 	/* Media Entity */
 
-	video_dev->entity.ops = &sun6i_video_media_ops;
+	video_dev->entity.ops = &sun6i_csi_capture_media_ops;
 
 	/* Media Pad */
 
@@ -654,22 +658,22 @@ int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
 
 	/* DMA queue */
 
-	INIT_LIST_HEAD(&video->dma_queue);
-	spin_lock_init(&video->dma_queue_lock);
+	INIT_LIST_HEAD(&capture->dma_queue);
+	spin_lock_init(&capture->dma_queue_lock);
 
-	video->sequence = 0;
+	capture->sequence = 0;
 
 	/* Queue */
 
-	mutex_init(&video->lock);
+	mutex_init(&capture->lock);
 
 	queue->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	queue->io_modes = VB2_MMAP | VB2_DMABUF;
 	queue->buf_struct_size = sizeof(struct sun6i_csi_buffer);
-	queue->ops = &sun6i_video_queue_ops;
+	queue->ops = &sun6i_csi_capture_queue_ops;
 	queue->mem_ops = &vb2_dma_contig_memops;
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	queue->lock = &video->lock;
+	queue->lock = &capture->lock;
 	queue->dev = csi_dev->dev;
 	queue->drv_priv = csi_dev;
 
@@ -685,12 +689,12 @@ int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
 	/* V4L2 Format */
 
 	format.type = queue->type;
-	pix_format->pixelformat = sun6i_video_formats[0];
+	pix_format->pixelformat = sun6i_csi_capture_formats[0];
 	pix_format->width = 1280;
 	pix_format->height = 720;
 	pix_format->field = V4L2_FIELD_NONE;
 
-	sun6i_video_format_set(video, &format);
+	sun6i_csi_capture_format_set(capture, &format);
 
 	/* Video Device */
 
@@ -698,11 +702,11 @@ int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
 	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
 	video_dev->vfl_dir = VFL_DIR_RX;
 	video_dev->release = video_device_release_empty;
-	video_dev->fops = &sun6i_video_fops;
-	video_dev->ioctl_ops = &sun6i_video_ioctl_ops;
+	video_dev->fops = &sun6i_csi_capture_fops;
+	video_dev->ioctl_ops = &sun6i_csi_capture_ioctl_ops;
 	video_dev->v4l2_dev = v4l2_dev;
 	video_dev->queue = queue;
-	video_dev->lock = &video->lock;
+	video_dev->lock = &capture->lock;
 
 	video_set_drvdata(video_dev, csi_dev);
 
@@ -736,17 +740,17 @@ int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
 error_media_entity:
 	media_entity_cleanup(&video_dev->entity);
 
-	mutex_destroy(&video->lock);
+	mutex_destroy(&capture->lock);
 
 	return ret;
 }
 
-void sun6i_video_cleanup(struct sun6i_csi_device *csi_dev)
+void sun6i_csi_capture_cleanup(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_video *video = &csi_dev->video;
-	struct video_device *video_dev = &video->video_dev;
+	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct video_device *video_dev = &capture->video_dev;
 
 	vb2_video_unregister_device(video_dev);
 	media_entity_cleanup(&video_dev->entity);
-	mutex_destroy(&video->lock);
+	mutex_destroy(&capture->lock);
 }
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
similarity index 64%
rename from drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
rename to drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index a917d2da6deb..36bba31fcb48 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -5,15 +5,15 @@
  * Author: Yong Deng <yong.deng@magewell.com>
  */
 
-#ifndef __SUN6I_VIDEO_H__
-#define __SUN6I_VIDEO_H__
+#ifndef __SUN6I_CAPTURE_H__
+#define __SUN6I_CAPTURE_H__
 
 #include <media/v4l2-dev.h>
 #include <media/videobuf2-core.h>
 
 struct sun6i_csi_device;
 
-struct sun6i_video {
+struct sun6i_csi_capture {
 	struct video_device		video_dev;
 	struct vb2_queue		queue;
 	struct mutex			lock; /* Queue lock. */
@@ -27,9 +27,9 @@ struct sun6i_video {
 	unsigned int			sequence;
 };
 
-int sun6i_video_setup(struct sun6i_csi_device *csi_dev);
-void sun6i_video_cleanup(struct sun6i_csi_device *csi_dev);
+int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev);
+void sun6i_csi_capture_cleanup(struct sun6i_csi_device *csi_dev);
 
-void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev);
+void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
 
-#endif /* __SUN6I_VIDEO_H__ */
+#endif /* __SUN6I_CAPTURE_H__ */
-- 
2.37.1

