Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB3C473422
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbhLMSgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbhLMSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:36:16 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605BEC061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:36:16 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bf8so24362336oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RKnW0CJ8QtZOwXTWz01u2sxEnEsigtwIbEpGidlLzFM=;
        b=cM2pfTVjOfN48+d2BFuLmg/I8038RTUIXfQhvmtCfl7T8tbRo1tSqVgAsWMbhfuBj5
         kHjaLSxxoEZYkHs7luwT8C4f5xEqCjSqQC8F4VMdiejkpe+w0WnAIdI6GueXaiT7/VjR
         veN4O/RBJTdy4QG2iPmJ3h0hJNSC451FpqGAIIqB3WogV9hC7plHXMHiyY5+f5m0Wwr8
         PCEZDq9EdJKEUJuh2+iDglw4r7daVN7tcVcTTVtMCjKNLmEZuxB2BfjmNTdLVUAdjFHx
         Mg99+E+6Xn7/B7gHjqVNVeAu7RaBBkB8Xo6NqcO3v7P2S2tElFHNYAUVbQOssTUT+ZFv
         uvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RKnW0CJ8QtZOwXTWz01u2sxEnEsigtwIbEpGidlLzFM=;
        b=L0/5SpPwI4uZIIStl3SQrEZc5R3LV2NLCwwF6Q7+BFSb8VvXysE/aXtaNPpHBH8Uwi
         MLUuy6F5qooffjpTvELMbBsDi5HtsHm7lg5SSMfdKBeFCeGWyPWSaEouJFgf+SmQNLQT
         C32JB+jFl3hlNcL0DuNGW95CHaRuwd7DH3rMRdssHubWV2/9Mpu1wuRI3Jg0jkx9fa9u
         BnUc91GDXkyYqsr/uk9dQheLLfCxpJt2hNPFxQ2xCGL5kDcnPj9OejmpjaWbLkNNg1M2
         rrxg8s3qyOb2HjJ3SnCYFZatepv+6M1bwA0AGYaJHkmQQZIDuEZMaI5D9vYs61OkWlCs
         8Bsg==
X-Gm-Message-State: AOAM533S0iotRTbHMSZMJxsWgeWZplDGlpZL1R4IPjNkliG/aCeTszup
        E4Tunfe5974/YGTXDr5z59ORDw==
X-Google-Smtp-Source: ABdhPJw6Si4lJQdVRuNx4RALSbSMB6q1TJ49keENLeWB/e+mU1SwF2YAHKiQaZCWgWALMTsS45tFjg==
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr29165889oih.51.1639420575644;
        Mon, 13 Dec 2021 10:36:15 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m12sm2310879ots.59.2021.12.13.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:36:15 -0800 (PST)
Date:   Mon, 13 Dec 2021 10:37:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 6/8] misc: fastrpc: add secure domain support
Message-ID: <YbeS7KXj1slU2qgf@ripper>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
 <20211209120626.26373-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209120626.26373-7-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Dec 04:06 PST 2021, Srinivas Kandagatla wrote:

> ADSP/MDSP/SDSP are by default secured, which means it can only be loaded
> with a Signed process.
> Where as CDSP can be either be secured/unsecured. non-secured Compute DSP
> would allow users to load unsigned process and run hexagon instructions,
> but blocking access to secured hardware within the DSP. Where as signed
> process with secure CDSP would be allowed to access all the dsp resources.
> 
> This patch adds basic code to create device nodes as per device tree property.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 61 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 79fc59caacef..50f8e23b6b04 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -240,12 +240,15 @@ struct fastrpc_channel_ctx {
>  	/* Flag if dsp attributes are cached */
>  	bool valid_attributes;
>  	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
> +	struct fastrpc_device *secure_fdevice;
>  	struct fastrpc_device *fdevice;
> +	bool secure;
>  };
>  
>  struct fastrpc_device {
>  	struct fastrpc_channel_ctx *cctx;
>  	struct miscdevice miscdev;
> +	bool secure;
>  };
>  
>  struct fastrpc_user {
> @@ -1876,7 +1879,7 @@ static struct platform_driver fastrpc_cb_driver = {
>  };
>  
>  static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
> -				   const char *domain)
> +				   bool is_secured, const char *domain)
>  {
>  	struct fastrpc_device *fdev;
>  	int err;
> @@ -1885,15 +1888,21 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
>  	if (!fdev)
>  		return -ENOMEM;
>  
> +	fdev->secure = is_secured;
>  	fdev->cctx = cctx;
>  	fdev->miscdev.minor = MISC_DYNAMIC_MINOR;
>  	fdev->miscdev.fops = &fastrpc_fops;
> -	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s", domain);
> +	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s%s",
> +					    domain, is_secured ? "-secure" : "");

Will this not result in existing userspace using the wrong misc device?

>  	err = misc_register(&fdev->miscdev);
> -	if (err)
> +	if (err) {
>  		kfree(fdev);
> -	else
> -		cctx->fdevice = fdev;
> +	} else {
> +		if (is_secured)
> +			cctx->secure_fdevice = fdev;
> +		else
> +			cctx->fdevice = fdev;
> +	}
>  
>  	return err;
>  }
> @@ -1904,6 +1913,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	struct fastrpc_channel_ctx *data;
>  	int i, err, domain_id = -1;
>  	const char *domain;
> +	bool secure_dsp = false;

Afaict this is only every accessed after first being written. So no need
to initialize it.

>  
>  	err = of_property_read_string(rdev->of_node, "label", &domain);
>  	if (err) {
> @@ -1927,10 +1937,31 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	err = fastrpc_device_register(rdev, data, domains[domain_id]);
> -	if (err) {
> -		kfree(data);
> -		return err;
> +
> +	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
> +	data->secure = secure_dsp;
> +
> +	switch (domain_id) {
> +	case ADSP_DOMAIN_ID:
> +	case MDSP_DOMAIN_ID:
> +	case SDSP_DOMAIN_ID:
> +		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
> +		if (err)
> +			goto fdev_error;
> +		break;
> +	case CDSP_DOMAIN_ID:
> +		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
> +		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
> +		if (err)
> +			goto fdev_error;
> +
> +		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
> +		if (err)
> +			goto fdev_error;
> +		break;
> +	default:
> +		err = -EINVAL;
> +		goto fdev_error;
>  	}
>  
>  	kref_init(&data->refcount);
> @@ -1943,7 +1974,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	data->domain_id = domain_id;
>  	data->rpdev = rpdev;
>  
> -	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	dev_info(rdev, "%s complete for %s with secure flag(%d) return: %d\n",
> +			__func__, domains[domain_id], secure_dsp, err);

I would prefer that we don't spam the kernel log with such useful
information, in particular since it will happen every time we start or
restart a remoteproc with fastrpc. So dev_dbg perhaps?

> +	return err;

I think that in the event that of_platform_populate() actually failed,
you will return an error here, fastrpc_rpmsg_remove() won't be called,
so you won't release the misc device or release &data->refcount. This
issue exists in the code today though...

Regards,
Bjorn

> +
> +fdev_error:
> +	kfree(data);
> +	return err;
>  }
>  
>  static void fastrpc_notify_users(struct fastrpc_user *user)
> @@ -1970,6 +2008,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	if (cctx->fdevice)
>  		misc_deregister(&cctx->fdevice->miscdev);
>  
> +	if (cctx->secure_fdevice)
> +		misc_deregister(&cctx->secure_fdevice->miscdev);
> +
>  	of_platform_depopulate(&rpdev->dev);
>  
>  	cctx->rpdev = NULL;
> -- 
> 2.21.0
> 
