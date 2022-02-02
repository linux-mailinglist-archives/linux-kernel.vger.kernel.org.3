Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CB4A79FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347426AbiBBVG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiBBVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:06:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DCDC061714;
        Wed,  2 Feb 2022 13:06:26 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9FEB72F3;
        Wed,  2 Feb 2022 22:06:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643835983;
        bh=kAgJCcK6S3DpuWQW4M0Qtks0xL7Wq1FZNMArkgnQQjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTMYJIpyA5Crpsg7VCHJPOUqZ9mbVVeHz92oz3n8tg8IIjOGLViwJh6nPlbPTfewi
         JEzcXYmR3U7Qhsq6ipu5BEcdJrij3GTOxv8kPdrHy19qELjJgXSqAFKQJZWo0AZJsf
         TfHIUPdgX6rDISB16rk5QITj/OcKPKY6rX8Uhr/M=
Date:   Wed, 2 Feb 2022 23:06:00 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com
Subject: Re: [RFC PATCH v3 01/11] media: v4l: Add V4L2-PIX-FMT-Y12P format
Message-ID: <YfryOKmX+Qc6WYce@pendragon.ideasonboard.com>
References: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
 <20220202175639.149681-2-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202175639.149681-2-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

On Wed, Feb 02, 2022 at 06:56:29PM +0100, Jean-Michel Hautbois wrote:
> This is a packed grey-scale image format with a depth of 12 bits per
> pixel. Two consecutive pixels are packed into 3 bytes. The first 2 bytes
> contain the 8 high order bits of the pixels, and the 3rd byte contains
> the 4 least significants bits of each pixel, in the same order.
> 
> Add the entry in userspace API, and document it.

I only see documentation. At a quick glance this is caused by rebasing
on top of the ISP support. Don't. Please rebase this correctly on top of
linux-media/master with *only* the V4L2 streams series added to it, and
send a v4. I'll skip review of v3.

> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-yuv-luma.rst       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> index 8ebd58c3588f..d37ce6027095 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> @@ -92,6 +92,17 @@ are often referred to as greyscale formats.
>        - ...
>        - ...
>  
> +    * .. _V4L2-PIX-FMT-Y12P:
> +
> +      - ``V4L2_PIX_FMT_Y12P``
> +      - 'Y12P'
> +
> +      - Y'\ :sub:`0`\ [11:4]
> +      - Y'\ :sub:`1`\ [11:4]
> +      - Y'\ :sub:`1`\ [3:0] Y'\ :sub:`0`\ [3:0]
> +      - ...
> +      - ...
> +
>      * .. _V4L2-PIX-FMT-Y14:
>  
>        - ``V4L2_PIX_FMT_Y14``

-- 
Regards,

Laurent Pinchart
