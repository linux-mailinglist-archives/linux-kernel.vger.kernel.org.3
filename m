Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F753CD17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343860AbiFCQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343813AbiFCQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:22:42 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF9122519;
        Fri,  3 Jun 2022 09:22:41 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e93bbb54f9so11162648fac.12;
        Fri, 03 Jun 2022 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MG4fB5L16PJOB6eygIdqZV5Ksttsv4vvkIROtuQ0QKg=;
        b=joqdIXgCTJQK6rmOLq9hEzhW5hwG3cLQXUjb+cboAdPNERXpcXFUz62Yn33raBmc3o
         blplY+PffT0s0Ma3Gjv1Dfji90dnBCQ0JR2M8adnSDl9hJoyKJqgg3aWFvyFxeB5RM+K
         YoAkXQ88H8i9uUo9rKmbeuT/ZimhUj19/+ld6yWtzKNq1afkr3t3eiBm7Wso6leCedKO
         cuYkfF5vxJ3xYJodra8xm2bhjpd+/hhXjeu6V0/G4NB9CrRPaFaXSDKbCX7KZsCwi2wh
         jgjHN74aQl6bGwmJ2pDkbljmkUhKU6f8aC4TFk5T5u6RrZj1ScAJgyYyVZMHyM/ekVkJ
         64vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MG4fB5L16PJOB6eygIdqZV5Ksttsv4vvkIROtuQ0QKg=;
        b=q4VDddI+QV9bvDivCISA403lqF09R7dQMCssj1lIxbg0tfAg6ncGIVWR33DuCgEoj+
         0Fa/gc+QI7TQO8SGg+vTZUOrbRA1fNWY3RgQ9WCLSUmJk6LZnN7JX7V46USJNxpJ5UIw
         7Y/a5e8P+qqkMt6Kg2fPUCG2XYnubceSRHjPkWBkT+g6rasYjFv4zA7Z1HVo+RhMg1CI
         Y2VlGY6XiktwGC9b2Vlj9H8K8vdbFyiK4XF7qZCT1JEZya9QZPlX99FyMlXllMZPOAjt
         VkKkerHrydYk7UlogzRMqNnNv+Bf1fDLyMFxpZN+Fr0rpM9cwtaBr3/VcxjjvwvGs8A9
         MsMg==
X-Gm-Message-State: AOAM533nIMgvlWy9pSnN3rfYWOyG1ozmMcevcUKoueKdq974HJFzogZ1
        lRpK1uBW3A/AWJvgNkrv5gBga8wVlcU=
X-Google-Smtp-Source: ABdhPJx2XtRXI3hkPrfqrFyv7zA3+CCZ1oBRo6S2VY+rDVqlMJ2cFUadZ8sCGk08GLh4x3pQ99KDyw==
X-Received: by 2002:a05:6870:891f:b0:e1:ec98:3c59 with SMTP id i31-20020a056870891f00b000e1ec983c59mr6325967oao.295.1654273361054;
        Fri, 03 Jun 2022 09:22:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9-20020a056870530900b000f33b23a030sm3412594oan.57.2022.06.03.09.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 09:22:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ef87536-7a71-0d1b-3121-94e763041562@roeck-us.net>
Date:   Fri, 3 Jun 2022 09:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/6] watchdog: max77620: update Luca Ceresoli's e-mail
 address
Content-Language: en-US
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20220603155727.1232061-1-luca@lucaceresoli.net>
 <20220603155727.1232061-6-luca@lucaceresoli.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220603155727.1232061-6-luca@lucaceresoli.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 08:57, Luca Ceresoli wrote:
> My Bootlin address is preferred from now on.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

An entry in .mailmap might be easier, though.

Guenter

> ---
>   drivers/watchdog/max77620_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
> index b76ad6ba0915..33835c0b06de 100644
> --- a/drivers/watchdog/max77620_wdt.c
> +++ b/drivers/watchdog/max77620_wdt.c
> @@ -6,7 +6,7 @@
>    * Copyright (C) 2022 Luca Ceresoli
>    *
>    * Author: Laxman Dewangan <ldewangan@nvidia.com>
> - * Author: Luca Ceresoli <luca@lucaceresoli.net>
> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>    */
>   
>   #include <linux/err.h>
> @@ -260,5 +260,5 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>   	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
>   MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> -MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
> +MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
>   MODULE_LICENSE("GPL v2");

