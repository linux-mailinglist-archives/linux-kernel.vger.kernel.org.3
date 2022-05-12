Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DBF525232
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356320AbiELQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiELQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:11:47 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB0EE66687;
        Thu, 12 May 2022 09:11:42 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1npBPf-0001Vm-03; Thu, 12 May 2022 18:11:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AE78BC01DC; Thu, 12 May 2022 18:09:27 +0200 (CEST)
Date:   Thu, 12 May 2022 18:09:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] MIPS: Sibyte: remove unnecessary return variable
Message-ID: <20220512160927.GD14475@alpha.franken.de>
References: <20220505030116.14371-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505030116.14371-1-guozhengkui@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:01:14AM +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> arch/mips/sibyte/bcm1480/setup.c:37:5-8: Unneeded variable: "ret".
> Return "0" on line 67.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  arch/mips/sibyte/bcm1480/setup.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/mips/sibyte/bcm1480/setup.c b/arch/mips/sibyte/bcm1480/setup.c
> index 6f34b871b08e..e3e807046a9c 100644
> --- a/arch/mips/sibyte/bcm1480/setup.c
> +++ b/arch/mips/sibyte/bcm1480/setup.c
> @@ -34,8 +34,6 @@ static char *pass_str;
>  
>  static int __init setup_bcm1x80_bcm1x55(void)
>  {
> -	int ret = 0;
> -
>  	switch (soc_pass) {
>  	case K_SYS_REVISION_BCM1480_S0:
>  		periph_rev = 1;
> @@ -64,7 +62,7 @@ static int __init setup_bcm1x80_bcm1x55(void)
>  		break;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /* Setup code likely to be common to all SiByte platforms */
> -- 
> 2.20.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
