Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A159AA78
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbiHTBW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiHTBWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:22:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672FBEA316;
        Fri, 19 Aug 2022 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OpNrq55m/JLCvI2ky9eQsoWN7lws3PlwSAsyx8RIXCI=; b=p8aL/PdE2aGPqVuP0OhuQKiFpa
        Z64cov40S/wTuqpF9Kf/Ten9kx3riUlMY5jisAge0/UbWG9FsHcuzHuOPG30cyZivnBWQuxEvLBXk
        2dfDiXlr079CrNXS8pDPjUMBc+hdeIp/Rs9WvRk7LemZ+nk6jDqHFE8VwVOiJ+nuM5Y+AE5TYcJlD
        +XO5my02azhJ80Wg/C7uXP/CoqgALsBYTofSiPvZs4a8Ovo3rm0A7F/R7pMZQkftasc5uqDKIKJVn
        1IINszv2ZK6T1Mw0+s/s+8ZbyClHwRX1NYtcLNCOw6ntFvsNs7628NOnC5kLXTNGQgQRa7ci0gQ3j
        po3sIfvg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPDCN-00ERZg-UD; Sat, 20 Aug 2022 01:22:52 +0000
Message-ID: <20061362-7415-a7bb-12f2-2956561ce68a@infradead.org>
Date:   Fri, 19 Aug 2022 18:22:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-parisc compile failure in current git
To:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
 <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
 <YNOafsB81ZcP2r7z@ls3530>
 <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
 <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com>
 <39ee0ca2-48a0-755b-605c-3ce1205b9715@gmx.de>
 <CAK7LNAQceFhO1-vupRAJy3rU+p+MK97vRuswVXvVEgF7q0akDA@mail.gmail.com>
 <Yv/PLFLga51+T9xg@p100>
Content-Language: en-US
In-Reply-To: <Yv/PLFLga51+T9xg@p100>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/22 10:58, Helge Deller wrote:
> * Masahiro Yamada <masahiroy@kernel.org>:
>>
>> Then, you can mimic sparc code.

Good idea.

> The patch below fixes it nicely and I've pushed it into the parisc
> for-next git tree.
> 
> @Randy: Maybe you could try it as well. With that approach
> you get what you want. Maybe that's a better approach for riscv64 as
> well?

I like this one better than the earlier attempt.
It's more generic.


> From a529c0a388f74a243363976af8535b10d3d69d20 Mon Sep 17 00:00:00 2001
> From: Helge Deller <deller@gmx.de>
> Date: Fri, 19 Aug 2022 19:30:50 +0200
> Subject: [PATCH] parisc: Enable CONFIG_64BIT for ARCH=parisc64 only
> 
> With this patch the ARCH= parameter decides if the
> CONFIG_64BIT option will be set or not. This means, the
> ARCH= parameter will give:
> 
> 	ARCH=parisc	-> 32-bit kernel
> 	ARCH=parisc64	-> 64-bit kernel
> 
> This simplifies the usage of the other config options like
> randconfig, allmodconfig and allyesconfig a lot and produces
> the output which is expected for parisc64 (64-bit) vs. parisc (32-bit).
> 
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 7f059cd1196a..9aede2447011 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -146,10 +146,10 @@ menu "Processor type and features"
> 
>  choice
>  	prompt "Processor type"
> -	default PA7000
> +	default PA7000 if "$(ARCH)" = "parisc"
> 
>  config PA7000
> -	bool "PA7000/PA7100"
> +	bool "PA7000/PA7100" if "$(ARCH)" = "parisc"
>  	help
>  	  This is the processor type of your CPU.  This information is
>  	  used for optimizing purposes.  In order to compile a kernel
> @@ -160,21 +160,21 @@ config PA7000
>  	  which is required on some machines.
> 
>  config PA7100LC
> -	bool "PA7100LC"
> +	bool "PA7100LC" if "$(ARCH)" = "parisc"
>  	help
>  	  Select this option for the PCX-L processor, as used in the
>  	  712, 715/64, 715/80, 715/100, 715/100XC, 725/100, 743, 748,
>  	  D200, D210, D300, D310 and E-class
> 
>  config PA7200
> -	bool "PA7200"
> +	bool "PA7200" if "$(ARCH)" = "parisc"
>  	help
>  	  Select this option for the PCX-T' processor, as used in the
>  	  C100, C110, J100, J110, J210XC, D250, D260, D350, D360,
>  	  K100, K200, K210, K220, K400, K410 and K420
> 
>  config PA7300LC
> -	bool "PA7300LC"
> +	bool "PA7300LC" if "$(ARCH)" = "parisc"
>  	help
>  	  Select this option for the PCX-L2 processor, as used in the
>  	  744, A180, B132L, B160L, B180L, C132L, C160L, C180L,
> @@ -224,17 +224,8 @@ config MLONGCALLS
>  	  Enabling this option will probably slow down your kernel.
> 
>  config 64BIT
> -	bool "64-bit kernel"
> +	def_bool "$(ARCH)" = "parisc64"
>  	depends on PA8X00
> -	help
> -	  Enable this if you want to support 64bit kernel on PA-RISC platform.
> -
> -	  At the moment, only people willing to use more than 2GB of RAM,
> -	  or having a 64bit-only capable PA-RISC machine should say Y here.
> -
> -	  Since there is no 64bit userland on PA-RISC, there is no point to
> -	  enable this option otherwise. The 64bit kernel is significantly bigger
> -	  and slower than the 32bit one.
> 
>  choice
>  	prompt "Kernel page size"

LGTM.
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.
-- 
~Randy
