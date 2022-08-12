Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A91590BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiHLG1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiHLG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:26:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D49A9AA;
        Thu, 11 Aug 2022 23:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CFB1B8224C;
        Fri, 12 Aug 2022 06:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DEEC433C1;
        Fri, 12 Aug 2022 06:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660285612;
        bh=N9yDCwZWH4lQLolXhZw5cSELDgyq0Uqno4QMbHTaHDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8OCvO3XylXDDYcdVCgQ7qv4gPoNwB8Z+43uqh9+tqrbbRQpITDg5sAQHZslvreTc
         p7uG2BBgBH2ejPQXk2zjkXlP1tfXIj/5zsKcG/cFLtwky7GoPUkOQK0wRFUPe8cEEE
         QF2u5TBZdBB6ALdWf7vvZcUG6yis4nHS6pcUUbrs=
Date:   Fri, 12 Aug 2022 08:26:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] USB: trancevibrator: remove redundant space
Message-ID: <YvXyqRGPSMWvCMrw@kroah.com>
References: <20220812061805.88627-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812061805.88627-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:18:01PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> remove a redundant space after usb_get_intfdata
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/usb/misc/trancevibrator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
> index 26baba3ab7d7..55cb63652eda 100644
> --- a/drivers/usb/misc/trancevibrator.c
> +++ b/drivers/usb/misc/trancevibrator.c
> @@ -106,7 +106,7 @@ static void tv_disconnect(struct usb_interface *interface)
>  {
>  	struct trancevibrator *dev;
>  
> -	dev = usb_get_intfdata (interface);
> +	dev = usb_get_intfdata(interface);
>  	usb_set_intfdata(interface, NULL);
>  	usb_put_dev(dev->udev);
>  	kfree(dev);
> -- 
> 2.35.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
