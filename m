Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08629509F02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382548AbiDULyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiDULyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:54:20 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6BEB2A265;
        Thu, 21 Apr 2022 04:51:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A873B8106;
        Thu, 21 Apr 2022 11:48:39 +0000 (UTC)
Date:   Thu, 21 Apr 2022 14:51:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>, Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul@pwsan.com>, kernel-janitors@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: fix typos in comments
Message-ID: <YmFFQjmAYS7btKsP@atomide.com>
References: <20220318103729.157574-33-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318103729.157574-33-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Julia Lawall <Julia.Lawall@inria.fr> [220318 12:36]:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Probably best that Arnd picks this into his omap1-multiplatform branch:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony

> ---
>  arch/arm/mach-omap1/clock_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
> index 3ebcd96efbff..c761e72563c1 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -818,7 +818,7 @@ int __init omap1_clk_init(void)
>  		omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
>  		omap_readw(ARM_CKCTL));
>  
> -	/* We want to be in syncronous scalable mode */
> +	/* We want to be in synchronous scalable mode */
>  	omap_writew(0x1000, ARM_SYSST);
>  
>  
> 
