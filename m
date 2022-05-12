Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9C524936
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbiELJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351040AbiELJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2069157D;
        Thu, 12 May 2022 02:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0ED5619E2;
        Thu, 12 May 2022 09:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F7DC385B8;
        Thu, 12 May 2022 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652348300;
        bh=B4K6BQAm7NYqTK919kivzANfZ0FJ/7Ep6q3oO1tLOAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdxQSjoVPD8RLWWhrFXL+8R0OVN9ab5CuEWNR4QcUNtEwhfmm5LoTwuDrYmBWA2V+
         /45Zsk0wO0U2nTrqc7C3bvkndNDh6QJdz6nICo0YqXWSVg4KE4Bsixe9X0g2+uYz7W
         FR4AptYXg7ceE+pR5JLNhacJc1MWigRuZ5Jm7WVM=
Date:   Thu, 12 May 2022 11:38:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou jie <zhoujie@nfschina.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:Modify the return value to void
Message-ID: <YnzViTaLcvP4eBqZ@kroah.com>
References: <20220512093210.GA6602@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512093210.GA6602@localhost.localdomain>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 05:32:10PM +0800, Zhou jie wrote:
> drivers:Modify the return value to void
> 
> Signed-off-by: Zhou jie <zhoujie@nfschina.com>
> ---
>  drivers/usb/serial/mos7720.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 1e12b5f30dcc..e944c32505da 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -239,13 +239,12 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
>  
>  #ifdef CONFIG_USB_SERIAL_MOS7715_PARPORT
>  
> -static inline int mos7715_change_mode(struct mos7715_parport *mos_parport,
> +static void mos7715_change_mode(struct mos7715_parport *mos_parport,
>  				      enum mos7715_pp_modes mode)
>  {
>  	mos_parport->shadowECR = mode;
>  	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
>  		      mos_parport->shadowECR);
> -	return 0;
>  }
>  
>  static void destroy_mos_parport(struct kref *kref)
> -- 
> 2.18.2
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
