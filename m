Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365A47B152
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhLTQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:39:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57822 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhLTQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:39:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D719BB80F9B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 16:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9A9C36AF7;
        Mon, 20 Dec 2021 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640018360;
        bh=TwNNfoMA/Zn3DehtozWj5LYPABBiZWDOxvsgDGzs+ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vj3FIbPGlSQsSsUmKCI7mROpgen35CW65onA9Leof2FwOd/IaI2EwWMfxYH0iBCvP
         Pd4ePfWaSc79+iKSxg/HXo2tubo0VH70UDtSlMi4D4/FLcFYmU+loK5z00RYt8qFB9
         JKUQt18Y+BVAOzW5J3/sDQgUIIp9Lu0HinTNv4V8=
Date:   Mon, 20 Dec 2021 17:39:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Forest Bond <forest@alittletooquiet.net>,
        Alberto Merciai <alb3rt0.m3rciai@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: drop off byRxMode var in device.h
Message-ID: <YcCxtkNJKhFWONv7@kroah.com>
References: <20211219182004.25656-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219182004.25656-1-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 07:20:03PM +0100, Tommaso Merciai wrote:
> Drop off unused variable byRxMode in device.h, this fix following 
> checkpatch.pl check:
> 
> CHECK: Avoid CamelCase: <byRxMode>
> 131: FILE: drivers/staging/vt6655/device.h:131:
> 	unsigned char byRxMode
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/staging/vt6655/device.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index 4706bde1ec1d..84b1dcf80e47 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -128,8 +128,6 @@ struct vnt_private {
>  	u32                         memaddr;
>  	u32                         ioaddr;
>  
> -	unsigned char byRxMode;
> -
>  	spinlock_t                  lock;
>  
>  	volatile int                iTDUsed[TYPE_MAXTD];
> -- 
> 2.25.1
> 
> 

Did you send this twice?  What is the difference between the two
versions?

And you have trailing whitespace in the changelog for this message,
please fix.

thanks,

greg k-h
