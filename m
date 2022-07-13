Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFAC573D04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiGMTMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiGMTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:12:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A831F63D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:12:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x91so15359650ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLq+vxmSJZQVlzojHgHWzYyGYj9NCZYGnKKKS15nhgc=;
        b=z+8/nuDj0YhTITREu8tEiSYhUaWtxa2u8s/WCri+GGAhIqC1JlOWNr5amsXORQhXvC
         HIjrp0W+dC6fYVhLJKT+zqPvpxBtXVbp5QUhil9xtDc9gq6HbcU1o/Av4IlXLCjJ5llM
         YBYmLJc5gwMUNbqCkOvUx+7S8DxrCJZp0WqnPxLynzfopX5/QBU/GlyE22MUUgPuPwEZ
         YUzweQU4YvgVe010Jf1Tj2yM79HPjV+GDG1DzxV0mn//ddaGYYgso77VgA6wl9Cnceov
         NyVS1PjEJgD/kOTaQSkTPG+cdImEbh3mU2gEU3pSs8lCD/S9namtcGgmYawjdFqtiMYs
         c18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLq+vxmSJZQVlzojHgHWzYyGYj9NCZYGnKKKS15nhgc=;
        b=s+xYr8RMjin/xuvbucPLgOrN0pDPlAcHHcfajKwX9F0Xj2l6RrvBM7vAmrbMbLY0Zb
         oWw3f/RmrKTsrVFXZ2N2CKdjkKWtcZF6f3HRsokoFZlQ4W+keooXPcEEhTg4jHuwlsFR
         tNuqBr32SDuOvYmr14ZVDBflLRyYCcUWfP6a1HpGWEZSxz7NfRkN8/+gOuO9eGWNrojT
         ffAkYp9Y2GQSBORhtzdUHMeZyX9s4PEs07ZuE7kKHrEMsCdF1ZvzVk0nAdM1FHKHI3/q
         YjVRVqRPP9EPRJhcU5Z+zmviRka5giPVuLSVuxwPE8lr++ntgOIa7cWRX36Fyj+DRuR0
         LnPw==
X-Gm-Message-State: AJIora96UAR+M694YmBmNInTL6XKl+C94Jd2xrSCPmHEduS+USIs4nU8
        BxGandw66cCm5jWqz7+ddJ/Gc5ddWCNyJ7KFkJ/eFbxWs/Cpzg==
X-Google-Smtp-Source: AGRyM1ubxyRQpxoVT6CAxq4vQ0utB7Mdt4cgjhd5Fh5373cKkbymnqNFUGq1gmsYNG8qOCThsrxESBTdiHe6Uajwe7M=
X-Received: by 2002:a05:6402:4396:b0:43a:77b5:41f7 with SMTP id
 o22-20020a056402439600b0043a77b541f7mr6804147edc.45.1657739529010; Wed, 13
 Jul 2022 12:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220713163201.136202-1-sebastian.fricke@collabora.com> <20220713163201.136202-3-sebastian.fricke@collabora.com>
In-Reply-To: <20220713163201.136202-3-sebastian.fricke@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 13 Jul 2022 16:11:57 -0300
Message-ID: <CAAEAJfAD49kc_zQsjKjB+v5PNcQXTEyT_fL98a2cSyzhTuk1Zg@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging: media: rkvdec: Enable S_CTRL IOCTL
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Wed, Jul 13, 2022 at 1:33 PM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
>
> Enable user-space to set the SPS of the current byte-stream on the
> decoder. This action will trigger the decoder to pick the optimal
> pixel-format for the capture queue.
>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 60 ++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 2625e0a736f4..f84579f764ab 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -27,6 +27,17 @@
>  #include "rkvdec.h"
>  #include "rkvdec-regs.h"
>
> +static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
> +                                      struct v4l2_pix_format_mplane *pix_mp)
> +{
> +       v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> +                           pix_mp->width, pix_mp->height);
> +       pix_mp->plane_fmt[0].sizeimage += 128 *
> +               DIV_ROUND_UP(pix_mp->width, 16) *
> +               DIV_ROUND_UP(pix_mp->height, 16);
> +       pix_mp->field = V4L2_FIELD_NONE;
> +}
> +
>  /*
>   * Fetch the optimal pixel-format directly from the codec variation. If the
>   * valid_fmt callback is not implemented, then the context variable valid_fmt
> @@ -44,6 +55,27 @@ static int rkvdec_get_valid_fmt(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +static int rkvdec_set_valid_fmt(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
> +{
> +       struct v4l2_pix_format_mplane *pix_mp;
> +
> +       switch (ctrl->id) {
> +       case V4L2_CID_STATELESS_H264_SPS:
> +       case V4L2_CID_STATELESS_VP9_FRAME:
> +       case V4L2_CID_STATELESS_HEVC_SPS:
> +               ctx->valid_fmt = rkvdec_get_valid_fmt(ctx, ctrl);
> +
> +               pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
> +               pix_mp->pixelformat = ctx->valid_fmt;
> +               rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
> +               break;
> +       default:
> +               dev_err(ctx->dev->dev, "Unsupported stateless control ID: %x\n", ctrl->id);
> +               return -EINVAL;
> +       };
> +       return 0;
> +}
> +
>  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> @@ -58,8 +90,18 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +static int rkvdec_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +       struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> +
> +       if (!ctx->valid_fmt)
> +               return rkvdec_set_valid_fmt(ctx, ctrl);

We've discussed this approach with Jonas.
See "[PATCH v2 10/12] media: rkvdec: Lock capture pixel format in
s_ctrl and s_fmt".

https://lore.kernel.org/all/f26407dbf3efc6cc046daaabdbe75c516743a187.camel@collabora.com/

The outcome of the discussion is:
* setting SPS resets the CAPTURE format (as per the spec).
* the application uses ENUM/TRY/S_FMT to negotiate a format, and uses
SPS to filter formats.

Thanks!
Ezequiel
