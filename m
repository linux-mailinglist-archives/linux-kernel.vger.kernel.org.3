Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017404EA894
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiC2HfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiC2HfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:35:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5633E64D3;
        Tue, 29 Mar 2022 00:33:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D434B1F434C3;
        Tue, 29 Mar 2022 08:33:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648539203;
        bh=6168akkeItinnefCNizxCX6qty+XlEyo8LTc/EhMHyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfICraTN9dPWVshI9ejFuM3OX2hFoRD5nKosTH5g67vwjeXewf8wTD/SF5u6n7PrN
         EnMshmHt8DYMnG89m0nwlWnmkcwRGUkrvqsP+n2t9g01xI37wA+XLebyOxR0ZMia6F
         vP+/wYs8obUoAX4lgY0vJ0W7weHyn6x9KQXStKF2JVswKPJxDhtkTocV1ZBDoysAUg
         kcIX6skZLT/4VG9kV1o0tywt6I9JGrroedxusx6cq27IYJ70KDj3WYyy5rXMLfbYpE
         kM/RczV2Nq51Vpsnp6jx+hXJ1FDIiczEzEaUoPfNe58xxLiWmnOjqR1I+OvEstUk0Z
         G8K+1WzbNLfVw==
Date:   Tue, 29 Mar 2022 09:33:19 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     James_Lin <Ping-lei.Lin@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Sherlock.Chang@mediatek.com,
        TM.Wu@mediatek.com
Subject: Re: [PATCH] Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
Message-ID: <20220329073319.7da77tpgt523zksg@basti-XPS-13-9310>
References: <20220329071407.17703-1-Ping-lei.Lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220329071407.17703-1-Ping-lei.Lin@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey James,

Looks like something went wrong during the creation of the patch.

The patch needs a commit subject line, a description what it does and
the SOB has to beneath that description.

Greetings,
Sebastian

On 29.03.2022 15:14, James_Lin wrote:
>diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
>index dda0f0aa78b8..ebb807c33e57 100644
>--- a/drivers/media/usb/uvc/uvc_driver.c
>+++ b/drivers/media/usb/uvc/uvc_driver.c
>@@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] = {
> 		.guid		= UVC_GUID_FORMAT_H264,
> 		.fcc		= V4L2_PIX_FMT_H264,
> 	},
>+	{
>+		.name		= "H.265",
>+		.guid		= UVC_GUID_FORMAT_H265,
>+		.fcc		= V4L2_PIX_FMT_H265,
>+	},
> 	{
> 		.name		= "Greyscale 8 L/R (Y8I)",
> 		.guid		= UVC_GUID_FORMAT_Y8I,
>diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
>index 143230b3275b..41f4d8c33f2a 100644
>--- a/drivers/media/usb/uvc/uvcvideo.h
>+++ b/drivers/media/usb/uvc/uvcvideo.h
>@@ -139,6 +139,9 @@
> #define UVC_GUID_FORMAT_H264 \
> 	{ 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
> 	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
>+#define UVC_GUID_FORMAT_H265 \
>+	{ 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
>+	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> #define UVC_GUID_FORMAT_Y8I \
> 	{ 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
> 	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
>diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>index 96e307fe3aab..aeaeb29307a4 100644
>--- a/drivers/media/v4l2-core/v4l2-ioctl.c
>+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>@@ -1402,6 +1402,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> 		case V4L2_PIX_FMT_JPEG:		descr = "JFIF JPEG"; break;
> 		case V4L2_PIX_FMT_DV:		descr = "1394"; break;
> 		case V4L2_PIX_FMT_MPEG:		descr = "MPEG-1/2/4"; break;
>+		case V4L2_PIX_FMT_H265:		descr = "H.265"; break;
> 		case V4L2_PIX_FMT_H264:		descr = "H.264"; break;
> 		case V4L2_PIX_FMT_H264_NO_SC:	descr = "H.264 (No Start Codes)"; break;
> 		case V4L2_PIX_FMT_H264_MVC:	descr = "H.264 MVC"; break;
>diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>index 3768a0a80830..636e4236bfb8 100644
>--- a/include/uapi/linux/videodev2.h
>+++ b/include/uapi/linux/videodev2.h
>@@ -691,6 +691,7 @@ struct v4l2_pix_format {
> #define V4L2_PIX_FMT_JPEG     v4l2_fourcc('J', 'P', 'E', 'G') /* JFIF JPEG     */
> #define V4L2_PIX_FMT_DV       v4l2_fourcc('d', 'v', 's', 'd') /* 1394          */
> #define V4L2_PIX_FMT_MPEG     v4l2_fourcc('M', 'P', 'E', 'G') /* MPEG-1/2/4 Multiplexed */
>+#define V4L2_PIX_FMT_H265     v4l2_fourcc('H', '2', '6', '5') /* H265 with start codes */
> #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
> #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
> #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
>-- 
>2.18.0
>
