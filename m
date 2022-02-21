Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E694BD4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbiBUEfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:35:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343853AbiBUEfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:35:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674540E4E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:35:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B70AD6113B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DA9C340E9;
        Mon, 21 Feb 2022 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645418125;
        bh=dwZtDGQQX9fM6lCbHqZPpjk93gPQ/Aq82vtGnV09KjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZZ/fQexQxELEi7dWIaqQD+WlOZqyXY87H1NScG6tTC7dWsBFGEKznrH8NbM/LGmX
         Z6dzDBoXc0FLu53oP4xmhTTCtP9ZoV9BXfz5wwz+11KXpmhTcnrHuxRNkGn3GxlATQ
         sE+w6RsmvNGWcb51e1BFsU0kxR7b9a7uvd3KPohA5do+SdTCHwroxmwYANyF5yMes9
         hRHwR3ObAHjI7kK2BHjv7P2UuB3duavfdp9pXVqcImbLYIGIV4U2dbZxNbbazljnZU
         fAtK/F4fYXsRxcqMx0MHr1xt5S6lIYuelQ+Bu0AlLisgrZYUEWkCH47otDhp5BanRC
         1593qMcFjMiig==
Date:   Sun, 20 Feb 2022 20:35:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: [PATCH v2 03/10] random: remove whitespace and reorder includes
Message-ID: <YhMWi+zuIH9XPvmS@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-4-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:11PM +0100, Jason A. Donenfeld wrote:
> This is purely cosmetic. Future work involves figuring out which of
> these headers we need and which we don't.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 436b146b33be..7bb18422705a 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -193,11 +193,10 @@
>  #include <linux/syscalls.h>
>  #include <linux/completion.h>
>  #include <linux/uuid.h>
> +#include <linux/uaccess.h>
>  #include <crypto/chacha.h>
>  #include <crypto/blake2s.h>
> -
>  #include <asm/processor.h>
> -#include <linux/uaccess.h>
>  #include <asm/irq.h>
>  #include <asm/irq_regs.h>
>  #include <asm/io.h>
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
