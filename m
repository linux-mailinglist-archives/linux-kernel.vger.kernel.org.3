Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36551527D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379766AbiD2Rpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379753AbiD2Rpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:45:46 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DECCFE70;
        Fri, 29 Apr 2022 10:42:28 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso5562857otf.12;
        Fri, 29 Apr 2022 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9z0oLEhMUo0s36vvIh02UNk7tir7g6nfy3uYHA227Nk=;
        b=BFVgjtTHDF38sq9/Xc3eyU+f5mbUCTUHCGLzkBEp4pgpiOZYELdIjgA2DA68sFhr89
         XhdrPwINbYmzlVQXplgDQddxEPCW1P+YV2W3c4eqkNIAiPmh3q2YPplseotDaMggWQ+8
         QYBYqqIIYhV0RD/XaoIT5059YH+ZaVnzE8OEAMnymG8TGZZkF/k4oKb1jqvPK2br0F34
         AvQkE7aC6RVa9m7DDP2509iIaYTzZhrhxmPV0OY+BRWSGKy3FUl8TIMV0NtR5f97QLOK
         A8JHelq4uHiBlVzfaw/nDtmgUjXBCE8ucibVmVLEgk0ki2kJhwQglWmwm9PLRo0YPJXg
         jIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9z0oLEhMUo0s36vvIh02UNk7tir7g6nfy3uYHA227Nk=;
        b=reLI0azF/dIi4YWXGnwgklVLDEOVMeI843GjjVRAWqDR34vxUZpp8QcqK878AfhnxU
         6TwTsWeMMadSJaRa3HFgy6IpdI3dpv67tgJG15xmAVJWhQa4gC6RPBoW3VWFkZidOXvN
         6eJkOvWTYTxjawVQ/bZuxh0mGL//VkF+dnFnikgPyca0KXvhoX/xAmH/79GNq9cuh3pu
         i9N7dBi1VoeRs6yWXhdLZqaRvB6b2GpqkGCmNnQGu1avybxyyngDA8zHT+zqArGqP4mM
         +uwroyYR/tg2WgUDaM1zJ9OMfI04HbxKvxP7XHfJz/g8s1wQSzuNvd9w9/UynqcwW9HJ
         Jbxg==
X-Gm-Message-State: AOAM533DR4BWhPDq79blyqkUJOAMNWR8BKld3vouGlD2PqiFLmfrOB7j
        GEZYHnzIOyhRsvS4lP7vK4w=
X-Google-Smtp-Source: ABdhPJz5e2UfdinEgtc+ze6y3kQhFU9T8UDmBrBsmd/4YwtVPRLBwHmqIvvcLUpZfYNdPNZqQAJJkA==
X-Received: by 2002:a9d:491c:0:b0:605:c207:1f6b with SMTP id e28-20020a9d491c000000b00605c2071f6bmr186432otf.41.1651254147619;
        Fri, 29 Apr 2022 10:42:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i8-20020a9d53c8000000b00605f347a4fdsm844322oth.79.2022.04.29.10.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 10:42:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aec36ea2-b007-f24a-5709-27b6e87e5177@roeck-us.net>
Date:   Fri, 29 Apr 2022 10:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/7] watchdog: npcm: Enable clock if provided
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20220429172030.398011-1-j.neuschaefer@gmx.net>
 <20220429172030.398011-4-j.neuschaefer@gmx.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220429172030.398011-4-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 10:20, Jonathan Neuschäfer wrote:
> On the Nuvoton WPCM450 SoC, with its upcoming clock driver, peripheral
> clocks are individually gated and ungated. Therefore, the watchdog
> driver must be able to ungate the watchdog clock.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v2:
> - Add clk_disable_unprepare call, suggested by Guenter Roeck
> 
> v1:
> - https://lore.kernel.org/lkml/20220422183012.444674-4-j.neuschaefer@gmx.net/
> ---
>   drivers/watchdog/npcm_wdt.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 28a24caa2627c..ee08d9805f966 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -3,6 +3,7 @@
>   // Copyright (c) 2018 IBM Corp.
> 
>   #include <linux/bitops.h>
> +#include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
>   #include <linux/kernel.h>
> @@ -43,6 +44,7 @@
>   struct npcm_wdt {
>   	struct watchdog_device  wdd;
>   	void __iomem		*reg;
> +	struct clk		*clk;
>   };
> 
>   static inline struct npcm_wdt *to_npcm_wdt(struct watchdog_device *wdd)
> @@ -66,6 +68,9 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
>   	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
>   	u32 val;
> 
> +	if (wdt->clk)
> +		clk_prepare_enable(wdt->clk);
> +
>   	if (wdd->timeout < 2)
>   		val = 0x800;
>   	else if (wdd->timeout < 3)
> @@ -100,6 +105,9 @@ static int npcm_wdt_stop(struct watchdog_device *wdd)
> 
>   	writel(0, wdt->reg);
> 
> +	if (wdt->clk)
> +		clk_disable_unprepare(wdt->clk);
> +
>   	return 0;
>   }
> 
> @@ -191,6 +199,10 @@ static int npcm_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(wdt->reg))
>   		return PTR_ERR(wdt->reg);
> 
> +	wdt->clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(wdt->clk))
> +		return PTR_ERR(wdt->clk);
> +
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)
>   		return irq;
> --
> 2.35.1
> 

