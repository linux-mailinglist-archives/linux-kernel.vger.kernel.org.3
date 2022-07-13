Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624457301C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiGMIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:10:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE32E922B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:10:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so14324141wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0GqG1BS7duofznD7e4pYx0NZnR4aAfeMrhDrHXO4LRU=;
        b=ld5F+PLSePRhAOJj4cezt1eO8YWjJBGGY/QSeNSwAlg+DA106xRqccDuE7lOFjDBhE
         fGjBL6tT2/cpX6zgHb3l+cjs+drTkS5I67NYUP/oW3SwZKt82N3TpUS/vTbvrVnIbeQF
         Ve2wrMOFiwRCed2iHAqxobFZQ7wmVqNWHPAhZzgDI6m+1uuMsToWeRbKuv6zlWiY4+4I
         rT4vhKzIi657ht5HAeBp/S4+gtD1jgFEaVHAyAWFZyewJtivdzdnP4KQKZo2rfqFqOUX
         TxUOi6CIPJ0r7pKEfr6f+P0zNW92dE8MQ9075bgByKB4hb0Xhi9Uxv3NKvG//0B2T3kj
         C5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0GqG1BS7duofznD7e4pYx0NZnR4aAfeMrhDrHXO4LRU=;
        b=1Lu0YD3Tg5nL9317uxHTBg75+h2Hx1H3sEkdY6ZTn6FDjwUS3I9oGRkua+l5cvW27u
         I0Rba/COZUZB4XgBM3w0UFQtQMIlwmCwi4/AUCf8v7S0wAfSjK7m4X8Hvo+8O4KduDfo
         Wvr3wEIg66j2rJ929dlAICMxQOHgsvrd0mKXTu/V4xS2maSVWmRolMWLXJ8mEAj03wiq
         30NoS3FjfeAT75gFTthw+IzbAOJsCrvs+hL6PxBr4UIYXgRvcECmmTKWk2it90H9VasJ
         hnYh72rkweuVYz0FsaMt+eN7fbi4Qd60U7KfZI/UNl2PgdL333wfDj6wvnkE6NL0tE7w
         gh9A==
X-Gm-Message-State: AJIora/CEq3q2daGLxT14KGftjswCkWcSWh6XBhjT0Mxh28cewZldhOu
        +nIreIfsoE4yxVIGmu7p1g2jS00R3DsRXg==
X-Google-Smtp-Source: AGRyM1vNl2BJS7V95SvT6qyCjAZwbtbgSZHBaYC5KbJJvFonqzGwPo8+P196pQMm/XESqdxhGhX1eQ==
X-Received: by 2002:a5d:58ef:0:b0:21d:9fc8:302e with SMTP id f15-20020a5d58ef000000b0021d9fc8302emr1873959wrd.22.1657699808218;
        Wed, 13 Jul 2022 01:10:08 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d46ca000000b0021badf3cb26sm12180167wrs.63.2022.07.13.01.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:10:07 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:10:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Provide an SSP type to the SPI
 driver
Message-ID: <Ys593spfcFtoILhS@google.com>
References: <20220702211903.9093-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220702211903.9093-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jul 2022, Andy Shevchenko wrote:

> The SPI driver wants to know the exact type of the controller.
> Provide this information to it. This is a complementary part to
> the previously updated intel-lpss-acpi.c.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Note that this patch depends on earlier sent [1].
> [1]: https://lore.kernel.org/lkml/20220628223047.34301-1-andriy.shevchenko@linux.intel.com/
> 
>  drivers/mfd/intel-lpss-pci.c | 141 +++++++++++++++++++++++------------
>  1 file changed, 95 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index bb08b7a73fe1..dde31c50a632 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -14,6 +14,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/pxa2xx_ssp.h>
>  
>  #include "intel-lpss.h"
>  
> @@ -73,8 +74,18 @@ static void intel_lpss_pci_remove(struct pci_dev *pdev)
>  
>  static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
>  
> +static const struct property_entry spt_spi_properties[] = {
> +	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_SPT_SSP),
> +	{ }
> +};
> +
> +static const struct software_node spt_spi_node = {
> +	.properties = spt_spi_properties,
> +};
> +
>  static const struct intel_lpss_platform_info spt_info = {
>  	.clk_rate = 120000000,
> +	.swnode = &spt_spi_node,
>  };

