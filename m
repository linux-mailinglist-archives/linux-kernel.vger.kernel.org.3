Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2116489C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiAJPiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiAJPiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:38:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF10C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:38:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x4so2347023wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zYb/b2eN9/xxenlM3wRxRRdx4QgyTjqcoOjnTYvHl8Y=;
        b=jr3s3gUNQLaELn3BiUstpJOD3qP44llteog38teNUMkkzXnxP973PoY8Pxmx+9LuXQ
         CSQxYPNwgJCG5eHItofZCzgxYQZwSDwW8sTbBzktRRupG1duLRT1JM2SSL1mDkGd6Umt
         hrsJ5276dyeSly/rH59fJmGD2E1EeqdfmUs2p2g9CtixSJyAhu0LeQ3L+suPSp6MmI3/
         uOmoo+DeQ2cV42IGf4uRanKLaVU6btt9FISxS48fW89888iS3gZ5CeieEka5OtxRB/Hn
         ogo1UZ0vAlfChyluX//wx9R5ZOm6DyVsxJSJ+49SDWdTlOf4SUJ0pSQVzFJTKUh9YRGb
         NOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zYb/b2eN9/xxenlM3wRxRRdx4QgyTjqcoOjnTYvHl8Y=;
        b=ejKggDyVLMDJ5S/EG15RcUnwbWqrhFRsl8wg9tcBvXegSZl1IUzw9Hdif1L7SlctGS
         E+/pMZZiEhL+cfWJWjCUDujJMVMcpEazVf2bEC9+ixAM4xKt6NP7+WnGu2vl+MOcUdFU
         a8F/AdNZFlXx9OgyAxn+qt+Uvr6yG29r+0J+LuwSV8hHgSKmqOBOPVJzhXQlcGubxqi8
         frCh87QnotcdTSEJv456Xqg1iQE9bhhVl2sM20b2axJ7RdRVdvRMnZ1Q1RvpiGp2mEQX
         g+2x8x3whywSzREmCBLevkO0iLTgNUGMOcH8BHnxrCCUCFM1wjYK6//PH6AQcuijjhID
         UIIw==
X-Gm-Message-State: AOAM5317l5hPOdb3xslbGiZHZEEvavQuIG8OUPVwO6zW7jknkIbJNcCy
        RJMyGaypco1367+pyQjiI/F63A==
X-Google-Smtp-Source: ABdhPJziX28sEa5ijCKSY/r3feNH1vgCBSTwVExJgIw4NhbYSnqyALWrvsW1r5ujIYqjlpaU1oEbNw==
X-Received: by 2002:adf:df0a:: with SMTP id y10mr183503wrl.360.1641829095355;
        Mon, 10 Jan 2022 07:38:15 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id j13sm7504485wmq.11.2022.01.10.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:38:14 -0800 (PST)
Date:   Mon, 10 Jan 2022 15:38:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, romain.izard.pro@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v2 2/2] mfd: atmel-flexcom: use resume_noirq
Message-ID: <YdxS5NaIWLviZUc0@google.com>
References: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
 <20211028135138.3481166-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028135138.3481166-3-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021, Claudiu Beznea wrote:

> Flexcom IP embeds 3 other IPs: usart, i2c, spi and selects the operation
> mode (usart, i2c, spi) via mode register (FLEX_MR). On i2c bus there might
> be connected critical devices (like PMIC) which on suspend/resume should
> be suspended/resumed at the end/beginning. i2c uses
> .suspend_noirq/.resume_noirq for this kind of purposes. Align flexcom
> to use .resume_noirq as it should be resumed before the embedded IPs.
> Otherwise the embedded devices might behave badly.
> 
> Fixes: 7fdec11015c3 ("atmel_flexcom: Support resuming after a chip reset")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Tested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/mfd/atmel-flexcom.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 962f66dc8813..559eb4d352b6 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -87,7 +87,7 @@ static const struct of_device_id atmel_flexcom_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
>  
> -static int __maybe_unused atmel_flexcom_resume(struct device *dev)
> +static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
>  {
>  	struct atmel_flexcom *ddata = dev_get_drvdata(dev);
>  	int err;
> @@ -105,8 +105,9 @@ static int __maybe_unused atmel_flexcom_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(atmel_flexcom_pm_ops, NULL,
> -			 atmel_flexcom_resume);
> +static const struct dev_pm_ops atmel_flexcom_pm_ops = {
> +	.resume_noirq = atmel_flexcom_resume_noirq,

Doesn't this mean you can remove __maybe_unused?

> +};
>  
>  static struct platform_driver atmel_flexcom_driver = {
>  	.probe	= atmel_flexcom_probe,

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
