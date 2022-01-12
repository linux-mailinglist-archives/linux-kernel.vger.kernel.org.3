Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE648C80D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355094AbiALQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:16:48 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44692 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349703AbiALQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:16:16 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 706B9340;
        Wed, 12 Jan 2022 17:16:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642004174;
        bh=OdCAYVxPGlGzBjJAZfdEDoFg3tAUV2S7TAulIDIH1/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cq6UNLnQQofhxWavfthLkNvC9nq+hh0uoxJZUKyGNb0mjrgMMzXkzRt2fAFtspjcU
         Afki/DBJOkfSJMgF5RhAMmJ2+uwvZ6hA33BnJX9WW6+CMoPcQzk6oGfeVkIvvoP1U0
         fpcgnCXztW+Dug2i+lQ0nZRHAyORqG2XbbIWV7kI=
Date:   Wed, 12 Jan 2022 18:16:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, dave.stevenson@raspberrypi.com
Subject: Re: [PATCH 1/3] media: doc: pixfmt-yuv: Fix V4L2-PIX-FMT-Y10P format
Message-ID: <Yd7+wz4tMDppKRro@pendragon.ideasonboard.com>
References: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
 <20220112161014.972076-2-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220112161014.972076-2-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Wed, Jan 12, 2022 at 05:10:12PM +0100, Jean-Michel Hautbois wrote:
> This packed grey-scale image format has a depth of 10 bits per pixel.
> Every four consecutive pixels are packed into 5 bytes. Each of the first
> 4 bytes contain the 8 high order bits of the pixels, and the 5th byte
> contains the 2 least significants bits of each pixel, in the same order.
> 
> The first two bytes are not corresponding to this description, fix it.
> 
> Fixes: af4f45057695 ("media: doc: pixfmt-yuv: Move all luma-only YUV formats to common file")
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> index 91942c4f0967..8ebd58c3588f 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> @@ -75,8 +75,8 @@ are often referred to as greyscale formats.
>        - ``V4L2_PIX_FMT_Y10P``
>        - 'Y10P'
>  
> -      - Y'\ :sub:`0`\ [7:0]
> -      - Y'\ :sub:`1`\ [9:8]
> +      - Y'\ :sub:`0`\ [9:2]
> +      - Y'\ :sub:`1`\ [9:2]
>        - Y'\ :sub:`2`\ [9:2]
>        - Y'\ :sub:`3`\ [9:2]
>        - Y'\ :sub:`3`\ [1:0] Y'\ :sub:`2`\ [1:0] Y'\ :sub:`1`\ [1:0] Y'\ :sub:`0`\ [1:0]

-- 
Regards,

Laurent Pinchart
