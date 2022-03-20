Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE94E1A89
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbiCTGpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbiCTGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:45:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFFB11156
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A997BB80B9A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 06:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5F9C340E9;
        Sun, 20 Mar 2022 06:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647758626;
        bh=E1cNCX9vev6PFo4MsZbG07lf5lcESLRFVUpbYU/nJxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fi4xf6EqmzOX1Q3RqaNrrAU8lcK/FNK7h+nM/pz7a5gK8vJanNMJhUlih4tSC+QT4
         5avkLFPhVs3nyAtdZoYAmfiju+P6cVwvjoWhPvrzNk4lcpBbSkQc15D6CqS4zQwBWn
         cpPaJrM2dcjOaippK++G92hI0R4cUqy0RBLEeJLM=
Date:   Sun, 20 Mar 2022 07:43:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ryan C. England" <rcengland@gmail.com>
Cc:     arve@android.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: ashmem: Fixed a struct coding style
 issue
Message-ID: <YjbNHUIoSpStOTA3@kroah.com>
References: <20220320033337.47118-1-rcengland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320033337.47118-1-rcengland@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 03:33:37AM +0000, Ryan C. England wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Ryan C. England <rcengland@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index ddbde3f8430e..f2bf7995b403 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> -- 
> 2.27.0
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

- Your patch breaks the build.

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.

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
