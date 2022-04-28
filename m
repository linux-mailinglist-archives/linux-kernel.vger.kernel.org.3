Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF4513499
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbiD1NOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346952AbiD1NOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:14:15 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EAA1AF32;
        Thu, 28 Apr 2022 06:11:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s131so5294718oie.1;
        Thu, 28 Apr 2022 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m1086ZQTgciBDTHOLT4KKyAGoDAeJX2AiJjybJQ5ZuA=;
        b=LOr1/Kv/sLO4NyKJzb6wqfS6o0gV4djWxJx68mOvZpgzsNuLzwrbG+2V7jAE76zIUj
         iikJ8X+ovko/EHgij1nBQo/x7Bi/KPoLw5dbFg1zkl+o+xzs/STuev2VguEmliiioU9o
         aCRBFz40yeAc2H4oCQbOSaMqx4cZT1CU8By5trHyfwPkvOAWyXlHhK8z6XGX/SWIIQLl
         Q1L2YoO0TcjAiw0rojGcluE6Tex4gTGwkAVShpqBRAL9TZm38Dq0T+qg4j3LtP3jpc5T
         CCMOla56w5vcgbaVApT13+c8dDBbEjXo0Hng5F4WYel0R7mCQx+yTsPc3q4uQqGQqOeU
         09+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m1086ZQTgciBDTHOLT4KKyAGoDAeJX2AiJjybJQ5ZuA=;
        b=4OqAqygbgnAM6NRfolPcwj2dafkw5q6nJwddL4HNmu1oJCi8xAqCNtbsQtB7BiryQs
         WJ/rSBgVcHuQ33M1IA4zt3hNWdqXIDpCezaqQd3um4G1KpkFKaUBKkFBIo9Z2OF9dtqp
         aaIpR2PV9zTPDXQAT3Yk4CprDEXH1jfC9iFsB90fcHLAE36d9tNkhZsq27e2shFYl2D8
         E2kesnTAsRz3URdLKaayZOoK93lcYYW1zuiJK8ZnUmt35lBBixovvma+AkTdeNPv5vYv
         wZs35F1ZXu+6ZVH5pzk3i+YRDNca12qPiZ/wH+ug9ZsFxQHapEFCKa34X5K9tGBsTFA3
         xFLA==
X-Gm-Message-State: AOAM532RIWCtDXP07UUKZJjJhPpMtnLvYozOnZj+bU9NgAAcMaF43B9X
        D+03HikrJkqQByP5+cGAA+Q=
X-Google-Smtp-Source: ABdhPJzcMUpV76tKlp2QvspGppKBwEJiHCceRqEhu5DMtQBUZJkt02KlvwVAfbzsG9cuehRDhFmpIQ==
X-Received: by 2002:aca:782:0:b0:325:4771:90b1 with SMTP id 124-20020aca0782000000b00325477190b1mr8237240oih.236.1651151459806;
        Thu, 28 Apr 2022 06:10:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i16-20020a056870d41000b000e686d1388esm1917184oag.40.2022.04.28.06.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 06:10:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b19ce453-1235-689b-8796-fa6cba35c1f0@roeck-us.net>
Date:   Thu, 28 Apr 2022 06:10:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] watchdog: max63xx_wdt: Add support for specifying WDI
 logic via GPIO
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220428091603.6838-1-pali@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220428091603.6838-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 02:16, Pali Rohár wrote:
> On some boards is WDI logic of max6370 chip connected via GPIO. So extend
> max63xx_wdt driver and DTS schema to allow specifying WDI logic via GPIO.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

How is that different to just using the gpio watchdog driver ?

Guenter

> ---
>   .../bindings/watchdog/maxim,max63xx.yaml      |  4 +++
>   drivers/watchdog/max63xx_wdt.c                | 28 +++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> index ab9641e845db..a97aa0135ef9 100644
> --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> @@ -27,6 +27,10 @@ properties:
>       description: This is a 1-byte memory-mapped address
>       maxItems: 1
>   
> +  gpios:
> +    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg
> diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> index 9e1541cfae0d..eaf00c3f06a5 100644
> --- a/drivers/watchdog/max63xx_wdt.c
> +++ b/drivers/watchdog/max63xx_wdt.c
> @@ -27,6 +27,7 @@
>   #include <linux/io.h>
>   #include <linux/slab.h>
>   #include <linux/property.h>
> +#include <linux/gpio/consumer.h>
>   
>   #define DEFAULT_HEARTBEAT 60
>   #define MAX_HEARTBEAT     60
> @@ -53,6 +54,9 @@ struct max63xx_wdt {
>   	void __iomem *base;
>   	spinlock_t lock;
>   
> +	/* GPIOs */
> +	struct gpio_desc *gpio_wdi;
> +
>   	/* WDI and WSET bits write access routines */
>   	void (*ping)(struct max63xx_wdt *wdt);
>   	void (*set)(struct max63xx_wdt *wdt, u8 set);
> @@ -158,6 +162,17 @@ static const struct watchdog_info max63xx_wdt_info = {
>   	.identity = "max63xx Watchdog",
>   };
>   
> +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
> +{
> +	spin_lock(&wdt->lock);
> +
> +	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
> +	udelay(1);
> +	gpiod_set_value_cansleep(wdt->gpio_wdi, 0);
> +
> +	spin_unlock(&wdt->lock);
> +}
> +
>   static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
>   {
>   	u8 val;
> @@ -225,6 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> +	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
> +	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT) {
> +		if (PTR_ERR(wdt->gpio_wdi) != -EPROBE_DEFER)
> +			dev_err(dev, "unable to request gpio: %ld\n",
> +				PTR_ERR(wdt->gpio_wdi));
> +		return PTR_ERR(wdt->gpio_wdi);
> +	}
> +
> +	if (!IS_ERR(wdt->gpio_wdi))
> +		wdt->ping = max63xx_gpio_ping;
> +	else
> +		wdt->gpio_wdi = NULL;
> +
>   	err = max63xx_mmap_init(pdev, wdt);
>   	if (err)
>   		return err;

