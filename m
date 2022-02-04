Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA4A4A925C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356646AbiBDClQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:41:16 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38780 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiBDClQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:41:16 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E7E75D;
        Fri,  4 Feb 2022 03:41:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643942474;
        bh=gm3VPwGfySIA6bfsEf09CQTmh9DJS/6sCCO2gi3LOn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHrfglMtr+G1bJARrqbamxuh5V51PhfZpPvZ2vCCNm3sDBcb6AMadKMk+KprPak/M
         PxjM4rA2qTXzmFoFBnmno4+9IUmCCCBAWK/2/7bhQW7biarT+HKzJ1D7afywYjbrSI
         D4J36asHABdqSRI7cvz2zTsC8AFb82+ky3SA+624=
Date:   Fri, 4 Feb 2022 04:40:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH v4 04/12] media: MAINTAINERS: add bcm2835 unicam
 driver
Message-ID: <YfySMufB8GE/ztFB@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <20220203175009.558868-5-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203175009.558868-5-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Thu, Feb 03, 2022 at 06:50:01PM +0100, Jean-Michel Hautbois wrote:
> Add the BCM2835 Camera driver named Unicam in the list.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1868a6002df8..740cf86c56dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3670,6 +3670,13 @@ N:	bcm113*
>  N:	bcm216*
>  N:	kona
>  
> +BROADCOM BCM2835 CAMERA DRIVER
> +M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> +F:	arch/arm/boot/dts/bcm283x*

Add the driver here, and move this patch later in the series after
adding all the files listed above. With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  BROADCOM BCM47XX MIPS ARCHITECTURE
>  M:	Hauke Mehrtens <hauke@hauke-m.de>
>  M:	Rafał Miłecki <zajec5@gmail.com>

-- 
Regards,

Laurent Pinchart
