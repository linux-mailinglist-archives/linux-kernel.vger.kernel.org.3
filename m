Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644858CB30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbiHHPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiHHPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:20:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999C32632
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:20:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso7593600wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2sLx6fEQwkbGZWDAMNRbYQgltbUIN1vZK/rvp0HIjo4=;
        b=nwoEwxKTGt8V6iwPdg4L2df7wpzRUbGM5oh14oMdkU3PpY7aYt3ndUeEBThBPRJiEW
         urtaayJeZFZYI6Y1aLClDNYma1LXn5iYZbNpFOS7H9XmKYIBmE4wFgTHJOC/1uc318DS
         daWaPl8l5pF2IQPWiCie+omUaUSzH02CnOv+9CwfpJexNCvfdSK4d27ftNk9sodirDyp
         8J22b9rMU055iOxRzwVpcFoUtS6uudEek3YAagtYjyrEHka7ULPA4Z0cPU6deaa9M6Ys
         iRmJ0yjXzKknnEsRpZ59nC8q9slwfOqtB9ORHPdayD8v9HEFPDlJxdte8EsXWUMh7RtW
         l0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2sLx6fEQwkbGZWDAMNRbYQgltbUIN1vZK/rvp0HIjo4=;
        b=ybtp08ljSnlS4DdhkVQYuTuWHrGhGaytpeBFb8FJkNo7jqz8wj51GwAzmq7gq70XwZ
         OdfZD+kh4060Fz290nzqrU0MpdT4EIZdGmGwVReBRL6b/EGPiN5tdDeIOKP13CKGVWIK
         vZWl369KQT3r/LMDkjvsGmNrPQbJkJehucpYQSJkbVDO2VW0vhAy5abounB+6twd2vn6
         /l6+iG+z/jRAHe0p6ME87SEmDp43CXcuv60dCuXwOyq5PAiUc+ZDMJ9T3StfgJNVwFQ/
         hw6/S5byZpygRuKzTIo91TcgM369NlEuC6A1QqppXJbQP6BRiyp/RJsydSIShbGx0NU+
         TCnQ==
X-Gm-Message-State: ACgBeo0t5etBBkN4WXHQBLxTXtL5aDq7IjrZu3nBV2uKVRilD+XOVa1P
        uw23Ls0hagWS5QA0zYjKGQO42e2xhwCnjA==
X-Google-Smtp-Source: AA6agR6SgIfrt8NeC9kMXjRv2jbafNW4hHNvvi487MT5aAzT7mCG9rSauGVqPaZgNI03UnqE6/ftMw==
X-Received: by 2002:a05:600c:600b:b0:3a3:1176:222d with SMTP id az11-20020a05600c600b00b003a31176222dmr18086995wmb.42.1659972014200;
        Mon, 08 Aug 2022 08:20:14 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e3-20020adf9bc3000000b0020e6ce4dabdsm11530060wrc.103.2022.08.08.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:20:13 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:20:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [RESEND][PATCH v1 8/9] mfd: intel_soc_pmic_bxtwc: Support IRQ
 chip hierarchy
Message-ID: <YvEprE7YwuwaMXwL@google.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
 <20220718122328.8287-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718122328.8287-8-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022, Andy Shevchenko wrote:

No commit message.

Probably needs to justify why it's calling a function denoted for
internal use only.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 8dac0d41f64f..f9842ff44b3f 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -422,8 +422,10 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
>  		return dev_err_probe(pmic->dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
>  				     pirq, chip->name);
>  
> -	return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
> -					0, chip, data);
> +	return __devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq,
> +					  irq_flags, 0,
> +					  regmap_irq_get_domain(pdata),
> +					  chip, data);
>  }
>  
>  static int bxtwc_probe(struct platform_device *pdev)

-- 
DEPRECATED: Please use lee@kernel.org
