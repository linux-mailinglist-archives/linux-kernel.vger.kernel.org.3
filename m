Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB97492AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbiARQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347843AbiARQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:14:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295FC061401;
        Tue, 18 Jan 2022 08:12:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso7130868wmj.0;
        Tue, 18 Jan 2022 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Krm5uyz9TkCVOdM6IRP/tp33k9YUzt1fxsTNdw5NfEw=;
        b=KA9qDwiChE5WC5y/z8sx1fIYwcOJidks7V9x+KmnagPHsG/nangXyPC3+rMOFMxiG2
         ba1U24ByRXFbXcM2BPRH8q10tMqXd/SE3zLPY4vLmSr1dht5Hl5QAbq5uW7cBldbYOyd
         KctbVzA3zk8oUtacvgfhQhSlGI8KrWCEL5/Ov1dM8hvydrW6ai3lhzQtK83R9ttUHqiL
         +sXBFT6cUIOjHBZxKnetfudtQXdy/CW1udxChPQokhurcwURo5fx8oT/Zqqysw6BIDva
         o9xoqpbbMxvpnLJSeVBIPbhcW6mbOucfiC6+juCQZfdXMZKsIxEs0ynuJGXNuzsT4mXh
         BBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Krm5uyz9TkCVOdM6IRP/tp33k9YUzt1fxsTNdw5NfEw=;
        b=13GWTjrGu/OUDjwPeQCmV8nBZ8Fe3fCZmTYP7DaXjcC099U6cQaLgFVsQeTiSKbEfV
         4yKbD6CJsmdXjON7OZjhlFqUuZh1aavB4HtSFpKVjMdfckdbIKuPjiuGp+M004E82pGN
         sSmMiFNIIjJo4E5FPHv/AYRsjmVBoX0PiT3VwUbx3HsoGu2luIcXREDT05dyz4H0aQQa
         qjs1YSTSVVmBbS95V8gQ2V6U19tdQu429Q8IPbgs5LletNzK8knokzLw/LFpDTUOMUVo
         LJDaQw/Gms63Gcmoa7ITMFskLYGkGAfrppGTj7tUHAYyKYFk+6USvtjYC1GxQpwlkCOy
         HR1A==
X-Gm-Message-State: AOAM530G/1TSyx/2BAIHtWsZn9Eiojscg7ZPMwU+I2Ql7lgkevB7+zhE
        Cs4zXDk08ENBLREyp0gBDtixYJcQEPgU2vZiKALlSp2n
X-Google-Smtp-Source: ABdhPJxZIYhkFdiZT/A6fnYqp1GLnjJj7ZtJQYuN9lfydv7zQ4SqlsycyamGHxs7L0u+wVdYcHjoii0Dp7pIpJ75ZNY=
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr25280266wmj.151.1642522350903;
 Tue, 18 Jan 2022 08:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org> <20220117155559.234026-2-stanimir.varbanov@linaro.org>
In-Reply-To: <20220117155559.234026-2-stanimir.varbanov@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 18 Jan 2022 08:12:27 -0800
Message-ID: <CAF6AEGuB2drN-qt8TicP0pLYbKQLt2vEhLt+xSND7tVoOiNEQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] v4l: Add Qualcomm custom compressed pixel formats
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 6:36 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Add custom Qualcomm raw compressed pixel formats. They are
> used in Qualcomm SoCs to optimize the interconnect bandwidth.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../media/v4l/pixfmt-reserved.rst             | 19 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
>  include/uapi/linux/videodev2.h                |  2 ++
>  3 files changed, 23 insertions(+)
>
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 2f2133b4cd9c..929bd0dc0ba3 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -245,6 +245,25 @@ please make a proposal on the linux-media mailing list.
>        - Non-compressed, tiled two-planar format used by Mediatek MT8183.
>         This is an opaque intermediate format and the MDP3 hardware can be
>         used to convert it to other formats.
> +    * .. _V4L2-PIX-FMT-QC08C:
> +
> +      - ``V4L2_PIX_FMT_QC08C``
> +      - 'QC08C'
> +      - Compressed Macro-tile 8-Bit YUV420 format used by Qualcomm platforms.
> +        It is an opaque intermediate format. The used compression is lossless
> +        and it is used by various multimedia hardware blocks like GPU, display
> +        controllers, ISP and video accelerators.
> +        It contains four planes for progressive video and eight planes for
> +        interlaced video.

I guess QC08C is the same thing as NV12+UBWC?  Note that on the GPU
side, NV12+UBWC is treated as two planes, we program the hw with the
address of the start of UBWC data and the hw calculates the offset to
pixel data for the plane.  So the UBWC and pixel data are not actually
independent planes.

BR,
-R

> +    * .. _V4L2-PIX-FMT-QC10C:
> +
> +      - ``V4L2_PIX_FMT_QC10C``
> +      - 'QC10C'
> +      - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
> +        It is an opaque intermediate format. The used compression is lossless
> +        and it is used by various multimedia hardware blocks like GPU, display
> +        controllers, ISP and video accelerators.
> +        It contains four planes for progressive video.
>
>  .. raw:: latex
>
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 9ac557b8e146..1b6462f9ad7e 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1437,6 +1437,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>                 case V4L2_PIX_FMT_SE401:        descr = "GSPCA SE401"; break;
>                 case V4L2_PIX_FMT_S5C_UYVY_JPG: descr = "S5C73MX interleaved UYVY/JPEG"; break;
>                 case V4L2_PIX_FMT_MT21C:        descr = "Mediatek Compressed Format"; break;
> +               case V4L2_PIX_FMT_QC08C:        descr = "QCOM Compressed 8-bit Format"; break;
> +               case V4L2_PIX_FMT_QC10C:        descr = "QCOM Compressed 10-bit Format"; break;
>                 default:
>                         if (fmt->description[0])
>                                 return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index df8b9c486ba1..e710903185bd 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -744,6 +744,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
> +#define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
> +#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
>
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10      v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
> --
> 2.25.1
>
