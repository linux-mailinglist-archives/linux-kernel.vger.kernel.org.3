Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFAE466594
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358682AbhLBOqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358717AbhLBOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:46:26 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AECC061759;
        Thu,  2 Dec 2021 06:43:03 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 7so55820643oip.12;
        Thu, 02 Dec 2021 06:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gdDNZknPlWQXti9kxSRAtYOCyds+UvL28w+exexiozg=;
        b=OCZ16K/FevUJX4L7LUbXRCWsXmrNw3L1yCZGoNsb6J2OvNRApNkg/VhtLXrnIF4sRb
         8+zJ5z606yzljnkehQGLmuGmXm3PUvAmekngTZg4AK0Dwzu94tPBm+7sKzAoqUAeFmCg
         JcrAOcR5rGll6Y8rqWltIN0e17miYMK2wwMujE7LhKutog3G/0IWe2UnXTOoyMMbINka
         ZKvakAIg6EejIrgz4Hw2LvQ9cNlYNahvXTj03jxuQlIXqyVxbUBtoxtPrRqdAwq0H2ay
         G5fg+BNcjNNjzm5EjjRAiSof0ImAGOgesIvxYoAOxYJXw9NZJwDOuRAfpSJ1lqHpeQyR
         VIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gdDNZknPlWQXti9kxSRAtYOCyds+UvL28w+exexiozg=;
        b=3acfiCaZuRVKDim1vXBILnxUXtfolNkF0IXv6dVtvem79biJS/WwRECpOTh3putKO9
         TXx4wOTs60xDdbe7elqbnMU2kBJzx2IWuT2RUkwPRkXM9rA478QTzl6NS+/GJJhlTBeE
         yHeR9cGYxYp9PineH0Lq947hVJVx8DbiUZbEgvUQaVz1mpOI+fdOMhrAanB3KcDshsde
         mxmnCXhEUE/xocJgg4diEjq5YILx4ghGHSAQEzmWh/AG/CxTcSwaeAIBkYO+KXbco4ld
         C12KxlmY7Fhkbx7YjrHkFRjCK3t+wjap7o6SPqS5qNqhgt2wrTKJGrzOEP535f8qxfNt
         qRiA==
X-Gm-Message-State: AOAM53145INbT4RN4uahankWhDmYm3J/0ENMuHDMs/YoqqOFgk5Ps+Wd
        nuT8xwEMs7JcCYMIGueepLI=
X-Google-Smtp-Source: ABdhPJy9d9K8vQfaMrzF0NadviuLFl6VvISc3/6oMkqiDL/F5a7ieaJY8UOOdcxrdm+usctEjtxjvw==
X-Received: by 2002:aca:d0d:: with SMTP id 13mr4537737oin.107.1638456183251;
        Thu, 02 Dec 2021 06:43:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bh12sm29018oib.25.2021.12.02.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:43:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 2 Dec 2021 06:43:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>,
        Mark Kettenis <kettenis@openbsd.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Apple Watchdog
Message-ID: <20211202144301.GA829000@roeck-us.net>
References: <20211130161809.64591-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130161809.64591-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:18:08PM +0100, Sven Peter wrote:
> Apple SoCs come with a simple embedded watchdog. This watchdog is also
> required in order to reset the SoC.
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1 --> v2:
>   - add Mark's and Rob's r-b tags
> 
>  .../bindings/watchdog/apple,wdt.yaml          | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> new file mode 100644
> index 000000000000..e58c56a6fdf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/apple,wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC Watchdog
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-wdt
> +          - apple,t6000-wdt
> +      - const: apple,wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    wdt: watchdog@50000000 {
> +        compatible = "apple,t8103-wdt", "apple,wdt";
> +        reg = <0x50000000 0x4000>;
> +        clocks = <&clk>;
> +        interrupts = <AIC_IRQ 123 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 360e9aa0205d..859201bbd4e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1750,6 +1750,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> +F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/i2c/busses/i2c-pasemi-core.c
>  F:	drivers/i2c/busses/i2c-pasemi-platform.c
> -- 
> 2.25.1
> 
