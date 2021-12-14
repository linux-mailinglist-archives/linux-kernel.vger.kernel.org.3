Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E576473F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhLNJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:34:29 -0500
Received: from elvis.franken.de ([193.175.24.41]:46446 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhLNJe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:34:27 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mx4CW-0005hz-01; Tue, 14 Dec 2021 10:34:24 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 298A5C0752; Tue, 14 Dec 2021 10:31:22 +0100 (CET)
Date:   Tue, 14 Dec 2021 10:31:22 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     john@phrozen.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: Fix typo in a comment
Message-ID: <20211214093122.GB7220@alpha.franken.de>
References: <20211211085418.228537-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211085418.228537-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 04:54:18PM +0800, Jason Wang wrote:
> The double `if' in the comment in line 144 is repeated. Remove one
> of them from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/mips/lantiq/falcon/sysctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
> index 42222f849bd2..64726c670ca6 100644
> --- a/arch/mips/lantiq/falcon/sysctrl.c
> +++ b/arch/mips/lantiq/falcon/sysctrl.c
> @@ -141,7 +141,7 @@ static void falcon_gpe_enable(void)
>  	unsigned int freq;
>  	unsigned int status;
>  
> -	/* if if the clock is already enabled */
> +	/* if the clock is already enabled */
>  	status = sysctl_r32(SYSCTL_SYS1, SYS1_INFRAC);
>  	if (status & (1 << (GPPC_OFFSET + 1)))
>  		return;
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
