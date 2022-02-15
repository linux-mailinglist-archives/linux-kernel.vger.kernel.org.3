Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED94B707E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbiBOQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:05:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241216AbiBOQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:05:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1BD77AAD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:05:44 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B4C640259
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644941143;
        bh=a5p0jbJuoZXuIYXCuk7jCb9IudJlG8HUMfMyA2TVNH8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PaO6d/R8TgtQejkwhSJDwNccTNiE85rLdwWsTrFnon7RZKt4z+aQzzT3bWRHGlgjA
         lE4XFlHoHpMjXGqVWYJjOzjtvu7pNKPYDyniWmW6L/2DfEbDNZ5YL25UtPno9yoxa4
         JNMvpFv2enI8LUyCPH43DAc27u34NvWDyZxAP24DIvb6LsKFsfyk4ggS9AZQfhsa1K
         Y9Iw/O8HPjJc6zHHv6oN6fPoAPhuqFmw1ofOtoHofp2JS1rgMKf1voZGgk49aMvJyR
         /FueZ+BJcF7P3dmdueZo5Cdv9nxOKdKGwqIZD3VILj51Mh2pE5+b8do8/huRO420IU
         fuVXy5n9XHHVA==
Received: by mail-wr1-f72.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso8583362wrv.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a5p0jbJuoZXuIYXCuk7jCb9IudJlG8HUMfMyA2TVNH8=;
        b=3Jl/0n7Fm83K0NCsRRf4Hxo6w5eej/C+wvppL+D25iWaRh6j2I1CfRi17AIwq99eAd
         ox4q2K/pSbtf1V2AYlXzitnVjPdLcIV6f31mlZ329h7t5nlxpAIyPwRXLJy4L6wTLKSS
         oFmbO2+LrNOe5tHGExnhHCIjwBOMwKIryhFcXtJSD/x8oJtpGXsY8VTVTQMBL5H493wT
         iNl+XE6rWxQyRK3jbFUoQpgroG2OFqB4LS6zLwaJnPdpRvhXmSWEzM5q6+vUjYxSKLEH
         Mwq0YCboDdPorYFNc7HCPLecx6hJ1oQDF8ByQZC04qsgzz6MX7AotJSRuhF1Rg9kl92P
         G3Jw==
X-Gm-Message-State: AOAM530kft9U1UlxYr8aHZlCOnNT6n5s6haa2iWrRftW1WP9R1kKJMAi
        2gwRKIbg0vC3M0C9IQrsi31Kzn5djk2Dj1J3LohUUgRBH8vXnOMJ21QWhP+eA3GeiQTxJ++TP9p
        dgVIPhEPuCljQHOggEdvz5iR0izqSfdp8Q4Jcxiyqxg==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr3725611wrd.336.1644941142996;
        Tue, 15 Feb 2022 08:05:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYtMqD5BoT21+c2/cnHXsvFgj0v2YRgdfIP0mCqy6zs5EMdNWfuwPAegRw3OvftSpaYYRLSg==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr3725586wrd.336.1644941142726;
        Tue, 15 Feb 2022 08:05:42 -0800 (PST)
Received: from [192.168.0.109] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n9sm14195262wrx.76.2022.02.15.08.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:05:42 -0800 (PST)
Message-ID: <3fbb2e11-ca60-0b25-8c59-9d73eb4addd1@canonical.com>
Date:   Tue, 15 Feb 2022 17:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] Input: add Imagis touchscreen driver
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <1644531943.391463.3262540.nullmailer@robh.at.kernel.org>
 <20220215151527.84634-1-markuss.broks@gmail.com>
 <20220215151527.84634-3-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215151527.84634-3-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 16:15, Markuss Broks wrote:
> Add support for the IST3038C touchscreen IC from Imagis, based on
> downstream driver. The driver supports multi-touch (10 touch points)
> The IST3038C IC supports touch keys, but the support isn't added
> because the touch screen used for testing doesn't utilize touch keys.
> Looking at the downstream driver, it is possible to add support
> for other Imagis ICs of IST30**C series.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  MAINTAINERS                        |   6 +
>  drivers/input/touchscreen/Kconfig  |  10 +
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/imagis.c | 330 +++++++++++++++++++++++++++++
>  4 files changed, 347 insertions(+)
>  create mode 100644 drivers/input/touchscreen/imagis.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a899828a8d4e..f7f717ae926a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9405,6 +9405,12 @@ F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
>  
> +IMAGIS TOUCHSCREEN DRIVER

Please read the line 143-144 of this file.

> +M:	Markuss Broks <markuss.broks@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +F:	drivers/input/touchscreen/imagis.c
> +
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 2f6adfb7b938..6810b4b094e8 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1367,4 +1367,14 @@ config TOUCHSCREEN_ZINITIX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zinitix.
>  
> +config TOUCHSCREEN_IMAGIS

Here and in Makefile - do not add entries at the end, but
alphabetically. This reduces conflicts.

> +	tristate "Imagis touchscreen support"
> +	depends on I2C
> +	help
> +		Say Y here if you have an Imagis IST30xxC touchscreen.
> +		If unsure, say N.
> +
> +		To compile this driver as a module, choose M here: the
> +		module will be called imagis.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 39a8127cf6a5..989bb1d563d3 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -115,3 +115,4 @@ obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
>  obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
> +obj-$(CONFIG_TOUCHSCREEN_IMAGIS)	+= imagis.o


(...)

> +
> +static int imagis_init_regulators(struct imagis_ts *ts)
> +{
> +	struct i2c_client *client = ts->client;
> +	int error;
> +
> +	ts->supplies[0].supply = "vdd";
> +	ts->supplies[1].supply = "vddio";
> +	error = devm_regulator_bulk_get(&client->dev,
> +					ARRAY_SIZE(ts->supplies),
> +					ts->supplies);
> +	if (error < 0) {
> +		dev_err(&client->dev, "Failed to get regulators: %d\n", error);

This should be also dev_err_probe() in case of deferred probing. On the
other hand, you already handle printing in probe(), so why doing it twice?

> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imagis_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev;
> +	struct imagis_ts *ts;
> +	int chip_id, ret;
> +
> +	dev = &i2c->dev;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client = i2c;
> +
> +	ret = imagis_init_regulators(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regulator init error: %d\n", ret);
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ts->supplies),
> +				    ts->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulators: %d\n", ret);
> +
> +	msleep(IST3038C_CHIP_ON_DELAY);
> +
> +	ret = imagis_i2c_read_reg(ts, IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS, &chip_id);
> +	if (ret)

You miss here and other error paths the regulator cleanup (disabling).

> +		return dev_err_probe(dev, ret, "chip ID read failure: %d\n", ret);
> +
> +	if (chip_id == IST3038C_WHOAMI)
> +		dev_dbg(dev, "Detected IST3038C chip\n");
> +	else
> +		return dev_err_probe(dev, -EINVAL, "unknown chip ID: 0x%x\n", chip_id);
> +
> +	ret = devm_request_threaded_irq(dev, i2c->irq,
> +					NULL, imagis_interrupt,
> +					IRQF_ONESHOT | IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,

The interrupt edge should come from DT, not be hard-coded. I think you
can safely skip IRQF_TRIGGER_FALLING.

> +					"imagis-touchscreen", ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "IRQ allocation failure: %d\n", ret);
> +
> +	ret = imagis_init_input_dev(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "input subsystem init error: %d\n", ret);
> +
> +	return 0;
> +}
> +


Best regards,
Krzysztof
