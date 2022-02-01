Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422204A5831
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiBAICT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:02:19 -0500
Received: from elvis.franken.de ([193.175.24.41]:50684 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbiBAICR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:02:17 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nEo7E-0001iW-01; Tue, 01 Feb 2022 09:02:16 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BE1E9C1F81; Tue,  1 Feb 2022 09:02:01 +0100 (CET)
Date:   Tue, 1 Feb 2022 09:02:01 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: octeon: Fix missed PTR->PTR_WD conversion
Message-ID: <20220201080201.GB5886@alpha.franken.de>
References: <20220131100702.57096-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131100702.57096-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:07:02AM +0100, Thomas Bogendoerfer wrote:
> Fixes: fa62f39dc7e2 ("MIPS: Fix build error due to PTR used in more places")
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/cavium-octeon/octeon-memcpy.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
> index 0a515cde1c18..25860fba6218 100644
> --- a/arch/mips/cavium-octeon/octeon-memcpy.S
> +++ b/arch/mips/cavium-octeon/octeon-memcpy.S
> @@ -74,7 +74,7 @@
>  #define EXC(inst_reg,addr,handler)		\
>  9:	inst_reg, addr;				\
>  	.section __ex_table,"a";		\
> -	PTR	9b, handler;			\
> +	PTR_WD	9b, handler;			\
>  	.previous
>  
>  /*
> -- 
> 2.29.2

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
