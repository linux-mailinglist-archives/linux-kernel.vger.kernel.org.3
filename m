Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62157D912
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiGVDmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiGVDmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:42:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF56643F6;
        Thu, 21 Jul 2022 20:42:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 17so3519206pfy.0;
        Thu, 21 Jul 2022 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2p59n5POjurSFojWtS6TLrKzOOWmg70RmE+edb+vDEs=;
        b=GHKLMTep9hcjGKBHyj485c942VxwTnVCWICFWNFZHy1mD/cg+ruxfMtpF+PIY9XFzC
         L58Zp2JznOdddOVUDFcrHpCaOuf02c6cJj5PMIUb8Gw+q9bOJt5YKQ+g461T6fZCmtZU
         CZcDL+NKUe2a/p9vyHLlK/XB0SSiO8CCdhYxh0qNRNCN2KNjVyZQ6tX+XetvsXceL7lM
         kD3XHKW09KpF4EqZ8VLYwFqwUehMGq0ZFbAIjyQaRUMkVTDeod+wEFr/4jIPfDbQv+34
         L7YkbVMaS+3xNNuh8nDcR9/vuFB7yD0qwg9UdmXn1zGd43JNEJpUmBRtaV2Q/GfaFTgk
         qKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2p59n5POjurSFojWtS6TLrKzOOWmg70RmE+edb+vDEs=;
        b=pnsRI57grsEmUizpDGenZdqlwESN9Qbsxka8HYFW5m6/p+y2FYW0hFZHoEGwMAQdzH
         pn3s9/FOQpLyNgQCFIj1InMISuJ/qHKs9lzNBKj/m3dQ2ilimjaGdxykP+sGBGtsd5vb
         Bd5igkjoBl98c/b6Zh1dYdlAILTGlpBgUvXUBczqdk1JK8K1D+nXRtsmuulx3QY6F6Lz
         +nMRxndBQo32XMEwT2u0nBWH221hvvjGofZLYm2Ch/dT9haKDxu5Hl8OVX+5UPJg/p+z
         fH7Lq9dxU7sCyyRpI2Iu9GGqzro6twd7vL+cExH4uiuxV1gwuuCus02RvRuJ4A6a7tuH
         F8Jg==
X-Gm-Message-State: AJIora94mZb+DEaaQ6HTzj+5lTsfyHGFNy9wycxeWHzxDqV5ogS7Wed/
        cG+Thfxuouqn5z8IQiJPSOo=
X-Google-Smtp-Source: AGRyM1uZyjNh7b+6RHrkCltlYCU9AlH6uvzXynPHjY3sFNZ91rFZ2yDmwLXFe6Cwu6Bt14Gn4tttsw==
X-Received: by 2002:a63:8049:0:b0:415:d366:7229 with SMTP id j70-20020a638049000000b00415d3667229mr1410851pgd.137.1658461367904;
        Thu, 21 Jul 2022 20:42:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b0016d295888e3sm2488493plx.241.2022.07.21.20.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 20:42:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1f78e47a-1f5b-7e33-0015-66d7c37c05e3@roeck-us.net>
Date:   Thu, 21 Jul 2022 20:42:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] watchdog: armada_37xx_wdt: check the return value of
 devm_ioremap() in armada_37xx_wdt_probe()
Content-Language: en-US
To:     williamsukatube@163.com, kabel@kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
References: <20220722030938.2925156-1-williamsukatube@163.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220722030938.2925156-1-williamsukatube@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/21/22 20:09, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@gmail.com>
> 
> The function devm_ioremap() in armada_37xx_wdt_probe() can fail, so
> its return value should be checked.
> 
> Fixes: 54e3d9b518c8a ("watchdog: Add support for Armada 37xx CPU watchdog")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/armada_37xx_wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
> index 1635f421ef2c..854b1cc723cb 100644
> --- a/drivers/watchdog/armada_37xx_wdt.c
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -274,6 +274,8 @@ static int armada_37xx_wdt_probe(struct platform_device *pdev)
>   	if (!res)
>   		return -ENODEV;
>   	dev->reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!dev->reg)
> +		return -ENOMEM;
>   
>   	/* init clock */
>   	dev->clk = devm_clk_get(&pdev->dev, NULL);

