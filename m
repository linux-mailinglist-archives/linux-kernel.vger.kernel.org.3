Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEBC46281F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhK2XUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhK2XT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:19:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45393C058173;
        Mon, 29 Nov 2021 15:14:57 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 64EB8D97;
        Tue, 30 Nov 2021 00:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638227694;
        bh=HT9LpoGOUZY9zBMjn2519+p3/sfl6YV9d7qGsvynGqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucgOUR/gh2s8cc283l/35FwhWyRohwOg8mtzq42sR+Nogw9x6Kg7f1yQ94nKNzt4K
         efjmzu2Hq5qg7xXsvOjiNWnrFw3q4Rdp/cNu5zbt5TR7iSNQUZitJ68EuW0+DtT3pE
         wMCqWGYI1MouUOg3iqiMbcYpfQSVvclwr5oNIaZw=
Date:   Tue, 30 Nov 2021 01:14:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jacopo@jmondi.org, sakari.ailus@iki.fi, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 01/25] MAINTAINERS: add microchip csi2dc
Message-ID: <YaVe1sNFQfYEVtKh@pendragon.ideasonboard.com>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-2-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112142509.2230884-2-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

Thank you for the patch.

On Fri, Nov 12, 2021 at 04:24:45PM +0200, Eugen Hristev wrote:
> Add Microchip CSI2DC driver in the list.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 486bdf97f754..545c642c937f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12422,6 +12422,13 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
>  F:	sound/soc/atmel
>  
> +MICROCHIP CSI2DC DRIVER
> +M:	Eugen Hristev <eugen.hristev@microchip.com>
> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> +F:	drivers/media/platform/atmel/microchip-csi2dc.c
> +
>  MICROCHIP ECC DRIVER
>  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
>  L:	linux-crypto@vger.kernel.org

-- 
Regards,

Laurent Pinchart
