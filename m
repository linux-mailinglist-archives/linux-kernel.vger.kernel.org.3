Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95744F0924
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357144AbiDCLta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbiDCLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:49:27 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD4240AF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:47:33 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 10A218322
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 06:47:33 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id ayhgnK2MCRnrrayhhnOeSo; Sun, 03 Apr 2022 06:47:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D15xCUb442Ec8EfdAW8hFG2zlSek3cke5HOYPZHtACo=; b=JrnIJLxPj1V/sCCYtYLlgfvSIl
        PdS0JCw/qQ3wiJgYZlRQZ8Z1Zy81KBQdEkHVO/KUcg7rPEo/TghYsp0gpzSZHuTohrCer79z0zI5T
        scXbCDakoEBRULRn3NhhKKS+ltKwCX80lvSFhitLeFmkFlzTkyOVZ7IATXJV8Df78Er5spwB+zQ0N
        Bj0HJ8fUGnsAPMysJq6Pb8mzbFfIzuL3lqCejT+OBxlr7bMUm+cfT4IZv8858OpNAIa0hDYZQXphx
        q+CRPc17GX9yGTeW35m9Yie0ui15hxeyyYsUDDlvJVZumONcOy8KAu3UcV0XQ+hHVDof7AMAUnoay
        qX9fWGvQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54672)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nayhg-001Hwn-Hv; Sun, 03 Apr 2022 11:47:32 +0000
Message-ID: <24d73707-f0b5-23aa-e7c1-f9f8a72fe5cd@roeck-us.net>
Date:   Sun, 3 Apr 2022 04:47:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] watchdog: sp805: add support for irq
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, dwmw@amazon.co.uk
References: <20220403052449.1986-1-farbere@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220403052449.1986-1-farbere@amazon.com>
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
X-Exim-ID: 1nayhg-001Hwn-Hv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54672
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 7
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 22:24, Eliav Farber wrote:
> This change adds registration to IRQ for the sp805 watchdog.
> Before this change there was no notification for watchdog
> barking and the only thing that the HW watchdog did was to
> directly restart the CPU.
> 
> With this change, upon IRQ the driver will call panic() which
> in turn might initiate kdump (in case configured). In case the
> dying process (like kdump collection) will hang, the hardware
> watchdog will still directly restart the CPU on a second timeout.
> 
> The driver used to cut the specified timeout in half when setting
> the watchdog timeout, since it was ignoring the IRQ that occurred
> the first time the timeout expired. We now use the timeout as is
> since the watchdog IRQ will go off after the configured interval.
> 

The functionality is quite similar to pretimeout. dw_wdt implements
pretty much the same functionality this way. Why not use that mechanism ?

Guenter

> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>   drivers/watchdog/sp805_wdt.c | 102 +++++++++++++++++++++++++++++++----
>   1 file changed, 93 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index d8876fba686d..09223aed87e3 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -17,6 +17,7 @@
>   #include <linux/amba/bus.h>
>   #include <linux/bitops.h>
>   #include <linux/clk.h>
> +#include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/ioport.h>
>   #include <linux/kernel.h>
> @@ -78,6 +79,11 @@ module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout,
>   		"Set to 1 to keep watchdog running after device release");
>   
> +static bool skip_panic_skip_reset_on_timeout;
> +module_param(skip_panic_skip_reset_on_timeout, bool, 0600);
> +MODULE_PARM_DESC(skip_panic_skip_reset_on_timeout,
> +		 "For skipping panic and skipping reset on timeout, set this to Y/1");
> +
>   /* returns true if wdt is running; otherwise returns false */
>   static bool wdt_is_running(struct watchdog_device *wdd)
>   {
> @@ -87,7 +93,14 @@ static bool wdt_is_running(struct watchdog_device *wdd)
>   	return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;
>   }
>   
> -/* This routine finds load value that will reset system in required timout */
> +/*
> + * This routine finds load value that will reset or panic the system in the
> + * required timeout.
> + * It also calculates the actual timeout, which can differ from the input
> + * timeout if load value is not in the range of LOAD_MIN and LOAD_MAX.
> + * When panic is enabled it calculates the timeout till the panic, and when it
> + * is disabled it calculates the timeout till the reset.
> + */
>   static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>   {
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> @@ -98,10 +111,21 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>   	/*
>   	 * sp805 runs counter with given value twice, after the end of first
>   	 * counter it gives an interrupt and then starts counter again. If
> -	 * interrupt already occurred then it resets the system. This is why
> -	 * load is half of what should be required.
> +	 * interrupt already occurred then it resets the system.
>   	 */
> -	load = div_u64(rate, 2) * timeout - 1;
> +	if (wdt->adev->irq[0]) {
> +		/*
> +		 * Set load value based on a single timeout until we handle
> +		 * the interrupt.
> +		 */
> +		load = rate * timeout - 1;
> +	} else {
> +		/*
> +		 * Set load value to half the timeout, since the interrupt is
> +		 * ignored and counter must expire twice before CPU is reset.
> +		 */
> +		load = div_u64(rate, 2) * timeout - 1;
> +	}
>   
>   	load = (load > LOAD_MAX) ? LOAD_MAX : load;
>   	load = (load < LOAD_MIN) ? LOAD_MIN : load;
> @@ -109,13 +133,19 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>   	spin_lock(&wdt->lock);
>   	wdt->load_val = load;
>   	/* roundup timeout to closest positive integer value */
> -	wdd->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
> +	if (wdt->adev->irq[0])
> +		wdd->timeout = div_u64((load + 1) + (rate / 2), rate);
> +	else
> +		wdd->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
>   	spin_unlock(&wdt->lock);
>   
>   	return 0;
>   }
>   
> -/* returns number of seconds left for reset to occur */
> +/*
> + * returns number of seconds left for reset to occur, or returns number of
> + * seconds left for panic to occur when enabled.
> + */
>   static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>   {
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> @@ -124,9 +154,18 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>   	spin_lock(&wdt->lock);
>   	load = readl_relaxed(wdt->base + WDTVALUE);
>   
> -	/*If the interrupt is inactive then time left is WDTValue + WDTLoad. */
> -	if (!(readl_relaxed(wdt->base + WDTRIS) & INT_MASK))
> -		load += wdt->load_val + 1;
> +	/*
> +	 * When panic is enabled, it occurs after the first time that sp805
> +	 * runs the counter with the given load value.
> +	 * Otherwise, reset happens after sp805 runs the counter with given
> +	 * value twice (once before the interrupt and second after the
> +	 * interrupt), so if the interrupt is inactive (first count) then time
> +	 * left is WDTValue + WDTLoad.
> +	 */
> +	if (!wdt->adev->irq[0])
> +		if (!(readl_relaxed(wdt->base + WDTRIS) & INT_MASK))
> +			load += wdt->load_val + 1;
> +
>   	spin_unlock(&wdt->lock);
>   
>   	return div_u64(load, wdt->rate);
> @@ -227,6 +266,29 @@ static const struct watchdog_ops wdt_ops = {
>   	.restart	= wdt_restart,
>   };
>   
> +static irqreturn_t wdt_irq_handler(int irq, void *dev_id)
> +{
> +	struct device *dev = dev_id;
> +	struct sp805_wdt *wdt = dev_get_drvdata(dev);
> +
> +	/*
> +	 * Reset the watchdog timeout to maximize time available to the panic
> +	 * handler before the watchdog induces a CPU reset.  Without resetting
> +	 * the watchdog here, it would have a single timeout remaining between
> +	 * interrupt and hardware reset. By resetting the timeout, the panic
> +	 * handler can run with interrupts disabled for two watchdog timeouts,
> +	 * ignoring the interrupt that would occur after the first timeout.
> +	 */
> +	wdt_config(&wdt->wdd, true);
> +
> +	if (skip_panic_skip_reset_on_timeout)
> +		dev_warn(dev, "watchdog timeout expired\n");
> +	else
> +		panic("watchdog timeout expired");
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int
>   sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   {
> @@ -299,9 +361,28 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   	}
>   	amba_set_drvdata(adev, wdt);
>   
> +	if (adev->irq[0]) {
> +		ret = devm_request_irq(&adev->dev,
> +				       adev->irq[0],
> +				       wdt_irq_handler,
> +				       0,
> +				       MODULE_NAME,
> +				       adev);
> +		if (ret) {
> +			dev_err(&adev->dev,
> +				"watchdog irq request failed: %d\n",
> +				ret);
> +			goto err_request_irq;
> +		}
> +	} else {
> +		dev_warn(&adev->dev, "no irq exists for watchdog\n");
> +	}
> +
>   	dev_info(&adev->dev, "registration successful\n");
>   	return 0;
>   
> +err_request_irq:
> +	watchdog_unregister_device(&wdt->wdd);
>   err:
>   	dev_err(&adev->dev, "Probe Failed!!!\n");
>   	return ret;
> @@ -311,6 +392,9 @@ static int sp805_wdt_remove(struct amba_device *adev)
>   {
>   	struct sp805_wdt *wdt = amba_get_drvdata(adev);
>   
> +	if (adev->irq[0])
> +		devm_free_irq(&adev->dev, adev->irq[0], adev);
> +
>   	watchdog_unregister_device(&wdt->wdd);
>   	watchdog_set_drvdata(&wdt->wdd, NULL);
>   

