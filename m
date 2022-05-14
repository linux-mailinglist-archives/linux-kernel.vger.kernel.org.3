Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB460527449
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiENVxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiENVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:53:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD172AE18
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 135EBB80AC1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 21:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5209AC340EE;
        Sat, 14 May 2022 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652565208;
        bh=2stIwY+49/Whk61m61x6Ybqso17SvvKJO6ui7x816pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKph4Wt9NAKmjrKeQS0CDbtP0eolybotRGfW7AZstwjl3UOOfJ2Luu4cK+kWezlF0
         jQbPxI/jN5jnGKs8W5aKVVtdpXFjd8Smv+dh1FuAQ4bhf/sKkXvRHInQI06KGSxwkv
         dFo2qFW32Vpnci24/RTJk1m6OsEipK+JJByotYgw=
Date:   Sat, 14 May 2022 23:53:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH 2/5] char: lp: remove redundant initialization of err
Message-ID: <YoAk1fqKLse5Algl@kroah.com>
References: <20220514211455.284782-1-sshedi@vmware.com>
 <20220514211455.284782-2-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514211455.284782-2-sshedi@vmware.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 02:44:52AM +0530, Shreenidhi Shedi wrote:
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  drivers/char/lp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index d474d02b6c7f..536ceb11176e 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -1019,7 +1019,7 @@ static struct parport_driver lp_driver = {
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
