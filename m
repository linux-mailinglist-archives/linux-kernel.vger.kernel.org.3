Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE2527660
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 10:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiEOIIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 04:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiEOIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 04:08:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94386248D2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 01:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50E57B8068E
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BE2C385B8;
        Sun, 15 May 2022 08:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652602107;
        bh=cDtMkmX59j5MSkc9OMvYT4RR/sLkyUn7U0RGG/+Kjok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFtdPom5Cl+DRXh2N+Jk8UYQHoVgXtKhJ4coPrGOvkbmKm52zIyQnvQP1aiaFBYWV
         Q2/p1nHKNvcJ+6Zzhpdr2zt+Q6gjaL3mwhZlaCVtPIrKXQ3ITar4RSsXgrDQeM5Zah
         PTkV5MvZ+WuVMuQHMhjpkC0+qviZUBtzcLhWXIHA=
Date:   Sun, 15 May 2022 10:08:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH 2/3] char: lp: remove redundant initialization of err
Message-ID: <YoC09ZabkFUg9qAO@kroah.com>
References: <20220515075455.306082-1-sshedi@vmware.com>
 <20220515075455.306082-2-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515075455.306082-2-sshedi@vmware.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 01:24:54PM +0530, Shreenidhi Shedi wrote:
> err is getting assigned with an appropriate value before returning,
> hence this initialization is unnecessary.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  drivers/char/lp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index e61060f3c..5e8bd8d6c 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -1018,7 +1018,7 @@ static struct parport_driver lp_driver = {
>  
>  static int __init lp_init(void)
>  {
> -	int i, err = 0;
> +	int i, err;
>  
>  	if (parport_nr[0] == LP_PARPORT_OFF)
>  		return 0;
> -- 
> 2.36.1
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

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
