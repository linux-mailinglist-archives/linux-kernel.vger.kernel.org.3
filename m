Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B324527448
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiENVxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiENVxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B92B29C84
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1171F60B70
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 21:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13645C34115;
        Sat, 14 May 2022 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652565178;
        bh=BnPFlwLRDc82nDZpgdcH/vpAbXZ05U0sVKLhxJZ9DAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuV9qUcIddZ7CLIySSN0izttSQjYlgeqs3PVEcsnQ8hd8iDZgg+L5vjgU2M45Y3Jb
         3284qSmAg2RUXcJDKOfCK4nB7hIk9qAN2SWwjAi6IrRI9p07S2ShgmK4RLUpcyHJTG
         3bVtHb34e7LR3c29fHJkSrA153Gd0VE7zh5xHNrg=
Date:   Sat, 14 May 2022 23:52:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH 1/5] char: lp: ensure that index has not exceeded LP_NO
Message-ID: <YoAkt3qXffRAr7Bq@kroah.com>
References: <20220514211455.284782-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514211455.284782-1-sshedi@vmware.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 02:44:51AM +0530, Shreenidhi Shedi wrote:
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  drivers/char/lp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index 0e22e3b0a04e..d474d02b6c7f 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -972,7 +972,7 @@ static void lp_attach(struct parport *port)
>  			if (port_num[i] == -1)
>  				break;
>  
> -		if (!lp_register(i, port))
> +		if (i < LP_NO && !lp_register(i, port))
>  			lp_count++;
>  		break;
>  
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
