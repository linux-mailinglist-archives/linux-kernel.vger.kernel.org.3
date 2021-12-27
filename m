Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BBF47FA82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 07:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhL0GWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 01:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhL0GWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 01:22:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6722C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 22:22:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE76CB80E41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 06:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB49C36AE9;
        Mon, 27 Dec 2021 06:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640586154;
        bh=x0C0vb8ishT2V5+rf2VVWHRrHwoEM9zfj/BD07nqD3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRGzizb4t67HqTkAWQvWWt+7o2Xk9gqpIjG5wIbw/ieC7810lMfyQNRPwy93xVIOs
         LQDmoQLjGl0wD9P372VolX4TjECFwVC1DskJP1RiuCNTS6d4ZfRbg7RX7h7HnU6P3J
         CDS6MiqOOrFRckEL8vV/Usv1YqDjxg/vG/twaKlg=
Date:   Mon, 27 Dec 2021 07:22:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gautam Menghani <gautammenghani14@gmail.com>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com, gascoar@gmail.com,
        ojaswin98@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove repeated word in vchiq log warning
Message-ID: <Yclbp0ZBkT8dxgbu@kroah.com>
References: <20211226164632.48952-1-gautammenghani14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226164632.48952-1-gautammenghani14@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:16:32PM +0530, Gautam Menghani wrote:
> Signed-off-by: Gautam Menghani <gautammenghani14@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index c650a32bcedf..6759a6261500 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1661,7 +1661,7 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
>  				  service_data[i].clientid, service_data[i].use_count,
>  				  service_data[i].use_count ? nz : "");
>  	}
> -	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count count %d", peer_count);
> +	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count %d", peer_count);
>  	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
>  			  vc_use_count);
>  
> -- 
> 2.25.1
> 
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
