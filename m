Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A3462AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhK3Cz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhK3Cz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:55:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24421C061574;
        Mon, 29 Nov 2021 18:52:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7870D2FD;
        Tue, 30 Nov 2021 03:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638240755;
        bh=4u9kNKPRXz4Ni6t34lnHUeQWyG9lt3eOK7bwlAgLNFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MV4KJgr9gz+6xYe3v+oo7mLDOKtEvDxFDaw+VcT93P4E67cBKmCrJfs8707eyd2Qh
         IlMczvF2Y1f4KXgjIYrBmdKYSQtHcsnW5kwum6CycHkaDEL9od7aiOS0c4uG7RORp5
         0BLgBomsNVyku/pJU/fLcsJELe191v7IG89O+FCM=
Date:   Tue, 30 Nov 2021 04:52:11 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drm: rcar-du: Select DRM_MIPI_DSI with
 DRM_RCAR_MIPI_DSI
Message-ID: <YaWR23+2FoNsAH64@pendragon.ideasonboard.com>
References: <20211126101518.938783-1-kieran.bingham+renesas@ideasonboard.com>
 <20211126101518.938783-3-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211126101518.938783-3-kieran.bingham+renesas@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Fri, Nov 26, 2021 at 10:15:16AM +0000, Kieran Bingham wrote:
> The RCAR_MIPI_DSI uses the DRM_MIPI_DSI interface.
> 
> Ensure that it is selected when the option is enabled.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'll squash it with the appropriate patch.

> ---
>  drivers/gpu/drm/rcar-du/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
> index 8cb94fe90639..8145c6d4cbc8 100644
> --- a/drivers/gpu/drm/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/rcar-du/Kconfig
> @@ -41,6 +41,7 @@ config DRM_RCAR_LVDS
>  config DRM_RCAR_MIPI_DSI
>  	tristate "R-Car DU MIPI DSI Encoder Support"
>  	depends on DRM && DRM_BRIDGE && OF
> +	select DRM_MIPI_DSI
>  	help
>  	  Enable support for the R-Car Display Unit embedded MIPI DSI encoders.
>  

-- 
Regards,

Laurent Pinchart
