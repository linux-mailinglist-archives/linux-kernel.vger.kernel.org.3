Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83658ABAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiHENd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbiHENdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22143ED65
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9721860B58
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE6C433C1;
        Fri,  5 Aug 2022 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659706433;
        bh=rXa3UVzmTFbaVAR9fsOdIS9u3/+GXKgha3YAxEXRLkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1YqQcyVH62u5yFqk5L/RKwv10P0TxJHxAMAF6NcNqB7C+025tIm00FjNfxbMmo9oC
         Z0iHg6/rhTAAZyamFLik5IjO4KgTA8z65oDI5tIIy0Xe3aRWVj4yPXOrjw0y8kT7Vk
         wN5yGIZ/ihiYaGGBnZjW9pTN8GkaoRuVFbo6+2W0=
Date:   Fri, 5 Aug 2022 15:33:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alix Dixon <notdixon.alix@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: android: binder: Fixed coding style issue
Message-ID: <Yu0cOiT3qKK/osGd@kroah.com>
References: <20220805130611.59289-1-notdixon.alix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805130611.59289-1-notdixon.alix@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:06:11PM +0100, Alix Dixon wrote:
> Fixed issue with comments on multiple lines not being aligned correctly + multiline comments not being on multiple lines

The irony of a changelog about not wrapping lines properly having an
inproper wrapped line is not lost on me :)

> 
> Signed-off-by: Alix Dixon <notdixon.alix@gmail.com>

Any reason you didn't cc: all of the proper people that
scripts/get_maintainer.pl told you to cc?  This driver does have very
active maintainers.

> ---
>  drivers/android/binder.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c964d7c8c..5a6da6765 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5289,8 +5289,10 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	unsigned int size = _IOC_SIZE(cmd);
>  	void __user *ubuf = (void __user *)arg;
>  
> -	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
> -			proc->pid, current->pid, cmd, arg);*/
> +	/*
> +	 * pr_info("binder_ioctl: %d:%d %x %lx\n",
> +	 *		proc->pid, current->pid, cmd, arg);
> +	 */

There's nothing wrong with the original code here.

Please fix up and resend.

thanks,

greg k-h
