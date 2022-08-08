Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60E58C808
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiHHL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiHHL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:59:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D407825C7;
        Mon,  8 Aug 2022 04:58:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t22so8574445pjy.1;
        Mon, 08 Aug 2022 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=45zF6wFzN206raoW09X+vEo3k3IpyXxBW6ekbRawA1Y=;
        b=Xzbv9UFANA1nX9nbeNbq7CReZK+z0sy8IJcwuMrQ12aNYVwKrpfaHhAgJ+9Gn6eXys
         HctwQJPPSkJiA5uiIl/v3MdijO0d5fmHVaxfUMm3qNjtMlp6NEtNM7HbRPiLBYRVDW9M
         LT4TBbf2f+oQmyxGc1cr2AczZZ442WDTpbkfxi4lWBIAS4Z95CQMYOsIIayDf7BOdNzV
         AlLL/v7PTWDYhmnJ1Pj8G/aCNXF8yvATcdfYw/fZTFnzq3H8UC/3/RYgF3UihytBMG08
         jkDCWfZ049XtYEMMoyd4xfJ5jCBtKgo2jpArhNSc4Lm85842D4p5jJ4NPZQf6QZqZOLY
         FRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=45zF6wFzN206raoW09X+vEo3k3IpyXxBW6ekbRawA1Y=;
        b=6lDV/QxzRSnDGz7VDqdNRkp3O/ezYJCz0M+U8E1EbQdYMM8tiKTj/aPZrjU6k0UjBX
         wMwqtFzuepeWpZ1U9GCMVEM08SXDp3VoFHJ2vQqLuFXTJCWRxoEvNviLmuXXGfvNJPf2
         iTZRxY1c5ls/Ma1HXSfrfXvkFqSUaSjQfyWeK/WUsAB7exVqrHwxi4gKgVMtD9Ec0VOC
         sNF7/fJuWpoNsU+rmqo36gDWnhTYE4y2aRCHtSdBYCl3EeCV3OudahUcdrFHIjNQlhXz
         ptbj6rLHbvm4THmtU5VmDbEmUSUskSNGx57ZFyG9sMvNgQ3caC2d/isTwXBCt7rjvhLo
         /AhA==
X-Gm-Message-State: ACgBeo3bdh3F7RGcPGgpecTUd56xQZ3nA53c4DsVLOpIcvVYzd29yNdh
        ue1W6uMdWPcZDfq0q4eoR6A=
X-Google-Smtp-Source: AA6agR4TOhoorhEezH7+HGtDNevbEABb5dRbZHifApvFkLvUdS9VD2eZClFF7q6j2TufSSkYjEWcsg==
X-Received: by 2002:a17:902:9005:b0:16c:f62c:4376 with SMTP id a5-20020a170902900500b0016cf62c4376mr18404036plp.87.1659959939385;
        Mon, 08 Aug 2022 04:58:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b0016cd74dae66sm8748344plg.28.2022.08.08.04.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 04:58:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ab495dd-4b3e-46e8-6db0-1dd20860043f@roeck-us.net>
Date:   Mon, 8 Aug 2022 04:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] watchdog: meson: keep running if already active
Content-Language: en-US
To:     Philippe Boos <pboos@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220801092150.4449-1-pboos@baylibre.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220801092150.4449-1-pboos@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 02:21, Philippe Boos wrote:
> If the watchdog is already running (e.g.: started by bootloader) then
> the kernel driver should keep the watchdog active but the amlogic driver
> turns it off.
> 
> Let the driver fix the clock rate if already active because we do not
> know the previous timebase value. To avoid unintentional resetting we
> temporarily set it to its maximum value.
> 
> Then keep the enable bit if is was previously active.
> 
> Signed-off-by: Philippe Boos <pboos@baylibre.com>

What changed since v1 ?

Guenter

> ---
>   drivers/watchdog/meson_gxbb_wdt.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 5a9ca10fbcfa..8be8fd9e5637 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -146,6 +146,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct meson_gxbb_wdt *data;
>   	int ret;
> +	u32 ctrl_reg;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -177,13 +178,26 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>   	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
>   	watchdog_set_drvdata(&data->wdt_dev, data);
>   
> +	ctrl_reg = readl(data->reg_base + GXBB_WDT_CTRL_REG) &
> +				GXBB_WDT_CTRL_EN;
> +
> +	if (ctrl_reg) {
> +		/* Watchdog is running - keep it running but extend timeout
> +		 * to the maximum while setting the timebase
> +		 */
> +		set_bit(WDOG_HW_RUNNING, &data->wdt_dev.status);
> +		meson_gxbb_wdt_set_timeout(&data->wdt_dev,
> +				GXBB_WDT_TCNT_SETUP_MASK / 1000);
> +	}
> +
>   	/* Setup with 1ms timebase */
> -	writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
> -		GXBB_WDT_CTRL_EE_RESET |
> -		GXBB_WDT_CTRL_CLK_EN |
> -		GXBB_WDT_CTRL_CLKDIV_EN,
> -		data->reg_base + GXBB_WDT_CTRL_REG);
> +	ctrl_reg |= ((clk_get_rate(data->clk) / 1000) &
> +			GXBB_WDT_CTRL_DIV_MASK) |
> +			GXBB_WDT_CTRL_EE_RESET |
> +			GXBB_WDT_CTRL_CLK_EN |
> +			GXBB_WDT_CTRL_CLKDIV_EN;
>   
> +	writel(ctrl_reg, data->reg_base + GXBB_WDT_CTRL_REG);
>   	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
>   
>   	watchdog_stop_on_reboot(&data->wdt_dev);

