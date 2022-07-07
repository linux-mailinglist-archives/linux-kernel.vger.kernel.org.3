Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3556A816
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiGGQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiGGQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:28:43 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE5922B2A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:28:39 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id n9so7180406ilq.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=bX/xevDn8WtFSl0IB5VYC2ORDf8wm9NdP64Yp3br5eo=;
        b=EpzGDfXVYY63Ckrm9mhyTUdX6B3MB7twOv+zcEqraWqEnUzdzGjsB30ewuaGMLd1OC
         fPqdWqyV1g3PQkp9dOrbY0N3LCNQvU6Ff8ygbxDtxkQTyBjcg0pk/T+57A8QmPMu+taP
         6g15kkqMysh46iMwRudeg5V0D5NWGMyMGMpfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=bX/xevDn8WtFSl0IB5VYC2ORDf8wm9NdP64Yp3br5eo=;
        b=vVcuRG6iPfSurR4cdEVYPlWI2DGje6958oMOeuXi/RCR+WpKEvMN0D2155/CT8OFiC
         zy9NGbbxGb1vByr10mZWydOJ85wafu6Uu5SpPnhlcM9zsIjmsibJkQF/bAo4t4DIHr3P
         U25aZj5C/3IBtyXbJzXhe8j3caFhH02suZm+aLZXde2kMpRqwTf3IdFACpXwesaFeCcR
         0t6bTaC5q0Vq7MQYJLuHRMoVyncem9URxCmqnpvVZ0d7mQOj0YgdBNzlekr3ZY1rSCbg
         vc7GNPRVn/yJMtiBuM0xRbUVNXM84C0oiYxodGDo341OfSE9btH1MvXFuGYgh3ySpUvy
         g4xw==
X-Gm-Message-State: AJIora/7ygNb3+totzAWXaq032yFos+Y0nHq4xLXwVl2c/URci5wKzxZ
        FsTNPN/nM4e1UCGSHHNQGZPykXQaK3XH1w==
X-Google-Smtp-Source: AGRyM1s6CiQX5XkXxRl9zdcJIewS2aIqjbFDJMCsi5bN1STth3Yti23g+yzCcn/m5plsv6SYVD8+iA==
X-Received: by 2002:a92:c811:0:b0:2dc:14bf:e15d with SMTP id v17-20020a92c811000000b002dc14bfe15dmr12371405iln.305.1657211318712;
        Thu, 07 Jul 2022 09:28:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s10-20020a5ec64a000000b0067520155dedsm16153859ioo.15.2022.07.07.09.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:28:38 -0700 (PDT)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Linux Media vimc update for 5.20-rc1
Message-ID: <7e719640-80e6-b3ab-751a-156b8e74d87b@linuxfoundation.org>
Date:   Thu, 7 Jul 2022 10:28:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7740FBF526EC3FB04E40AFBD"
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7740FBF526EC3FB04E40AFBD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mauro,

Please pull the following vimc update for Linux 5.20-rc1.

This vimc update Linux Media 5.20-rc1 consists of enhancement and
cleanup patches:

- add lens to vimc driver and links it with sensors using ancillary
   links.
- add documentation for lens
- changes to make the code readable and maintainable.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

   Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-vimc-5.20-rc1

for you to fetch changes up to 55c592e9cff59e0d1c4069b7fe649b02ddf6c36b:

   media: vimc: documentation for lens (2022-06-29 12:58:21 -0600)

----------------------------------------------------------------
linux-media-vimc-5.20-rc1

This vimc update Linux Media 5.20-rc1 consists of enhancement and
cleanup patches:

- add lens to vimc driver and links it with sensors using ancillary
   links.
- add documentation for lens
- changes to make the code readable and maintainable.

----------------------------------------------------------------
Daniel Oakley (3):
       media: vimc: expand the names of vimc entity types
       media: vimc: enumerate data link entities for clarity
       media: vimc: use data link entities enum to index the ent_config array

Yunke Cao (2):
       media: vimc: add ancillary lens
       media: vimc: documentation for lens

  Documentation/admin-guide/media/vimc.dot       |   4 +
  Documentation/admin-guide/media/vimc.rst       |  19 ++
  drivers/media/test-drivers/vimc/Makefile       |   2 +-
  drivers/media/test-drivers/vimc/vimc-capture.c | 270 ++++++++---------
  drivers/media/test-drivers/vimc/vimc-common.h  |   9 +-
  drivers/media/test-drivers/vimc/vimc-core.c    | 142 ++++++---
  drivers/media/test-drivers/vimc/vimc-debayer.c | 393 +++++++++++++------------
  drivers/media/test-drivers/vimc/vimc-lens.c    | 102 +++++++
  drivers/media/test-drivers/vimc/vimc-scaler.c  | 216 +++++++-------
  drivers/media/test-drivers/vimc/vimc-sensor.c  | 307 +++++++++----------
  10 files changed, 830 insertions(+), 634 deletions(-)
  create mode 100644 drivers/media/test-drivers/vimc/vimc-lens.c
----------------------------------------------------------------

--------------7740FBF526EC3FB04E40AFBD
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-vimc-5.20-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-vimc-5.20-rc1.diff"