IMHO, this is a rubbish interface.

The amount of 10-line changes required to store a 32-bit value is
depressing.  Is there not a reduced interface for storing small pieces
of data that doesn't require arrays of structs?

>  static const struct property_entry spt_i2c_properties[] = {
> @@ -108,8 +119,18 @@ static const struct intel_lpss_platform_info spt_uart_info = {
>  	.swnode = &uart_node,
>  };
>  
> +static const struct property_entry bxt_spi_properties[] = {
> +	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BXT_SSP),
> +	{ }
> +};
> +
> +static const struct software_node bxt_spi_node = {
> +	.properties = bxt_spi_properties,
> +};
> +
>  static const struct intel_lpss_platform_info bxt_info = {
>  	.clk_rate = 100000000,
> +	.swnode = &bxt_spi_node,
>  };
>  
>  static const struct intel_lpss_platform_info bxt_uart_info = {
> @@ -166,6 +187,20 @@ static const struct intel_lpss_platform_info glk_i2c_info = {
>  	.swnode = &glk_i2c_node,
>  };
>  
> +static const struct property_entry cnl_spi_properties[] = {
> +	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_CNL_SSP),
> +	{ }
> +};
> +
> +static const struct software_node cnl_spi_node = {
> +	.properties = cnl_spi_properties,
> +};
> +
> +static const struct intel_lpss_platform_info cnl_info = {
> +	.clk_rate = 120000000,
> +	.swnode = &cnl_spi_node,
> +};
> +
>  static const struct intel_lpss_platform_info cnl_i2c_info = {
>  	.clk_rate = 216000000,
>  	.swnode = &spt_i2c_node,
> @@ -176,12 +211,26 @@ static const struct intel_lpss_platform_info ehl_i2c_info = {
>  	.swnode = &bxt_i2c_node,
>  };
>  
> +static const struct property_entry tgl_spi_properties[] = {
> +	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_CNL_SSP),
> +	{ }
> +};
> +
> +static const struct software_node tgl_spi_node = {
> +	.properties = tgl_spi_properties,
> +};
> +
> +static const struct intel_lpss_platform_info tgl_info = {
> +	.clk_rate = 100000000,
> +	.swnode = &tgl_spi_node,
> +};
> +
>  static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* CML-LP */
>  	{ PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0x02c5), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x02c6), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x02c7), (kernel_ulong_t)&spt_uart_info },
> @@ -189,18 +238,18 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x02e9), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x02ea), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x02eb), (kernel_ulong_t)&cnl_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x02fb), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x02fb), (kernel_ulong_t)&cnl_info },
>  	/* CML-H */
>  	{ PCI_VDEVICE(INTEL, 0x06a8), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x06a9), (kernel_ulong_t)&spt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x06aa), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x06ab), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x06aa), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x06ab), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0x06c7), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x06e8), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x06e9), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x06ea), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x06eb), (kernel_ulong_t)&cnl_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x06fb), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x06fb), (kernel_ulong_t)&cnl_info },
>  	/* BXT A-Step */
>  	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x0aae), (kernel_ulong_t)&bxt_i2c_info },
> @@ -255,8 +304,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* ICL-LP */
>  	{ PCI_VDEVICE(INTEL, 0x34a8), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x34a9), (kernel_ulong_t)&spt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x34aa), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x34ab), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x34aa), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x34ab), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0x34c5), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34c6), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34c7), (kernel_ulong_t)&spt_uart_info },
> @@ -264,15 +313,15 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x34e9), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&cnl_info },
>  	/* ICL-N */
>  	{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&spt_uart_info },
>  	/* TGL-H */
>  	{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x43a9), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x43aa), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x43ab), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x43aa), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x43ab), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x43ad), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x43ae), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x43d8), (kernel_ulong_t)&bxt_i2c_info },
> @@ -281,8 +330,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x43e9), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x43ea), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x43eb), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x43fb), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x43fd), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x43fb), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x43fd), (kernel_ulong_t)&tgl_info },
>  	/* EHL */
>  	{ PCI_VDEVICE(INTEL, 0x4b28), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x4b29), (kernel_ulong_t)&bxt_uart_info },
> @@ -301,8 +350,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* JSL */
>  	{ PCI_VDEVICE(INTEL, 0x4da8), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x4da9), (kernel_ulong_t)&spt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x4daa), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x4dab), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x4daa), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x4dab), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0x4dc5), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x4dc6), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x4dc7), (kernel_ulong_t)&spt_uart_info },
> @@ -310,12 +359,12 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x4de9), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x4dea), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x4deb), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x4dfb), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x4dfb), (kernel_ulong_t)&cnl_info },
>  	/* ADL-P */
>  	{ PCI_VDEVICE(INTEL, 0x51a8), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x51a9), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x51aa), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x51ab), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x51aa), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x51ab), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x51c5), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x51c6), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x51c7), (kernel_ulong_t)&bxt_uart_info },
> @@ -325,12 +374,12 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x51e9), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x51ea), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x51eb), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x51fb), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x51fb), (kernel_ulong_t)&tgl_info },
>  	/* ADL-M */
>  	{ PCI_VDEVICE(INTEL, 0x54a8), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x54a9), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x54aa), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x54ab), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x54aa), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x54ab), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x54c5), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x54c6), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x54c7), (kernel_ulong_t)&bxt_uart_info },
> @@ -338,7 +387,7 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x54e9), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x54ea), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x54eb), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x54fb), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x54fb), (kernel_ulong_t)&tgl_info },
>  	/* APL */
>  	{ PCI_VDEVICE(INTEL, 0x5aac), (kernel_ulong_t)&apl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x5aae), (kernel_ulong_t)&apl_i2c_info },
> @@ -358,39 +407,39 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* RPL-S */
>  	{ PCI_VDEVICE(INTEL, 0x7a28), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a29), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x7a2a), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x7a2b), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a2a), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a2b), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a4c), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a4d), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a4e), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a4f), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a5c), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x7a79), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x7a7b), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a79), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a7b), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a7c), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a7d), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7a7e), (kernel_ulong_t)&bxt_uart_info },
>  	/* ADL-S */
>  	{ PCI_VDEVICE(INTEL, 0x7aa8), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x7aa9), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x7aaa), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x7aab), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7aaa), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x7aab), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x7acc), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7acd), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7ace), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7acf), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7adc), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x7af9), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x7afb), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7af9), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x7afb), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x7afc), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7afd), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7afe), (kernel_ulong_t)&bxt_uart_info },
>  	/* MTL-P */
>  	{ PCI_VDEVICE(INTEL, 0x7e25), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x7e26), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x7e27), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x7e30), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x7e46), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7e27), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x7e30), (kernel_ulong_t)&tgl_info },
> +	{ PCI_VDEVICE(INTEL, 0x7e46), (kernel_ulong_t)&tgl_info },
>  	{ PCI_VDEVICE(INTEL, 0x7e50), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7e51), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x7e52), (kernel_ulong_t)&bxt_uart_info },
> @@ -424,8 +473,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* CNL-LP */
>  	{ PCI_VDEVICE(INTEL, 0x9da8), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x9da9), (kernel_ulong_t)&spt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x9dc7), (kernel_ulong_t)&spt_uart_info },
> @@ -433,12 +482,12 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&cnl_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&cnl_info },
>  	/* TGL-LP */
>  	{ PCI_VDEVICE(INTEL, 0xa0a8), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0a9), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0xa0aa), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0xa0ab), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa0aa), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0xa0ab), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0c5), (kernel_ulong_t)&spt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0c6), (kernel_ulong_t)&spt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0c7), (kernel_ulong_t)&bxt_uart_info },
> @@ -448,15 +497,15 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa0db), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0dc), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0dd), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0xa0de), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0xa0df), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa0de), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0xa0df), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0e8), (kernel_ulong_t)&spt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0e9), (kernel_ulong_t)&spt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0ea), (kernel_ulong_t)&spt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa0eb), (kernel_ulong_t)&spt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0xa0fb), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0xa0fd), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0xa0fe), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa0fb), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0xa0fd), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0xa0fe), (kernel_ulong_t)&cnl_info },
>  	/* SPT-H */
>  	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
> @@ -479,14 +528,14 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* CNL-H */
>  	{ PCI_VDEVICE(INTEL, 0xa328), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa329), (kernel_ulong_t)&spt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0xa32a), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa32a), (kernel_ulong_t)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0xa347), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&cnl_info },
>  	/* CML-V */
>  	{ PCI_VDEVICE(INTEL, 0xa3a7), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa3a8), (kernel_ulong_t)&spt_uart_info },

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
