Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DFE471786
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhLLBWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:22:50 -0500
Received: from marcansoft.com ([212.63.210.85]:58916 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhLLBWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:22:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2B678425DF;
        Sun, 12 Dec 2021 01:22:44 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Add Apple watchdog to ARM/APPLE
 MACHINE SUPPORT
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>
References: <20211211123633.4392-1-sven@svenpeter.dev>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7324f7f7-87d0-258f-9dce-7fa4865d8ad7@marcan.st>
Date:   Sun, 12 Dec 2021 10:22:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211211123633.4392-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2021 21.36, Sven Peter wrote:
> Add apple_wdt.c under the ARM/APPLE MACHINE SUPPORT entry.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v3: new commit to be taken through the SoC tree to prevent
>      merge conflicts upstream since we have multiple drivers
>      that all touch the same section in-flight as requested
>      by Hector Martin
> 
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43007f2d29e0..0e919de0a808 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1756,6 +1756,7 @@ F:	drivers/i2c/busses/i2c-pasemi-platform.c
>   F:	drivers/irqchip/irq-apple-aic.c
>   F:	drivers/mailbox/apple-mailbox.c
>   F:	drivers/pinctrl/pinctrl-apple-gpio.c
> +F:	drivers/watchdog/apple_wdt.c
>   F:	include/dt-bindings/interrupt-controller/apple-aic.h
>   F:	include/dt-bindings/pinctrl/apple.h
>   F:	include/linux/apple-mailbox.h
> 

Reviewed-by: Hector Martin <marcan@marcan.st>

Thanks! Guenter, if you can merge the driver through your tree I'll be 
happy to take care of the MAINTAINERS and DT stuff via Asahi-SoC :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