diff --git a/Documentation/admin-guide/media/vimc.dot b/Documentation/admin-guide/media/vimc.dot
index 8e829c164626..92a5bb631235 100644
--- a/Documentation/admin-guide/media/vimc.dot
+++ b/Documentation/admin-guide/media/vimc.dot
@@ -5,9 +5,13 @@ digraph board {
 	n00000001 [label="{{} | Sensor A\n/dev/v4l-subdev0 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
 	n00000001:port0 -> n00000005:port0 [style=bold]
 	n00000001:port0 -> n0000000b [style=bold]
+	n00000001 -> n00000002
+	n00000002 [label="{{} | Lens A\n/dev/v4l-subdev5 | {<port0>}}", shape=Mrecord, style=filled, fillcolor=green]
 	n00000003 [label="{{} | Sensor B\n/dev/v4l-subdev1 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
 	n00000003:port0 -> n00000008:port0 [style=bold]
 	n00000003:port0 -> n0000000f [style=bold]
+	n00000003 -> n00000004
+	n00000004 [label="{{} | Lens B\n/dev/v4l-subdev6 | {<port0>}}", shape=Mrecord, style=filled, fillcolor=green]
 	n00000005 [label="{{<port0> 0} | Debayer A\n/dev/v4l-subdev2 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
 	n00000005:port1 -> n00000015:port0
 	n00000008 [label="{{<port0> 0} | Debayer B\n/dev/v4l-subdev3 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
diff --git a/Documentation/admin-guide/media/vimc.rst b/Documentation/admin-guide/media/vimc.rst
index 0b07f05dde25..3b4d2b36b4f3 100644
--- a/Documentation/admin-guide/media/vimc.rst
+++ b/Documentation/admin-guide/media/vimc.rst
@@ -53,6 +53,25 @@ vimc-sensor:
 
 	* 1 Pad source
 
+vimc-lens:
+	Ancillary lens for a sensor. Supports auto focus control. Linked to
+	a vimc-sensor using an ancillary link. The lens supports FOCUS_ABSOLUTE
+	control.
+
+.. code-block:: bash
+
+	media-ctl -p
+	...
+	- entity 28: Lens A (0 pad, 0 link)
+			type V4L2 subdev subtype Lens flags 0
+			device node name /dev/v4l-subdev6
+	- entity 29: Lens B (0 pad, 0 link)
+			type V4L2 subdev subtype Lens flags 0
+			device node name /dev/v4l-subdev7
+	v4l2-ctl -d /dev/v4l-subdev7 -C focus_absolute
+	focus_absolute: 0
+
+
 vimc-debayer:
 	Transforms images in bayer format into a non-bayer format.
 	Exposes:
diff --git a/drivers/media/test-drivers/vimc/Makefile b/drivers/media/test-drivers/vimc/Makefile
index a53b2b532e9f..9b9631562473 100644
--- a/drivers/media/test-drivers/vimc/Makefile
+++ b/drivers/media/test-drivers/vimc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 vimc-y := vimc-core.o vimc-common.o vimc-streamer.o vimc-capture.o \
-		vimc-debayer.o vimc-scaler.o vimc-sensor.o
+		vimc-debayer.o vimc-scaler.o vimc-sensor.o vimc-lens.o
 
 obj-$(CONFIG_VIDEO_VIMC) += vimc.o
 
diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index d1e2d0739c00..6c437802f91f 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -13,7 +13,7 @@
 #include "vimc-common.h"
 #include "vimc-streamer.h"
 
-struct vimc_cap_device {
+struct vimc_capture_device {
 	struct vimc_ent_device ved;
 	struct video_device vdev;
 	struct v4l2_pix_format format;
@@ -41,7 +41,7 @@ static const struct v4l2_pix_format fmt_default = {
 	.colorspace = V4L2_COLORSPACE_SRGB,
 };
 
-struct vimc_cap_buffer {
+struct vimc_capture_buffer {
 	/*
 	 * struct vb2_v4l2_buffer must be the first element
 	 * the videobuf2 framework will allocate this struct based on
@@ -52,7 +52,7 @@ struct vimc_cap_buffer {
 	struct list_head list;
 };
 
-static int vimc_cap_querycap(struct file *file, void *priv,
+static int vimc_capture_querycap(struct file *file, void *priv,
 			     struct v4l2_capability *cap)
 {
 	strscpy(cap->driver, VIMC_PDEV_NAME, sizeof(cap->driver));
@@ -63,26 +63,26 @@ static int vimc_cap_querycap(struct file *file, void *priv,
 	return 0;
 }
 
-static void vimc_cap_get_format(struct vimc_ent_device *ved,
+static void vimc_capture_get_format(struct vimc_ent_device *ved,
 				struct v4l2_pix_format *fmt)
 {
-	struct vimc_cap_device *vcap = container_of(ved, struct vimc_cap_device,
+	struct vimc_capture_device *vcapture = container_of(ved, struct vimc_capture_device,
 						    ved);
 
-	*fmt = vcap->format;
+	*fmt = vcapture->format;
 }
 
-static int vimc_cap_g_fmt_vid_cap(struct file *file, void *priv,
+static int vimc_capture_g_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	struct vimc_cap_device *vcap = video_drvdata(file);
+	struct vimc_capture_device *vcapture = video_drvdata(file);
 
-	f->fmt.pix = vcap->format;
+	f->fmt.pix = vcapture->format;
 
 	return 0;
 }
 
-static int vimc_cap_try_fmt_vid_cap(struct file *file, void *priv,
+static int vimc_capture_try_fmt_vid_cap(struct file *file, void *priv,
 				    struct v4l2_format *f)
 {
 	struct v4l2_pix_format *format = &f->fmt.pix;
@@ -114,40 +114,40 @@ static int vimc_cap_try_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-static int vimc_cap_s_fmt_vid_cap(struct file *file, void *priv,
+static int vimc_capture_s_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	struct vimc_cap_device *vcap = video_drvdata(file);
+	struct vimc_capture_device *vcapture = video_drvdata(file);
 	int ret;
 
 	/* Do not change the format while stream is on */
-	if (vb2_is_busy(&vcap->queue))
+	if (vb2_is_busy(&vcapture->queue))
 		return -EBUSY;
 
-	ret = vimc_cap_try_fmt_vid_cap(file, priv, f);
+	ret = vimc_capture_try_fmt_vid_cap(file, priv, f);
 	if (ret)
 		return ret;
 
-	dev_dbg(vcap->ved.dev, "%s: format update: "
+	dev_dbg(vcapture->ved.dev, "%s: format update: "
 		"old:%dx%d (0x%x, %d, %d, %d, %d) "
-		"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vcap->vdev.name,
+		"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vcapture->vdev.name,
 		/* old */
-		vcap->format.width, vcap->format.height,
-		vcap->format.pixelformat, vcap->format.colorspace,
-		vcap->format.quantization, vcap->format.xfer_func,
-		vcap->format.ycbcr_enc,
+		vcapture->format.width, vcapture->format.height,
+		vcapture->format.pixelformat, vcapture->format.colorspace,
+		vcapture->format.quantization, vcapture->format.xfer_func,
+		vcapture->format.ycbcr_enc,
 		/* new */
 		f->fmt.pix.width, f->fmt.pix.height,
 		f->fmt.pix.pixelformat,	f->fmt.pix.colorspace,
 		f->fmt.pix.quantization, f->fmt.pix.xfer_func,
 		f->fmt.pix.ycbcr_enc);
 
-	vcap->format = f->fmt.pix;
+	vcapture->format = f->fmt.pix;
 
 	return 0;
 }
 
-static int vimc_cap_enum_fmt_vid_cap(struct file *file, void *priv,
+static int vimc_capture_enum_fmt_vid_cap(struct file *file, void *priv,
 				     struct v4l2_fmtdesc *f)
 {
 	const struct vimc_pix_map *vpix;
@@ -169,7 +169,7 @@ static int vimc_cap_enum_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-static int vimc_cap_enum_framesizes(struct file *file, void *fh,
+static int vimc_capture_enum_framesizes(struct file *file, void *fh,
 				    struct v4l2_frmsizeenum *fsize)
 {
 	const struct vimc_pix_map *vpix;
@@ -193,7 +193,7 @@ static int vimc_cap_enum_framesizes(struct file *file, void *fh,
 	return 0;
 }
 
-static const struct v4l2_file_operations vimc_cap_fops = {
+static const struct v4l2_file_operations vimc_capture_fops = {
 	.owner		= THIS_MODULE,
 	.open		= v4l2_fh_open,
 	.release	= vb2_fop_release,
@@ -203,14 +203,14 @@ static const struct v4l2_file_operations vimc_cap_fops = {
 	.mmap           = vb2_fop_mmap,
 };
 
-static const struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
-	.vidioc_querycap = vimc_cap_querycap,
+static const struct v4l2_ioctl_ops vimc_capture_ioctl_ops = {
+	.vidioc_querycap = vimc_capture_querycap,
 
-	.vidioc_g_fmt_vid_cap = vimc_cap_g_fmt_vid_cap,
-	.vidioc_s_fmt_vid_cap = vimc_cap_s_fmt_vid_cap,
-	.vidioc_try_fmt_vid_cap = vimc_cap_try_fmt_vid_cap,
-	.vidioc_enum_fmt_vid_cap = vimc_cap_enum_fmt_vid_cap,
-	.vidioc_enum_framesizes = vimc_cap_enum_framesizes,
+	.vidioc_g_fmt_vid_cap = vimc_capture_g_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap = vimc_capture_s_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap = vimc_capture_try_fmt_vid_cap,
+	.vidioc_enum_fmt_vid_cap = vimc_capture_enum_fmt_vid_cap,
+	.vidioc_enum_framesizes = vimc_capture_enum_framesizes,
 
 	.vidioc_reqbufs = vb2_ioctl_reqbufs,
 	.vidioc_create_bufs = vb2_ioctl_create_bufs,
@@ -223,40 +223,40 @@ static const struct v4l2_ioctl_ops vimc_cap_ioctl_ops = {
 	.vidioc_streamoff = vb2_ioctl_streamoff,
 };
 
-static void vimc_cap_return_all_buffers(struct vimc_cap_device *vcap,
+static void vimc_capture_return_all_buffers(struct vimc_capture_device *vcapture,
 					enum vb2_buffer_state state)
 {
-	struct vimc_cap_buffer *vbuf, *node;
+	struct vimc_capture_buffer *vbuf, *node;
 
-	spin_lock(&vcap->qlock);
+	spin_lock(&vcapture->qlock);
 
-	list_for_each_entry_safe(vbuf, node, &vcap->buf_list, list) {
+	list_for_each_entry_safe(vbuf, node, &vcapture->buf_list, list) {
 		list_del(&vbuf->list);
 		vb2_buffer_done(&vbuf->vb2.vb2_buf, state);
 	}
 
-	spin_unlock(&vcap->qlock);
+	spin_unlock(&vcapture->qlock);
 }
 
-static int vimc_cap_start_streaming(struct vb2_queue *vq, unsigned int count)
+static int vimc_capture_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
-	struct vimc_cap_device *vcap = vb2_get_drv_priv(vq);
-	struct media_entity *entity = &vcap->vdev.entity;
+	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vq);
+	struct media_entity *entity = &vcapture->vdev.entity;
 	int ret;
 
-	vcap->sequence = 0;
+	vcapture->sequence = 0;
 
 	/* Start the media pipeline */
-	ret = media_pipeline_start(entity, &vcap->stream.pipe);
+	ret = media_pipeline_start(entity, &vcapture->stream.pipe);
 	if (ret) {
-		vimc_cap_return_all_buffers(vcap, VB2_BUF_STATE_QUEUED);
+		vimc_capture_return_all_buffers(vcapture, VB2_BUF_STATE_QUEUED);
 		return ret;
 	}
 
-	ret = vimc_streamer_s_stream(&vcap->stream, &vcap->ved, 1);
+	ret = vimc_streamer_s_stream(&vcapture->stream, &vcapture->ved, 1);
 	if (ret) {
 		media_pipeline_stop(entity);
-		vimc_cap_return_all_buffers(vcap, VB2_BUF_STATE_QUEUED);
+		vimc_capture_return_all_buffers(vcapture, VB2_BUF_STATE_QUEUED);
 		return ret;
 	}
 
@@ -267,65 +267,65 @@ static int vimc_cap_start_streaming(struct vb2_queue *vq, unsigned int count)
  * Stop the stream engine. Any remaining buffers in the stream queue are
  * dequeued and passed on to the vb2 framework marked as STATE_ERROR.
  */
-static void vimc_cap_stop_streaming(struct vb2_queue *vq)
+static void vimc_capture_stop_streaming(struct vb2_queue *vq)
 {
-	struct vimc_cap_device *vcap = vb2_get_drv_priv(vq);
+	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vq);
 
-	vimc_streamer_s_stream(&vcap->stream, &vcap->ved, 0);
+	vimc_streamer_s_stream(&vcapture->stream, &vcapture->ved, 0);
 
 	/* Stop the media pipeline */
-	media_pipeline_stop(&vcap->vdev.entity);
+	media_pipeline_stop(&vcapture->vdev.entity);
 
 	/* Release all active buffers */
-	vimc_cap_return_all_buffers(vcap, VB2_BUF_STATE_ERROR);
+	vimc_capture_return_all_buffers(vcapture, VB2_BUF_STATE_ERROR);
 }
 
-static void vimc_cap_buf_queue(struct vb2_buffer *vb2_buf)
+static void vimc_capture_buf_queue(struct vb2_buffer *vb2_buf)
 {
-	struct vimc_cap_device *vcap = vb2_get_drv_priv(vb2_buf->vb2_queue);
-	struct vimc_cap_buffer *buf = container_of(vb2_buf,
-						   struct vimc_cap_buffer,
+	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vb2_buf->vb2_queue);
+	struct vimc_capture_buffer *buf = container_of(vb2_buf,
+						   struct vimc_capture_buffer,
 						   vb2.vb2_buf);
 
-	spin_lock(&vcap->qlock);
-	list_add_tail(&buf->list, &vcap->buf_list);
-	spin_unlock(&vcap->qlock);
+	spin_lock(&vcapture->qlock);
+	list_add_tail(&buf->list, &vcapture->buf_list);
+	spin_unlock(&vcapture->qlock);
 }
 
-static int vimc_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
+static int vimc_capture_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				unsigned int *nplanes, unsigned int sizes[],
 				struct device *alloc_devs[])
 {
-	struct vimc_cap_device *vcap = vb2_get_drv_priv(vq);
+	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vq);
 
 	if (*nplanes)
-		return sizes[0] < vcap->format.sizeimage ? -EINVAL : 0;
+		return sizes[0] < vcapture->format.sizeimage ? -EINVAL : 0;
 	/* We don't support multiplanes for now */
 	*nplanes = 1;
-	sizes[0] = vcap->format.sizeimage;
+	sizes[0] = vcapture->format.sizeimage;
 
 	return 0;
 }
 
-static int vimc_cap_buffer_prepare(struct vb2_buffer *vb)
+static int vimc_capture_buffer_prepare(struct vb2_buffer *vb)
 {
-	struct vimc_cap_device *vcap = vb2_get_drv_priv(vb->vb2_queue);
-	unsigned long size = vcap->format.sizeimage;
+	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vb->vb2_queue);
+	unsigned long size = vcapture->format.sizeimage;
 
 	if (vb2_plane_size(vb, 0) < size) {
-		dev_err(vcap->ved.dev, "%s: buffer too small (%lu < %lu)\n",
-			vcap->vdev.name, vb2_plane_size(vb, 0), size);
+		dev_err(vcapture->ved.dev, "%s: buffer too small (%lu < %lu)\n",
+			vcapture->vdev.name, vb2_plane_size(vb, 0), size);
 		return -EINVAL;
 	}
 	return 0;
 }
 
-static const struct vb2_ops vimc_cap_qops = {
-	.start_streaming	= vimc_cap_start_streaming,
-	.stop_streaming		= vimc_cap_stop_streaming,
-	.buf_queue		= vimc_cap_buf_queue,
-	.queue_setup		= vimc_cap_queue_setup,
-	.buf_prepare		= vimc_cap_buffer_prepare,
+static const struct vb2_ops vimc_capture_qops = {
+	.start_streaming	= vimc_capture_start_streaming,
+	.stop_streaming		= vimc_capture_stop_streaming,
+	.buf_queue		= vimc_capture_buf_queue,
+	.queue_setup		= vimc_capture_queue_setup,
+	.buf_prepare		= vimc_capture_buffer_prepare,
 	/*
 	 * Since q->lock is set we can use the standard
 	 * vb2_ops_wait_prepare/finish helper functions.
@@ -334,107 +334,107 @@ static const struct vb2_ops vimc_cap_qops = {
 	.wait_finish		= vb2_ops_wait_finish,
 };
 
-static const struct media_entity_operations vimc_cap_mops = {
+static const struct media_entity_operations vimc_capture_mops = {
 	.link_validate		= vimc_vdev_link_validate,
 };
 
-static void vimc_cap_release(struct vimc_ent_device *ved)
+static void vimc_capture_release(struct vimc_ent_device *ved)
 {
-	struct vimc_cap_device *vcap =
-		container_of(ved, struct vimc_cap_device, ved);
+	struct vimc_capture_device *vcapture =
+		container_of(ved, struct vimc_capture_device, ved);
 
-	media_entity_cleanup(vcap->ved.ent);
-	kfree(vcap);
+	media_entity_cleanup(vcapture->ved.ent);
+	kfree(vcapture);
 }
 
-static void vimc_cap_unregister(struct vimc_ent_device *ved)
+static void vimc_capture_unregister(struct vimc_ent_device *ved)
 {
-	struct vimc_cap_device *vcap =
-		container_of(ved, struct vimc_cap_device, ved);
+	struct vimc_capture_device *vcapture =
+		container_of(ved, struct vimc_capture_device, ved);
 
-	vb2_video_unregister_device(&vcap->vdev);
+	vb2_video_unregister_device(&vcapture->vdev);
 }
 
-static void *vimc_cap_process_frame(struct vimc_ent_device *ved,
+static void *vimc_capture_process_frame(struct vimc_ent_device *ved,
 				    const void *frame)
 {
-	struct vimc_cap_device *vcap = container_of(ved, struct vimc_cap_device,
+	struct vimc_capture_device *vcapture = container_of(ved, struct vimc_capture_device,
 						    ved);
-	struct vimc_cap_buffer *vimc_buf;
+	struct vimc_capture_buffer *vimc_buf;
 	void *vbuf;
 
-	spin_lock(&vcap->qlock);
+	spin_lock(&vcapture->qlock);
 
 	/* Get the first entry of the list */
-	vimc_buf = list_first_entry_or_null(&vcap->buf_list,
+	vimc_buf = list_first_entry_or_null(&vcapture->buf_list,
 					    typeof(*vimc_buf), list);
 	if (!vimc_buf) {
-		spin_unlock(&vcap->qlock);
+		spin_unlock(&vcapture->qlock);
 		return ERR_PTR(-EAGAIN);
 	}
 
 	/* Remove this entry from the list */
 	list_del(&vimc_buf->list);
 
-	spin_unlock(&vcap->qlock);
+	spin_unlock(&vcapture->qlock);
 
 	/* Fill the buffer */
 	vimc_buf->vb2.vb2_buf.timestamp = ktime_get_ns();
-	vimc_buf->vb2.sequence = vcap->sequence++;
-	vimc_buf->vb2.field = vcap->format.field;
+	vimc_buf->vb2.sequence = vcapture->sequence++;
+	vimc_buf->vb2.field = vcapture->format.field;
 
 	vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, 0);
 
-	memcpy(vbuf, frame, vcap->format.sizeimage);
+	memcpy(vbuf, frame, vcapture->format.sizeimage);
 
 	/* Set it as ready */
 	vb2_set_plane_payload(&vimc_buf->vb2.vb2_buf, 0,
-			      vcap->format.sizeimage);
+			      vcapture->format.sizeimage);
 	vb2_buffer_done(&vimc_buf->vb2.vb2_buf, VB2_BUF_STATE_DONE);
 	return NULL;
 }
 
-static struct vimc_ent_device *vimc_cap_add(struct vimc_device *vimc,
+static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 					    const char *vcfg_name)
 {
 	struct v4l2_device *v4l2_dev = &vimc->v4l2_dev;
 	const struct vimc_pix_map *vpix;
-	struct vimc_cap_device *vcap;
+	struct vimc_capture_device *vcapture;
 	struct video_device *vdev;
 	struct vb2_queue *q;
 	int ret;
 
-	/* Allocate the vimc_cap_device struct */
-	vcap = kzalloc(sizeof(*vcap), GFP_KERNEL);
-	if (!vcap)
+	/* Allocate the vimc_capture_device struct */
+	vcapture = kzalloc(sizeof(*vcapture), GFP_KERNEL);
+	if (!vcapture)
 		return ERR_PTR(-ENOMEM);
 
 	/* Initialize the media entity */
-	vcap->vdev.entity.name = vcfg_name;
-	vcap->vdev.entity.function = MEDIA_ENT_F_IO_V4L;
-	vcap->pad.flags = MEDIA_PAD_FL_SINK;
-	ret = media_entity_pads_init(&vcap->vdev.entity,
-				     1, &vcap->pad);
+	vcapture->vdev.entity.name = vcfg_name;
+	vcapture->vdev.entity.function = MEDIA_ENT_F_IO_V4L;
+	vcapture->pad.flags = MEDIA_PAD_FL_SINK;
+	ret = media_entity_pads_init(&vcapture->vdev.entity,
+				     1, &vcapture->pad);
 	if (ret)
-		goto err_free_vcap;
+		goto err_free_vcapture;
 
 	/* Initialize the lock */
-	mutex_init(&vcap->lock);
+	mutex_init(&vcapture->lock);
 
 	/* Initialize the vb2 queue */
-	q = &vcap->queue;
+	q = &vcapture->queue;
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_DMABUF;
 	if (vimc_allocator == VIMC_ALLOCATOR_VMALLOC)
 		q->io_modes |= VB2_USERPTR;
-	q->drv_priv = vcap;
-	q->buf_struct_size = sizeof(struct vimc_cap_buffer);
-	q->ops = &vimc_cap_qops;
+	q->drv_priv = vcapture;
+	q->buf_struct_size = sizeof(struct vimc_capture_buffer);
+	q->ops = &vimc_capture_qops;
 	q->mem_ops = vimc_allocator == VIMC_ALLOCATOR_DMA_CONTIG
 		   ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->min_buffers_needed = 2;
-	q->lock = &vcap->lock;
+	q->lock = &vcapture->lock;
 	q->dev = v4l2_dev->dev;
 
 	ret = vb2_queue_init(q);
@@ -445,57 +445,57 @@ static struct vimc_ent_device *vimc_cap_add(struct vimc_device *vimc,
 	}
 
 	/* Initialize buffer list and its lock */
-	INIT_LIST_HEAD(&vcap->buf_list);
-	spin_lock_init(&vcap->qlock);
+	INIT_LIST_HEAD(&vcapture->buf_list);
+	spin_lock_init(&vcapture->qlock);
 
 	/* Set default frame format */
-	vcap->format = fmt_default;
-	vpix = vimc_pix_map_by_pixelformat(vcap->format.pixelformat);
-	vcap->format.bytesperline = vcap->format.width * vpix->bpp;
-	vcap->format.sizeimage = vcap->format.bytesperline *
-				 vcap->format.height;
+	vcapture->format = fmt_default;
+	vpix = vimc_pix_map_by_pixelformat(vcapture->format.pixelformat);
+	vcapture->format.bytesperline = vcapture->format.width * vpix->bpp;
+	vcapture->format.sizeimage = vcapture->format.bytesperline *
+				 vcapture->format.height;
 
 	/* Fill the vimc_ent_device struct */
-	vcap->ved.ent = &vcap->vdev.entity;
-	vcap->ved.process_frame = vimc_cap_process_frame;
-	vcap->ved.vdev_get_format = vimc_cap_get_format;
-	vcap->ved.dev = vimc->mdev.dev;
+	vcapture->ved.ent = &vcapture->vdev.entity;
+	vcapture->ved.process_frame = vimc_capture_process_frame;
+	vcapture->ved.vdev_get_format = vimc_capture_get_format;
+	vcapture->ved.dev = vimc->mdev.dev;
 
 	/* Initialize the video_device struct */
-	vdev = &vcap->vdev;
+	vdev = &vcapture->vdev;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING
 			  | V4L2_CAP_IO_MC;
-	vdev->entity.ops = &vimc_cap_mops;
+	vdev->entity.ops = &vimc_capture_mops;
 	vdev->release = video_device_release_empty;
-	vdev->fops = &vimc_cap_fops;
-	vdev->ioctl_ops = &vimc_cap_ioctl_ops;
-	vdev->lock = &vcap->lock;
+	vdev->fops = &vimc_capture_fops;
+	vdev->ioctl_ops = &vimc_capture_ioctl_ops;
+	vdev->lock = &vcapture->lock;
 	vdev->queue = q;
 	vdev->v4l2_dev = v4l2_dev;
 	vdev->vfl_dir = VFL_DIR_RX;
 	strscpy(vdev->name, vcfg_name, sizeof(vdev->name));
-	video_set_drvdata(vdev, &vcap->ved);
+	video_set_drvdata(vdev, &vcapture->ved);
 
 	/* Register the video_device with the v4l2 and the media framework */
 	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (ret) {
 		dev_err(vimc->mdev.dev, "%s: video register failed (err=%d)\n",
-			vcap->vdev.name, ret);
+			vcapture->vdev.name, ret);
 		goto err_clean_m_ent;
 	}
 
-	return &vcap->ved;
+	return &vcapture->ved;
 
 err_clean_m_ent:
-	media_entity_cleanup(&vcap->vdev.entity);
-err_free_vcap:
-	kfree(vcap);
+	media_entity_cleanup(&vcapture->vdev.entity);
+err_free_vcapture:
+	kfree(vcapture);
 
 	return ERR_PTR(ret);
 }
 
-struct vimc_ent_type vimc_cap_type = {
-	.add = vimc_cap_add,
-	.unregister = vimc_cap_unregister,
-	.release = vimc_cap_release
+struct vimc_ent_type vimc_capture_type = {
+	.add = vimc_capture_add,
+	.unregister = vimc_capture_unregister,
+	.release = vimc_capture_release
 };
diff --git a/drivers/media/test-drivers/vimc/vimc-common.h b/drivers/media/test-drivers/vimc/vimc-common.h
index ba1930772589..7641a101a728 100644
--- a/drivers/media/test-drivers/vimc/vimc-common.h
+++ b/drivers/media/test-drivers/vimc/vimc-common.h
@@ -167,10 +167,11 @@ struct vimc_ent_config {
  */
 bool vimc_is_source(struct media_entity *ent);
 
-extern struct vimc_ent_type vimc_sen_type;
-extern struct vimc_ent_type vimc_deb_type;
-extern struct vimc_ent_type vimc_sca_type;
-extern struct vimc_ent_type vimc_cap_type;
+extern struct vimc_ent_type vimc_sensor_type;
+extern struct vimc_ent_type vimc_debayer_type;
+extern struct vimc_ent_type vimc_scaler_type;
+extern struct vimc_ent_type vimc_capture_type;
+extern struct vimc_ent_type vimc_lens_type;
 
 /**
  * vimc_pix_map_by_index - get vimc_pix_map struct by its index
diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
index 06edf9d4d92c..c73f91947f44 100644
--- a/drivers/media/test-drivers/vimc/vimc-core.c
+++ b/drivers/media/test-drivers/vimc/vimc-core.c
@@ -24,7 +24,7 @@ MODULE_PARM_DESC(allocator, " memory allocator selection, default is 0.\n"
 
 #define VIMC_MDEV_MODEL_NAME "VIMC MDEV"
 
-#define VIMC_ENT_LINK(src, srcpad, sink, sinkpad, link_flags) {	\
+#define VIMC_DATA_LINK(src, srcpad, sink, sinkpad, link_flags) {	\
 	.src_ent = src,						\
 	.src_pad = srcpad,					\
 	.sink_ent = sink,					\
@@ -32,8 +32,13 @@ MODULE_PARM_DESC(allocator, " memory allocator selection, default is 0.\n"
 	.flags = link_flags,					\
 }
 
-/* Structure which describes links between entities */
-struct vimc_ent_link {
+#define VIMC_ANCILLARY_LINK(primary, ancillary) {	\
+	.primary_ent = primary,			\
+	.ancillary_ent = ancillary		\
+}
+
+/* Structure which describes data links between entities */
+struct vimc_data_link {
 	unsigned int src_ent;
 	u16 src_pad;
 	unsigned int sink_ent;
@@ -41,12 +46,35 @@ struct vimc_ent_link {
 	u32 flags;
 };
 
+/* Enum to improve clarity when defining vimc_data_links */
+enum vimc_data_link_ents {
+	SENSOR_A,
+	SENSOR_B,
+	DEBAYER_A,
+	DEBAYER_B,
+	RAW_CAPTURE_0,
+	RAW_CAPTURE_1,
+	RGB_YUV_INPUT,
+	SCALER,
+	RGB_YUV_CAPTURE,
+	LENS_A,
+	LENS_B,
+};
+
+/* Structure which describes ancillary links between entities */
+struct vimc_ancillary_link {
+	unsigned int primary_ent;
+	unsigned int ancillary_ent;
+};
+
 /* Structure which describes the whole topology */
 struct vimc_pipeline_config {
 	const struct vimc_ent_config *ents;
 	size_t num_ents;
-	const struct vimc_ent_link *links;
-	size_t num_links;
+	const struct vimc_data_link *data_links;
+	size_t num_data_links;
+	const struct vimc_ancillary_link *ancillary_links;
+	size_t num_ancillary_links;
 };
 
 /* --------------------------------------------------------------------------
@@ -54,69 +82,91 @@ struct vimc_pipeline_config {
  */
 
 static struct vimc_ent_config ent_config[] = {
-	{
+	[SENSOR_A] = {
 		.name = "Sensor A",
-		.type = &vimc_sen_type
+		.type = &vimc_sensor_type
 	},
-	{
+	[SENSOR_B] = {
 		.name = "Sensor B",
-		.type = &vimc_sen_type
+		.type = &vimc_sensor_type
 	},
-	{
+	[DEBAYER_A] = {
 		.name = "Debayer A",
-		.type = &vimc_deb_type
+		.type = &vimc_debayer_type
 	},
-	{
+	[DEBAYER_B] = {
 		.name = "Debayer B",
-		.type = &vimc_deb_type
+		.type = &vimc_debayer_type
 	},
-	{
+	[RAW_CAPTURE_0] = {
 		.name = "Raw Capture 0",
-		.type = &vimc_cap_type
+		.type = &vimc_capture_type
 	},
-	{
+	[RAW_CAPTURE_1] = {
 		.name = "Raw Capture 1",
-		.type = &vimc_cap_type
+		.type = &vimc_capture_type
 	},
-	{
+	[RGB_YUV_INPUT] = {
 		/* TODO: change this to vimc-input when it is implemented */
 		.name = "RGB/YUV Input",
-		.type = &vimc_sen_type
+		.type = &vimc_sensor_type
 	},
-	{
+	[SCALER] = {
 		.name = "Scaler",
-		.type = &vimc_sca_type
+		.type = &vimc_scaler_type
 	},
-	{
+	[RGB_YUV_CAPTURE] = {
 		.name = "RGB/YUV Capture",
-		.type = &vimc_cap_type
+		.type = &vimc_capture_type
+	},
+	[LENS_A] = {
+		.name = "Lens A",
+		.type = &vimc_lens_type
+	},
+	[LENS_B] = {
+		.name = "Lens B",
+		.type = &vimc_lens_type
 	},
 };
 
-static const struct vimc_ent_link ent_links[] = {
+static const struct vimc_data_link data_links[] = {
 	/* Link: Sensor A (Pad 0)->(Pad 0) Debayer A */
-	VIMC_ENT_LINK(0, 0, 2, 0, MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
+	VIMC_DATA_LINK(SENSOR_A, 0, DEBAYER_A, 0,
+		       MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
 	/* Link: Sensor A (Pad 0)->(Pad 0) Raw Capture 0 */
-	VIMC_ENT_LINK(0, 0, 4, 0, MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
+	VIMC_DATA_LINK(SENSOR_A, 0, RAW_CAPTURE_0, 0,
+		       MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
 	/* Link: Sensor B (Pad 0)->(Pad 0) Debayer B */
-	VIMC_ENT_LINK(1, 0, 3, 0, MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
+	VIMC_DATA_LINK(SENSOR_B, 0, DEBAYER_B, 0,
+		       MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
 	/* Link: Sensor B (Pad 0)->(Pad 0) Raw Capture 1 */
-	VIMC_ENT_LINK(1, 0, 5, 0, MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
+	VIMC_DATA_LINK(SENSOR_B, 0, RAW_CAPTURE_1, 0,
+		       MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
 	/* Link: Debayer A (Pad 1)->(Pad 0) Scaler */
-	VIMC_ENT_LINK(2, 1, 7, 0, MEDIA_LNK_FL_ENABLED),
+	VIMC_DATA_LINK(DEBAYER_A, 1, SCALER, 0, MEDIA_LNK_FL_ENABLED),
 	/* Link: Debayer B (Pad 1)->(Pad 0) Scaler */
-	VIMC_ENT_LINK(3, 1, 7, 0, 0),
+	VIMC_DATA_LINK(DEBAYER_B, 1, SCALER, 0, 0),
 	/* Link: RGB/YUV Input (Pad 0)->(Pad 0) Scaler */
-	VIMC_ENT_LINK(6, 0, 7, 0, 0),
+	VIMC_DATA_LINK(RGB_YUV_INPUT, 0, SCALER, 0, 0),
 	/* Link: Scaler (Pad 1)->(Pad 0) RGB/YUV Capture */
-	VIMC_ENT_LINK(7, 1, 8, 0, MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
+	VIMC_DATA_LINK(SCALER, 1, RGB_YUV_CAPTURE, 0,
+		       MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE),
+};
+
+static const struct vimc_ancillary_link ancillary_links[] = {
+	/* Link: Sensor A -> Lens A */
+	VIMC_ANCILLARY_LINK(0, 9),
+	/* Link: Sensor B -> Lens B */
+	VIMC_ANCILLARY_LINK(1, 10),
 };
 
 static struct vimc_pipeline_config pipe_cfg = {
-	.ents		= ent_config,
-	.num_ents	= ARRAY_SIZE(ent_config),
-	.links		= ent_links,
-	.num_links	= ARRAY_SIZE(ent_links)
+	.ents		     = ent_config,
+	.num_ents	     = ARRAY_SIZE(ent_config),
+	.data_links	     = data_links,
+	.num_data_links	     = ARRAY_SIZE(data_links),
+	.ancillary_links     = ancillary_links,
+	.num_ancillary_links = ARRAY_SIZE(ancillary_links),
 };
 
 /* -------------------------------------------------------------------------- */
@@ -135,8 +185,8 @@ static int vimc_create_links(struct vimc_device *vimc)
 	int ret;
 
 	/* Initialize the links between entities */
-	for (i = 0; i < vimc->pipe_cfg->num_links; i++) {
-		const struct vimc_ent_link *link = &vimc->pipe_cfg->links[i];
+	for (i = 0; i < vimc->pipe_cfg->num_data_links; i++) {
+		const struct vimc_data_link *link = &vimc->pipe_cfg->data_links[i];
 
 		struct vimc_ent_device *ved_src =
 			vimc->ent_devs[link->src_ent];
@@ -150,6 +200,22 @@ static int vimc_create_links(struct vimc_device *vimc)
 			goto err_rm_links;
 	}
 
+	for (i = 0; i < vimc->pipe_cfg->num_ancillary_links; i++) {
+		const struct vimc_ancillary_link *link = &vimc->pipe_cfg->ancillary_links[i];
+
+		struct vimc_ent_device *ved_primary =
+			vimc->ent_devs[link->primary_ent];
+		struct vimc_ent_device *ved_ancillary =
+			vimc->ent_devs[link->ancillary_ent];
+		struct media_link *ret_link =
+			media_create_ancillary_link(ved_primary->ent, ved_ancillary->ent);
+
+		if (IS_ERR(ret_link)) {
+			ret = PTR_ERR(link);
+			goto err_rm_links;
+		}
+	}
+
 	return 0;
 
 err_rm_links:
diff --git a/drivers/media/test-drivers/vimc/vimc-debayer.c b/drivers/media/test-drivers/vimc/vimc-debayer.c
index 2d06cdbacc76..f671251fdf0e 100644
--- a/drivers/media/test-drivers/vimc/vimc-debayer.c
+++ b/drivers/media/test-drivers/vimc/vimc-debayer.c
@@ -15,28 +15,29 @@
 
 #include "vimc-common.h"
 
-enum vimc_deb_rgb_colors {
-	VIMC_DEB_RED = 0,
-	VIMC_DEB_GREEN = 1,
-	VIMC_DEB_BLUE = 2,
+enum vimc_debayer_rgb_colors {
+	VIMC_DEBAYER_RED = 0,
+	VIMC_DEBAYER_GREEN = 1,
+	VIMC_DEBAYER_BLUE = 2,
 };
 
-struct vimc_deb_pix_map {
+struct vimc_debayer_pix_map {
 	u32 code;
-	enum vimc_deb_rgb_colors order[2][2];
+	enum vimc_debayer_rgb_colors order[2][2];
 };
 
-struct vimc_deb_device {
+struct vimc_debayer_device {
 	struct vimc_ent_device ved;
 	struct v4l2_subdev sd;
 	/* The active format */
 	struct v4l2_mbus_framefmt sink_fmt;
 	u32 src_code;
-	void (*set_rgb_src)(struct vimc_deb_device *vdeb, unsigned int lin,
-			    unsigned int col, unsigned int rgb[3]);
+	void (*set_rgb_src)(struct vimc_debayer_device *vdebayer,
+			    unsigned int lin, unsigned int col,
+			    unsigned int rgb[3]);
 	/* Values calculated when the stream starts */
 	u8 *src_frame;
-	const struct vimc_deb_pix_map *sink_pix_map;
+	const struct vimc_debayer_pix_map *sink_pix_map;
 	unsigned int sink_bpp;
 	unsigned int mean_win_size;
 	struct v4l2_ctrl_handler hdl;
@@ -51,7 +52,7 @@ static const struct v4l2_mbus_framefmt sink_fmt_default = {
 	.colorspace = V4L2_COLORSPACE_SRGB,
 };
 
-static const u32 vimc_deb_src_mbus_codes[] = {
+static const u32 vimc_debayer_src_mbus_codes[] = {
 	MEDIA_BUS_FMT_GBR888_1X24,
 	MEDIA_BUS_FMT_BGR888_1X24,
 	MEDIA_BUS_FMT_BGR888_3X8,
@@ -64,95 +65,95 @@ static const u32 vimc_deb_src_mbus_codes[] = {
 	MEDIA_BUS_FMT_RGB888_1X32_PADHI,
 };
 
-static const struct vimc_deb_pix_map vimc_deb_pix_map_list[] = {
+static const struct vimc_debayer_pix_map vimc_debayer_pix_map_list[] = {
 	{
 		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
-		.order = { { VIMC_DEB_BLUE, VIMC_DEB_GREEN },
-			   { VIMC_DEB_GREEN, VIMC_DEB_RED } }
+		.order = { { VIMC_DEBAYER_BLUE, VIMC_DEBAYER_GREEN },
+			   { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_RED } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
-		.order = { { VIMC_DEB_GREEN, VIMC_DEB_BLUE },
-			   { VIMC_DEB_RED, VIMC_DEB_GREEN } }
+		.order = { { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_BLUE },
+			   { VIMC_DEBAYER_RED, VIMC_DEBAYER_GREEN } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGRBG8_1X8,
-		.order = { { VIMC_DEB_GREEN, VIMC_DEB_RED },
-			   { VIMC_DEB_BLUE, VIMC_DEB_GREEN } }
+		.order = { { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_RED },
+			   { VIMC_DEBAYER_BLUE, VIMC_DEBAYER_GREEN } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SRGGB8_1X8,
-		.order = { { VIMC_DEB_RED, VIMC_DEB_GREEN },
-			   { VIMC_DEB_GREEN, VIMC_DEB_BLUE } }
+		.order = { { VIMC_DEBAYER_RED, VIMC_DEBAYER_GREEN },
+			   { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_BLUE } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
-		.order = { { VIMC_DEB_BLUE, VIMC_DEB_GREEN },
-			   { VIMC_DEB_GREEN, VIMC_DEB_RED } }
+		.order = { { VIMC_DEBAYER_BLUE, VIMC_DEBAYER_GREEN },
+			   { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_RED } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
-		.order = { { VIMC_DEB_GREEN, VIMC_DEB_BLUE },
-			   { VIMC_DEB_RED, VIMC_DEB_GREEN } }
+		.order = { { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_BLUE },
+			   { VIMC_DEBAYER_RED, VIMC_DEBAYER_GREEN } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
-		.order = { { VIMC_DEB_GREEN, VIMC_DEB_RED },
-			   { VIMC_DEB_BLUE, VIMC_DEB_GREEN } }
+		.order = { { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_RED },
+			   { VIMC_DEBAYER_BLUE, VIMC_DEBAYER_GREEN } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
-		.order = { { VIMC_DEB_RED, VIMC_DEB_GREEN },
-			   { VIMC_DEB_GREEN, VIMC_DEB_BLUE } }
+		.order = { { VIMC_DEBAYER_RED, VIMC_DEBAYER_GREEN },
+			   { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_BLUE } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SBGGR12_1X12,
-		.order = { { VIMC_DEB_BLUE, VIMC_DEB_GREEN },
-			   { VIMC_DEB_GREEN, VIMC_DEB_RED } }
+		.order = { { VIMC_DEBAYER_BLUE, VIMC_DEBAYER_GREEN },
+			   { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_RED } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGBRG12_1X12,
-		.order = { { VIMC_DEB_GREEN, VIMC_DEB_BLUE },
-			   { VIMC_DEB_RED, VIMC_DEB_GREEN } }
+		.order = { { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_BLUE },
+			   { VIMC_DEBAYER_RED, VIMC_DEBAYER_GREEN } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGRBG12_1X12,
-		.order = { { VIMC_DEB_GREEN, VIMC_DEB_RED },
-			   { VIMC_DEB_BLUE, VIMC_DEB_GREEN } }
+		.order = { { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_RED },
+			   { VIMC_DEBAYER_BLUE, VIMC_DEBAYER_GREEN } }
 	},
 	{
 		.code = MEDIA_BUS_FMT_SRGGB12_1X12,
-		.order = { { VIMC_DEB_RED, VIMC_DEB_GREEN },
-			   { VIMC_DEB_GREEN, VIMC_DEB_BLUE } }
+		.order = { { VIMC_DEBAYER_RED, VIMC_DEBAYER_GREEN },
+			   { VIMC_DEBAYER_GREEN, VIMC_DEBAYER_BLUE } }
 	},
 };
 
-static const struct vimc_deb_pix_map *vimc_deb_pix_map_by_code(u32 code)
+static const struct vimc_debayer_pix_map *vimc_debayer_pix_map_by_code(u32 code)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(vimc_deb_pix_map_list); i++)
-		if (vimc_deb_pix_map_list[i].code == code)
-			return &vimc_deb_pix_map_list[i];
+	for (i = 0; i < ARRAY_SIZE(vimc_debayer_pix_map_list); i++)
+		if (vimc_debayer_pix_map_list[i].code == code)
+			return &vimc_debayer_pix_map_list[i];
 
 	return NULL;
 }
 
-static bool vimc_deb_src_code_is_valid(u32 code)
+static bool vimc_debayer_src_code_is_valid(u32 code)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(vimc_deb_src_mbus_codes); i++)
-		if (vimc_deb_src_mbus_codes[i] == code)
+	for (i = 0; i < ARRAY_SIZE(vimc_debayer_src_mbus_codes); i++)
+		if (vimc_debayer_src_mbus_codes[i] == code)
 			return true;
 
 	return false;
 }
 
-static int vimc_deb_init_cfg(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_state *sd_state)
+static int vimc_debayer_init_cfg(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state)
 {
-	struct vimc_deb_device *vdeb = v4l2_get_subdevdata(sd);
+	struct vimc_debayer_device *vdebayer = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *mf;
 	unsigned int i;
 
@@ -162,45 +163,45 @@ static int vimc_deb_init_cfg(struct v4l2_subdev *sd,
 	for (i = 1; i < sd->entity.num_pads; i++) {
 		mf = v4l2_subdev_get_try_format(sd, sd_state, i);
 		*mf = sink_fmt_default;
-		mf->code = vdeb->src_code;
+		mf->code = vdebayer->src_code;
 	}
 
 	return 0;
 }
 
-static int vimc_deb_enum_mbus_code(struct v4l2_subdev *sd,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_mbus_code_enum *code)
+static int vimc_debayer_enum_mbus_code(struct v4l2_subdev *sd,
+				       struct v4l2_subdev_state *sd_state,
+				       struct v4l2_subdev_mbus_code_enum *code)
 {
 	if (VIMC_IS_SRC(code->pad)) {
-		if (code->index >= ARRAY_SIZE(vimc_deb_src_mbus_codes))
+		if (code->index >= ARRAY_SIZE(vimc_debayer_src_mbus_codes))
 			return -EINVAL;
 
-		code->code = vimc_deb_src_mbus_codes[code->index];
+		code->code = vimc_debayer_src_mbus_codes[code->index];
 	} else {
-		if (code->index >= ARRAY_SIZE(vimc_deb_pix_map_list))
+		if (code->index >= ARRAY_SIZE(vimc_debayer_pix_map_list))
 			return -EINVAL;
 
-		code->code = vimc_deb_pix_map_list[code->index].code;
+		code->code = vimc_debayer_pix_map_list[code->index].code;
 	}
 
 	return 0;
 }
 
-static int vimc_deb_enum_frame_size(struct v4l2_subdev *sd,
-				    struct v4l2_subdev_state *sd_state,
-				    struct v4l2_subdev_frame_size_enum *fse)
+static int vimc_debayer_enum_frame_size(struct v4l2_subdev *sd,
+					struct v4l2_subdev_state *sd_state,
+					struct v4l2_subdev_frame_size_enum *fse)
 {
 	if (fse->index)
 		return -EINVAL;
 
 	if (VIMC_IS_SINK(fse->pad)) {
-		const struct vimc_deb_pix_map *vpix =
-			vimc_deb_pix_map_by_code(fse->code);
+		const struct vimc_debayer_pix_map *vpix =
+			vimc_debayer_pix_map_by_code(fse->code);
 
 		if (!vpix)
 			return -EINVAL;
-	} else if (!vimc_deb_src_code_is_valid(fse->code)) {
+	} else if (!vimc_debayer_src_code_is_valid(fse->code)) {
 		return -EINVAL;
 	}
 
@@ -212,30 +213,30 @@ static int vimc_deb_enum_frame_size(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int vimc_deb_get_fmt(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_state *sd_state,
-			    struct v4l2_subdev_format *fmt)
+static int vimc_debayer_get_fmt(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_format *fmt)
 {
-	struct vimc_deb_device *vdeb = v4l2_get_subdevdata(sd);
+	struct vimc_debayer_device *vdebayer = v4l2_get_subdevdata(sd);
 
 	/* Get the current sink format */
 	fmt->format = fmt->which == V4L2_SUBDEV_FORMAT_TRY ?
 		      *v4l2_subdev_get_try_format(sd, sd_state, 0) :
-		      vdeb->sink_fmt;
+		      vdebayer->sink_fmt;
 
 	/* Set the right code for the source pad */
 	if (VIMC_IS_SRC(fmt->pad))
-		fmt->format.code = vdeb->src_code;
+		fmt->format.code = vdebayer->src_code;
 
 	return 0;
 }
 
-static void vimc_deb_adjust_sink_fmt(struct v4l2_mbus_framefmt *fmt)
+static void vimc_debayer_adjust_sink_fmt(struct v4l2_mbus_framefmt *fmt)
 {
-	const struct vimc_deb_pix_map *vpix;
+	const struct vimc_debayer_pix_map *vpix;
 
 	/* Don't accept a code that is not on the debayer table */
-	vpix = vimc_deb_pix_map_by_code(fmt->code);
+	vpix = vimc_debayer_pix_map_by_code(fmt->code);
 	if (!vpix)
 		fmt->code = sink_fmt_default.code;
 
@@ -250,21 +251,21 @@ static void vimc_deb_adjust_sink_fmt(struct v4l2_mbus_framefmt *fmt)
 	vimc_colorimetry_clamp(fmt);
 }
 
-static int vimc_deb_set_fmt(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_state *sd_state,
-			    struct v4l2_subdev_format *fmt)
+static int vimc_debayer_set_fmt(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_format *fmt)
 {
-	struct vimc_deb_device *vdeb = v4l2_get_subdevdata(sd);
+	struct vimc_debayer_device *vdebayer = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *sink_fmt;
 	u32 *src_code;
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vdeb->src_frame)
+		if (vdebayer->src_frame)
 			return -EBUSY;
 
-		sink_fmt = &vdeb->sink_fmt;
-		src_code = &vdeb->src_code;
+		sink_fmt = &vdebayer->sink_fmt;
+		src_code = &vdebayer->src_code;
 	} else {
 		sink_fmt = v4l2_subdev_get_try_format(sd, sd_state, 0);
 		src_code = &v4l2_subdev_get_try_format(sd, sd_state, 1)->code;
@@ -279,17 +280,17 @@ static int vimc_deb_set_fmt(struct v4l2_subdev *sd,
 
 		fmt->format = *sink_fmt;
 
-		if (vimc_deb_src_code_is_valid(code))
+		if (vimc_debayer_src_code_is_valid(code))
 			*src_code = code;
 
 		fmt->format.code = *src_code;
 	} else {
 		/* Set the new format in the sink pad */
-		vimc_deb_adjust_sink_fmt(&fmt->format);
+		vimc_debayer_adjust_sink_fmt(&fmt->format);
 
-		dev_dbg(vdeb->ved.dev, "%s: sink format update: "
+		dev_dbg(vdebayer->ved.dev, "%s: sink format update: "
 			"old:%dx%d (0x%x, %d, %d, %d, %d) "
-			"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vdeb->sd.name,
+			"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vdebayer->sd.name,
 			/* old */
 			sink_fmt->width, sink_fmt->height, sink_fmt->code,
 			sink_fmt->colorspace, sink_fmt->quantization,
@@ -305,97 +306,97 @@ static int vimc_deb_set_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static const struct v4l2_subdev_pad_ops vimc_deb_pad_ops = {
-	.init_cfg		= vimc_deb_init_cfg,
-	.enum_mbus_code		= vimc_deb_enum_mbus_code,
-	.enum_frame_size	= vimc_deb_enum_frame_size,
-	.get_fmt		= vimc_deb_get_fmt,
-	.set_fmt		= vimc_deb_set_fmt,
+static const struct v4l2_subdev_pad_ops vimc_debayer_pad_ops = {
+	.init_cfg		= vimc_debayer_init_cfg,
+	.enum_mbus_code		= vimc_debayer_enum_mbus_code,
+	.enum_frame_size	= vimc_debayer_enum_frame_size,
+	.get_fmt		= vimc_debayer_get_fmt,
+	.set_fmt		= vimc_debayer_set_fmt,
 };
 
-static void vimc_deb_process_rgb_frame(struct vimc_deb_device *vdeb,
-				       unsigned int lin,
-				       unsigned int col,
-				       unsigned int rgb[3])
+static void vimc_debayer_process_rgb_frame(struct vimc_debayer_device *vdebayer,
+					   unsigned int lin,
+					   unsigned int col,
+					   unsigned int rgb[3])
 {
 	const struct vimc_pix_map *vpix;
 	unsigned int i, index;
 
-	vpix = vimc_pix_map_by_code(vdeb->src_code);
-	index = VIMC_FRAME_INDEX(lin, col, vdeb->sink_fmt.width, 3);
+	vpix = vimc_pix_map_by_code(vdebayer->src_code);
+	index = VIMC_FRAME_INDEX(lin, col, vdebayer->sink_fmt.width, 3);
 	for (i = 0; i < 3; i++) {
 		switch (vpix->pixelformat) {
 		case V4L2_PIX_FMT_RGB24:
-			vdeb->src_frame[index + i] = rgb[i];
+			vdebayer->src_frame[index + i] = rgb[i];
 			break;
 		case V4L2_PIX_FMT_BGR24:
-			vdeb->src_frame[index + i] = rgb[2 - i];
+			vdebayer->src_frame[index + i] = rgb[2 - i];
 			break;
 		}
 	}
 }
 
-static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
+static int vimc_debayer_s_stream(struct v4l2_subdev *sd, int enable)
 {
-	struct vimc_deb_device *vdeb = v4l2_get_subdevdata(sd);
+	struct vimc_debayer_device *vdebayer = v4l2_get_subdevdata(sd);
 
 	if (enable) {
 		const struct vimc_pix_map *vpix;
 		unsigned int frame_size;
 
-		if (vdeb->src_frame)
+		if (vdebayer->src_frame)
 			return 0;
 
 		/* Calculate the frame size of the source pad */
-		vpix = vimc_pix_map_by_code(vdeb->src_code);
-		frame_size = vdeb->sink_fmt.width * vdeb->sink_fmt.height *
+		vpix = vimc_pix_map_by_code(vdebayer->src_code);
+		frame_size = vdebayer->sink_fmt.width * vdebayer->sink_fmt.height *
 				vpix->bpp;
 
 		/* Save the bytes per pixel of the sink */
-		vpix = vimc_pix_map_by_code(vdeb->sink_fmt.code);
-		vdeb->sink_bpp = vpix->bpp;
+		vpix = vimc_pix_map_by_code(vdebayer->sink_fmt.code);
+		vdebayer->sink_bpp = vpix->bpp;
 
 		/* Get the corresponding pixel map from the table */
-		vdeb->sink_pix_map =
-			vimc_deb_pix_map_by_code(vdeb->sink_fmt.code);
+		vdebayer->sink_pix_map =
+			vimc_debayer_pix_map_by_code(vdebayer->sink_fmt.code);
 
 		/*
 		 * Allocate the frame buffer. Use vmalloc to be able to
 		 * allocate a large amount of memory
 		 */
-		vdeb->src_frame = vmalloc(frame_size);
-		if (!vdeb->src_frame)
+		vdebayer->src_frame = vmalloc(frame_size);
+		if (!vdebayer->src_frame)
 			return -ENOMEM;
 
 	} else {
-		if (!vdeb->src_frame)
+		if (!vdebayer->src_frame)
 			return 0;
 
-		vfree(vdeb->src_frame);
-		vdeb->src_frame = NULL;
+		vfree(vdebayer->src_frame);
+		vdebayer->src_frame = NULL;
 	}
 
 	return 0;
 }
 
-static const struct v4l2_subdev_core_ops vimc_deb_core_ops = {
+static const struct v4l2_subdev_core_ops vimc_debayer_core_ops = {
 	.log_status = v4l2_ctrl_subdev_log_status,
 	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
 	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
 };
 
-static const struct v4l2_subdev_video_ops vimc_deb_video_ops = {
-	.s_stream = vimc_deb_s_stream,
+static const struct v4l2_subdev_video_ops vimc_debayer_video_ops = {
+	.s_stream = vimc_debayer_s_stream,
 };
 
-static const struct v4l2_subdev_ops vimc_deb_ops = {
-	.core = &vimc_deb_core_ops,
-	.pad = &vimc_deb_pad_ops,
-	.video = &vimc_deb_video_ops,
+static const struct v4l2_subdev_ops vimc_debayer_ops = {
+	.core = &vimc_debayer_core_ops,
+	.pad = &vimc_debayer_pad_ops,
+	.video = &vimc_debayer_video_ops,
 };
 
-static unsigned int vimc_deb_get_val(const u8 *bytes,
-				     const unsigned int n_bytes)
+static unsigned int vimc_debayer_get_val(const u8 *bytes,
+					 const unsigned int n_bytes)
 {
 	unsigned int i;
 	unsigned int acc = 0;
@@ -406,11 +407,11 @@ static unsigned int vimc_deb_get_val(const u8 *bytes,
 	return acc;
 }
 
-static void vimc_deb_calc_rgb_sink(struct vimc_deb_device *vdeb,
-				   const u8 *frame,
-				   const unsigned int lin,
-				   const unsigned int col,
-				   unsigned int rgb[3])
+static void vimc_debayer_calc_rgb_sink(struct vimc_debayer_device *vdebayer,
+				       const u8 *frame,
+				       const unsigned int lin,
+				       const unsigned int col,
+				       unsigned int rgb[3])
 {
 	unsigned int i, seek, wlin, wcol;
 	unsigned int n_rgb[3] = {0, 0, 0};
@@ -423,13 +424,13 @@ static void vimc_deb_calc_rgb_sink(struct vimc_deb_device *vdeb,
 	 * the top left corner of the mean window (considering the current
 	 * pixel as the center)
 	 */
-	seek = vdeb->mean_win_size / 2;
+	seek = vdebayer->mean_win_size / 2;
 
 	/* Sum the values of the colors in the mean window */
 
-	dev_dbg(vdeb->ved.dev,
+	dev_dbg(vdebayer->ved.dev,
 		"deb: %s: --- Calc pixel %dx%d, window mean %d, seek %d ---\n",
-		vdeb->sd.name, lin, col, vdeb->sink_fmt.height, seek);
+		vdebayer->sd.name, lin, col, vdebayer->sink_fmt.height, seek);
 
 	/*
 	 * Iterate through all the lines in the mean window, start
@@ -438,7 +439,7 @@ static void vimc_deb_calc_rgb_sink(struct vimc_deb_device *vdeb,
 	 * frame
 	 */
 	for (wlin = seek > lin ? 0 : lin - seek;
-	     wlin < lin + seek + 1 && wlin < vdeb->sink_fmt.height;
+	     wlin < lin + seek + 1 && wlin < vdebayer->sink_fmt.height;
 	     wlin++) {
 
 		/*
@@ -448,78 +449,80 @@ static void vimc_deb_calc_rgb_sink(struct vimc_deb_device *vdeb,
 		 * frame
 		 */
 		for (wcol = seek > col ? 0 : col - seek;
-		     wcol < col + seek + 1 && wcol < vdeb->sink_fmt.width;
+		     wcol < col + seek + 1 && wcol < vdebayer->sink_fmt.width;
 		     wcol++) {
-			enum vimc_deb_rgb_colors color;
+			enum vimc_debayer_rgb_colors color;
 			unsigned int index;
 
 			/* Check which color this pixel is */
-			color = vdeb->sink_pix_map->order[wlin % 2][wcol % 2];
+			color = vdebayer->sink_pix_map->order[wlin % 2][wcol % 2];
 
 			index = VIMC_FRAME_INDEX(wlin, wcol,
-						 vdeb->sink_fmt.width,
-						 vdeb->sink_bpp);
+						 vdebayer->sink_fmt.width,
+						 vdebayer->sink_bpp);
 
-			dev_dbg(vdeb->ved.dev,
+			dev_dbg(vdebayer->ved.dev,
 				"deb: %s: RGB CALC: frame index %d, win pos %dx%d, color %d\n",
-				vdeb->sd.name, index, wlin, wcol, color);
+				vdebayer->sd.name, index, wlin, wcol, color);
 
 			/* Get its value */
 			rgb[color] = rgb[color] +
-				vimc_deb_get_val(&frame[index], vdeb->sink_bpp);
+				vimc_debayer_get_val(&frame[index],
+						     vdebayer->sink_bpp);
 
 			/* Save how many values we already added */
 			n_rgb[color]++;
 
-			dev_dbg(vdeb->ved.dev, "deb: %s: RGB CALC: val %d, n %d\n",
-				vdeb->sd.name, rgb[color], n_rgb[color]);
+			dev_dbg(vdebayer->ved.dev, "deb: %s: RGB CALC: val %d, n %d\n",
+				vdebayer->sd.name, rgb[color], n_rgb[color]);
 		}
 	}
 
 	/* Calculate the mean */
 	for (i = 0; i < 3; i++) {
-		dev_dbg(vdeb->ved.dev,
+		dev_dbg(vdebayer->ved.dev,
 			"deb: %s: PRE CALC: %dx%d Color %d, val %d, n %d\n",
-			vdeb->sd.name, lin, col, i, rgb[i], n_rgb[i]);
+			vdebayer->sd.name, lin, col, i, rgb[i], n_rgb[i]);
 
 		if (n_rgb[i])
 			rgb[i] = rgb[i] / n_rgb[i];
 
-		dev_dbg(vdeb->ved.dev,
+		dev_dbg(vdebayer->ved.dev,
 			"deb: %s: FINAL CALC: %dx%d Color %d, val %d\n",
-			vdeb->sd.name, lin, col, i, rgb[i]);
+			vdebayer->sd.name, lin, col, i, rgb[i]);
 	}
 }
 
-static void *vimc_deb_process_frame(struct vimc_ent_device *ved,
-				    const void *sink_frame)
+static void *vimc_debayer_process_frame(struct vimc_ent_device *ved,
+					const void *sink_frame)
 {
-	struct vimc_deb_device *vdeb = container_of(ved, struct vimc_deb_device,
-						    ved);
+	struct vimc_debayer_device *vdebayer =
+		container_of(ved, struct vimc_debayer_device, ved);
+
 	unsigned int rgb[3];
 	unsigned int i, j;
 
 	/* If the stream in this node is not active, just return */
-	if (!vdeb->src_frame)
+	if (!vdebayer->src_frame)
 		return ERR_PTR(-EINVAL);
 
-	for (i = 0; i < vdeb->sink_fmt.height; i++)
-		for (j = 0; j < vdeb->sink_fmt.width; j++) {
-			vimc_deb_calc_rgb_sink(vdeb, sink_frame, i, j, rgb);
-			vdeb->set_rgb_src(vdeb, i, j, rgb);
+	for (i = 0; i < vdebayer->sink_fmt.height; i++)
+		for (j = 0; j < vdebayer->sink_fmt.width; j++) {
+			vimc_debayer_calc_rgb_sink(vdebayer, sink_frame, i, j, rgb);
+			vdebayer->set_rgb_src(vdebayer, i, j, rgb);
 		}
 
-	return vdeb->src_frame;
+	return vdebayer->src_frame;
 }
 
-static int vimc_deb_s_ctrl(struct v4l2_ctrl *ctrl)
+static int vimc_debayer_s_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct vimc_deb_device *vdeb =
-		container_of(ctrl->handler, struct vimc_deb_device, hdl);
+	struct vimc_debayer_device *vdebayer =
+		container_of(ctrl->handler, struct vimc_debayer_device, hdl);
 
 	switch (ctrl->id) {
 	case VIMC_CID_MEAN_WIN_SIZE:
-		vdeb->mean_win_size = ctrl->val;
+		vdebayer->mean_win_size = ctrl->val;
 		break;
 	default:
 		return -EINVAL;
@@ -527,29 +530,29 @@ static int vimc_deb_s_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
-static const struct v4l2_ctrl_ops vimc_deb_ctrl_ops = {
-	.s_ctrl = vimc_deb_s_ctrl,
+static const struct v4l2_ctrl_ops vimc_debayer_ctrl_ops = {
+	.s_ctrl = vimc_debayer_s_ctrl,
 };
 
-static void vimc_deb_release(struct vimc_ent_device *ved)
+static void vimc_debayer_release(struct vimc_ent_device *ved)
 {
-	struct vimc_deb_device *vdeb =
-		container_of(ved, struct vimc_deb_device, ved);
+	struct vimc_debayer_device *vdebayer =
+		container_of(ved, struct vimc_debayer_device, ved);
 
-	v4l2_ctrl_handler_free(&vdeb->hdl);
-	media_entity_cleanup(vdeb->ved.ent);
-	kfree(vdeb);
+	v4l2_ctrl_handler_free(&vdebayer->hdl);
+	media_entity_cleanup(vdebayer->ved.ent);
+	kfree(vdebayer);
 }
 
-static const struct v4l2_ctrl_config vimc_deb_ctrl_class = {
+static const struct v4l2_ctrl_config vimc_debayer_ctrl_class = {
 	.flags = V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_WRITE_ONLY,
 	.id = VIMC_CID_VIMC_CLASS,
 	.name = "VIMC Controls",
 	.type = V4L2_CTRL_TYPE_CTRL_CLASS,
 };
 
-static const struct v4l2_ctrl_config vimc_deb_ctrl_mean_win_size = {
-	.ops = &vimc_deb_ctrl_ops,
+static const struct v4l2_ctrl_config vimc_debayer_ctrl_mean_win_size = {
+	.ops = &vimc_debayer_ctrl_ops,
 	.id = VIMC_CID_MEAN_WIN_SIZE,
 	.name = "Debayer Mean Window Size",
 	.type = V4L2_CTRL_TYPE_INTEGER,
@@ -559,65 +562,65 @@ static const struct v4l2_ctrl_config vimc_deb_ctrl_mean_win_size = {
 	.def = 3,
 };
 
-static struct vimc_ent_device *vimc_deb_add(struct vimc_device *vimc,
-					    const char *vcfg_name)
+static struct vimc_ent_device *vimc_debayer_add(struct vimc_device *vimc,
+						const char *vcfg_name)
 {
 	struct v4l2_device *v4l2_dev = &vimc->v4l2_dev;
-	struct vimc_deb_device *vdeb;
+	struct vimc_debayer_device *vdebayer;
 	int ret;
 
-	/* Allocate the vdeb struct */
-	vdeb = kzalloc(sizeof(*vdeb), GFP_KERNEL);
-	if (!vdeb)
+	/* Allocate the vdebayer struct */
+	vdebayer = kzalloc(sizeof(*vdebayer), GFP_KERNEL);
+	if (!vdebayer)
 		return ERR_PTR(-ENOMEM);
 
 	/* Create controls: */
-	v4l2_ctrl_handler_init(&vdeb->hdl, 2);
-	v4l2_ctrl_new_custom(&vdeb->hdl, &vimc_deb_ctrl_class, NULL);
-	v4l2_ctrl_new_custom(&vdeb->hdl, &vimc_deb_ctrl_mean_win_size, NULL);
-	vdeb->sd.ctrl_handler = &vdeb->hdl;
-	if (vdeb->hdl.error) {
-		ret = vdeb->hdl.error;
-		goto err_free_vdeb;
+	v4l2_ctrl_handler_init(&vdebayer->hdl, 2);
+	v4l2_ctrl_new_custom(&vdebayer->hdl, &vimc_debayer_ctrl_class, NULL);
+	v4l2_ctrl_new_custom(&vdebayer->hdl, &vimc_debayer_ctrl_mean_win_size, NULL);
+	vdebayer->sd.ctrl_handler = &vdebayer->hdl;
+	if (vdebayer->hdl.error) {
+		ret = vdebayer->hdl.error;
+		goto err_free_vdebayer;
 	}
 
 	/* Initialize ved and sd */
-	vdeb->pads[0].flags = MEDIA_PAD_FL_SINK;
-	vdeb->pads[1].flags = MEDIA_PAD_FL_SOURCE;
+	vdebayer->pads[0].flags = MEDIA_PAD_FL_SINK;
+	vdebayer->pads[1].flags = MEDIA_PAD_FL_SOURCE;
 
-	ret = vimc_ent_sd_register(&vdeb->ved, &vdeb->sd, v4l2_dev,
+	ret = vimc_ent_sd_register(&vdebayer->ved, &vdebayer->sd, v4l2_dev,
 				   vcfg_name,
 				   MEDIA_ENT_F_PROC_VIDEO_PIXEL_ENC_CONV, 2,
-				   vdeb->pads, &vimc_deb_ops);
+				   vdebayer->pads, &vimc_debayer_ops);
 	if (ret)
 		goto err_free_hdl;
 
-	vdeb->ved.process_frame = vimc_deb_process_frame;
-	vdeb->ved.dev = vimc->mdev.dev;
-	vdeb->mean_win_size = vimc_deb_ctrl_mean_win_size.def;
+	vdebayer->ved.process_frame = vimc_debayer_process_frame;
+	vdebayer->ved.dev = vimc->mdev.dev;
+	vdebayer->mean_win_size = vimc_debayer_ctrl_mean_win_size.def;
 
 	/* Initialize the frame format */
-	vdeb->sink_fmt = sink_fmt_default;
+	vdebayer->sink_fmt = sink_fmt_default;
 	/*
 	 * TODO: Add support for more output formats, we only support
 	 * RGB888 for now
 	 * NOTE: the src format is always the same as the sink, except
 	 * for the code
 	 */
-	vdeb->src_code = MEDIA_BUS_FMT_RGB888_1X24;
-	vdeb->set_rgb_src = vimc_deb_process_rgb_frame;
+	vdebayer->src_code = MEDIA_BUS_FMT_RGB888_1X24;
+	vdebayer->set_rgb_src = vimc_debayer_process_rgb_frame;
 
-	return &vdeb->ved;
+	return &vdebayer->ved;
 
 err_free_hdl:
-	v4l2_ctrl_handler_free(&vdeb->hdl);
-err_free_vdeb:
-	kfree(vdeb);
+	v4l2_ctrl_handler_free(&vdebayer->hdl);
+err_free_vdebayer:
+	kfree(vdebayer);
 
 	return ERR_PTR(ret);
 }
 
-struct vimc_ent_type vimc_deb_type = {
-	.add = vimc_deb_add,
-	.release = vimc_deb_release
+struct vimc_ent_type vimc_debayer_type = {
+	.add = vimc_debayer_add,
+	.release = vimc_debayer_release
 };
diff --git a/drivers/media/test-drivers/vimc/vimc-lens.c b/drivers/media/test-drivers/vimc/vimc-lens.c
new file mode 100644
index 000000000000..3ce7f4b4d2cc
--- /dev/null
+++ b/drivers/media/test-drivers/vimc/vimc-lens.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * vimc-lens.c Virtual Media Controller Driver
+ * Copyright (C) 2022 Google, Inc
+ * Author: yunkec@google.com (Yunke Cao)
+ */
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-subdev.h>
+
+#include "vimc-common.h"
+
+#define VIMC_LENS_MAX_FOCUS_POS	1023
+#define VIMC_LENS_MAX_FOCUS_STEP	1
+
+struct vimc_lens_device {
+	struct vimc_ent_device ved;
+	struct v4l2_subdev sd;
+	struct v4l2_ctrl_handler hdl;
+	u32 focus_absolute;
+};
+
+static const struct v4l2_subdev_core_ops vimc_lens_core_ops = {
+	.log_status = v4l2_ctrl_subdev_log_status,
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_ops vimc_lens_ops = {
+	.core = &vimc_lens_core_ops
+};
+
+static int vimc_lens_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vimc_lens_device *vlens =
+		container_of(ctrl->handler, struct vimc_lens_device, hdl);
+	if (ctrl->id == V4L2_CID_FOCUS_ABSOLUTE) {
+		vlens->focus_absolute = ctrl->val;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static const struct v4l2_ctrl_ops vimc_lens_ctrl_ops = {
+	.s_ctrl = vimc_lens_s_ctrl,
+};
+
+static struct vimc_ent_device *vimc_lens_add(struct vimc_device *vimc,
+					     const char *vcfg_name)
+{
+	struct v4l2_device *v4l2_dev = &vimc->v4l2_dev;
+	struct vimc_lens_device *vlens;
+	int ret;
+
+	/* Allocate the vlens struct */
+	vlens = kzalloc(sizeof(*vlens), GFP_KERNEL);
+	if (!vlens)
+		return ERR_PTR(-ENOMEM);
+
+	v4l2_ctrl_handler_init(&vlens->hdl, 1);
+
+	v4l2_ctrl_new_std(&vlens->hdl, &vimc_lens_ctrl_ops,
+			  V4L2_CID_FOCUS_ABSOLUTE, 0,
+			  VIMC_LENS_MAX_FOCUS_POS, VIMC_LENS_MAX_FOCUS_STEP, 0);
+	vlens->sd.ctrl_handler = &vlens->hdl;
+	if (vlens->hdl.error) {
+		ret = vlens->hdl.error;
+		goto err_free_vlens;
+	}
+	vlens->ved.dev = vimc->mdev.dev;
+
+	ret = vimc_ent_sd_register(&vlens->ved, &vlens->sd, v4l2_dev,
+				   vcfg_name, MEDIA_ENT_F_LENS, 0,
+				   NULL, &vimc_lens_ops);
+	if (ret)
+		goto err_free_hdl;
+
+	return &vlens->ved;
+
+err_free_hdl:
+	v4l2_ctrl_handler_free(&vlens->hdl);
+err_free_vlens:
+	kfree(vlens);
+
+	return ERR_PTR(ret);
+}
+
+static void vimc_lens_release(struct vimc_ent_device *ved)
+{
+	struct vimc_lens_device *vlens =
+		container_of(ved, struct vimc_lens_device, ved);
+
+	v4l2_ctrl_handler_free(&vlens->hdl);
+	media_entity_cleanup(vlens->ved.ent);
+	kfree(vlens);
+}
+
+struct vimc_ent_type vimc_lens_type = {
+	.add = vimc_lens_add,
+	.release = vimc_lens_release
+};
diff --git a/drivers/media/test-drivers/vimc/vimc-scaler.c b/drivers/media/test-drivers/vimc/vimc-scaler.c
index 820b8f5b502f..b671774e2784 100644
--- a/drivers/media/test-drivers/vimc/vimc-scaler.c
+++ b/drivers/media/test-drivers/vimc/vimc-scaler.c
@@ -16,14 +16,14 @@
 
 /* Pad identifier */
 enum vic_sca_pad {
-	VIMC_SCA_SINK = 0,
-	VIMC_SCA_SRC = 1,
+	VIMC_SCALER_SINK = 0,
+	VIMC_SCALER_SRC = 1,
 };
 
-#define VIMC_SCA_FMT_WIDTH_DEFAULT  640
-#define VIMC_SCA_FMT_HEIGHT_DEFAULT 480
+#define VIMC_SCALER_FMT_WIDTH_DEFAULT  640
+#define VIMC_SCALER_FMT_HEIGHT_DEFAULT 480
 
-struct vimc_sca_device {
+struct vimc_scaler_device {
 	struct vimc_ent_device ved;
 	struct v4l2_subdev sd;
 	struct v4l2_rect crop_rect;
@@ -36,16 +36,16 @@ struct vimc_sca_device {
 };
 
 static const struct v4l2_mbus_framefmt fmt_default = {
-	.width = VIMC_SCA_FMT_WIDTH_DEFAULT,
-	.height = VIMC_SCA_FMT_HEIGHT_DEFAULT,
+	.width = VIMC_SCALER_FMT_WIDTH_DEFAULT,
+	.height = VIMC_SCALER_FMT_HEIGHT_DEFAULT,
 	.code = MEDIA_BUS_FMT_RGB888_1X24,
 	.field = V4L2_FIELD_NONE,
 	.colorspace = V4L2_COLORSPACE_SRGB,
 };
 
 static const struct v4l2_rect crop_rect_default = {
-	.width = VIMC_SCA_FMT_WIDTH_DEFAULT,
-	.height = VIMC_SCA_FMT_HEIGHT_DEFAULT,
+	.width = VIMC_SCALER_FMT_WIDTH_DEFAULT,
+	.height = VIMC_SCALER_FMT_HEIGHT_DEFAULT,
 	.top = 0,
 	.left = 0,
 };
@@ -58,7 +58,7 @@ static const struct v4l2_rect crop_rect_min = {
 };
 
 static struct v4l2_rect
-vimc_sca_get_crop_bound_sink(const struct v4l2_mbus_framefmt *sink_fmt)
+vimc_scaler_get_crop_bound_sink(const struct v4l2_mbus_framefmt *sink_fmt)
 {
 	/* Get the crop bounds to clamp the crop rectangle correctly */
 	struct v4l2_rect r = {
@@ -70,7 +70,7 @@ vimc_sca_get_crop_bound_sink(const struct v4l2_mbus_framefmt *sink_fmt)
 	return r;
 }
 
-static int vimc_sca_init_cfg(struct v4l2_subdev *sd,
+static int vimc_scaler_init_cfg(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *sd_state)
 {
 	struct v4l2_mbus_framefmt *mf;
@@ -82,13 +82,13 @@ static int vimc_sca_init_cfg(struct v4l2_subdev *sd,
 		*mf = fmt_default;
 	}
 
-	r = v4l2_subdev_get_try_crop(sd, sd_state, VIMC_SCA_SINK);
+	r = v4l2_subdev_get_try_crop(sd, sd_state, VIMC_SCALER_SINK);
 	*r = crop_rect_default;
 
 	return 0;
 }
 
-static int vimc_sca_enum_mbus_code(struct v4l2_subdev *sd,
+static int vimc_scaler_enum_mbus_code(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_state *sd_state,
 				   struct v4l2_subdev_mbus_code_enum *code)
 {
@@ -109,7 +109,7 @@ static int vimc_sca_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int vimc_sca_enum_frame_size(struct v4l2_subdev *sd,
+static int vimc_scaler_enum_frame_size(struct v4l2_subdev *sd,
 				    struct v4l2_subdev_state *sd_state,
 				    struct v4l2_subdev_frame_size_enum *fse)
 {
@@ -133,57 +133,57 @@ static int vimc_sca_enum_frame_size(struct v4l2_subdev *sd,
 }
 
 static struct v4l2_mbus_framefmt *
-vimc_sca_pad_format(struct vimc_sca_device *vsca,
+vimc_scaler_pad_format(struct vimc_scaler_device *vscaler,
 		    struct v4l2_subdev_state *sd_state, u32 pad,
 		    enum v4l2_subdev_format_whence which)
 {
 	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_format(&vsca->sd, sd_state, pad);
+		return v4l2_subdev_get_try_format(&vscaler->sd, sd_state, pad);
 	else
-		return &vsca->fmt[pad];
+		return &vscaler->fmt[pad];
 }
 
 static struct v4l2_rect *
-vimc_sca_pad_crop(struct vimc_sca_device *vsca,
+vimc_scaler_pad_crop(struct vimc_scaler_device *vscaler,
 		  struct v4l2_subdev_state *sd_state,
 		  enum v4l2_subdev_format_whence which)
 {
 	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_crop(&vsca->sd, sd_state,
-						VIMC_SCA_SINK);
+		return v4l2_subdev_get_try_crop(&vscaler->sd, sd_state,
+						VIMC_SCALER_SINK);
 	else
-		return &vsca->crop_rect;
+		return &vscaler->crop_rect;
 }
 
-static int vimc_sca_get_fmt(struct v4l2_subdev *sd,
+static int vimc_scaler_get_fmt(struct v4l2_subdev *sd,
 			    struct v4l2_subdev_state *sd_state,
 			    struct v4l2_subdev_format *format)
 {
-	struct vimc_sca_device *vsca = v4l2_get_subdevdata(sd);
+	struct vimc_scaler_device *vscaler = v4l2_get_subdevdata(sd);
 
-	format->format = *vimc_sca_pad_format(vsca, sd_state, format->pad,
+	format->format = *vimc_scaler_pad_format(vscaler, sd_state, format->pad,
 					      format->which);
 	return 0;
 }
 
-static int vimc_sca_set_fmt(struct v4l2_subdev *sd,
+static int vimc_scaler_set_fmt(struct v4l2_subdev *sd,
 			    struct v4l2_subdev_state *sd_state,
 			    struct v4l2_subdev_format *format)
 {
-	struct vimc_sca_device *vsca = v4l2_get_subdevdata(sd);
+	struct vimc_scaler_device *vscaler = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *fmt;
 
 	/* Do not change the active format while stream is on */
-	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE && vsca->src_frame)
+	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE && vscaler->src_frame)
 		return -EBUSY;
 
-	fmt = vimc_sca_pad_format(vsca, sd_state, format->pad, format->which);
+	fmt = vimc_scaler_pad_format(vscaler, sd_state, format->pad, format->which);
 
 	/*
 	 * The media bus code and colorspace can only be changed on the sink
 	 * pad, the source pad only follows.
 	 */
-	if (format->pad == VIMC_SCA_SINK) {
+	if (format->pad == VIMC_SCALER_SINK) {
 		const struct vimc_pix_map *vpix;
 
 		/* Only accept code in the pix map table in non bayer format. */
@@ -211,17 +211,17 @@ static int vimc_sca_set_fmt(struct v4l2_subdev *sd,
 	 * Propagate the sink pad format to the crop rectangle and the source
 	 * pad.
 	 */
-	if (format->pad == VIMC_SCA_SINK) {
+	if (format->pad == VIMC_SCALER_SINK) {
 		struct v4l2_mbus_framefmt *src_fmt;
 		struct v4l2_rect *crop;
 
-		crop = vimc_sca_pad_crop(vsca, sd_state, format->which);
+		crop = vimc_scaler_pad_crop(vscaler, sd_state, format->which);
 		crop->width = fmt->width;
 		crop->height = fmt->height;
 		crop->top = 0;
 		crop->left = 0;
 
-		src_fmt = vimc_sca_pad_format(vsca, sd_state, VIMC_SCA_SRC,
+		src_fmt = vimc_scaler_pad_format(vscaler, sd_state, VIMC_SCALER_SRC,
 					      format->which);
 		*src_fmt = *fmt;
 	}
@@ -231,11 +231,11 @@ static int vimc_sca_set_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int vimc_sca_get_selection(struct v4l2_subdev *sd,
+static int vimc_scaler_get_selection(struct v4l2_subdev *sd,
 				  struct v4l2_subdev_state *sd_state,
 				  struct v4l2_subdev_selection *sel)
 {
-	struct vimc_sca_device *vsca = v4l2_get_subdevdata(sd);
+	struct vimc_scaler_device *vscaler = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *sink_fmt;
 
 	if (VIMC_IS_SRC(sel->pad))
@@ -243,12 +243,12 @@ static int vimc_sca_get_selection(struct v4l2_subdev *sd,
 
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP:
-		sel->r = *vimc_sca_pad_crop(vsca, sd_state, sel->which);
+		sel->r = *vimc_scaler_pad_crop(vscaler, sd_state, sel->which);
 		break;
 	case V4L2_SEL_TGT_CROP_BOUNDS:
-		sink_fmt = vimc_sca_pad_format(vsca, sd_state, VIMC_SCA_SINK,
+		sink_fmt = vimc_scaler_pad_format(vscaler, sd_state, VIMC_SCALER_SINK,
 					       sel->which);
-		sel->r = vimc_sca_get_crop_bound_sink(sink_fmt);
+		sel->r = vimc_scaler_get_crop_bound_sink(sink_fmt);
 		break;
 	default:
 		return -EINVAL;
@@ -257,22 +257,22 @@ static int vimc_sca_get_selection(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static void vimc_sca_adjust_sink_crop(struct v4l2_rect *r,
+static void vimc_scaler_adjust_sink_crop(struct v4l2_rect *r,
 				      const struct v4l2_mbus_framefmt *sink_fmt)
 {
 	const struct v4l2_rect sink_rect =
-		vimc_sca_get_crop_bound_sink(sink_fmt);
+		vimc_scaler_get_crop_bound_sink(sink_fmt);
 
 	/* Disallow rectangles smaller than the minimal one. */
 	v4l2_rect_set_min_size(r, &crop_rect_min);
 	v4l2_rect_map_inside(r, &sink_rect);
 }
 
-static int vimc_sca_set_selection(struct v4l2_subdev *sd,
+static int vimc_scaler_set_selection(struct v4l2_subdev *sd,
 				  struct v4l2_subdev_state *sd_state,
 				  struct v4l2_subdev_selection *sel)
 {
-	struct vimc_sca_device *vsca = v4l2_get_subdevdata(sd);
+	struct vimc_scaler_device *vscaler = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *sink_fmt;
 	struct v4l2_rect *crop_rect;
 
@@ -280,165 +280,165 @@ static int vimc_sca_set_selection(struct v4l2_subdev *sd,
 	if (VIMC_IS_SRC(sel->pad) || sel->target != V4L2_SEL_TGT_CROP)
 		return -EINVAL;
 
-	if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE && vsca->src_frame)
+	if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE && vscaler->src_frame)
 		return -EBUSY;
 
-	crop_rect = vimc_sca_pad_crop(vsca, sd_state, sel->which);
-	sink_fmt = vimc_sca_pad_format(vsca, sd_state, VIMC_SCA_SINK,
+	crop_rect = vimc_scaler_pad_crop(vscaler, sd_state, sel->which);
+	sink_fmt = vimc_scaler_pad_format(vscaler, sd_state, VIMC_SCALER_SINK,
 				       sel->which);
-	vimc_sca_adjust_sink_crop(&sel->r, sink_fmt);
+	vimc_scaler_adjust_sink_crop(&sel->r, sink_fmt);
 	*crop_rect = sel->r;
 
 	return 0;
 }
 
-static const struct v4l2_subdev_pad_ops vimc_sca_pad_ops = {
-	.init_cfg		= vimc_sca_init_cfg,
-	.enum_mbus_code		= vimc_sca_enum_mbus_code,
-	.enum_frame_size	= vimc_sca_enum_frame_size,
-	.get_fmt		= vimc_sca_get_fmt,
-	.set_fmt		= vimc_sca_set_fmt,
-	.get_selection		= vimc_sca_get_selection,
-	.set_selection		= vimc_sca_set_selection,
+static const struct v4l2_subdev_pad_ops vimc_scaler_pad_ops = {
+	.init_cfg		= vimc_scaler_init_cfg,
+	.enum_mbus_code		= vimc_scaler_enum_mbus_code,
+	.enum_frame_size	= vimc_scaler_enum_frame_size,
+	.get_fmt		= vimc_scaler_get_fmt,
+	.set_fmt		= vimc_scaler_set_fmt,
+	.get_selection		= vimc_scaler_get_selection,
+	.set_selection		= vimc_scaler_set_selection,
 };
 
-static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
+static int vimc_scaler_s_stream(struct v4l2_subdev *sd, int enable)
 {
-	struct vimc_sca_device *vsca = v4l2_get_subdevdata(sd);
+	struct vimc_scaler_device *vscaler = v4l2_get_subdevdata(sd);
 
 	if (enable) {
 		const struct vimc_pix_map *vpix;
 		unsigned int frame_size;
 
-		if (vsca->src_frame)
+		if (vscaler->src_frame)
 			return 0;
 
 		/* Save the bytes per pixel of the sink */
-		vpix = vimc_pix_map_by_code(vsca->fmt[VIMC_SCA_SINK].code);
-		vsca->bpp = vpix->bpp;
+		vpix = vimc_pix_map_by_code(vscaler->fmt[VIMC_SCALER_SINK].code);
+		vscaler->bpp = vpix->bpp;
 
 		/* Calculate the frame size of the source pad */
-		frame_size = vsca->fmt[VIMC_SCA_SRC].width
-			   * vsca->fmt[VIMC_SCA_SRC].height * vsca->bpp;
+		frame_size = vscaler->fmt[VIMC_SCALER_SRC].width
+			   * vscaler->fmt[VIMC_SCALER_SRC].height * vscaler->bpp;
 
 		/* Allocate the frame buffer. Use vmalloc to be able to
 		 * allocate a large amount of memory
 		 */
-		vsca->src_frame = vmalloc(frame_size);
-		if (!vsca->src_frame)
+		vscaler->src_frame = vmalloc(frame_size);
+		if (!vscaler->src_frame)
 			return -ENOMEM;
 
 	} else {
-		if (!vsca->src_frame)
+		if (!vscaler->src_frame)
 			return 0;
 
-		vfree(vsca->src_frame);
-		vsca->src_frame = NULL;
+		vfree(vscaler->src_frame);
+		vscaler->src_frame = NULL;
 	}
 
 	return 0;
 }
 
-static const struct v4l2_subdev_video_ops vimc_sca_video_ops = {
-	.s_stream = vimc_sca_s_stream,
+static const struct v4l2_subdev_video_ops vimc_scaler_video_ops = {
+	.s_stream = vimc_scaler_s_stream,
 };
 
-static const struct v4l2_subdev_ops vimc_sca_ops = {
-	.pad = &vimc_sca_pad_ops,
-	.video = &vimc_sca_video_ops,
+static const struct v4l2_subdev_ops vimc_scaler_ops = {
+	.pad = &vimc_scaler_pad_ops,
+	.video = &vimc_scaler_video_ops,
 };
 
-static void vimc_sca_fill_src_frame(const struct vimc_sca_device *const vsca,
+static void vimc_scaler_fill_src_frame(const struct vimc_scaler_device *const vscaler,
 				    const u8 *const sink_frame)
 {
-	const struct v4l2_mbus_framefmt *src_fmt = &vsca->fmt[VIMC_SCA_SRC];
-	const struct v4l2_rect *r = &vsca->crop_rect;
-	unsigned int snk_width = vsca->fmt[VIMC_SCA_SINK].width;
+	const struct v4l2_mbus_framefmt *src_fmt = &vscaler->fmt[VIMC_SCALER_SRC];
+	const struct v4l2_rect *r = &vscaler->crop_rect;
+	unsigned int snk_width = vscaler->fmt[VIMC_SCALER_SINK].width;
 	unsigned int src_x, src_y;
-	u8 *walker = vsca->src_frame;
+	u8 *walker = vscaler->src_frame;
 
 	/* Set each pixel at the src_frame to its sink_frame equivalent */
 	for (src_y = 0; src_y < src_fmt->height; src_y++) {
 		unsigned int snk_y, y_offset;
 
 		snk_y = (src_y * r->height) / src_fmt->height + r->top;
-		y_offset = snk_y * snk_width * vsca->bpp;
+		y_offset = snk_y * snk_width * vscaler->bpp;
 
 		for (src_x = 0; src_x < src_fmt->width; src_x++) {
 			unsigned int snk_x, x_offset, index;
 
 			snk_x = (src_x * r->width) / src_fmt->width + r->left;
-			x_offset = snk_x * vsca->bpp;
+			x_offset = snk_x * vscaler->bpp;
 			index = y_offset + x_offset;
-			memcpy(walker, &sink_frame[index], vsca->bpp);
-			walker += vsca->bpp;
+			memcpy(walker, &sink_frame[index], vscaler->bpp);
+			walker += vscaler->bpp;
 		}
 	}
 }
 
-static void *vimc_sca_process_frame(struct vimc_ent_device *ved,
+static void *vimc_scaler_process_frame(struct vimc_ent_device *ved,
 				    const void *sink_frame)
 {
-	struct vimc_sca_device *vsca = container_of(ved, struct vimc_sca_device,
+	struct vimc_scaler_device *vscaler = container_of(ved, struct vimc_scaler_device,
 						    ved);
 
 	/* If the stream in this node is not active, just return */
-	if (!vsca->src_frame)
+	if (!vscaler->src_frame)
 		return ERR_PTR(-EINVAL);
 
-	vimc_sca_fill_src_frame(vsca, sink_frame);
+	vimc_scaler_fill_src_frame(vscaler, sink_frame);
 
-	return vsca->src_frame;
+	return vscaler->src_frame;
 };
 
-static void vimc_sca_release(struct vimc_ent_device *ved)
+static void vimc_scaler_release(struct vimc_ent_device *ved)
 {
-	struct vimc_sca_device *vsca =
-		container_of(ved, struct vimc_sca_device, ved);
+	struct vimc_scaler_device *vscaler =
+		container_of(ved, struct vimc_scaler_device, ved);
 
-	media_entity_cleanup(vsca->ved.ent);
-	kfree(vsca);
+	media_entity_cleanup(vscaler->ved.ent);
+	kfree(vscaler);
 }
 
-static struct vimc_ent_device *vimc_sca_add(struct vimc_device *vimc,
+static struct vimc_ent_device *vimc_scaler_add(struct vimc_device *vimc,
 					    const char *vcfg_name)
 {
 	struct v4l2_device *v4l2_dev = &vimc->v4l2_dev;
-	struct vimc_sca_device *vsca;
+	struct vimc_scaler_device *vscaler;
 	int ret;
 
-	/* Allocate the vsca struct */
-	vsca = kzalloc(sizeof(*vsca), GFP_KERNEL);
-	if (!vsca)
+	/* Allocate the vscaler struct */
+	vscaler = kzalloc(sizeof(*vscaler), GFP_KERNEL);
+	if (!vscaler)
 		return ERR_PTR(-ENOMEM);
 
 	/* Initialize ved and sd */
-	vsca->pads[VIMC_SCA_SINK].flags = MEDIA_PAD_FL_SINK;
-	vsca->pads[VIMC_SCA_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	vscaler->pads[VIMC_SCALER_SINK].flags = MEDIA_PAD_FL_SINK;
+	vscaler->pads[VIMC_SCALER_SRC].flags = MEDIA_PAD_FL_SOURCE;
 
-	ret = vimc_ent_sd_register(&vsca->ved, &vsca->sd, v4l2_dev,
+	ret = vimc_ent_sd_register(&vscaler->ved, &vscaler->sd, v4l2_dev,
 				   vcfg_name,
 				   MEDIA_ENT_F_PROC_VIDEO_SCALER, 2,
-				   vsca->pads, &vimc_sca_ops);
+				   vscaler->pads, &vimc_scaler_ops);
 	if (ret) {
-		kfree(vsca);
+		kfree(vscaler);
 		return ERR_PTR(ret);
 	}
 
-	vsca->ved.process_frame = vimc_sca_process_frame;
-	vsca->ved.dev = vimc->mdev.dev;
+	vscaler->ved.process_frame = vimc_scaler_process_frame;
+	vscaler->ved.dev = vimc->mdev.dev;
 
 	/* Initialize the frame format */
-	vsca->fmt[VIMC_SCA_SINK] = fmt_default;
-	vsca->fmt[VIMC_SCA_SRC] = fmt_default;
+	vscaler->fmt[VIMC_SCALER_SINK] = fmt_default;
+	vscaler->fmt[VIMC_SCALER_SRC] = fmt_default;
 
 	/* Initialize the crop selection */
-	vsca->crop_rect = crop_rect_default;
+	vscaler->crop_rect = crop_rect_default;
 
-	return &vsca->ved;
+	return &vscaler->ved;
 }
 
-struct vimc_ent_type vimc_sca_type = {
-	.add = vimc_sca_add,
-	.release = vimc_sca_release
+struct vimc_ent_type vimc_scaler_type = {
+	.add = vimc_scaler_add,
+	.release = vimc_scaler_release
 };
diff --git a/drivers/media/test-drivers/vimc/vimc-sensor.c b/drivers/media/test-drivers/vimc/vimc-sensor.c
index 74ab79cadb5d..41a3dce2d714 100644
--- a/drivers/media/test-drivers/vimc/vimc-sensor.c
+++ b/drivers/media/test-drivers/vimc/vimc-sensor.c
@@ -14,18 +14,18 @@
 
 #include "vimc-common.h"
 
-enum vimc_sen_osd_mode {
-	VIMC_SEN_OSD_SHOW_ALL = 0,
-	VIMC_SEN_OSD_SHOW_COUNTERS = 1,
-	VIMC_SEN_OSD_SHOW_NONE = 2
+enum vimc_sensor_osd_mode {
+	VIMC_SENSOR_OSD_SHOW_ALL = 0,
+	VIMC_SENSOR_OSD_SHOW_COUNTERS = 1,
+	VIMC_SENSOR_OSD_SHOW_NONE = 2
 };
 
-struct vimc_sen_device {
+struct vimc_sensor_device {
 	struct vimc_ent_device ved;
 	struct v4l2_subdev sd;
 	struct tpg_data tpg;
 	u8 *frame;
-	enum vimc_sen_osd_mode osd_value;
+	enum vimc_sensor_osd_mode osd_value;
 	u64 start_stream_ts;
 	/* The active format */
 	struct v4l2_mbus_framefmt mbus_format;
@@ -41,8 +41,8 @@ static const struct v4l2_mbus_framefmt fmt_default = {
 	.colorspace = V4L2_COLORSPACE_SRGB,
 };
 
-static int vimc_sen_init_cfg(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_state *sd_state)
+static int vimc_sensor_init_cfg(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state)
 {
 	unsigned int i;
 
@@ -56,9 +56,9 @@ static int vimc_sen_init_cfg(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int vimc_sen_enum_mbus_code(struct v4l2_subdev *sd,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_mbus_code_enum *code)
+static int vimc_sensor_enum_mbus_code(struct v4l2_subdev *sd,
+				      struct v4l2_subdev_state *sd_state,
+				      struct v4l2_subdev_mbus_code_enum *code)
 {
 	u32 mbus_code = vimc_mbus_code_by_index(code->index);
 
@@ -70,9 +70,9 @@ static int vimc_sen_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int vimc_sen_enum_frame_size(struct v4l2_subdev *sd,
-				    struct v4l2_subdev_state *sd_state,
-				    struct v4l2_subdev_frame_size_enum *fse)
+static int vimc_sensor_enum_frame_size(struct v4l2_subdev *sd,
+				       struct v4l2_subdev_state *sd_state,
+				       struct v4l2_subdev_frame_size_enum *fse)
 {
 	const struct vimc_pix_map *vpix;
 
@@ -92,39 +92,39 @@ static int vimc_sen_enum_frame_size(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int vimc_sen_get_fmt(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_state *sd_state,
-			    struct v4l2_subdev_format *fmt)
+static int vimc_sensor_get_fmt(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *sd_state,
+			       struct v4l2_subdev_format *fmt)
 {
-	struct vimc_sen_device *vsen =
-				container_of(sd, struct vimc_sen_device, sd);
+	struct vimc_sensor_device *vsensor =
+				container_of(sd, struct vimc_sensor_device, sd);
 
 	fmt->format = fmt->which == V4L2_SUBDEV_FORMAT_TRY ?
 		      *v4l2_subdev_get_try_format(sd, sd_state, fmt->pad) :
-		      vsen->mbus_format;
+		      vsensor->mbus_format;
 
 	return 0;
 }
 
-static void vimc_sen_tpg_s_format(struct vimc_sen_device *vsen)
+static void vimc_sensor_tpg_s_format(struct vimc_sensor_device *vsensor)
 {
 	const struct vimc_pix_map *vpix =
-				vimc_pix_map_by_code(vsen->mbus_format.code);
+				vimc_pix_map_by_code(vsensor->mbus_format.code);
 
-	tpg_reset_source(&vsen->tpg, vsen->mbus_format.width,
-			 vsen->mbus_format.height, vsen->mbus_format.field);
-	tpg_s_bytesperline(&vsen->tpg, 0, vsen->mbus_format.width * vpix->bpp);
-	tpg_s_buf_height(&vsen->tpg, vsen->mbus_format.height);
-	tpg_s_fourcc(&vsen->tpg, vpix->pixelformat);
+	tpg_reset_source(&vsensor->tpg, vsensor->mbus_format.width,
+			 vsensor->mbus_format.height, vsensor->mbus_format.field);
+	tpg_s_bytesperline(&vsensor->tpg, 0, vsensor->mbus_format.width * vpix->bpp);
+	tpg_s_buf_height(&vsensor->tpg, vsensor->mbus_format.height);
+	tpg_s_fourcc(&vsensor->tpg, vpix->pixelformat);
 	/* TODO: add support for V4L2_FIELD_ALTERNATE */
-	tpg_s_field(&vsen->tpg, vsen->mbus_format.field, false);
-	tpg_s_colorspace(&vsen->tpg, vsen->mbus_format.colorspace);
-	tpg_s_ycbcr_enc(&vsen->tpg, vsen->mbus_format.ycbcr_enc);
-	tpg_s_quantization(&vsen->tpg, vsen->mbus_format.quantization);
-	tpg_s_xfer_func(&vsen->tpg, vsen->mbus_format.xfer_func);
+	tpg_s_field(&vsensor->tpg, vsensor->mbus_format.field, false);
+	tpg_s_colorspace(&vsensor->tpg, vsensor->mbus_format.colorspace);
+	tpg_s_ycbcr_enc(&vsensor->tpg, vsensor->mbus_format.ycbcr_enc);
+	tpg_s_quantization(&vsensor->tpg, vsensor->mbus_format.quantization);
+	tpg_s_xfer_func(&vsensor->tpg, vsensor->mbus_format.xfer_func);
 }
 
-static void vimc_sen_adjust_fmt(struct v4l2_mbus_framefmt *fmt)
+static void vimc_sensor_adjust_fmt(struct v4l2_mbus_framefmt *fmt)
 {
 	const struct vimc_pix_map *vpix;
 
@@ -145,29 +145,29 @@ static void vimc_sen_adjust_fmt(struct v4l2_mbus_framefmt *fmt)
 	vimc_colorimetry_clamp(fmt);
 }
 
-static int vimc_sen_set_fmt(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_state *sd_state,
-			    struct v4l2_subdev_format *fmt)
+static int vimc_sensor_set_fmt(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *sd_state,
+			       struct v4l2_subdev_format *fmt)
 {
-	struct vimc_sen_device *vsen = v4l2_get_subdevdata(sd);
+	struct vimc_sensor_device *vsensor = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *mf;
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vsen->frame)
+		if (vsensor->frame)
 			return -EBUSY;
 
-		mf = &vsen->mbus_format;
+		mf = &vsensor->mbus_format;
 	} else {
 		mf = v4l2_subdev_get_try_format(sd, sd_state, fmt->pad);
 	}
 
 	/* Set the new format */
-	vimc_sen_adjust_fmt(&fmt->format);
+	vimc_sensor_adjust_fmt(&fmt->format);
 
-	dev_dbg(vsen->ved.dev, "%s: format update: "
+	dev_dbg(vsensor->ved.dev, "%s: format update: "
 		"old:%dx%d (0x%x, %d, %d, %d, %d) "
-		"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vsen->sd.name,
+		"new:%dx%d (0x%x, %d, %d, %d, %d)\n", vsensor->sd.name,
 		/* old */
 		mf->width, mf->height, mf->code,
 		mf->colorspace,	mf->quantization,
@@ -182,146 +182,147 @@ static int vimc_sen_set_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static const struct v4l2_subdev_pad_ops vimc_sen_pad_ops = {
-	.init_cfg		= vimc_sen_init_cfg,
-	.enum_mbus_code		= vimc_sen_enum_mbus_code,
-	.enum_frame_size	= vimc_sen_enum_frame_size,
-	.get_fmt		= vimc_sen_get_fmt,
-	.set_fmt		= vimc_sen_set_fmt,
+static const struct v4l2_subdev_pad_ops vimc_sensor_pad_ops = {
+	.init_cfg		= vimc_sensor_init_cfg,
+	.enum_mbus_code		= vimc_sensor_enum_mbus_code,
+	.enum_frame_size	= vimc_sensor_enum_frame_size,
+	.get_fmt		= vimc_sensor_get_fmt,
+	.set_fmt		= vimc_sensor_set_fmt,
 };
 
-static void *vimc_sen_process_frame(struct vimc_ent_device *ved,
-				    const void *sink_frame)
+static void *vimc_sensor_process_frame(struct vimc_ent_device *ved,
+				       const void *sink_frame)
 {
-	struct vimc_sen_device *vsen = container_of(ved, struct vimc_sen_device,
-						    ved);
+	struct vimc_sensor_device *vsensor =
+		container_of(ved, struct vimc_sensor_device, ved);
+
 	const unsigned int line_height = 16;
 	u8 *basep[TPG_MAX_PLANES][2];
 	unsigned int line = 1;
 	char str[100];
 
-	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame);
-	tpg_calc_text_basep(&vsen->tpg, basep, 0, vsen->frame);
-	switch (vsen->osd_value) {
-	case VIMC_SEN_OSD_SHOW_ALL: {
-		const char *order = tpg_g_color_order(&vsen->tpg);
+	tpg_fill_plane_buffer(&vsensor->tpg, 0, 0, vsensor->frame);
+	tpg_calc_text_basep(&vsensor->tpg, basep, 0, vsensor->frame);
+	switch (vsensor->osd_value) {
+	case VIMC_SENSOR_OSD_SHOW_ALL: {
+		const char *order = tpg_g_color_order(&vsensor->tpg);
 
-		tpg_gen_text(&vsen->tpg, basep, line++ * line_height,
+		tpg_gen_text(&vsensor->tpg, basep, line++ * line_height,
 			     16, order);
 		snprintf(str, sizeof(str),
 			 "brightness %3d, contrast %3d, saturation %3d, hue %d ",
-			 vsen->tpg.brightness,
-			 vsen->tpg.contrast,
-			 vsen->tpg.saturation,
-			 vsen->tpg.hue);
-		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
+			 vsensor->tpg.brightness,
+			 vsensor->tpg.contrast,
+			 vsensor->tpg.saturation,
+			 vsensor->tpg.hue);
+		tpg_gen_text(&vsensor->tpg, basep, line++ * line_height, 16, str);
 		snprintf(str, sizeof(str), "sensor size: %dx%d",
-			 vsen->mbus_format.width,
-			 vsen->mbus_format.height);
-		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
+			 vsensor->mbus_format.width,
+			 vsensor->mbus_format.height);
+		tpg_gen_text(&vsensor->tpg, basep, line++ * line_height, 16, str);
 		fallthrough;
 	}
-	case VIMC_SEN_OSD_SHOW_COUNTERS: {
+	case VIMC_SENSOR_OSD_SHOW_COUNTERS: {
 		unsigned int ms;
 
-		ms = div_u64(ktime_get_ns() - vsen->start_stream_ts, 1000000);
+		ms = div_u64(ktime_get_ns() - vsensor->start_stream_ts, 1000000);
 		snprintf(str, sizeof(str), "%02d:%02d:%02d:%03d",
 			 (ms / (60 * 60 * 1000)) % 24,
 			 (ms / (60 * 1000)) % 60,
 			 (ms / 1000) % 60,
 			 ms % 1000);
-		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
+		tpg_gen_text(&vsensor->tpg, basep, line++ * line_height, 16, str);
 		break;
 	}
-	case VIMC_SEN_OSD_SHOW_NONE:
+	case VIMC_SENSOR_OSD_SHOW_NONE:
 	default:
 		break;
 	}
 
-	return vsen->frame;
+	return vsensor->frame;
 }
 
-static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
+static int vimc_sensor_s_stream(struct v4l2_subdev *sd, int enable)
 {
-	struct vimc_sen_device *vsen =
-				container_of(sd, struct vimc_sen_device, sd);
+	struct vimc_sensor_device *vsensor =
+				container_of(sd, struct vimc_sensor_device, sd);
 
 	if (enable) {
 		const struct vimc_pix_map *vpix;
 		unsigned int frame_size;
 
-		vsen->start_stream_ts = ktime_get_ns();
+		vsensor->start_stream_ts = ktime_get_ns();
 
 		/* Calculate the frame size */
-		vpix = vimc_pix_map_by_code(vsen->mbus_format.code);
-		frame_size = vsen->mbus_format.width * vpix->bpp *
-			     vsen->mbus_format.height;
+		vpix = vimc_pix_map_by_code(vsensor->mbus_format.code);
+		frame_size = vsensor->mbus_format.width * vpix->bpp *
+			     vsensor->mbus_format.height;
 
 		/*
 		 * Allocate the frame buffer. Use vmalloc to be able to
 		 * allocate a large amount of memory
 		 */
-		vsen->frame = vmalloc(frame_size);
-		if (!vsen->frame)
+		vsensor->frame = vmalloc(frame_size);
+		if (!vsensor->frame)
 			return -ENOMEM;
 
 		/* configure the test pattern generator */
-		vimc_sen_tpg_s_format(vsen);
+		vimc_sensor_tpg_s_format(vsensor);
 
 	} else {
 
-		vfree(vsen->frame);
-		vsen->frame = NULL;
+		vfree(vsensor->frame);
+		vsensor->frame = NULL;
 	}
 
 	return 0;
 }
 
-static const struct v4l2_subdev_core_ops vimc_sen_core_ops = {
+static const struct v4l2_subdev_core_ops vimc_sensor_core_ops = {
 	.log_status = v4l2_ctrl_subdev_log_status,
 	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
 	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
 };
 
-static const struct v4l2_subdev_video_ops vimc_sen_video_ops = {
-	.s_stream = vimc_sen_s_stream,
+static const struct v4l2_subdev_video_ops vimc_sensor_video_ops = {
+	.s_stream = vimc_sensor_s_stream,
 };
 
-static const struct v4l2_subdev_ops vimc_sen_ops = {
-	.core = &vimc_sen_core_ops,
-	.pad = &vimc_sen_pad_ops,
-	.video = &vimc_sen_video_ops,
+static const struct v4l2_subdev_ops vimc_sensor_ops = {
+	.core = &vimc_sensor_core_ops,
+	.pad = &vimc_sensor_pad_ops,
+	.video = &vimc_sensor_video_ops,
 };
 
-static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
+static int vimc_sensor_s_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct vimc_sen_device *vsen =
-		container_of(ctrl->handler, struct vimc_sen_device, hdl);
+	struct vimc_sensor_device *vsensor =
+		container_of(ctrl->handler, struct vimc_sensor_device, hdl);
 
 	switch (ctrl->id) {
 	case VIMC_CID_TEST_PATTERN:
-		tpg_s_pattern(&vsen->tpg, ctrl->val);
+		tpg_s_pattern(&vsensor->tpg, ctrl->val);
 		break;
 	case V4L2_CID_HFLIP:
-		tpg_s_hflip(&vsen->tpg, ctrl->val);
+		tpg_s_hflip(&vsensor->tpg, ctrl->val);
 		break;
 	case V4L2_CID_VFLIP:
-		tpg_s_vflip(&vsen->tpg, ctrl->val);
+		tpg_s_vflip(&vsensor->tpg, ctrl->val);
 		break;
 	case V4L2_CID_BRIGHTNESS:
-		tpg_s_brightness(&vsen->tpg, ctrl->val);
+		tpg_s_brightness(&vsensor->tpg, ctrl->val);
 		break;
 	case V4L2_CID_CONTRAST:
-		tpg_s_contrast(&vsen->tpg, ctrl->val);
+		tpg_s_contrast(&vsensor->tpg, ctrl->val);
 		break;
 	case V4L2_CID_HUE:
-		tpg_s_hue(&vsen->tpg, ctrl->val);
+		tpg_s_hue(&vsensor->tpg, ctrl->val);
 		break;
 	case V4L2_CID_SATURATION:
-		tpg_s_saturation(&vsen->tpg, ctrl->val);
+		tpg_s_saturation(&vsensor->tpg, ctrl->val);
 		break;
 	case VIMC_CID_OSD_TEXT_MODE:
-		vsen->osd_value = ctrl->val;
+		vsensor->osd_value = ctrl->val;
 		break;
 	default:
 		return -EINVAL;
@@ -329,31 +330,31 @@ static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
-static const struct v4l2_ctrl_ops vimc_sen_ctrl_ops = {
-	.s_ctrl = vimc_sen_s_ctrl,
+static const struct v4l2_ctrl_ops vimc_sensor_ctrl_ops = {
+	.s_ctrl = vimc_sensor_s_ctrl,
 };
 
-static void vimc_sen_release(struct vimc_ent_device *ved)
+static void vimc_sensor_release(struct vimc_ent_device *ved)
 {
-	struct vimc_sen_device *vsen =
-		container_of(ved, struct vimc_sen_device, ved);
+	struct vimc_sensor_device *vsensor =
+		container_of(ved, struct vimc_sensor_device, ved);
 
-	v4l2_ctrl_handler_free(&vsen->hdl);
-	tpg_free(&vsen->tpg);
-	media_entity_cleanup(vsen->ved.ent);
-	kfree(vsen);
+	v4l2_ctrl_handler_free(&vsensor->hdl);
+	tpg_free(&vsensor->tpg);
+	media_entity_cleanup(vsensor->ved.ent);
+	kfree(vsensor);
 }
 
 /* Image Processing Controls */
-static const struct v4l2_ctrl_config vimc_sen_ctrl_class = {
+static const struct v4l2_ctrl_config vimc_sensor_ctrl_class = {
 	.flags = V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_WRITE_ONLY,
 	.id = VIMC_CID_VIMC_CLASS,
 	.name = "VIMC Controls",
 	.type = V4L2_CTRL_TYPE_CTRL_CLASS,
 };
 
-static const struct v4l2_ctrl_config vimc_sen_ctrl_test_pattern = {
-	.ops = &vimc_sen_ctrl_ops,
+static const struct v4l2_ctrl_config vimc_sensor_ctrl_test_pattern = {
+	.ops = &vimc_sensor_ctrl_ops,
 	.id = VIMC_CID_TEST_PATTERN,
 	.name = "Test Pattern",
 	.type = V4L2_CTRL_TYPE_MENU,
@@ -368,8 +369,8 @@ static const char * const vimc_ctrl_osd_mode_strings[] = {
 	NULL,
 };
 
-static const struct v4l2_ctrl_config vimc_sen_ctrl_osd_mode = {
-	.ops = &vimc_sen_ctrl_ops,
+static const struct v4l2_ctrl_config vimc_sensor_ctrl_osd_mode = {
+	.ops = &vimc_sensor_ctrl_ops,
 	.id = VIMC_CID_OSD_TEXT_MODE,
 	.name = "Show Information",
 	.type = V4L2_CTRL_TYPE_MENU,
@@ -377,76 +378,76 @@ static const struct v4l2_ctrl_config vimc_sen_ctrl_osd_mode = {
 	.qmenu = vimc_ctrl_osd_mode_strings,
 };
 
-static struct vimc_ent_device *vimc_sen_add(struct vimc_device *vimc,
-					    const char *vcfg_name)
+static struct vimc_ent_device *vimc_sensor_add(struct vimc_device *vimc,
+					       const char *vcfg_name)
 {
 	struct v4l2_device *v4l2_dev = &vimc->v4l2_dev;
-	struct vimc_sen_device *vsen;
+	struct vimc_sensor_device *vsensor;
 	int ret;
 
-	/* Allocate the vsen struct */
-	vsen = kzalloc(sizeof(*vsen), GFP_KERNEL);
-	if (!vsen)
+	/* Allocate the vsensor struct */
+	vsensor = kzalloc(sizeof(*vsensor), GFP_KERNEL);
+	if (!vsensor)
 		return ERR_PTR(-ENOMEM);
 
-	v4l2_ctrl_handler_init(&vsen->hdl, 4);
+	v4l2_ctrl_handler_init(&vsensor->hdl, 4);
 
-	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_class, NULL);
-	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_test_pattern, NULL);
-	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_osd_mode, NULL);
-	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+	v4l2_ctrl_new_custom(&vsensor->hdl, &vimc_sensor_ctrl_class, NULL);
+	v4l2_ctrl_new_custom(&vsensor->hdl, &vimc_sensor_ctrl_test_pattern, NULL);
+	v4l2_ctrl_new_custom(&vsensor->hdl, &vimc_sensor_ctrl_osd_mode, NULL);
+	v4l2_ctrl_new_std(&vsensor->hdl, &vimc_sensor_ctrl_ops,
 			  V4L2_CID_VFLIP, 0, 1, 1, 0);
-	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+	v4l2_ctrl_new_std(&vsensor->hdl, &vimc_sensor_ctrl_ops,
 			  V4L2_CID_HFLIP, 0, 1, 1, 0);
-	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+	v4l2_ctrl_new_std(&vsensor->hdl, &vimc_sensor_ctrl_ops,
 			  V4L2_CID_BRIGHTNESS, 0, 255, 1, 128);
-	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+	v4l2_ctrl_new_std(&vsensor->hdl, &vimc_sensor_ctrl_ops,
 			  V4L2_CID_CONTRAST, 0, 255, 1, 128);
-	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+	v4l2_ctrl_new_std(&vsensor->hdl, &vimc_sensor_ctrl_ops,
 			  V4L2_CID_HUE, -128, 127, 1, 0);
-	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+	v4l2_ctrl_new_std(&vsensor->hdl, &vimc_sensor_ctrl_ops,
 			  V4L2_CID_SATURATION, 0, 255, 1, 128);
-	vsen->sd.ctrl_handler = &vsen->hdl;
-	if (vsen->hdl.error) {
-		ret = vsen->hdl.error;
-		goto err_free_vsen;
+	vsensor->sd.ctrl_handler = &vsensor->hdl;
+	if (vsensor->hdl.error) {
+		ret = vsensor->hdl.error;
+		goto err_free_vsensor;
 	}
 
 	/* Initialize the test pattern generator */
-	tpg_init(&vsen->tpg, vsen->mbus_format.width,
-		 vsen->mbus_format.height);
-	ret = tpg_alloc(&vsen->tpg, VIMC_FRAME_MAX_WIDTH);
+	tpg_init(&vsensor->tpg, vsensor->mbus_format.width,
+		 vsensor->mbus_format.height);
+	ret = tpg_alloc(&vsensor->tpg, VIMC_FRAME_MAX_WIDTH);
 	if (ret)
 		goto err_free_hdl;
 
 	/* Initialize ved and sd */
-	vsen->pad.flags = MEDIA_PAD_FL_SOURCE;
-	ret = vimc_ent_sd_register(&vsen->ved, &vsen->sd, v4l2_dev,
+	vsensor->pad.flags = MEDIA_PAD_FL_SOURCE;
+	ret = vimc_ent_sd_register(&vsensor->ved, &vsensor->sd, v4l2_dev,
 				   vcfg_name,
-				   MEDIA_ENT_F_CAM_SENSOR, 1, &vsen->pad,
-				   &vimc_sen_ops);
+				   MEDIA_ENT_F_CAM_SENSOR, 1, &vsensor->pad,
+				   &vimc_sensor_ops);
 	if (ret)
 		goto err_free_tpg;
 
-	vsen->ved.process_frame = vimc_sen_process_frame;
-	vsen->ved.dev = vimc->mdev.dev;
+	vsensor->ved.process_frame = vimc_sensor_process_frame;
+	vsensor->ved.dev = vimc->mdev.dev;
 
 	/* Initialize the frame format */
-	vsen->mbus_format = fmt_default;
+	vsensor->mbus_format = fmt_default;
 
-	return &vsen->ved;
+	return &vsensor->ved;
 
 err_free_tpg:
-	tpg_free(&vsen->tpg);
+	tpg_free(&vsensor->tpg);
 err_free_hdl:
-	v4l2_ctrl_handler_free(&vsen->hdl);
-err_free_vsen:
-	kfree(vsen);
+	v4l2_ctrl_handler_free(&vsensor->hdl);
+err_free_vsensor:
+	kfree(vsensor);
 
 	return ERR_PTR(ret);
 }
 
-struct vimc_ent_type vimc_sen_type = {
-	.add = vimc_sen_add,
-	.release = vimc_sen_release
+struct vimc_ent_type vimc_sensor_type = {
+	.add = vimc_sensor_add,
+	.release = vimc_sensor_release
 };

--------------7740FBF526EC3FB04E40AFBD--
