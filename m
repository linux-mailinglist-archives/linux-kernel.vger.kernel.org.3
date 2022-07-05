Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02940566321
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGEGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGEGZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:25:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF46260
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BCD3B815D1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B4FC341C7;
        Tue,  5 Jul 2022 06:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657002319;
        bh=50SXIxTHZYPTxV7l8Q1rmaRjO7tKZf67qEy8XQMWD1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oI51x5p3Rvs195/p4TrgU+XLYDlhkbaVWqeMMsGLwQmP3BqdrDpBQ4CV+a8CML8fU
         sLaXU9u/JCRQoxR/bQUSppPTNnDbOPxRYu8TN6JhQqvhnkOdzzUkUi04i2MFu5TyEL
         0NwZZq4It3ZfNpMA2W9EQwcxpz6f8mfWA6AIrc28=
Date:   Tue, 5 Jul 2022 08:25:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, liqiong@fschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] char: lp: Fix spelling mistake and add spaces
Message-ID: <YsPZTMXyk1r/Aoo2@kroah.com>
References: <20220705061518.13533-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705061518.13533-1-jiaming@nfschina.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 02:15:18PM +0800, Zhang Jiaming wrote:
> Fix spelling of doesn' t.
> Add spaces around '=' and ','.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  drivers/char/lp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index 38aad99ebb61..214fb037fa76 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -26,7 +26,7 @@
>   * be still BUSY. This is needed at least with Epson Stylus Color. To enable
>   * the new TRUST_IRQ mode read the `LP OPTIMIZATION' section below...
>   * Fixed the irq on the rising edge of the strobe case.
> - * Obsoleted the CAREFUL flag since a printer that doesn' t work with
> + * Obsoleted the CAREFUL flag since a printer that doesn't work with
>   * CAREFUL will block a bit after in lp_check_status().
>   *				Andrea Arcangeli, 15 Oct 1998
>   * Obsoleted and removed all the lowlevel stuff implemented in the last
> @@ -418,7 +418,7 @@ static ssize_t lp_read(struct file *file, char __user *buf,
>  		       size_t count, loff_t *ppos)
>  {
>  	DEFINE_WAIT(wait);
> -	unsigned int minor=iminor(file_inode(file));
> +	unsigned int minor = iminor(file_inode(file));
>  	struct parport *port = lp_table[minor].dev->port;
>  	ssize_t retval = 0;
>  	char *kbuf = lp_table[minor].lp_buffer;
> @@ -965,7 +965,7 @@ static void lp_attach(struct parport *port)
>  		    port->probe_info[0].class != PARPORT_CLASS_PRINTER)
>  			return;
>  		if (lp_count == LP_NO) {
> -			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n",LP_NO);
> +			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n", LP_NO);
>  			return;
>  		}
>  		for (i = 0; i < LP_NO; i++)
> -- 
> 2.34.1
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
