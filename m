Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283484EE63E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiDACtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiDACtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:49:39 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.184.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A731EFE33
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:47:50 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6F0763042
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:47:50 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id a7KInyhi4b6UBa7KIn0A1E; Thu, 31 Mar 2022 21:47:50 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XPMIYxgvctKhc67UpwQUIZ5z17//+6k0vlaXY6E/1DE=; b=GWt7XBamNm5br0OKlCmLe8A63Y
        QTB3FgP3uo5CUWsWj5YOfl2cxYI7qVU23Is4JjPPsbKYN6htw20IbixgYhM9EX08P/GZNuAuLAbk2
        12mvLWvwJj6kiq2JQpk2F6tg7x23iNHHgk+zxvWGNIodsHrJfDW8dUy1xkOmtGfbqXetm8kIkzsVP
        ECbtcrj+RwSbhwrpU1vxwYmLU84cg1fiK4c58XMFLX8qHRSWXwGG06bhBYowVUEkeWPdZdnx0cplr
        jjBFbJtVGXb2cNXR3E7EjTVrivbxO9ETjPCne4P40VmC74wQB/1ic1IWVua3XTyxm4eYyqFY5Twrf
        L7K/Y6Hg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54612)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1na7KH-004FHU-Qw; Fri, 01 Apr 2022 02:47:49 +0000
Message-ID: <99c8a2b0-ce78-0874-038e-f7defe15301b@roeck-us.net>
Date:   Thu, 31 Mar 2022 19:47:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] watchdog: imx2_wdg: Allow ping on suspend
Content-Language: en-US
To:     Alistair Francis <alistair@alistair23.me>, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20220330094552.31039-1-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220330094552.31039-1-alistair@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1na7KH-004FHU-Qw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54612
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 18
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 02:45, Alistair Francis wrote:
> The i.MX watchdog cannot be disabled by software once it has been
> enabled. This means that it can't be stopped before suspend.
> 
> For systems that enter low power mode this is fine, as the watchdog will
> be automatically stopped by hardware in low power mode. Not all i.MX
> platforms support low power mode in the mainline kernel. For example the
> i.MX7D does not enter low power mode and so will be rebooted 2 minutes
> after entering sleep states.
> 
> This patch introduces the "fsl,imx7d-wdt" compatible string
> which enables ping on suspend support. This allows the i.MX7D systems to
> suspend without triggering the watchdog.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v5:
>   - Fixup commit message description

Too late ;-)

Guenter

> v4:
>   - Fix spelling on allow/alow in title
> 
>   drivers/watchdog/imx2_wdt.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 51bfb796898b..d0c5d47ddede 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -66,6 +66,7 @@ struct imx2_wdt_device {
>   	struct watchdog_device wdog;
>   	bool ext_reset;
>   	bool clk_is_on;
> +	bool no_ping;
>   };
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -312,12 +313,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   
>   	wdev->ext_reset = of_property_read_bool(dev->of_node,
>   						"fsl,ext-reset-output");
> +	/*
> +	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
> +	 * during suspend.
> +	 */
> +	wdev->no_ping = !of_device_is_compatible(dev->of_node, "fsl,imx7d-wdt");
>   	platform_set_drvdata(pdev, wdog);
>   	watchdog_set_drvdata(wdog, wdev);
>   	watchdog_set_nowayout(wdog, nowayout);
>   	watchdog_set_restart_priority(wdog, 128);
>   	watchdog_init_timeout(wdog, timeout, dev);
> -	watchdog_stop_ping_on_suspend(wdog);
> +	if (wdev->no_ping)
> +		watchdog_stop_ping_on_suspend(wdog);
>   
>   	if (imx2_wdt_is_running(wdev)) {
>   		imx2_wdt_set_timeout(wdog, wdog->timeout);
> @@ -366,9 +373,11 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
>   		imx2_wdt_ping(wdog);
>   	}
>   
> -	clk_disable_unprepare(wdev->clk);
> +	if (wdev->no_ping) {
> +		clk_disable_unprepare(wdev->clk);
>   
> -	wdev->clk_is_on = false;
> +		wdev->clk_is_on = false;
> +	}
>   
>   	return 0;
>   }
> @@ -380,11 +389,14 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
>   	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>   	int ret;
>   
> -	ret = clk_prepare_enable(wdev->clk);
> -	if (ret)
> -		return ret;
> +	if (wdev->no_ping) {
> +		ret = clk_prepare_enable(wdev->clk);
>   
> -	wdev->clk_is_on = true;
> +		if (ret)
> +			return ret;
> +
> +		wdev->clk_is_on = true;
> +	}
>   
>   	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
>   		/*
> @@ -407,6 +419,7 @@ static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
>   
>   static const struct of_device_id imx2_wdt_dt_ids[] = {
>   	{ .compatible = "fsl,imx21-wdt", },
> +	{ .compatible = "fsl,imx7d-wdt", },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);

