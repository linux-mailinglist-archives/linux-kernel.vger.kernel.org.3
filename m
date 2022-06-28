Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9BE55EEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiF1UMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiF1ULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:11:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D644A37;
        Tue, 28 Jun 2022 13:02:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id r1so12023174plo.10;
        Tue, 28 Jun 2022 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aJsS1gBe8v1ujCdmpOQQ7l1qkzhu5I3jprSo1MRxR9k=;
        b=TBY0kbIbvXEBbgjQi9UPiy1yZrUa2/Fy6yAvldZoXJrZhDVJ41RehAJO6EFJdFv1NT
         oInNh174AH1zeK4+UiMltQKh4BBPzvFQe3CYIc2XuLtmHgE97K9Bl1MHPIiekeR1eZik
         Uqim4KijEerHbQwHUmspUmCmaViTUaIChZAa/K4BPH2N8fnoZx/ely8zigFMX6pZd5za
         gQTU4aeXGn/nC6DSuzr6NZV2LyOVW1kpyMx+QfHd/6CAGAr7Mge5TfP91UMfsqNhbLyk
         aX1zCdZv9aKkaA/FMJ8Ec0LiGn7BIX4OPyBPjrC2EVEiWEBN/ztW9AZrqwSQRI38sYcN
         HAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aJsS1gBe8v1ujCdmpOQQ7l1qkzhu5I3jprSo1MRxR9k=;
        b=WYr11cHyqJgsPxJn0dPb636KVZjE5uQbDQH1GoEDfjIUzi2/+zTdukQHIrpZsfChh7
         q4zujG1CXOTBC4Lq5Fpzn3o1ureXeOzNTiyuDkBwXvZjIsv2ClYIorh0MXOc2wl4+Bqp
         HvrUHfsGjnnlYnoTX8UWV+9OLbL3WLgN5QzRVG6Pz9igBaStXYflfwJ80yCKJMFqBPLS
         Bd5aCHFuxBKA4t+Q3NsamVodJMkEuAwn9lfNEzaxk7oBWA5GLrdSO/gNW+bDx8s7sjK0
         HnzgnpNLk0RDLdmpkOktv5XfzYvEF0iaCscHV5C+tne93ytxdvNloKam6jHeid3UEQCU
         Kpsw==
X-Gm-Message-State: AJIora9I4vgEN2JU2j3pBXlWtFP5LYLGBqiEuS4jGXoLEMa9+4WkW+eD
        ZW1Hnaxb1PdefgQiQK4UYgc=
X-Google-Smtp-Source: AGRyM1sYbBfSkhO0Q0kkW9p4U6q6kR6AW0c1LgwIdQimk+XCtttT3MMsztp5Q/QhN/MOzwIH3F8o8g==
X-Received: by 2002:a17:902:bb90:b0:16b:8a74:3aad with SMTP id m16-20020a170902bb9000b0016b8a743aadmr5304817pls.47.1656446571817;
        Tue, 28 Jun 2022 13:02:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1-20020a170903214100b0016a01637620sm9676024ple.76.2022.06.28.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:02:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:02:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/8] watchdog: mtk_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200249.GC3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-4-paul@crapouillou.net>
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

On Tue, Jun 28, 2022 at 08:34:44PM +0100, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
> handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mtk_wdt.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index f0d4e3cc7459..e97787536792 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -401,7 +401,6 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int mtk_wdt_suspend(struct device *dev)
>  {
>  	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
> @@ -423,7 +422,6 @@ static int mtk_wdt_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct of_device_id mtk_wdt_dt_ids[] = {
>  	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
> @@ -437,16 +435,14 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
>  
> -static const struct dev_pm_ops mtk_wdt_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
> -				mtk_wdt_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(mtk_wdt_pm_ops,
> +				mtk_wdt_suspend, mtk_wdt_resume);
>  
>  static struct platform_driver mtk_wdt_driver = {
>  	.probe		= mtk_wdt_probe,
>  	.driver		= {
>  		.name		= DRV_NAME,
> -		.pm		= &mtk_wdt_pm_ops,
> +		.pm		= pm_sleep_ptr(&mtk_wdt_pm_ops),
>  		.of_match_table	= mtk_wdt_dt_ids,
>  	},
>  };
> -- 
> 2.35.1
> 
