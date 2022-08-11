Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8458FF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiHKPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiHKPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:18:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C491D2E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:18:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z16so21651728wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LvtGbE8ArwA/382zTLFpyTK+JZhPrlQAS4neTYrF8D8=;
        b=FqNI2i6c2UsDj1wTkrnTqAPc4P95V+sbWj1mjVSJ4UVMbiojwgPil6lpPZYW4HnMx5
         RfsTkxWU3LwIa28ZIetuq0dSX1nlO1KJIcHhTKgFRjIs1zgCHYnt9nuFz0njvygXJYTS
         Ofw8lu7WgiwUIF7R3WFYOZNmoEWmyNtNL6giM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LvtGbE8ArwA/382zTLFpyTK+JZhPrlQAS4neTYrF8D8=;
        b=cTboy1fMWh0TNy3aLpApArmS08UHWvPZb12uqg0+6Ry1e+LSKRAQOztCSW6Wco7gqb
         O0pPa2gUQ4flrHNtzCmFTPRlF+8aPEXNs7NYC/36mKae3GPAEI+U+dlUZ+U2g8wUADcV
         7/fGlGeQNXb3eXfnjN5rCz+8kUl3u6eMH0FzbXqvvj1ZsTMcQYz6+QvS0mzwgiOzbq7D
         HVshcKILmAvYK0wBk8j970KHc0wBqDhDqCNp3VsbF1kjv5AR2vGDrVU9Hh/Gqujz4SVu
         MUOI764nifTo1j066OpBIr+wPJGbGQCQPJZWP6U/4xfGuCYk1JeoySH+z50SiBgtcfHy
         qJjw==
X-Gm-Message-State: ACgBeo2itav1aF/HOHDpvB9jOEb2L7466gCs6u8zMFLRBDlOHUINWRTJ
        +ka/WRhOEquPn6d5HgXl7GNxjA==
X-Google-Smtp-Source: AA6agR5F2FT3H8CY500By/sS38e5L9n7uHIRX0hN1D3i6sXH97kaKzzhf4o+Ntqmp1nssS0YdADpyw==
X-Received: by 2002:a05:6000:71e:b0:223:764f:b2a8 with SMTP id bs30-20020a056000071e00b00223764fb2a8mr5668673wrb.79.1660231135716;
        Thu, 11 Aug 2022 08:18:55 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-51-7.cust.vodafonedsl.it. [188.217.51.7])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003a32297598csm8145507wmq.43.2022.08.11.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:18:55 -0700 (PDT)
Date:   Thu, 11 Aug 2022 17:18:53 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, shawnguo@kernel.org,
        robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] media: add nv12_8l128 and nv12_10be_8l128 video
 format.
Message-ID: <20220811151853.GB6390@tom-ThinkPad-T14s-Gen-2i>
References: <cover.1660027440.git.ming.qian@nxp.com>
 <84842bffb432884a0fd84de96c6e64ee2273e511.1660027440.git.ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84842bffb432884a0fd84de96c6e64ee2273e511.1660027440.git.ming.qian@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Tue, Aug 09, 2022 at 02:50:38PM +0800, Ming Qian wrote:
> add contiguous nv12 tiled format nv12_8l128 and nv12_10be_8l128
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-yuv-planar.rst         | 8 ++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                      | 2 ++
>  include/uapi/linux/videodev2.h                            | 2 ++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 10b1feeb0b57..f1d5bb7b806d 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -273,7 +273,9 @@ of the luma plane.
>  .. _V4L2-PIX-FMT-NV12-16L16:
>  .. _V4L2-PIX-FMT-NV12-32L32:
>  .. _V4L2-PIX-FMT-NV12M-8L128:
> +.. _V4L2-PIX-FMT-NV12-8L128:
>  .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
> +.. _V4L2-PIX-FMT-NV12-10BE-8L128:
>  .. _V4L2-PIX-FMT-MM21:
>  
>  Tiled NV12
> @@ -319,6 +321,9 @@ pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
>  The image height must be aligned to a multiple of 128.
>  The layouts of the luma and chroma planes are identical.
>  
> +``V4L2_PIX_FMT_NV12_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_8L128`` but stores
> +two planes in one memory.
> +

Don't know, maybe we need more details here?

>  ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
>  10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
>  the data is arranged in big endian order.
> @@ -334,6 +339,9 @@ byte 2: Y1(bits 3-0) Y2(bits 9-6)
>  byte 3: Y2(bits 5-0) Y3(bits 9-8)
>  byte 4: Y3(bits 7-0)
>  
> +``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
> +two planes in one memory.
> +

here also?

>  ``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
>  in 16x16 tiles. The line stride must be aligned to a multiple of 16 and the
>  image height must be aligned to a multiple of 32. The number of luma and chroma
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index c314025d977e..d973bd2ff750 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1444,7 +1444,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
>  	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
>  	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
> +	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
> +	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
>  	case V4L2_PIX_FMT_NV12M_10BE_8L128:	descr = "10-bit NV12M (8x128 Linear, BE)"; break;
>  
>  	default:
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index cd66e01ed3c3..64f16490dd2b 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -655,6 +655,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
>  #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y/CbCr 4:2:0 32x32 tiles */
>  #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/CbCr 4:2:0 10-bit 4x4 macroblocks */
> +#define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
> +#define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
>  
>  /* Tiled YUV formats, non contiguous planes */
>  #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 64x32 tiles */
> -- 
> 2.37.1
> 

For the other parts look's good to me.
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Regards,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
