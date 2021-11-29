Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB80461533
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbhK2Mii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:38:38 -0500
Received: from elvis.franken.de ([193.175.24.41]:48752 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241775AbhK2MgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:36:14 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mrfq1-0005Wg-00; Mon, 29 Nov 2021 13:32:53 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9AE69C2FD1; Mon, 29 Nov 2021 13:31:50 +0100 (CET)
Date:   Mon, 29 Nov 2021 13:31:50 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     rdunlap@infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove a repeated word in a comment
Message-ID: <20211129123150.GA8232@alpha.franken.de>
References: <20211113032552.53817-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113032552.53817-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 11:25:52AM +0800, Jason Wang wrote:
> The repeated word `the' in a comment is redundant, thus one
> of them was removed from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/mips/mm/c-octeon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
> index ec2ae501539a..490322b01f91 100644
> --- a/arch/mips/mm/c-octeon.c
> +++ b/arch/mips/mm/c-octeon.c
> @@ -332,7 +332,7 @@ static void co_cache_error_call_notifiers(unsigned long val)
>  }
>  
>  /*
> - * Called when the the exception is recoverable
> + * Called when the exception is recoverable
>   */
>  
>  asmlinkage void cache_parity_error_octeon_recoverable(void)
> -- 
> 2.33.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
