Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD505489F61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiAJSlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbiAJSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:41:12 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:41:11 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r62so13187811oie.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p5QMknA8tOLAY9s9dTBzuIVAS12kbyGU2Ryi9GwiRoM=;
        b=niDUswhNo3PCLcm/3ji54to4wvBe0PLNunGnTCKFcl6YZh2E36FxNhyd+8/rkj6mKc
         ojOxLdFF1/WeETpmf5YWzuxg6Q/y6kCBm2d6Aj3g0dwr7wObUOkZ/vqN04LGt37PLRVO
         8fXmK5SSKfdcC2ZzlNviuLhS16wv6dS6eBrxd0zd2UmiAVjhfTWcTNPuk/evWVXYj1IZ
         0zop4HYnQe7QekEGMfNy0KPazjrczfaTpQi4dNut6AjPtN0o36RshOnPkxTKWeFhM5tk
         QHiwmof23AqmLKYV4C75TMPKtYsQ87SVB90SZoQ1HRNn1cmJbD1KPfoL7PhCjUzWdCK1
         NKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5QMknA8tOLAY9s9dTBzuIVAS12kbyGU2Ryi9GwiRoM=;
        b=YanCf42aMRisnB1hOs7kZKXGQ4z9mlvQlDI+A7uXrrrZHnj7kRTsAgYukPnPAje7Qi
         mNNfvX9iJitLX95Q6h3PHCyAt1Uilbwy57KrGd0415qKqzndutaEcpxixgHlAuxxZbq7
         P7u0LBKzLxyLLTyPu9D0nQGxXaAZG1+iaB/eGUO8KcnCZtnXhEbOb2wFgN5RKC4jnNqo
         6vcEzYPirMyrnPwBfaDeqiF5ptSC3kws5JdjwdvjCQ01Vh0bAO+facgp17h6UrTMTHMe
         0H8ro0dQhO/RhMk2Og2tCfGTtDHIhJPZt1UCRa8lgELz5fVfzLRWYADi9KCMOx+amiBt
         xxMw==
X-Gm-Message-State: AOAM5314XqtusZr5PZzCDoyNzy+Zun24hwii74ryCSrdUXSj7yOwXdkV
        r11eaMyOxuNwwg7HCEXsGBOwZguoHmJUNw==
X-Google-Smtp-Source: ABdhPJzNwPt5g/pwbdQ7XzU/8OQ0pYOekmiNLmdPKXrW3ek0nBkI/+wYIdvxbu0LNnwtq+2XlC9/tg==
X-Received: by 2002:a05:6808:1248:: with SMTP id o8mr550904oiv.157.1641840070911;
        Mon, 10 Jan 2022 10:41:10 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n26sm1459596ooc.48.2022.01.10.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:41:10 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:41:55 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Subject: Re: [PATCH v3 1/7] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <Ydx98+VkJOlUnkl5@ripper>
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
 <20220106173131.3279580-2-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106173131.3279580-2-caleb.connolly@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Jan 09:31 PST 2022, Caleb Connolly wrote:

