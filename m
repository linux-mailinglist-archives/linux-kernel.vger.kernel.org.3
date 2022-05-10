Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F36520B47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiEJCfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiEJCfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:35:32 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245CA50047;
        Mon,  9 May 2022 19:31:36 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so16788179fac.12;
        Mon, 09 May 2022 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WQ4ekUdvIEeuhghpikQ1JPVbw9/3bfIzB4anGXihbmA=;
        b=Ad5rH4ZCG1dSL6ZgrZmr4V5ghKezH1r/diKrjXYbe2YHw76OlU0K4LcnOsRp97woni
         y+Cl15CKjwB1DMvdRVqa8S3gu6ognXfTrPx1Mf9Bf/NWH9s/XhyONYRbDO6RdIgrjalw
         PWSiTj4Wu4vSv6OomeYhjQRcoxgKlmA3lb+b5YsyunvhqX9ixBlI7aCiTWW7aMVhcYIl
         XOa9J5Z98aP6VtU6jvGVFFaIo04iNV5rsw8scaYTyA9NtNQoYNhpCrcQoGYXJOg/d0TA
         zs63UmrzybGb0rrZRmOB9rtd49FO8AEsYgGuniLQ9ofCbCXeUYf9O+HKM/fG0C0egTFh
         iaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WQ4ekUdvIEeuhghpikQ1JPVbw9/3bfIzB4anGXihbmA=;
        b=ZYgNb5+ERN8ZhEvVBzqssjIhZMN2z/sS6vVIBrlsXZhA1Q1EHcKtQEGrCjusbpz3ks
         1PMcGVGBceWoPLOiihYpCgMD45sg3mMwhi7u/J2FJatUabEY/8DGyiF5Ek98OEbAmqyR
         KhB/OdQRopN8yqEK9JktniWnQ5lNEaSPVj0WqeMv8GAc730phcxSIFYGU+T3vLmD9ni/
         XxTYE+iTA62xWw+zrSg62sW73yidAyD+60xE6cTUI9wkKrZarhOCXaPOUS9Ld4RvfMsZ
         daoA0wyp6TANdkSlaxffsSPn2/oK6d0b691lNM7pyummmgOJ8chgwZ1QUkJUw8kl6ZKb
         HYsw==
X-Gm-Message-State: AOAM530iTnjoZJGIopPRAkoS+lY2sgFmjuJuAp3gxeAWfhRKPpQaA+tw
        6KLfahY4tyuc9c3qxaxhzcg=
X-Google-Smtp-Source: ABdhPJzCPsT/AkGUXnABu+k3dZsWeDaF9p1l07PTyX4dGljF669fkFfK7sPIb7GyrRglVmor+VG5KQ==
X-Received: by 2002:a05:6870:e40b:b0:ed:a6ac:4ae8 with SMTP id n11-20020a056870e40b00b000eda6ac4ae8mr8698314oag.71.1652149895444;
        Mon, 09 May 2022 19:31:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f22-20020a056870211600b000e686d13876sm4973331oae.16.2022.05.09.19.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 19:31:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6c22fe1c-03d9-3a7e-26e8-463b989a02b7@roeck-us.net>
Date:   Mon, 9 May 2022 19:31:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 3/7] watchdog: npcm: Enable clock if provided
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
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
 <20220508194333.2170161-4-j.neuschaefer@gmx.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220508194333.2170161-4-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/22 12:43, Jonathan Neuschäfer wrote:
> On the Nuvoton WPCM450 SoC, with its upcoming clock driver, peripheral
> clocks are individually gated and ungated. Therefore, the watchdog
> driver must be able to ungate the watchdog clock.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v3:
> - Add enable/disable calls to npcm_wdt_restart handler
> - Not applied due to the above change:  Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> v2:
> - https://lore.kernel.org/lkml/20220429172030.398011-4-j.neuschaefer@gmx.net/
> - Add clk_disable_unprepare call, suggested by Guenter Roeck
> 
> v1:
> - https://lore.kernel.org/lkml/20220422183012.444674-4-j.neuschaefer@gmx.net/
> ---
>   drivers/watchdog/npcm_wdt.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 28a24caa2627c..a1240a906ef2a 100644
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
> @@ -147,9 +155,15 @@ static int npcm_wdt_restart(struct watchdog_device *wdd,
>   {
>   	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> 
> +	if (wdt->clk)
> +		clk_prepare_enable(wdt->clk);
> +
>   	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
>   	udelay(1000);
> 
> +	if (wdt->clk)
> +		clk_disable_unprepare(wdt->clk);
> +

I am trying to understand why you stop the clock here.
If the watchdog didn't reset the system by now, for whatever reason,
you explicitly don't want it to reset the system ? If so, please add
a comment describing the reason for stopping the clock here.

Thanks,
Guenter

>   	return 0;
>   }
> 
> @@ -191,6 +205,10 @@ static int npcm_wdt_probe(struct platform_device *pdev)
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

