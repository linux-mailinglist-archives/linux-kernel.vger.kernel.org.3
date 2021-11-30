Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F5462AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhK3Cm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhK3Cm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:42:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF2C061574;
        Mon, 29 Nov 2021 18:39:39 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4126C2FD;
        Tue, 30 Nov 2021 03:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638239977;
        bh=D6c5QdmEOPbcUcWv/45z7zVdzObV1vuKlP/0f9FHf54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1ElRcoeeQXJSn0aDfgfttYjApGk3N9AekQZzH41b+TsHekB6RGm6RoYbSAGM4xYt
         xCFaOt+FHlYGWOswcjDbL4GseCtkCNOg0hbH1XThkb2kYUNMmkHjcClGLOvG407ykG
         ucxnxXkRZLfM6xKSChCWLNoA8FrDsw28f8/pJEUw=
Date:   Tue, 30 Nov 2021 04:39:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: rcar-du: Add DSI support to rcar_du_output_name
Message-ID: <YaWO0MjIDAa30cSM@pendragon.ideasonboard.com>
References: <20211129170845.2269532-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211129170845.2269532-1-kieran.bingham+renesas@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Mon, Nov 29, 2021 at 05:08:45PM +0000, Kieran Bingham wrote:
> The DSI output names were not added when the DSI pipeline support was
> introduced.
> 
> Add the correct labels for these outputs, and fix the sort order to
> match 'enum rcar_du_output' while we are here.
> 
> Fixes: b291fdcf5114 ("drm: rcar-du: Add r8a779a0 device support")
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 5612a9e7a905..5a8131ef81d5 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -544,10 +544,12 @@ const char *rcar_du_output_name(enum rcar_du_output output)
>  	static const char * const names[] = {
>  		[RCAR_DU_OUTPUT_DPAD0] = "DPAD0",
>  		[RCAR_DU_OUTPUT_DPAD1] = "DPAD1",
> -		[RCAR_DU_OUTPUT_LVDS0] = "LVDS0",
> -		[RCAR_DU_OUTPUT_LVDS1] = "LVDS1",
> +		[RCAR_DU_OUTPUT_DSI0] = "DSI0",
> +		[RCAR_DU_OUTPUT_DSI1] = "DSI1",
>  		[RCAR_DU_OUTPUT_HDMI0] = "HDMI0",
>  		[RCAR_DU_OUTPUT_HDMI1] = "HDMI1",
> +		[RCAR_DU_OUTPUT_LVDS0] = "LVDS0",
> +		[RCAR_DU_OUTPUT_LVDS1] = "LVDS1",
>  		[RCAR_DU_OUTPUT_TCON] = "TCON",
>  	};
>  

-- 
Regards,

Laurent Pinchart
