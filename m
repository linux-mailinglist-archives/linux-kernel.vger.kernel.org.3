Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CF589F41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiHDQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiHDQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:19:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C54D4E9;
        Thu,  4 Aug 2022 09:19:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A8FB2481;
        Thu,  4 Aug 2022 18:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659629979;
        bh=iVu2/kSSaltV7WMKKmcC4ymvsamnFHZBq5xbZhKVeCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXC4gPuhmTAaY6JfrNmdg5i4IGn0w1WpKCJYf0GwDlVWwJovnKNvYTXmUwCqcRxCF
         nsAY5kGoIAj3zlcObhKCnLbi4itaBVpFAMouTjhimoXNyk0tzM2FnZdnlyGOE05FuQ
         5nrSekZ8D/2HQ2dKVdREzTL+xaa9BaHrV+N/GeXQ=
Date:   Thu, 4 Aug 2022 19:19:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, sakari.ailus@linux.intel.com,
        ribalda@chromium.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2: Fix comment typo
Message-ID: <YuvxlOlGmPTbblaP@pendragon.ideasonboard.com>
References: <20220804120504.58083-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804120504.58083-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, Aug 04, 2022 at 08:05:04PM +0800, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index e6fd355a2e92..af75edee898c 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1045,7 +1045,7 @@ static void v4l_sanitize_format(struct v4l2_format *fmt)
>  	/*
>  	 * The v4l2_pix_format structure has been extended with fields that were
>  	 * not previously required to be set to zero by applications. The priv
> -	 * field, when set to a magic value, indicates the the extended fields
> +	 * field, when set to a magic value, indicates the extended fields

I wonder if the original intent was to write "indicates that the
extended fields ...".

>  	 * are valid. Otherwise they will contain undefined values. To simplify
>  	 * the API towards drivers zero the extended fields and set the priv
>  	 * field to the magic value when the extended pixel format structure

-- 
Regards,

Laurent Pinchart
