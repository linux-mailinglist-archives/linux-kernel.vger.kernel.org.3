Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA84AC436
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376387AbiBGPnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380053AbiBGPeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:34:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF0FC0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C24614C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0A5C004E1;
        Mon,  7 Feb 2022 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644248076;
        bh=5j63DxhNOeAOqeDOxMU3/s9mzDKx++25hxAQDhkhezo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqgq0ci8OBWzryHs9lJosHu9cV/k1mZgFPwNx7yiy7r1eFhp9J9RgpWCoTJW5E2CS
         C/UgP0tCmoWDuHyLnsBh6Q2U3BO1RVRHh925lO5dqzIzjXbSQY7LbVmfnBIRQ9h3it
         KvbQEfT0S2gwoPicVA9B651GDLRiSPDnYJ2uj/Ys=
Date:   Mon, 7 Feb 2022 16:34:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankit Kumar Pandey <itsankitkp@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes styleguide related issues in tty drivers
Message-ID: <YgE8CA+1jCEGPoWj@kroah.com>
References: <YgE3wNira6AmpHab@ankit-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgE3wNira6AmpHab@ankit-vm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:46:16PM +0530, Ankit Kumar Pandey wrote:
> Various styleguide warnings are raised in drivers/tty. This patch aims
> to fix those and bring styleguide warning to zero.
> Signed-off-by: Ankit Kumar Pandey <itsankitkp@gmail.com>
> ---
>  drivers/tty/ehv_bytechan.c | 5 +++--
>  drivers/tty/goldfish.c     | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
> index 19d32cb6a..c41c4c07b 100644
> --- a/drivers/tty/ehv_bytechan.c
> +++ b/drivers/tty/ehv_bytechan.c
> @@ -324,8 +324,9 @@ static int __init ehv_bc_console_init(void)
>  #endif
>  
>  	/* add_preferred_console() must be called before register_console(),
> -	   otherwise it won't work.  However, we don't want to enumerate all the
> -	   byte channels here, either, since we only care about one. */
> +	 * otherwise it won't work.  However, we don't want to enumerate all the
> +	 * byte channels here, either, since we only care about one.
> +	 */
>  
>  	add_preferred_console(ehv_bc_console.name, ehv_bc_console.index, NULL);
>  	register_console(&ehv_bc_console);
> diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
> index 5ed19a985..61ccbf670 100644
> --- a/drivers/tty/goldfish.c
> +++ b/drivers/tty/goldfish.c
> @@ -173,6 +173,7 @@ static void goldfish_tty_shutdown(struct tty_port *port)
>  static int goldfish_tty_open(struct tty_struct *tty, struct file *filp)
>  {
>  	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
> +
>  	return tty_port_open(&qtty->port, tty, filp);
>  }
>  
> @@ -202,6 +203,7 @@ static unsigned int goldfish_tty_chars_in_buffer(struct tty_struct *tty)
>  {
>  	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
>  	void __iomem *base = qtty->base;
> +
>  	return __raw_readl(base + GOLDFISH_TTY_REG_BYTES_READY);
>  }
>  
> -- 
> 2.32.0
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

- Your patch does not have a Signed-off-by: line in the correct
  location..  Please read the kernel file,
  Documentation/SubmittingPatches and resend it after adding that line.
  Note, the line needs to be in the body of the email, before the patch,
  not at the bottom of the patch or in the email signature.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

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
