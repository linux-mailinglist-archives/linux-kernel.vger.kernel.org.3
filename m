Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D029648C0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351892AbiALJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiALJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:03:38 -0500
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jan 2022 01:03:37 PST
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59314C06173F;
        Wed, 12 Jan 2022 01:03:37 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6E0C0240002;
        Wed, 12 Jan 2022 09:03:32 +0000 (UTC)
Date:   Wed, 12 Jan 2022 10:04:33 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 20/23] media: atmel: atmel-sama7g5-isc: fix UYVY input
 format mbus_code typo
Message-ID: <20220112090433.uy6aflzudfqy65y3@uno.localdomain>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-21-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-21-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Mon, Dec 13, 2021 at 03:49:37PM +0200, Eugen Hristev wrote:
> Fix the mbus code for UYVY input format type to the right color rotation.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> ---
>  drivers/media/platform/atmel/atmel-sama7g5-isc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> index d2ac80b1ccc3..38721bd902e2 100644
> --- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> @@ -188,7 +188,7 @@ static struct isc_format sama7g5_formats_list[] = {
>  	},
>  	{
>  		.fourcc		= V4L2_PIX_FMT_UYVY,
> -		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
> +		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
>  		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
>  	},
>  	{
> --
> 2.25.1
>
