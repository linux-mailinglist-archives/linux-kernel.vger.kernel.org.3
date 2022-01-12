Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC548C0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbiALJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:04:43 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34177 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351894AbiALJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:04:42 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EF5F81BF203;
        Wed, 12 Jan 2022 09:04:38 +0000 (UTC)
Date:   Wed, 12 Jan 2022 10:05:39 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 21/23] media: atmel: atmel-isc: add raw Bayer 8bit
 10bit output formats
Message-ID: <20220112090539.ksn4civgcceopsc3@uno.localdomain>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-22-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-22-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Mon, Dec 13, 2021 at 03:49:38PM +0200, Eugen Hristev wrote:
> The ISC can dump the 8 bit and 10 bit raw bayer formats directly to
> the memory.
> Thus, add them to the supported output format list.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> ---
>  .../media/platform/atmel/atmel-sama5d2-isc.c  | 24 +++++++++++++++++++
>  .../media/platform/atmel/atmel-sama7g5-isc.c  | 24 +++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> index a8d4ba60d3ac..025c3e8a7e95 100644
> --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> @@ -88,6 +88,30 @@ static const struct isc_format sama5d2_controller_formats[] = {
>  	{
>  		.fourcc		= V4L2_PIX_FMT_Y10,
>  	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SBGGR8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGBRG8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGRBG8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SRGGB8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SBGGR10,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGBRG10,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGRBG10,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SRGGB10,
> +	},
>  };
>
>  /* This is a list of formats that the ISC can receive as *input* */
> diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> index 38721bd902e2..9dc75eed0098 100644
> --- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> @@ -100,6 +100,30 @@ static const struct isc_format sama7g5_controller_formats[] = {
>  	{
>  		.fourcc		= V4L2_PIX_FMT_Y16,
>  	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SBGGR8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGBRG8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGRBG8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SRGGB8,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SBGGR10,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGBRG10,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SGRBG10,
> +	},
> +	{
> +		.fourcc		= V4L2_PIX_FMT_SRGGB10,
> +	},
>  };
>
>  /* This is a list of formats that the ISC can receive as *input* */
> --
> 2.25.1
>
