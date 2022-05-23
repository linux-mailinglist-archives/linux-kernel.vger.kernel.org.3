Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50D530D93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiEWJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiEWJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:30:56 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 600B549911;
        Mon, 23 May 2022 02:30:55 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt4Or-0001Pn-02; Mon, 23 May 2022 11:30:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 46EACC02F4; Mon, 23 May 2022 11:16:40 +0200 (CEST)
Date:   Mon, 23 May 2022 11:16:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     keguang.zhang@gmail.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH] MIPS: loongson32: Kconfig: Remove extra space
Message-ID: <20220523091640.GC5069@alpha.franken.de>
References: <20220520115113.147170-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520115113.147170-1-juergh@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:51:13PM +0200, Juerg Haefliger wrote:
> Remove extra space between 'prompt' keyword and string.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  arch/mips/loongson32/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
> index e27879b4813b..2ef9da0016df 100644
> --- a/arch/mips/loongson32/Kconfig
> +++ b/arch/mips/loongson32/Kconfig
> @@ -46,7 +46,7 @@ menuconfig CEVT_CSRC_LS1X
>  	  If unsure, say N.
>  
>  choice
> -	prompt  "Select clockevent/clocksource"
> +	prompt "Select clockevent/clocksource"
>  	depends on CEVT_CSRC_LS1X
>  	default TIMER_USE_PWM0
>  
> -- 
> 2.32.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
