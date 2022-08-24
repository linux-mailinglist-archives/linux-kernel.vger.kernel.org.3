Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEB59FEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbiHXPsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbiHXPrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:47:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C76BD75;
        Wed, 24 Aug 2022 08:47:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2DE814A8;
        Wed, 24 Aug 2022 17:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661356023;
        bh=D/UW03G27r2Le51fZi7KAiViwBYUC3IpZ2H1I2m/cRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nX66Vk/jr9yirBx/GAbeggRH0GGoauIox4MZLJKaAexUnUEtvzKuEW44TjR8VSjbj
         zu3SIKMgeCxHyOv37/n+SWV2GUvGaC7SOoFMboJ7KqEA7Qjf83032QC2ktf4p6Cv+w
         E1+bktobQVuxs9YD0zl5M6P/eGBNJj1o5tmSpvao=
Date:   Wed, 24 Aug 2022 18:46:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/uvc: fix repeated words in comments
Message-ID: <YwZH8qMVCl6HD0FN@pendragon.ideasonboard.com>
References: <20220824130827.44560-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220824130827.44560-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:08:27PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'the'.

Have you searched the mailing list archives to see if a similar patch
has been submitted recently ?

> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
