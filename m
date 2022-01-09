Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E081C488CA6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiAIVpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:45:36 -0500
Received: from elvis.franken.de ([193.175.24.41]:38467 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbiAIVpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:45:33 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n6g0I-0006cw-01; Sun, 09 Jan 2022 22:45:30 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 98F80C0E3B; Sun,  9 Jan 2022 22:43:23 +0100 (CET)
Date:   Sun, 9 Jan 2022 22:43:23 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] MIPS: Remove duplicated include in local.h
Message-ID: <20220109214323.GB2174@alpha.franken.de>
References: <20220107003128.81300-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107003128.81300-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:31:28AM +0800, Yang Li wrote:
> Fix following includecheck warning:
> ./arch/mips/include/asm/local.h: asm/asm.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/mips/include/asm/local.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
> index d4d47c846bb2..08366b1fd273 100644
> --- a/arch/mips/include/asm/local.h
> +++ b/arch/mips/include/asm/local.h
> @@ -8,7 +8,6 @@
>  #include <asm/asm.h>
>  #include <asm/cmpxchg.h>
>  #include <asm/compiler.h>
> -#include <asm/asm.h>
>  
>  typedef struct
>  {
> -- 
> 2.20.1.7.g153144c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
