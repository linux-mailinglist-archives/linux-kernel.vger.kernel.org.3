Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8738C57E387
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiGVPMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiGVPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:12:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E59B9CF;
        Fri, 22 Jul 2022 08:12:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E751F6D5;
        Fri, 22 Jul 2022 17:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1658502749;
        bh=DXTUVhnD7UCa264sFWauhAcnoJt+rJGc8XdQ19Hbdfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wmnow4r+byOMKl4yDuTEuXhmM4CZDIojks+lk+Nl43pbY2r/zDHbLnqK31LFq315J
         gyZJOpB7gF1jgSKU9rxKZXpFbb7B9a64A0c5DapFXKWdVeSWKHycX/FkhSqY8Xu4zW
         kPlhnsDwjB/YbRXHayljpWbFcZUP8py61QZEg3MM=
Date:   Fri, 22 Jul 2022 18:12:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: uvc: Fix typo 'the the' in comment
Message-ID: <Ytq+W2f81fh86YFN@pendragon.ideasonboard.com>
References: <20220722071343.71527-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722071343.71527-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Slark,

Thank you for the patch.

On Fri, Jul 22, 2022 at 03:13:43PM +0800, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/usb/uvc/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 6d3dfa4e0bb2..5aaee916045d 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1077,7 +1077,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>  	}
>  
>  	/* Synchronize to the input stream by waiting for the FID bit to be
> -	 * toggled when the the buffer state is not UVC_BUF_STATE_ACTIVE.
> +	 * toggled when the buffer state is not UVC_BUF_STATE_ACTIVE.
>  	 * stream->last_fid is initialized to -1, so the first isochronous
>  	 * frame will always be in sync.
>  	 *

-- 
Regards,

Laurent Pinchart
