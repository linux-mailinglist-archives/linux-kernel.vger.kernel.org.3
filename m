Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5853048C0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351923AbiALJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:05:20 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:40285 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351895AbiALJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:05:17 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6788D240008;
        Wed, 12 Jan 2022 09:05:14 +0000 (UTC)
Date:   Wed, 12 Jan 2022 10:06:15 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 22/23] media: atmel: atmel-isc: compact the controller
 formats list
Message-ID: <20220112090615.6mbzd7fwn4a7yjtw@uno.localdomain>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-23-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-23-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Mon, Dec 13, 2021 at 03:49:39PM +0200, Eugen Hristev wrote:
> Compact the list array to be more readable.
> No other changes, only cosmetic.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> ---
>  .../media/platform/atmel/atmel-sama5d2-isc.c  | 51 ++++++----------
>  .../media/platform/atmel/atmel-sama7g5-isc.c  | 60 +++++++------------
>  2 files changed, 37 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> index 025c3e8a7e95..d96ee3373889 100644
> --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> @@ -60,56 +60,39 @@
>  static const struct isc_format sama5d2_controller_formats[] = {
>  	{
>  		.fourcc		= V4L2_PIX_FMT_ARGB444,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_ARGB555,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_RGB565,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_ABGR32,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_XBGR32,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_YUV420,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_YUYV,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_YUV422P,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_GREY,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_Y10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SBGGR8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGBRG8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGRBG8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SRGGB8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SBGGR10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGBRG10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGRBG10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SRGGB10,
>  	},
>  };
> diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> index 9dc75eed0098..e07ae188c15f 100644
> --- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> @@ -63,65 +63,45 @@
>  static const struct isc_format sama7g5_controller_formats[] = {
>  	{
>  		.fourcc		= V4L2_PIX_FMT_ARGB444,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_ARGB555,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_RGB565,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_ABGR32,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_XBGR32,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_YUV420,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_UYVY,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_VYUY,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_YUYV,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_YUV422P,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_GREY,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_Y10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_Y16,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SBGGR8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGBRG8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGRBG8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SRGGB8,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SBGGR10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGBRG10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SGRBG10,
> -	},
> -	{
> +	}, {
>  		.fourcc		= V4L2_PIX_FMT_SRGGB10,
>  	},
>  };
> --
> 2.25.1
>
