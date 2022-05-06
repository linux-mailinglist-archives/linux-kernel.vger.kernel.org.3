Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3451D198
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382633AbiEFGtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385495AbiEFGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:49:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6C1B79C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:45:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d6so7592680ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QsLmijEooSiXfbLfva7oeI6L4KtnWX5pjKwE7m2Q6CM=;
        b=HLY18bGtl3gXLNmbQUg99B1iBQLAwTI73xDls7bmlM7Atl1v7DmFE2PcTvy7fRqWv3
         cVhBk4+6E7fhI09kT9VcDaHgJEs7KhTzCOS/sSCWmLq4aaxu0dUWkcWIEIDKsruo1S8z
         xhK+foqGRyepaKwC0aGsRiehU6B0IVGHpEnIeA5aN90KrxEd+Ia/da5kznhDU/kMrSPd
         jhUdlfcEUJOtuSA7modVtdyfgruNGmXYgarew9GNKSSuv4JnBenYLBYvd+mgwbKgWhhB
         PuMJcztI0/op/SKdzU/gFZKbXROKSUWhKeGavhMaGOpomqJHv63pRFmhEuDjF9icILzv
         N2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QsLmijEooSiXfbLfva7oeI6L4KtnWX5pjKwE7m2Q6CM=;
        b=QT+pf5iRmAOoE3gZiGaIpLS/3tncRhl5bjtG2oCuYgsUih9nRDGxWvuOVBQpHDBOlO
         fiwak7Eub4aETHHRYibFwAPLxXBLQkoQ4YMzgqmRtA7LF1vuRfWdbGQyvGQrE30J3DiU
         yU5A2fNuBDkCPLjwZVrqoFnKVV4Vm6QjU3wLO2CL9Co52tD+kLITEwP2wZcFoDgdbFqH
         FarSGx+UYMDZP+AKdJmSZVE6tzCTZENyVc56xgXC/r/kmj9Mf/yzaumLaxeQeUVEZMwh
         9JANdVOxz8mCoYdQkxjdI9I2m8Zv/+VovnO1CloxzyajPaUHcdPQbHXs0Kh4Mt2dIr9E
         15vw==
X-Gm-Message-State: AOAM530SqvLj119ABIOY7t7YAbAV3jIWQaGoVROstURmRD8ULp7QpMFa
        hytZoT3P8V3Z+YnRrYGlbJ+zAQ==
X-Google-Smtp-Source: ABdhPJxZSxVy7lcii5HWt3fudazIdSvFNLjs69lmR7PSXhsciOPsOqCmWLg28bfmdgjVADr51/ochQ==
X-Received: by 2002:a05:6402:1115:b0:427:e77b:a70e with SMTP id u21-20020a056402111500b00427e77ba70emr1983121edv.320.1651819541183;
        Thu, 05 May 2022 23:45:41 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y5-20020a50f1c5000000b0042617ba63afsm1850341edl.57.2022.05.05.23.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 23:45:40 -0700 (PDT)
Message-ID: <584df17c-3ffc-4290-a2dd-c803987dccfe@linaro.org>
Date:   Fri, 6 May 2022 08:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v5 6/6] usb: dwc3: dwc3-exynos: add host init
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220506063340epcas2p4c9d88670f9be952f3637e3a545a7d1da@epcas2p4.samsung.com>
 <1651818679-10594-7-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1651818679-10594-7-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 08:31, Daehwan Jung wrote:
> This is for xHCI Host Controller driver on Exynos SOC.

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> It registers vendor ops before loading xhci platform driver.

It does not explain why do you need it, why do you do it, what is this
going to achieve or give us.

> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c | 100 ++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 0ecf20eeceee..c22ea5cd6ab0 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -17,6 +17,12 @@
>  #include <linux/of_platform.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include "core.h"
> +
> +#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)

This symbol does not exist at this point, so your patch does not look
like correctly ordered.

