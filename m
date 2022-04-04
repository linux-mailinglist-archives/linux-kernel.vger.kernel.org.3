Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E9F4F1EA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381468AbiDDVuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380394AbiDDT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:59:51 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0342FE42
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:57:53 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so11983891fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkOj47m3NIAXN7Y2Vl/oLURlRLC9Yzh32pg7qVKr6tc=;
        b=Dziv3JNSINXqZhhCZm8NMbWDDVHGFTwq8qQY5I4K6du6wGYur35Cz3jlsRBVF5OKij
         G+NA6yDpn+BOkVmRhu7tPykJfFgJXJuYbQD2ka84fDH9vMox2xsyJUPjkU0k/edzoNj5
         /bymzVl9m11MjdnzDLhnYrgzE1orMHGsxQD9rsMHQ8pA33vL6+jbW1Fc2qXbYDMYiH+p
         q7UTFxzB/OCks/Ns2/T+8CDd6c2sLlxj/CB4mNXp5RoDPd8GvkR8qZzE3it+/QxBYHf2
         e8XAgkVSSoCvSINTxQKasKDi5Tqsj8N3jZJLW+GSYwX2cc0yS1yaXEu4t6G0dj6Sp4mq
         MffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkOj47m3NIAXN7Y2Vl/oLURlRLC9Yzh32pg7qVKr6tc=;
        b=wOHgbtU30tdc/Pjg8s5pVeRixtH8ll+X+hhBYxlEUtIOh7LIOn7SAFaDa1unciS/CE
         ZQ5oSkl7Nm/N2o0mGXaI1LvizXjaS7iF0hjiO5aHOlSLHPq3lbLlGsfR3zfppybKRzW5
         7gv6giZZDruv7Hccwndxj1QHfqQR2+mf0EFhd7jquzJp9+JrJ/UxKwuE+B6ZyxgJ9y0c
         QSXTjXOobjGAAQEYJnk9lsdC0MC3WaLJeGVajtk0WDJjiUBmJnF33Li0McUfna7PGxDM
         JXnITWXPmed2HodE4ttSEOFKC76tFiDdsnFemmE7l2NVyRlgKz+MFpp4RaXjQ4p6VrdD
         Zr5Q==
X-Gm-Message-State: AOAM532LZcrMM53Hu6FH7hreuMZZMKGMZd6orTdbHZNv9HZQ22fKYhq5
        A7swQJY7OU+kkjhkMAsrMzTRcQ==
X-Google-Smtp-Source: ABdhPJyhJM5jTJxZsMABqBAJUE8+OMMH0JTJjH8W90MwXAYKcWFCIe+mg3D+WCWqVPr6xUC5HldkKw==
X-Received: by 2002:a05:6871:92:b0:d9:abe2:936e with SMTP id u18-20020a056871009200b000d9abe2936emr449661oaa.83.1649102272437;
        Mon, 04 Apr 2022 12:57:52 -0700 (PDT)
Received: from eze-laptop ([190.194.87.200])
        by smtp.gmail.com with ESMTPSA id s10-20020a4a3b0a000000b0032486bc11d0sm4430044oos.39.2022.04.04.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 12:57:51 -0700 (PDT)
Date:   Mon, 4 Apr 2022 16:57:46 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, p.zabel@pengutronix.de,
        nicolas@ndufresne.ca, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH] media: Add P010 video format
Message-ID: <YktNur601fjyCt9i@eze-laptop>
References: <20220404090116.353034-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404090116.353034-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:01:16AM +0200, Benjamin Gaignard wrote:
> P010 is a YUV format with 10-bits per pixel with interleaved UV.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
> Note that P010 is already known in GStreamer, only the mapping with
> v4l2 pixel format is missing.
> 
> This patch has been acked in this series but never merged:
> https://patchwork.kernel.org/project/linux-rockchip/patch/20210618131526.566762-5-benjamin.gaignard@collabora.com/
> After rebased it on v5.18-rc1, resend in standalone mode.
> 
>  .../media/v4l/pixfmt-yuv-planar.rst           | 76 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>  include/uapi/linux/videodev2.h                |  1 +
>  4 files changed, 79 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 8dff5906639b..6d65c8ac44f0 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -102,6 +102,13 @@ All components are stored with the same number of bits per component.
>        - 64x32 tiles
>  
>          Horizontal Z order
> +    * - V4L2_PIX_FMT_P010
> +      - 'P010'
> +      - 16
> +      - 4:2:0
> +      - Cb, Cr
> +      - No
> +      - Linear
>      * - V4L2_PIX_FMT_NV12MT_16X16
>        - 'VM12'
>        - 8
> @@ -171,6 +178,7 @@ horizontally.
>  .. _V4L2-PIX-FMT-NV21:
>  .. _V4L2-PIX-FMT-NV12M:
>  .. _V4L2-PIX-FMT-NV21M:
> +.. _V4L2-PIX-FMT-P010:
>  
>  NV12, NV21, NV12M and NV21M
>  ---------------------------
> @@ -519,6 +527,74 @@ number of lines as the luma plane.
>        - Cb\ :sub:`33`
>        - Cr\ :sub:`33`
>  
> +.. _V4L2_PIX_FMT_P010:
> +
> +P010
> +----
> +
> +The number of bytes in one luminance row must be divisible by 16,
> +which means there will be padded 0 in the right edge when necessary.
> +
> +.. raw:: latex
> +
> +    \begingroup
> +    \small
> +    \setlength{\tabcolsep}{2pt}
> +
> +.. tabularcolumns:: |p{2.6cm}|p{0.70cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
> +
> +.. flat-table:: P010 16 Bits per component
> +    :header-rows:  2
> +    :stub-columns: 0
> +
> +    * - Identifier
> +      - Code
> +      - :cspan:`7` Byte 0 in memory
> +
> +      - :cspan:`7` Byte 1
> +    * -
> +      -
> +      - 7
> +      - 6
> +      - 5
> +      - 4
> +      - 3
> +      - 2
> +      - 1
> +      - 0
> +
> +      - 7
> +      - 6
> +      - 5
> +      - 4
> +      - 3
> +      - 2
> +      - 1
> +      - 0
> +    * - ``V4L2_PIX_FMT_P010``
> +      - 'P010'
> +
> +      - Y\ :sub:`9`
> +      - Y\ :sub:`8`
> +      - Y\ :sub:`7`
> +      - Y\ :sub:`6`
> +      - Y\ :sub:`5`
> +      - Y\ :sub:`4`
> +      - Y\ :sub:`3`
> +      - Y\ :sub:`2`
> +
> +      - Y\ :sub:`1`
> +      - Y\ :sub:`0`
> +      - 0
> +      - 0
> +      - 0
> +      - 0
> +      - 0
> +      - 0
> +
> +.. raw:: latex
> +
> +    \endgroup
>  
>  Fully Planar YUV Formats
>  ========================
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index df34b2a283bc..1e38ad8906a2 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -266,6 +266,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		{ .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>  
>  		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
>  		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 96e307fe3aab..e14d7e1a038e 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1301,6 +1301,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
> +	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CrCb 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 4c09969e7112..2e451c454db3 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -601,6 +601,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
>  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
>  #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
> +#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 15  Y/CbCr 4:2:0 10-bit per pixel*/
>  
>  /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */
> -- 
> 2.32.0
> 
