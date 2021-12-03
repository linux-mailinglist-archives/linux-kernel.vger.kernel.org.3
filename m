Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F119467C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbhLCRPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:15:32 -0500
Received: from foss.arm.com ([217.140.110.172]:51776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235278AbhLCRPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:15:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98AE31477;
        Fri,  3 Dec 2021 09:12:06 -0800 (PST)
Received: from [10.57.0.218] (unknown [10.57.0.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FE1F3F73B;
        Fri,  3 Dec 2021 09:12:04 -0800 (PST)
Subject: Re: [PATCH] ARM: Kconfig: improve ARM_SINGLE_ARMV7M with ARMv8-M too
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <ea2679ec-9bfd-6a78-a82d-7b160350ddfb@arm.com>
 <20211203170947.84283-1-giulio.benetti@benettiengineering.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <f8674032-ebcb-88be-2579-d65954c830b7@arm.com>
Date:   Fri, 3 Dec 2021 17:12:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211203170947.84283-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 5:09 PM, Giulio Benetti wrote:
> ARM_SINGLE_ARMV7M implies ARMv7-M and ARMv8-M, so let's remove
> "Cortex-M0/M3/M4" mention and add "/v8-M" after ARMv7-M instead.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c2724d986fa0..4a36a80e57b7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -329,7 +329,7 @@ config ARCH_MULTIPLATFORM
>  	select USE_OF
>  
>  config ARM_SINGLE_ARMV7M
> -	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
> +	bool "ARMv7-M/v8-M based platforms"
>  	depends on !MMU
>  	select ARM_NVIC
>  	select AUTO_ZRELADDR
> 

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks
Vladimir
