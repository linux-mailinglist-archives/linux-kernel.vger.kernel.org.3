Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85B4E97AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiC1NNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiC1NNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:13:37 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8569E14008;
        Mon, 28 Mar 2022 06:11:55 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id b15so16863595edn.4;
        Mon, 28 Mar 2022 06:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wduPLn72HNFMFI5wRZhSSzG+yA4cTZ99h7NbdswNd2A=;
        b=6MV6cuMsa9poZ98dOyiKq5HT6BXhCGhKGTRRRGRTtI31nu7Dl15ukcpJIV9Jk26Pdi
         7lTTbAMeyNBisjOGWrNUcF2mxz9WDx1S0Is0qzCBTbZ/ubXHejKgogB06e+DRBbZingu
         Q+51Lg+4TKx53wC3OJffwn16JfxrDEFk7KoHwmBD4ibqvC9pLpfrQeX86+hhwmMJgzef
         /joqHqB+DRmxS5Zaf3wduE3vMzYLbVD2V4K18z50p9xgkZIHxwZ/xzFUC1pwiaFMIIRw
         KO0djld+R0giRE1zcEfU8mWBT0YhCUV2pDqJe7sO1Q2S86MBrKUmicFmA58ZKUaLjOYx
         VUKg==
X-Gm-Message-State: AOAM532vFmrOLBklDOTCOrrM+qWBgS/PFE7F6r54+rq+ZBTupQ2tMjFk
        B6hWvm0N2QePlDpqFMQMi2E=
X-Google-Smtp-Source: ABdhPJxCudiVYrrAevwOd7qI2w6vJI/0O3iILZWbDoT5Qs6a4rL/zpZHpfRLRhnS4khWT/uf9WxELg==
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id a10-20020a056402168a00b003fb600e4cc3mr16186266edv.32.1648473114034;
        Mon, 28 Mar 2022 06:11:54 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id m21-20020a17090677d500b006df766974basm6046482ejn.3.2022.03.28.06.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:11:53 -0700 (PDT)
Message-ID: <8a55260d-7354-028b-8439-475a9fbfe092@kernel.org>
Date:   Mon, 28 Mar 2022 15:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] memory: omap-gpmc: Allow building as a module
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328111319.1236-1-rogerq@kernel.org>
 <20220328111319.1236-3-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328111319.1236-3-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 13:13, Roger Quadros wrote:
> Allow OMAP_GPMC to be built as a module.
> 
> Remove redundant of_match_node() call before
> of_platform_default_populate() as the latter takes
> care of matching with of_default_bus_match_table.

Split this part to separate commit, please. It does not look related to
making it a module.

> 
> Move compatible match table to the end where it is usually expected.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/Kconfig     |  2 +-
>  drivers/memory/omap-gpmc.c | 44 +++++++++++++++++++++-----------------
>  2 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index da2af9c38fe3..4debd4b2c8da 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -103,7 +103,7 @@ config TI_EMIF
>  	  temperature changes
>  
>  config OMAP_GPMC
> -	bool "Texas Instruments OMAP SoC GPMC driver"
> +	tristate "Texas Instruments OMAP SoC GPMC driver"
>  	depends on OF_ADDRESS || COMPILE_TEST
>  	select GPIOLIB
>  	help
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index ed11887c1b7c..6fdb76cc3bc9 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -12,6 +12,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> @@ -1889,16 +1890,6 @@ int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
>  }
>  
>  #ifdef CONFIG_OF
> -static const struct of_device_id gpmc_dt_ids[] = {
> -	{ .compatible = "ti,omap2420-gpmc" },
> -	{ .compatible = "ti,omap2430-gpmc" },
> -	{ .compatible = "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
> -	{ .compatible = "ti,omap4430-gpmc" },	/* omap4430 & omap4460 & omap543x */
> -	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
> -	{ .compatible = "ti,am64-gpmc" },
> -	{ }
> -};
> -
>  static void gpmc_cs_set_name(int cs, const char *name)
>  {
>  	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
> @@ -2257,11 +2248,9 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	if (!of_platform_device_create(child, NULL, &pdev->dev))
>  		goto err_child_fail;
>  
> -	/* is child a common bus? */
> -	if (of_match_node(of_default_bus_match_table, child))
> -		/* create children and other common bus children */
> -		if (of_platform_default_populate(child, NULL, &pdev->dev))
> -			goto err_child_fail;
> +	/* create children and other common bus children */
> +	if (of_platform_default_populate(child, NULL, &pdev->dev))
> +		goto err_child_fail;
>  
>  	return 0;
>  
> @@ -2278,6 +2267,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static const struct of_device_id gpmc_dt_ids[];
> +
>  static int gpmc_probe_dt(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -2644,6 +2635,19 @@ static int gpmc_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(gpmc_pm_ops, gpmc_suspend, gpmc_resume);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id gpmc_dt_ids[] = {
> +	{ .compatible = "ti,omap2420-gpmc" },
> +	{ .compatible = "ti,omap2430-gpmc" },
> +	{ .compatible = "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
> +	{ .compatible = "ti,omap4430-gpmc" },	/* omap4430 & omap4460 & omap543x */
> +	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
> +	{ .compatible = "ti,am64-gpmc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
> +#endif
> +
>  static struct platform_driver gpmc_driver = {
>  	.probe		= gpmc_probe,
>  	.remove		= gpmc_remove,
> @@ -2654,8 +2658,8 @@ static struct platform_driver gpmc_driver = {
>  	},
>  };
>  
> -static __init int gpmc_init(void)
> -{
> -	return platform_driver_register(&gpmc_driver);
> -}
> -postcore_initcall(gpmc_init);
> +module_platform_driver(gpmc_driver);
> +
> +MODULE_DESCRIPTION("Texas Instruments GPMC driver");
> +MODULE_ALIAS("platform:" DEVICE_NAME);

Why do you need this alias?

> +MODULE_LICENSE("GPL v2");


Best regards,
Krzysztof