> Some PMIC functions such as the RRADC need to be aware of the PMIC
> chip revision information to implement errata or otherwise adjust
> behaviour, export the PMIC information to enable this.
> 
> This is specifically required to enable the RRADC to adjust
> coefficients based on which chip fab the PMIC was produced in,
> this can vary per unique device and therefore has to be read at
> runtime.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/mfd/qcom-spmi-pmic.c | 108 +++++++++++++++++------------------
>  include/soc/qcom/qcom-pmic.h |  63 ++++++++++++++++++++
>  2 files changed, 114 insertions(+), 57 deletions(-)
>  create mode 100644 include/soc/qcom/qcom-pmic.h
> 
> diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
> index 1cacc00aa6c9..6b75c2f52b74 100644
> --- a/drivers/mfd/qcom-spmi-pmic.c
> +++ b/drivers/mfd/qcom-spmi-pmic.c
> @@ -3,51 +3,24 @@
>   * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/device.h>
> +#include <linux/gfp.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
>  #include <linux/spmi.h>
>  #include <linux/regmap.h>
>  #include <linux/of_platform.h>
> +#include <soc/qcom/qcom-pmic.h>
>  
>  #define PMIC_REV2		0x101
>  #define PMIC_REV3		0x102
>  #define PMIC_REV4		0x103
>  #define PMIC_TYPE		0x104
>  #define PMIC_SUBTYPE		0x105
> -
> +#define PMIC_FAB_ID		0x1f2
>  #define PMIC_TYPE_VALUE		0x51
>  
> -#define COMMON_SUBTYPE		0x00
> -#define PM8941_SUBTYPE		0x01
> -#define PM8841_SUBTYPE		0x02
> -#define PM8019_SUBTYPE		0x03
> -#define PM8226_SUBTYPE		0x04
> -#define PM8110_SUBTYPE		0x05
> -#define PMA8084_SUBTYPE		0x06
> -#define PMI8962_SUBTYPE		0x07
> -#define PMD9635_SUBTYPE		0x08
> -#define PM8994_SUBTYPE		0x09
> -#define PMI8994_SUBTYPE		0x0a
> -#define PM8916_SUBTYPE		0x0b
> -#define PM8004_SUBTYPE		0x0c
> -#define PM8909_SUBTYPE		0x0d
> -#define PM8028_SUBTYPE		0x0e
> -#define PM8901_SUBTYPE		0x0f
> -#define PM8950_SUBTYPE		0x10
> -#define PMI8950_SUBTYPE		0x11
> -#define PM8998_SUBTYPE		0x14
> -#define PMI8998_SUBTYPE		0x15
> -#define PM8005_SUBTYPE		0x18
> -#define PM660L_SUBTYPE		0x1A
> -#define PM660_SUBTYPE		0x1B
> -#define PM8150_SUBTYPE		0x1E
> -#define PM8150L_SUBTYPE		0x1f
> -#define PM8150B_SUBTYPE		0x20
> -#define PMK8002_SUBTYPE		0x21
> -#define PM8009_SUBTYPE		0x24
> -#define PM8150C_SUBTYPE		0x26
> -#define SMB2351_SUBTYPE		0x29
> -
>  static const struct of_device_id pmic_spmi_id_table[] = {
>  	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
>  	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
> @@ -81,42 +54,47 @@ static const struct of_device_id pmic_spmi_id_table[] = {
>  	{ }
>  };
>  
> -static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
> +static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,

You changed the return type to int, but ignore the returned value in the
caller.

> +				 struct qcom_spmi_pmic *pmic)
>  {
> -	unsigned int rev2, minor, major, type, subtype;
> -	const char *name = "unknown";
>  	int ret, i;
>  
> -	ret = regmap_read(map, PMIC_TYPE, &type);
> +	ret = regmap_read(map, PMIC_TYPE, &pmic->type);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
> -	if (type != PMIC_TYPE_VALUE)
> -		return;
> +	if (pmic->type != PMIC_TYPE_VALUE)
> +		return ret;
>  
> -	ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
> +	ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
> -		if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
> +		if (pmic->subtype == (unsigned long)pmic_spmi_id_table[i].data)
>  			break;
>  	}
>  
>  	if (i != ARRAY_SIZE(pmic_spmi_id_table))
> -		name = pmic_spmi_id_table[i].compatible;
> +		pmic->name = devm_kstrdup_const(dev, pmic_spmi_id_table[i].compatible, GFP_KERNEL);
>  
> -	ret = regmap_read(map, PMIC_REV2, &rev2);
> +	ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
> -	ret = regmap_read(map, PMIC_REV3, &minor);
> +	ret = regmap_read(map, PMIC_REV3, &pmic->minor);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
> -	ret = regmap_read(map, PMIC_REV4, &major);
> +	ret = regmap_read(map, PMIC_REV4, &pmic->major);
>  	if (ret < 0)
> -		return;
> +		return ret;
> +
> +	if (pmic->subtype == PMI8998_SUBTYPE || pmic->subtype == PM660_SUBTYPE) {

The rest of the patch just stuffs the existing information into a
different container, but this adds new information. Even though it's
trivial, how about moving that to a separate patch to keep it separate
from the other changes?

> +		ret = regmap_read(map, PMIC_FAB_ID, &pmic->fab_id);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	/*
>  	 * In early versions of PM8941 and PM8226, the major revision number
> @@ -124,14 +102,14 @@ static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>  	 * Increment the major revision number here if the chip is an early
>  	 * version of PM8941 or PM8226.
>  	 */
> -	if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
> -	    major < 0x02)
> -		major++;
> +	if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
> +	    pmic->major < 0x02)
> +		pmic->major++;
>  
> -	if (subtype == PM8110_SUBTYPE)
> -		minor = rev2;
> +	if (pmic->subtype == PM8110_SUBTYPE)
> +		pmic->minor = pmic->rev2;
>  
> -	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
> +	return 0;
>  }
>  
>  static const struct regmap_config spmi_regmap_config = {
> @@ -144,22 +122,38 @@ static const struct regmap_config spmi_regmap_config = {
>  static int pmic_spmi_probe(struct spmi_device *sdev)
>  {
>  	struct regmap *regmap;
> +	struct qcom_spmi_pmic *pmic;
>  
>  	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> +	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
>  	/* Only the first slave id for a PMIC contains this information */
> -	if (sdev->usid % 2 == 0)
> -		pmic_spmi_show_revid(regmap, &sdev->dev);
> +	if (sdev->usid % 2 == 0) {
> +		pmic_spmi_load_revid(regmap, &sdev->dev, pmic);
> +		spmi_device_set_drvdata(sdev, pmic);

In your answer to Jonathan, you say that the way child drivers can get
the PMIC version information is to dev_get_drvdata() on their parent.

But each PMIC has two USIDs (to give us 17bits address space), and you
only assign the drvdata on the first one. So any devices sitting in the
second USID would be unable to acquire the drvdata.


Also, rather than having child drivers "blindly" pull out the struct
qcom_spmi_pmic pointer out of a void * drvdata, how about adding a
function in this driver that they can call with their struct device * -
which traverses the parent hierarchy, checking if it finds a device
with the pmic_spmi_driver driver and then return the struct.

That way you hide the drvdata usage from your users and there's much
less risk that they get hold of the wrong drvdata.

> +		qcom_pmic_print_info(&sdev->dev, pmic);

Please don't dev_info hardware version information, there's enough stuff
in the kernel log already.

> +	}
>  
>  	return devm_of_platform_populate(&sdev->dev);
>  }
>  
> +static void pmic_spmi_remove(struct spmi_device *sdev)
> +{
> +	struct qcom_spmi_pmic *pmic = spmi_device_get_drvdata(sdev);
> +
> +	kfree(pmic->name);

This name was allocated using devm_kstrdup_const(), which means that as
soon as you return from remove() it will be automatically freed.

PS. I think the correct free function (if you want to release a
devm_kstrdup_const() allocation) would be devm_kfree_const(), but I'm
not able to find such function...

> +}
> +
>  MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
>  
>  static struct spmi_driver pmic_spmi_driver = {
>  	.probe = pmic_spmi_probe,
> +	.remove = pmic_spmi_remove,
>  	.driver = {
>  		.name = "pmic-spmi",
>  		.of_match_table = pmic_spmi_id_table,
> diff --git a/include/soc/qcom/qcom-pmic.h b/include/soc/qcom/qcom-pmic.h

Do you know if the ssbi PMICs provide similar information? Presumably
though they would need different drivers anyways. So perhaps name this
qcom-spmi-pmic.h just to be clear?

> new file mode 100644
> index 000000000000..59114988582d
> --- /dev/null
> +++ b/include/soc/qcom/qcom-pmic.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2021 Linaro. All rights reserved.
> + * Copyright (c) 2021 Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#ifndef __QCOM_PMIC_H__
> +#define __QCOM_PMIC_H__
> +
> +#define COMMON_SUBTYPE		0x00
> +#define PM8941_SUBTYPE		0x01
> +#define PM8841_SUBTYPE		0x02
> +#define PM8019_SUBTYPE		0x03
> +#define PM8226_SUBTYPE		0x04
> +#define PM8110_SUBTYPE		0x05
> +#define PMA8084_SUBTYPE		0x06
> +#define PMI8962_SUBTYPE		0x07
> +#define PMD9635_SUBTYPE		0x08
> +#define PM8994_SUBTYPE		0x09
> +#define PMI8994_SUBTYPE		0x0a
> +#define PM8916_SUBTYPE		0x0b
> +#define PM8004_SUBTYPE		0x0c
> +#define PM8909_SUBTYPE		0x0d
> +#define PM8028_SUBTYPE		0x0e
> +#define PM8901_SUBTYPE		0x0f
> +#define PM8950_SUBTYPE		0x10
> +#define PMI8950_SUBTYPE		0x11
> +#define PM8998_SUBTYPE		0x14
> +#define PMI8998_SUBTYPE		0x15
> +#define PM8005_SUBTYPE		0x18
> +#define PM660L_SUBTYPE		0x1A
> +#define PM660_SUBTYPE		0x1B
> +#define PM8150_SUBTYPE		0x1E
> +#define PM8150L_SUBTYPE		0x1f
> +#define PM8150B_SUBTYPE		0x20
> +#define PMK8002_SUBTYPE		0x21
> +#define PM8009_SUBTYPE		0x24
> +#define PM8150C_SUBTYPE		0x26
> +#define SMB2351_SUBTYPE		0x29
> +
> +#define PMI8998_FAB_ID_SMIC	0x11
> +#define PMI8998_FAB_ID_GF	0x30
> +
> +#define PM660_FAB_ID_GF		0x0
> +#define PM660_FAB_ID_TSMC	0x2
> +#define PM660_FAB_ID_MX		0x3
> +
> +struct qcom_spmi_pmic {
> +	unsigned int type;
> +	unsigned int subtype;
> +	unsigned int major;
> +	unsigned int minor;
> +	unsigned int rev2;
> +	unsigned int fab_id;
> +	const char *name;
> +};
> +
> +static inline void qcom_pmic_print_info(struct device *dev, struct qcom_spmi_pmic *pmic)

It's only in specific cases that this information is useful to people
reading the kernel log and putting it in the include file seems to
suggest that multiple drivers would want to print this information.

I think you should move it back into the spmi driver to avoid this.

Regards,
Bjorn

> +{
> +	dev_info(dev, "%x: %s v%d.%d\n",
> +		pmic->subtype, pmic->name, pmic->major, pmic->minor);
> +}
> +
> +#endif /* __QCOM_PMIC_H__ */
> -- 
> 2.34.1
> 