> +int xhci_exynos_register_vendor_ops(void);
> +#endif
> +
>  #define DWC3_EXYNOS_MAX_CLOCKS	4
>  
>  struct dwc3_exynos_driverdata {
> @@ -27,6 +33,7 @@ struct dwc3_exynos_driverdata {
>  
>  struct dwc3_exynos {
>  	struct device		*dev;
> +	struct dwc3		*dwc;
>  
>  	const char		**clk_names;
>  	struct clk		*clks[DWC3_EXYNOS_MAX_CLOCKS];
> @@ -46,12 +53,81 @@ static int dwc3_exynos_remove_child(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
> +static int dwc3_exynos_host_init(struct dwc3_exynos *exynos)
> +{
> +	struct dwc3		*dwc = exynos->dwc;
> +	struct device		*dev = exynos->dev;
> +	struct platform_device	*xhci;
> +	struct resource		*res;
> +	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
> +	int			ret = 0;
> +
> +	/* Configuration xhci resources */
> +	xhci_exynos_register_vendor_ops();

Why this is always being called? Runtime features should not be added
like that.

> +
> +	res = platform_get_resource(dwc3_pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "missing memory resource\n");
> +		return -ENODEV;
> +	}
> +	dwc->xhci_resources[0].start = res->start;
> +	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
> +					DWC3_XHCI_REGS_END;
> +	dwc->xhci_resources[0].flags = res->flags;
> +	dwc->xhci_resources[0].name = res->name;
> +
> +	res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(dev, "missing irq resource\n");
> +		return -ENODEV;
> +	}
> +
> +	dwc->xhci_resources[1].start = dwc->irq_gadget;
> +	dwc->xhci_resources[1].end = dwc->irq_gadget;
> +	dwc->xhci_resources[1].flags = res->flags;
> +	dwc->xhci_resources[1].name = res->name;
> +
> +	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> +	if (!xhci) {
> +		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
> +		return -ENOMEM;
> +	}
> +
> +	xhci->dev.parent	= dwc->dev;

Remove any duplicates spaces/tabs which should not be in the code (no
need for indenting '=').

> +	ret = dma_set_mask_and_coherent(&xhci->dev, DMA_BIT_MASK(36));
> +	if (ret) {
> +		pr_err("xhci dma set mask ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = platform_device_add_resources(xhci, dwc->xhci_resources,
> +						DWC3_XHCI_RESOURCES_NUM);

But this should be properly indented, how checkpatch asks.

> +	if (ret) {
> +		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
> +		goto err;
> +	}
> +
> +	ret = platform_device_add(xhci);
> +	if (ret) {
> +		dev_err(dwc->dev, "couldn't add xHCI device\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	platform_device_put(xhci);
> +	return ret;
> +}
> +#endif
> +
>  static int dwc3_exynos_probe(struct platform_device *pdev)
>  {
>  	struct dwc3_exynos	*exynos;
>  	struct device		*dev = &pdev->dev;
> -	struct device_node	*node = dev->of_node;
> +	struct device_node	*node = dev->of_node, *dwc3_np;
>  	const struct dwc3_exynos_driverdata *driver_data;
> +	struct platform_device *dwc3_pdev;
>  	int			i, ret;
>  
>  	exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
> @@ -109,6 +185,12 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  		goto vdd10_err;
>  	}
>  
> +	dwc3_np = of_get_compatible_child(node, "snps,dwc3");
> +	if (!dwc3_np) {
> +		dev_err(dev, "failed to find dwc3 core child!\n");

Please keep messages consistent with other, so start with capital letter
and do not shout.

> +		goto vdd33_err;
> +	}
> +
>  	if (node) {
>  		ret = of_platform_populate(node, NULL, NULL, dev);
>  		if (ret) {
> @@ -121,6 +203,22 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  		goto populate_err;
>  	}
>  
> +	dwc3_pdev = of_find_device_by_node(dwc3_np);
> +	exynos->dwc = platform_get_drvdata(dwc3_pdev);

Driver should not poke into its child. You violate device layering here.
No, no. This is a glue driver, not a "let's do something inside DWC3"
driver.

> +	if (!exynos->dwc) {
> +		ret = -EPROBE_DEFER;
> +		dev_err(dev, "failed to get dwc3 core node!\n");

Again no reason for shouting.

> +		goto populate_err;
> +	}
> +
> +#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
> +	/* USB host initialization. */
> +	ret = dwc3_exynos_host_init(exynos);
> +	if (ret) {
> +		dev_err(dev, "USB host pre-initialization fail!\n");
> +		goto populate_err;
> +	}
> +#endif
>  	return 0;
>  
>  populate_err:


Best regards,
Krzysztof
