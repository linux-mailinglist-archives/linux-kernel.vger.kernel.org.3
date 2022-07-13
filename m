Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3555573DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGMUeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiGMUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:34:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547FB19C0A;
        Wed, 13 Jul 2022 13:34:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0EA3305;
        Wed, 13 Jul 2022 22:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657744441;
        bh=FFwKvZARwFweAz3vNc8sElgRVMXjGCwOCjO0OsDEu50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kPDYTDWX5yiehF1r+ifUzzeNpGgCbE5IoIwK2MyTFRPultI/FEKG4ScMh0FwRqMG6
         DFqQBsuKJFObmWuYQtM0cgSu/p3tg4nN5W6uqqDwSlueENAcJzOOJvpktU1naYtH3i
         C42+v1Ty0UynNgSREV9kEJC5gvtqeJXaYdJMHrLs=
Date:   Wed, 13 Jul 2022 23:33:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rkisp1: Add NV16M and NV61M to output formats
Message-ID: <Ys8sHPPeZ8oQutJC@pendragon.ideasonboard.com>
References: <20220713072458.3425576-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220713072458.3425576-1-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Wed, Jul 13, 2022 at 04:24:58PM +0900, Paul Elder wrote:
> Add support for NV16M and NV61M as output formats. As NV16, NV61, NV12M
> and NV21M are already supported, the infrastructure is already in place
> to support NV16M and NV61M, so it is sufficient to simply add relevant
> entries to the list of output formats.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index fee2aaacb26b..43547ab55fab 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -110,6 +110,16 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
>  		.uv_swap = 1,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_NV16M,
> +		.uv_swap = 0,
> +		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_NV61M,
> +		.uv_swap = 1,
> +		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YVU422M,
>  		.uv_swap = 1,
> @@ -237,6 +247,18 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
>  		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_NV16M,
> +		.uv_swap = 0,
> +		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> +		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_NV61M,
> +		.uv_swap = 1,
> +		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> +		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YVU422M,
>  		.uv_swap = 1,

-- 
Regards,

Laurent Pinchart
