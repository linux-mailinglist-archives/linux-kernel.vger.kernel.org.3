Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA73255DF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiF0JdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiF0JdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:33:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475DC60F7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:33:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r20so12183728wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2n3L8G4jlo8gnX0RwebcTVvXVr2RWwNLmm09LfVziHo=;
        b=Zsv1tJkq9gNSbSM16VhBkw+5pOqZ2kvZIpOZJc4PXIoomtZ2tWxjuRQCMZpY/woAia
         4rFK94mD3yNyO8Q9SdoqMUQnY8y2fYTVzkfzR4iE4NtOjwpvbdnbGEGPGf4kqyUjFvp1
         dB2XXmK7H8Qeqci8qpWIolt1qAbHVF3e1rMDKSKsbXCPnM8wvaGl/M16WDFr9Iku60qa
         69uqRJZazVgnd51Inv8l+6+MTTXhBaJ3vxwP6+mFxJiIXFTfYCto8h2U96vHJx74Ehal
         qEISA4so36/gGUPf+t1JMQdROKqTPU/tvaoWOgl1zXNy+x1AZevrgOByE9b2dwaCQuqs
         EAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2n3L8G4jlo8gnX0RwebcTVvXVr2RWwNLmm09LfVziHo=;
        b=UDzZScusQ9WyVoMfyYLRkMTHC2Lpy1gpKSgcs/bmcLnb6Q3pXTR198t9Du50PKDNbF
         csWS5F/p24BNAKZzBF+yAVxM7yZ16OBKa9kglaMSK0zufUAlw8eJQUg7QztneR/ZcPk3
         jv8TRwejCcadMfdr0SQ9CvIetukWMmo0URljrmkVsQ3oCixTLA4Uk2a3rNCdrZKs220c
         6mbAntAGuoKrd+UeQCz5dkyISH1V8y4RDRJyZuHh8ntwGEMD8G7xPDC8RcxLjLHiQ8YM
         GISSXtSxVclrJFtdwsUmTn2CELWq2kC4nZD0YyG0woBv0VW+N8o9MNUQ61KaacRWqXdE
         Ef2w==
X-Gm-Message-State: AJIora+Fh8BVPhRlnbpCVaSCcsrjItB0tjnYIgV9HU7SJTztZmP+/Uio
        ZFvw3EP5I8mprRbmJlTiSBV9EKTjaqm+sA==
X-Google-Smtp-Source: AGRyM1uxJnnXWT0isDEPsl55AaG91ZiUdPFF+/2YvVcuX2uefTiqptX+LLkF6MvEKjGBLkuD0RfBRA==
X-Received: by 2002:a05:6000:1148:b0:21b:a4b2:ccd3 with SMTP id d8-20020a056000114800b0021ba4b2ccd3mr11493996wrx.193.1656322399855;
        Mon, 27 Jun 2022 02:33:19 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b003a04962ad3esm4939920wms.31.2022.06.27.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:33:19 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:33:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 11/11] mfd: intel_soc_pmic_bxtwc: Fix spelling in the
 comment
Message-ID: <Yrl5XZOgD8abd+Qm@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-11-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-11-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> There are a couple of spelling issues in the comment, fix them.
> While at it, fix indentation in the MODULE_AUTHOR() parameter
> and update copyright years.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 953f535a3c93..9e412d1d00f1 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -2,7 +2,7 @@
>  /*
>   * MFD core driver for Intel Broxton Whiskey Cove PMIC
>   *
> - * Copyright (C) 2015 Intel Corporation. All rights reserved.
> + * Copyright (C) 2015-2017, 2022 Intel Corporation. All rights reserved.

I do not profess to be an expert.  What happened between 2017-2022?

>   */
>  
>  #include <linux/acpi.h>
> @@ -527,11 +527,11 @@ static int bxtwc_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret, "Failed to add devices\n");
>  
>  	/*
> -	 * There is known hw bug. Upon reset BIT 5 of register
> +	 * There is known HW bug. Upon reset BIT 5 of register

You may as well fix the grammar while you're at it.

>  	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
>  	 * later it's set to 1(masked) automatically by hardware. So we
> -	 * have the software workaround here to unmaksed it in order to let
> -	 * charger interrutp work.
> +	 * have the software workaround here to unmasked it in order to let
> +	 * charger interrupt work.

Likewise.

>  	 */
>  	regmap_update_bits(pmic->regmap, BXTWC_MIRQLVL1, BXTWC_MIRQLVL1_MCHGR, 0);
>  
> @@ -584,4 +584,4 @@ static struct platform_driver bxtwc_driver = {
>  module_platform_driver(bxtwc_driver);
>  
>  MODULE_LICENSE("GPL v2");
> -MODULE_AUTHOR("Qipeng Zha<qipeng.zha@intel.com>");
> +MODULE_AUTHOR("Qipeng Zha <qipeng.zha@intel.com>");

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
