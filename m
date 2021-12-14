Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB8473F94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhLNJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:34:36 -0500
Received: from elvis.franken.de ([193.175.24.41]:46447 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhLNJe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:34:27 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mx4CW-0005hz-00; Tue, 14 Dec 2021 10:34:24 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4BB50C068C; Tue, 14 Dec 2021 10:31:11 +0100 (CET)
Date:   Tue, 14 Dec 2021 10:31:11 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     rdunlap@infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix typo in a comment
Message-ID: <20211214093111.GA7220@alpha.franken.de>
References: <20211211085132.224082-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211085132.224082-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 04:51:32PM +0800, Jason Wang wrote:
> The double `the' in the comment in line 344 is repeated. Remove one
> of them from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/mips/mm/c-octeon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
> index 490322b01f91..737870d8fd94 100644
> --- a/arch/mips/mm/c-octeon.c
> +++ b/arch/mips/mm/c-octeon.c
> @@ -341,7 +341,7 @@ asmlinkage void cache_parity_error_octeon_recoverable(void)
>  }
>  
>  /*
> - * Called when the the exception is not recoverable
> + * Called when the exception is not recoverable
>   */
>  
>  asmlinkage void cache_parity_error_octeon_non_recoverable(void)
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
