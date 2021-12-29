Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF448155F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbhL2QxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:53:13 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34804 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhL2QxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:53:12 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15485464;
        Wed, 29 Dec 2021 17:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640796791;
        bh=d4mUqBC++plc2D3Vh5L6ujyZUc9IN8xOvxhMd+u6XZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCc3yy70iQyyy1vXz8/aLYXRTGapqmsPk/n/zN1AWZg15snGiY0clN8DSwxiq1KJs
         uG4pxSgkkrAQlM2hRdmfEeMZDI00+XLJS/dDicpHVBr+NHIH/EvSo1d6buXtb+pr02
         2UeCg3/pGPehayk2VUrzLmv9t2V/Twu7lB+7Ap5U=
Date:   Wed, 29 Dec 2021 18:53:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: rcar-du: lvds: Add r8a77961 support
Message-ID: <YcySdeYmUBCW/9r7@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-2-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211224052309.1997096-2-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch.

On Fri, Dec 24, 2021 at 08:23:07AM +0300, Nikita Yushchenko wrote:
> The M3-W+ SoC has the same LVDS encoder as other R-Car Gen3 chips.
> Add support for M3-W+ (R8A77961) SoC to the LVDS encoder driver.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> index 72a272cfc11e..8dbfbbd3cad1 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -901,6 +901,7 @@ static const struct of_device_id rcar_lvds_of_table[] = {
>  	{ .compatible = "renesas,r8a7793-lvds", .data = &rcar_lvds_gen2_info },
>  	{ .compatible = "renesas,r8a7795-lvds", .data = &rcar_lvds_gen3_info },
>  	{ .compatible = "renesas,r8a7796-lvds", .data = &rcar_lvds_gen3_info },
> +	{ .compatible = "renesas,r8a77961-lvds", .data = &rcar_lvds_gen3_info },
>  	{ .compatible = "renesas,r8a77965-lvds", .data = &rcar_lvds_gen3_info },
>  	{ .compatible = "renesas,r8a77970-lvds", .data = &rcar_lvds_r8a77970_info },
>  	{ .compatible = "renesas,r8a77980-lvds", .data = &rcar_lvds_gen3_info },

-- 
Regards,

Laurent Pinchart
