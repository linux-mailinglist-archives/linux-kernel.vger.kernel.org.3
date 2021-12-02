Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35637466091
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356307AbhLBJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345216AbhLBJnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:43:08 -0500
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net [IPv6:2001:888:0:108::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60097C06174A;
        Thu,  2 Dec 2021 01:39:45 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id siZ1mcwTuyGz2siZ5mL26B; Thu, 02 Dec 2021 10:39:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638437983; bh=NB009B6v0eAw3dT3srPxYEFz06NHYHmUC1PrxnHY47o=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=dpKZeWsu3qlMzb4rlHYrNoj7Y7PizQueiB9n8TqasYOQcgZEH6DN0jnwVEfTaGW0y
         cm3YmFrIyfMox1NofDSN5Vs0n6U/S6yMhLXD3s62lm1U02S58XUl5NUNbsexZLbByd
         ljNxs9S8wIe+wmxfMq8Y8WUY/E39in8QPJ0o1ujhOrA+f40dGEz7CwY/mJjoYTktnq
         dqxqb7aTQk+trV/0Bj4ffDPVqwfT2j2k+f53lIa9OAAGjFZHOxOypP9R4oM+tIHfqK
         pvg+aMbqg7eyvQsMkEKmSbZymHOmdvynIPAqh6gl+rmFvoQXR+mswvvb7580mmkxZt
         uDyhBbIAnhk9Q==
Subject: Re: [PATCH v13 02/13] media:Add nv12mt_8l128 and nv12mt_10be_8l128
 video format.
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1638263914.git.ming.qian@nxp.com>
 <c7a7bf7a1d3c10a0e28064e37a472cbd45470e82.1638263914.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <3760b86b-b146-3382-595e-cf6483a883c8@xs4all.nl>
Date:   Thu, 2 Dec 2021 10:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c7a7bf7a1d3c10a0e28064e37a472cbd45470e82.1638263914.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCR/0dhhfdwQevvg/jHwV/Pje+Vh+tcrL4BZXKjNox3faw6f165FhRJM5wbWALkXkibOIpGrS3rZydX2jyfuXQySsTIwhxdiWALrmLQcirWMNswGUEbA
 nbvCBKuwNikPFWFPOnyqwRabqyURL9C2vNGjbWNVotcAffs0Dss/MKl8wgwYABiP1m+4sqMqiW6x92RB1vCZpqSIGpWlybGnnttQqSUQCYfqbLeYfLgOY+Eo
 HG9whZINvCNPT0qm3ehwVlIUfS83oszYOvNyQH+hL57/CKxs3VLAlNipajkOjWZyzCaHBVcndbnJ02E3YYggv86gWat4A8ppLG+er3AKC4/gtIm90m0hHx+z
 cuon8u0XPh1CAJ+1bOeyLRmFUGZpODvkv2DPWmLrA+BaQ5TMXKITo38bhFOGdRvc8DQsmkNb6vCOPwiEGdkYbkEIprRxBoaJHrP4uGoTaVoucXvnaptMFjKk
 Z1OrNPaR7zuJB30yM19AWqcrV3U15OaRss8Q7TQ7CooUHDxuv69Bqw8UHd7ki6Ihe2X6YIWT9EmPxOdwxkmIigbnR55GSb4rzziKCMV0WAWmMvKQy20yVCAx
 z2q54dhO6vTPiDtAEpG394TG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 10:48, Ming Qian wrote:
> nv12mt_8l128 is 8-bit tiled nv12 format used by amphion decoder.
> nv12mt_10be_8l128 is 10-bit tiled format used by amphion decoder.
> The tile size is 8x128
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-yuv-planar.rst | 15 +++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c              |  2 ++
>  include/uapi/linux/videodev2.h                    |  2 ++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 3a09d93d405b..fc3baa2753ab 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -257,6 +257,8 @@ of the luma plane.
>  .. _V4L2-PIX-FMT-NV12-4L4:
>  .. _V4L2-PIX-FMT-NV12-16L16:
>  .. _V4L2-PIX-FMT-NV12-32L32:
> +.. _V4L2_PIX_FMT_NV12MT_8L128:
> +.. _V4L2_PIX_FMT_NV12MT_10BE_8L128:
>  
>  Tiled NV12
>  ----------
> @@ -296,6 +298,19 @@ tiles linearly in memory. The line stride and image height must be
>  aligned to a multiple of 32. The layouts of the luma and chroma planes are
>  identical.
>  
> +``V4L2_PIX_FMT_NV12MT_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
> +pixel in 2D 8x128 tiles, and stores tiles linearly in memory.

pixel -> pixels (note: also wrong in the text V4L2_PIX_FMT_NV12_4L4/16L16/32L32)

Shouldn't this be called V4L2_PIX_FMT_NV12M_8L128? The 'MT' suffix seems to be specific
to macroblock tiles and not linear tiles.

> +The image height must be aligned to a multiple of 128.
> +The layouts of the luma and chroma planes are identical.
> +
> +``V4L2_PIX_FMT_NV12MT_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
> +10 bits pixel in 2D 8x128 tiles, and stores tiles linearly in memory.
> +the data is arranged at the big end.

at the big end -> in big endian order

I assume the 10 bit pixels are packed? So 5 bytes contain 4 10-bit pixels layout like
this (for luma):

byte 0: Y0(bits 9-2)
byte 1: Y0(bits 1-0) Y1(bits 9-4)
byte 2: Y1(bits 3-0) Y2(bits 9-6)
byte 3: Y2(bits 5-0) Y3(bits 9-8)
byte 4: Y3(bits 7-0)

> +The image height must be aligned to a multiple of 128.
> +The layouts of the luma and chroma planes are identical.
> +Note the tile size is 8bytes multiplied by 128 bytes,
> +it means that the low bits and high bits of one pixel may be in differnt tiles.

differnt -> different

> +
>  .. _nv12mt:
>  
>  .. kernel-figure:: nv12mt.svg
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 69b74d0e8a90..400eec0157a7 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1388,6 +1388,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
>  	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
>  	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
> +	case V4L2_PIX_FMT_NV12MT_8L128:	descr = "NV12M (8x128 Linear)"; break;
> +	case V4L2_PIX_FMT_NV12MT_10BE_8L128:	descr = "NV12M 10BE(8x128 Linear)"; break;

"10-bit NV12M (8x128 Linear, BE)"

>  
>  	default:
>  		/* Compressed formats */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index f118fe7a9f58..9443c3109928 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -632,6 +632,8 @@ struct v4l2_pix_format {
>  /* Tiled YUV formats, non contiguous planes */
>  #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 64x32 tiles */
>  #define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
> +#define V4L2_PIX_FMT_NV12MT_8L128      v4l2_fourcc('N', 'A', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
> +#define V4L2_PIX_FMT_NV12MT_10BE_8L128 v4l2_fourcc('N', 'T', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */

Use v4l2_fourcc_be to denote that this is a BE format.

>  
>  /* Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.htm */
>  #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  8  BGBG.. GRGR.. */
> 

Regards,

	Hans
