Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF7467415
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbhLCJeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:34:06 -0500
Received: from foss.arm.com ([217.140.110.172]:46204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237826AbhLCJeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:34:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93DF413D5;
        Fri,  3 Dec 2021 01:30:40 -0800 (PST)
Received: from [10.57.0.218] (unknown [10.57.0.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53553F5A1;
        Fri,  3 Dec 2021 01:30:37 -0800 (PST)
Subject: Re: [PATCH] ARM: Kconfig: improve ARM_SINGLE_ARMV7M description with
 Cortex M7
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
References: <20211202222002.33456-1-giulio.benetti@benettiengineering.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <db427a15-231b-957e-3690-73373fec55ea@arm.com>
Date:   Fri, 3 Dec 2021 09:30:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211202222002.33456-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 10:20 PM, Giulio Benetti wrote:
> ARM_SINGLE_ARMV7M implies Arm Cortex M7 too, so let's add it to
> description with M0/M3/M4.

Well it also implies M33 and M55. I'd suggest drop specific implementations
from description - so we do not need to update it each time new compatible
core is released. To account newest cores like M33 and M55 you can rephrase
to:
- ARMv7-M/v8-M
- ARMv7-M and above

Cheers
Vladimir

> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c2724d986fa0..67efbde70e34 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -329,7 +329,7 @@ config ARCH_MULTIPLATFORM
>  	select USE_OF
>  
>  config ARM_SINGLE_ARMV7M
> -	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
> +	bool "ARMv7-M based platforms (Cortex-M0/M3/M4/M7)"
>  	depends on !MMU
>  	select ARM_NVIC
>  	select AUTO_ZRELADDR
> 

