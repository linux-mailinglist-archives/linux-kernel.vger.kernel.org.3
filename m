Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5804C481C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhL3NMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:12:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45966 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL3NMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:12:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78786B81C25
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 13:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5B4C36AE9;
        Thu, 30 Dec 2021 13:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640869927;
        bh=NLHTFiOcx/0iD+8k4JgwLSVikVbIxyjOQCeKyTqhnEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmLD3Bt+VfCiQApPg5RLlNokGd9ieYH5W6ADF8rXJPZ02FsV3OIqeSQpLDkf1PDGM
         cgDvECWzteN5YxauMljNrH2XygFx9IvmMT3VMraXVl5P3Bwq6b/tz+WcTzw4m+DiKm
         JakuMaPZa9ADXvjC5bhlRzMuwThO9Uen5e0B0FZo=
Date:   Thu, 30 Dec 2021 14:12:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajith P V <ajithpv.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: remove repeat word from comment to avoid warning
Message-ID: <Yc2wJOa4fLKm4uoV@kroah.com>
References: <20211223122725.29842-1-ajithpv.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223122725.29842-1-ajithpv.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 05:57:25PM +0530, Ajith P V wrote:
> binder.c file comment produce warning with checkpatch as below:
> WARNING: Possible repeated word: 'and'
> Remove the repeated word from the comment to avoid this warning.
> 
> Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cffbe57a8e08..fc0f4e8b58bd 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4436,7 +4436,7 @@ static int binder_thread_release(struct binder_proc *proc,
>  
>  	/*
>  	 * This is needed to avoid races between wake_up_poll() above and
> -	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
> +	 * ep_remove_waitqueue() called for other reasons (eg the epoll file
>  	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
>  	 * lock, so we can be sure it's done after calling synchronize_rcu().
>  	 */
> -- 
> 2.17.1
> 

Does not apply to my tree at all :(
