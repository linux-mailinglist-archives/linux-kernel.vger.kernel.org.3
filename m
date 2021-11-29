Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA346282F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhK2XWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhK2XWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:22:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F97C0613DD;
        Mon, 29 Nov 2021 15:19:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B7FC2A5;
        Tue, 30 Nov 2021 00:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638227941;
        bh=gUbxnhMvIUzO2sVauXVm/cNcXhWEDp4Dhyy26gedo70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1K0mMTyr0TQhvwkhIaBS3WlPYl3D8biYFge2QN28QNeo0Rm4ogNyFaHbtFuxSid8
         afS/ztzcxX+oYgpXkXpo+dbsjpvkIIkpA6gKfM6J9mlkP6uQ//jVo33JO7ADDgz0sT
         FLZs4LGDS5KtvQSWb+A1GYRyNfIzG8N567OATEwE=
Date:   Tue, 30 Nov 2021 01:18:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jacopo@jmondi.org, sakari.ailus@iki.fi, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 04/25] MAINTAINERS: atmel-isc: add new file
 atmel-isc-clk.c
Message-ID: <YaVfzd/cBS/qqqNf@pendragon.ideasonboard.com>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-5-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112142509.2230884-5-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

Thank you for the patch.

On Fri, Nov 12, 2021 at 04:24:48PM +0200, Eugen Hristev wrote:
> Add new file atmel-isc-clk.c to MAINTAINERS entry.

I'd squash this with the patch that adds the new file, but even better
would be to use patterns instead of listing each file.

Some for the other patches touching MAINTAINERS in this series.

> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545c642c937f..bb7b48e3605c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12455,6 +12455,7 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/media/atmel,isc.yaml
>  F:	Documentation/devicetree/bindings/media/microchip,xisc.yaml
>  F:	drivers/media/platform/atmel/atmel-isc-base.c
> +F:	drivers/media/platform/atmel/atmel-isc-clk.c
>  F:	drivers/media/platform/atmel/atmel-isc-regs.h
>  F:	drivers/media/platform/atmel/atmel-isc.h
>  F:	drivers/media/platform/atmel/atmel-sama5d2-isc.c

-- 
Regards,

Laurent Pinchart
