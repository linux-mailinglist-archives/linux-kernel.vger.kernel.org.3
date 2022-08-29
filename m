Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657D5A4E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiH2Nxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiH2Nxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:53:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDF97511;
        Mon, 29 Aug 2022 06:53:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c24so7734051pgg.11;
        Mon, 29 Aug 2022 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ENR6zXlzprDZixSeKqPFK+t4TDIeg7JZE6a8SVGK308=;
        b=AWq+ofH1oIUg8rs4W95LjB2cXM5FY8EUmeMiY0qYklZnsdd07ZYpo8K8WstNc4XzYR
         9+HdvZbOnuGit7LFpT++pBAMTAj8geXLb50DDLDrI/ajmVZaveD13FT0dKcFb1ZTLdoI
         mzvfPWrSNePUTV9AcCFs7iODJeTZol49M7xI7BuwTd3QtL7Ui5zyAfwkTl7L4i5l08qF
         kKGCk1E14eAe2Xqd5zn+nGxU4e9Lec+XvSA4sSqyTvcCIi4y+5wXmpeF2FAfusE01NWL
         WYwASqFjUaUQU+vjZVdIAYFpEk7yroAtGWPEotsnuR0Yu+8L4zIX7kXaJmlFQ2ZJVB9j
         e4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ENR6zXlzprDZixSeKqPFK+t4TDIeg7JZE6a8SVGK308=;
        b=pAg7qlHbubVD+B9LAImf371LLMy04WWnMa2kdVJRrO/NdJl70TkuD2nWlsV9yecrPL
         yy6G6Fd4TT+hVYYPaAaZppI00s/uELPRiJ5nL++W8RoJ2q2KKA0V0qJAd1pSEW7I+/xq
         P2y544MGt0U9ko/AFAmTZehrwMddmbpvXU3Nb/iLHMVQ6m8dQCLFgeE7DGglM63VnfS9
         Mc+c67Q79EW2fk14q0eRF0yjVFaJVaTecR6KE6gm1BJaF67HObfQxCa9cA5RBIjOAst3
         4NVuq9xwCKwoBmIwDRbTOY9n/GLn9AVnHkUXVAa5rR78WOMvcVKYCTd+uXSZQvbmU2yq
         /3XQ==
X-Gm-Message-State: ACgBeo0HwKF483nf0oR4UciqxQuMaiVTFS+j9e20IwM6a/dKvDbgxHl4
        MfwZzu0y7kCs2mom1+7yQLmADoY5lKukbg==
X-Google-Smtp-Source: AA6agR75x82sSQ1XzmeJ6rgPwMc/ySBDjGhGNtf9HiwPGJGdolFJkT7h2+H3BNLmp+SYhltmGNeC0Q==
X-Received: by 2002:a63:4547:0:b0:41d:ba0a:870a with SMTP id u7-20020a634547000000b0041dba0a870amr14272003pgk.216.1661781219647;
        Mon, 29 Aug 2022 06:53:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902c40d00b001743ba85d39sm7612123plk.110.2022.08.29.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:53:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:53:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] hwmon: (sparx5) Use devm_clk_get_enabled() helper
Message-ID: <20220829135338.GA229655@roeck-us.net>
References: <cfe4c965074b5ecbe03830b05e038b4594c7b970.1661336689.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe4c965074b5ecbe03830b05e038b4594c7b970.1661336689.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:25:13PM +0200, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code, the error handling paths and avoid the need of
> a dedicated function used with devm_add_action_or_reset().
> 
> Based on my test with allyesconfig, this reduces the .o size from:
>    text	   data	    bss	    dec	    hex	filename
>    2419	   1472	      0	   3891	    f33	drivers/hwmon/sparx5-temp.o
> down to:
>    2155	   1472	      0	   3627	    e2b	drivers/hwmon/sparx5-temp.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> devm_clk_get_enabled() is new and is part of 6.0-rc1
> ---
>  drivers/hwmon/sparx5-temp.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
> index 98be48e3a22a..04fd8505e5d6 100644
> --- a/drivers/hwmon/sparx5-temp.c
> +++ b/drivers/hwmon/sparx5-temp.c
> @@ -26,13 +26,6 @@ struct s5_hwmon {
>  	struct clk *clk;
>  };
>  
> -static void s5_temp_clk_disable(void *data)
> -{
> -	struct clk *clk = data;
> -
> -	clk_disable_unprepare(clk);
> -}
> -
>  static void s5_temp_enable(struct s5_hwmon *hwmon)
>  {
>  	u32 val = readl(hwmon->base + TEMP_CFG);
> @@ -113,7 +106,6 @@ static int s5_temp_probe(struct platform_device *pdev)
>  {
>  	struct device *hwmon_dev;
>  	struct s5_hwmon *hwmon;
> -	int ret;
>  
>  	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
>  	if (!hwmon)
> @@ -123,19 +115,10 @@ static int s5_temp_probe(struct platform_device *pdev)
>  	if (IS_ERR(hwmon->base))
>  		return PTR_ERR(hwmon->base);
>  
> -	hwmon->clk = devm_clk_get(&pdev->dev, NULL);
> +	hwmon->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(hwmon->clk))
>  		return PTR_ERR(hwmon->clk);
>  
> -	ret = clk_prepare_enable(hwmon->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(&pdev->dev, s5_temp_clk_disable,
> -				       hwmon->clk);
> -	if (ret)
> -		return ret;
> -
>  	s5_temp_enable(hwmon);
>  
>  	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
