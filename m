Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC54B5215
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354620AbiBNNqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:46:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354613AbiBNNqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:46:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730DBCBF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:46:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so6410149wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w7Y2pezxBsweg1F5I/VGY695nV4P7xVufo9MH/6yH4w=;
        b=xbBzSuDMBF4QcBOgUYmHXwtJ8dWcuIuUf140cvSkvLow8cj8kYcFB4do4WkalZa3XS
         8d9s0BtXVhj3b8h6vy6UlCEgZBLcU1/Qom1uZyeHgFKh9kfdDacWzy1LL/pmKExd690W
         DETyv+xXrlYN2SNwheJSZM/VepnFWEYOloLT6xeK9Bw98s5hum78ZHjN6uh7GYctQI4a
         U3Rm5lvrfoTlw9jO4MeePvBBmUeo5GQsY0C27x0TzmhYHiUaaPw7f6MeL1bwOouJldMM
         0QAC00Gg6se2kiBkKRFwpZ2P/QYpJ+5/64PI6ibT4QIq94fnmN4bLjEZbJrcmwrx3sek
         tXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w7Y2pezxBsweg1F5I/VGY695nV4P7xVufo9MH/6yH4w=;
        b=0GBqHDr72PDPwU06c1qXQQTjq3ZcZOoEZXCGO7t4GU8njXMCOtvbfqIC61qYsd1N9r
         2s9ZEwb/mI9a/hlUWMuPl7n4GI+40IFX9S5aiEnNCohFiKuzyLxENkC3fg4MsZcHeSf1
         vUY4vRCHTtOsKPeAEo5w3RAT6kMeWS+EPA8ZHjJsn3kODHwy5CgztLlGYhUBJUhoSPwI
         /vpEQf1GSoQYz4cJ5yEDyufk4bplHTh9b+Kemhpd51uZ/8AWZSMgV0h1vId7BbdwQjVX
         1lYR9T+836Z2cXqP4KlcdPKSyfBVkLykUvdljPlguYuJXsauj+9kIoYuuw5WGPxM2Tyf
         +5TQ==
X-Gm-Message-State: AOAM5303d5AY3615RJx6u58PVvR0k5XT0Ihs+NfFJPYeki0aHm/y1Yml
        AEvECMBkBIsrwOifcpYDVYcsAQ==
X-Google-Smtp-Source: ABdhPJzXEeknb6ILWxHf2R1dA6zSDZITWc+9hhismzIz4RJI7wlJaYVzhoqbDzYnJ6jvnEucUApvXw==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr11466614wrs.275.1644846400191;
        Mon, 14 Feb 2022 05:46:40 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b15sm25416656wri.96.2022.02.14.05.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:46:39 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:46:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] mfd: stmfx: Improve error message triggered by regulator
 fault in .remove()
Message-ID: <YgpdPTDurgsvR9mk@google.com>
References: <20220207081709.27288-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207081709.27288-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022, Uwe Kleine-König wrote:

> Returning a non-zero value in an i2c remove callback results in the i2c
> core emitting a very generic error message ("remove failed (-ESOMETHING),
> will be ignored") and as the message indicates not further error handling
> is done.
> 
> Instead emit a more specific error message and then return zero in
> .remove().
> 
> The long-term goal is to make the i2c remove prototype return void, making
> all implementations return 0 is preparatory work for this change.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/stmfx.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
> index e095a3930142..16631c675f2f 100644
> --- a/drivers/mfd/stmfx.c
> +++ b/drivers/mfd/stmfx.c
> @@ -392,17 +392,21 @@ static int stmfx_chip_init(struct i2c_client *client)
>  	return ret;
>  }
>  
> -static int stmfx_chip_exit(struct i2c_client *client)
> +static void stmfx_chip_exit(struct i2c_client *client)
>  {
>  	struct stmfx *stmfx = i2c_get_clientdata(client);
>  
>  	regmap_write(stmfx->map, STMFX_REG_IRQ_SRC_EN, 0);
>  	regmap_write(stmfx->map, STMFX_REG_SYS_CTRL, 0);
>  
> -	if (stmfx->vdd)
> -		return regulator_disable(stmfx->vdd);
> +	if (stmfx->vdd) {
> +		int ret = regulator_disable(stmfx->vdd);
>  
> -	return 0;
> +		if (ret)

Nit: Premise of the patch is fine, but please can you use the standard
function call, check the return value format please.  Something about
this is triggering my OCD! :)

     	int ret;

	ret = regulator_disable(stmfx->vdd);
	if (ret)
		do_thing();

> +			dev_err(&client->dev,
> +				"Failed to disable vdd regulator: %pe\n",
> +				ERR_PTR(ret));
> +	}
>  }
>  
>  static int stmfx_probe(struct i2c_client *client,
> @@ -466,7 +470,9 @@ static int stmfx_remove(struct i2c_client *client)
>  {
>  	stmfx_irq_exit(client);
>  
> -	return stmfx_chip_exit(client);
> +	stmfx_chip_exit(client);
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> 
> base-commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
