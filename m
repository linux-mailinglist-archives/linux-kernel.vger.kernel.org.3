Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD552745E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiENVzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiENVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:55:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AF12E0BB
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9C9FB80B26
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 21:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32777C340EE;
        Sat, 14 May 2022 21:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652565296;
        bh=gMJSb4CxmhTgLpKS0+r2BvvEYboNlZJAypNpnjTCGXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eq401OiH3ESQoLBSj2mq35okhw4v0nh2XeeTyW/KIO1UQD2JbyBKGxJKZQXOiv9GH
         fk3z+28GiD6Z2wpSMUPVcLUHUvSUQmr52pifXcAIPyUSlwaRk0AM+BcGfIqLH4jMNg
         YwP4oR+x+CddChWL9KaTNNVq+gphnNwq/XgE1ths=
Date:   Sat, 14 May 2022 23:54:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH 4/5] audit: remove redundant data_len check
Message-ID: <YoAlLeo5dCua/+ua@kroah.com>
References: <20220514211455.284782-1-sshedi@vmware.com>
 <20220514211455.284782-4-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514211455.284782-4-sshedi@vmware.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 02:44:54AM +0530, Shreenidhi Shedi wrote:
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 7690c29d4ee4..0749211d5552 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1390,7 +1390,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  						 str);
>  			} else {
>  				audit_log_format(ab, " data=");
> -				if (data_len > 0 && str[data_len - 1] == '\0')
> +				if (str[data_len - 1] == '\0')
>  					data_len--;
>  				audit_log_n_untrustedstring(ab, str, data_len);
>  			}
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
