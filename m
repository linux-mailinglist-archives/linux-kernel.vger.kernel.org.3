Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557A14ADDCA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382364AbiBHP7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiBHP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:59:05 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDBC061576;
        Tue,  8 Feb 2022 07:59:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A6136A04;
        Tue,  8 Feb 2022 16:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644335942;
        bh=3ZHPiTQ+E4LPkJaFQULINzRsOnPVcUSSNop2nwOFTPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JI92CtT/N3hjpdjr1ADac9M0ugA0aaKrIwStu+0fYDnuJN8dlmtvUx6h1YJ/BhadC
         YUW3GZmlIToEVOwxoXRzaj0btlTT40DJ6r3s7yI7lL7GZ8lGw6oLwL6G2OR2fGhSud
         W9YUqDDmZjl+ienVZWJVQ70ZL/rS8myFT96tvv0s=
Date:   Tue, 8 Feb 2022 17:58:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: Re: [PATCH v5 05/11] media: MAINTAINERS: add bcm2835 unicam driver
Message-ID: <YgKTQykit5Lv8i5D@pendragon.ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-6-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208155027.891055-6-jeanmichel.hautbois@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Tue, Feb 08, 2022 at 04:50:21PM +0100, Jean-Michel Hautbois wrote:
> Add the BCM2835 Camera driver named Unicam in the list.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c25bc24d58e2..ca84a66c6a9a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3670,6 +3670,14 @@ N:	bcm113*
>  N:	bcm216*
>  N:	kona
>  
> +BROADCOM BCM2835 CAMERA DRIVER
> +M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> +F:	arch/arm/boot/dts/bcm283x*

I don't think this entry is needed. With that removed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +F:	drivers/media/platform/bcm2835/
> +
>  BROADCOM BCM47XX MIPS ARCHITECTURE
>  M:	Hauke Mehrtens <hauke@hauke-m.de>
>  M:	Rafał Miłecki <zajec5@gmail.com>

-- 
Regards,

Laurent Pinchart
