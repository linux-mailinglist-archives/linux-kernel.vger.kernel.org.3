Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D9589F36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiHDQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHDQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:17:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7191A81D;
        Thu,  4 Aug 2022 09:17:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 44AC0481;
        Thu,  4 Aug 2022 18:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659629852;
        bh=S5flaIH/svUzUXABqxvIb4PXcFN2VazEDqYrMfWJdGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bs4bJsMO9nNQG1vtODN9AhYdpO5NI6H/kDMXpV/YVOm5JQg6yRacEZHS+85qTbIuh
         LkLBEeA7Re6j5+8LsfwJKYja0IvUjF5aWnZSzMyTr7oivlYAsr+ArCTdpmJoL3A0Xz
         ddws3TtV0VdUHSgV1JbFLaYDM+Dv1dViF9v1mxeI=
Date:   Thu, 4 Aug 2022 19:17:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix comment typo
Message-ID: <YuvxFIVUFOKMTsdV@pendragon.ideasonboard.com>
References: <20220804115620.52384-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804115620.52384-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

An identical patch has already been posted to the linux-media mailing
list.

On Thu, Aug 04, 2022 at 07:56:20PM +0800, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 170a008f4006..d2eb9066e4dc 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1095,7 +1095,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>  
>  	/*
>  	 * Synchronize to the input stream by waiting for the FID bit to be
> -	 * toggled when the the buffer state is not UVC_BUF_STATE_ACTIVE.
> +	 * toggled when the buffer state is not UVC_BUF_STATE_ACTIVE.
>  	 * stream->last_fid is initialized to -1, so the first isochronous
>  	 * frame will always be in sync.
>  	 *

-- 
Regards,

Laurent Pinchart
