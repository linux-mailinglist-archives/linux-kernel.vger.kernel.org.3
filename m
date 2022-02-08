Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CED4AD753
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiBHLcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349025AbiBHK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27281C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:59:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBE8CB8199A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C4BC004E1;
        Tue,  8 Feb 2022 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644317977;
        bh=rJa3mWMR+Z37EWXelDQ1JL+U5G1tnHLnFg5NkU2xviQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugFRfiTJpxAwzsbpfO9z64ui7FlYKW4BTxGFyuQvgqyqjx5EC04wd8fQ7W9+8AtJO
         o01FGLjtKhG4o+RDCegnhEfWnleyfaMT6MUpr8TYiZ1i4vXJI4MuCfh7tLGOeVVeb/
         ueohYd3eHwiIt3KpmhluPBWfDq+mfL9QdYb4fNfs=
Date:   Tue, 8 Feb 2022 11:59:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankit Kumar Pandey <itsankitkp@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        martin@kaiser.cxl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed styleguide error by removing un-needed commented
 out lines
Message-ID: <YgJNFiO7XDkcel5d@kroah.com>
References: <YgFWZbX6hGZJ3khE@ankit-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgFWZbX6hGZJ3khE@ankit-vm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 10:57:01PM +0530, Ankit Kumar Pandey wrote:
> Volatile keyword was left commented out as it was probably used during
> development but was not needed in final build.
> And this was causing styleguide error, so I have removed this and there
> are no warnings now.
> 
> Signed-off-by: Ankit Kumar Pandey <itsankitkp@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_pwrctrl.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
> index b35b9c792..29f8b6136 100644
> --- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
> +++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
> @@ -74,14 +74,14 @@ struct reportpwrstate_parm {
>  
>  struct	pwrctrl_priv {
>  	struct mutex mutex_lock;
> -	/*volatile*/ u8 rpwm; /* requested power state for fw */
> +	u8 rpwm; /* requested power state for fw */
>  	/* fw current power state. updated when 1. read from HCPWM or
>  	 * 2. driver lowers power level
>  	 */
> -	/*volatile*/ u8 cpwm;
> -	/*volatile*/ u8 tog; /* toggling */
> -	/*volatile*/ u8 cpwm_tog; /* toggling */
> -	/*volatile*/ u8 tgt_rpwm; /* wanted power state */
> +	u8 cpwm;
> +	u8 tog; /* toggling */
> +	u8 cpwm_tog; /* toggling */
> +	u8 tgt_rpwm; /* wanted power state */
>  	uint pwr_mode;
>  	uint smart_ps;
>  	uint alives;
> @@ -106,7 +106,7 @@ void r8712_unregister_cmd_alive(struct _adapter *padapter);
>  void r8712_cpwm_int_hdl(struct _adapter *padapter,
>  			struct reportpwrstate_parm *preportpwrstate);
>  void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode,
> -			uint smart_ps);
> +		       uint smart_ps);
>  void r8712_set_rpwm(struct _adapter *padapter, u8 val8);
>  void r8712_flush_rwctrl_works(struct _adapter *padapter);
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

- You did not send this patch to the correct mailing list.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
