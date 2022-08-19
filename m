Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9211959A697
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351504AbiHSTgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHSTgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:36:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67ADC2FA5;
        Fri, 19 Aug 2022 12:36:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso8451469pjl.1;
        Fri, 19 Aug 2022 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=RGQInboxZApXDt02Ut7F/gX7q5m4BMuZBtDGjZ3GBqg=;
        b=XoY5HbkeUs1Z1cPPS5VrIn5lnw/qF0mSlhb0qSo9SZmJWyoHoAnIRivwFzRbIB+C38
         jSuiNJWcQtO5a2AMEQ1sfy1IH61nyB1Fb+ygSDdJqHVd/DMbifRohEGhX/lTZQjaIyfh
         srToJBrF/XTDMelu/Ym0YYGRHidpJyxgFNtR3fOS7EjKnq1vWbg7qsruh3xr0LDpE1W1
         aI3C8BB2xJD74jJdKGS+b7MHD+bnoTM1p3tGJzQcODpXDOiiCuCVkwnwMOqnwpXlDufZ
         nbod4lfG3yelvnz/as6gcoOwB8OKCocV1THadfnXf3iChwGGvRgWf4FgJJ4u9/Srqqcp
         TRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=RGQInboxZApXDt02Ut7F/gX7q5m4BMuZBtDGjZ3GBqg=;
        b=rhHNTmuouZYBDstglRypSxEuXFdss4UwbLsmHzjp2VZ8Q4C5nU0nNEY2Kk8FN3Wvo0
         fzX+p0RV1kbDzXjjK8zH3gGS42+V7nirREzSl4tafwK+XvYTB9O94X4NqigfcSBjWqDJ
         dwG9Sv/hPF2GTWoypQizSM4Z5HLTuv/JXRLuQ+rHajUp+bUbl4vHOF+znVKzkzIWX3p5
         gwXGBA2Ml1DlokMxLV3Wg0W6dUlxQQ5m/U29UYhEMp5QAFeM5VIZ8oDQW61S+bHobw6a
         c0QQzlNArZgnnFCk21oA+mL4xKsm0/ULRRwnNYd4eZhhNGRVdjdO5QFhAI1wQfLbOcE6
         DR2A==
X-Gm-Message-State: ACgBeo3cV/BZjrzdKJ/3xIGSEAPyedm/Qrq9+i+SkZItV6ycYvhzMe3l
        ifrvPtPhaNPDnzcO6JcDNNXOD1tGyQI=
X-Google-Smtp-Source: AA6agR5sX008bzvMYeo8Dw+0EFf5/eaf5A4G1UPYTAB1q7yU+974jWXMyulUjO2f9YDipA6hId+AwQ==
X-Received: by 2002:a17:903:120d:b0:171:4fa0:7b4a with SMTP id l13-20020a170903120d00b001714fa07b4amr8662135plh.45.1660937796270;
        Fri, 19 Aug 2022 12:36:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k63-20020a17090a4cc500b001facb7bc1adsm3420475pjh.26.2022.08.19.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:36:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 12:36:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/14] hwmon: adm1177: simplify using
 devm_regulator_get_enable()
Message-ID: <20220819193633.GA3150608@roeck-us.net>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <718e4ea3a54c036dcb59ff55c338e253735e516b.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718e4ea3a54c036dcb59ff55c338e253735e516b.1660934107.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:18:46PM +0300, Matti Vaittinen wrote:
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable() and drop the pointer to the regulator.
> This simplifies code and makes it less tempting to add manual control
> for the regulator which is also controlled by devm.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> v2 => v3:
> New patch
> ---
>  drivers/hwmon/adm1177.c | 27 +++------------------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
> index 0c5dbc5e33b4..be17a26a84f1 100644
> --- a/drivers/hwmon/adm1177.c
> +++ b/drivers/hwmon/adm1177.c
> @@ -26,14 +26,12 @@
>  /**
>   * struct adm1177_state - driver instance specific data
>   * @client:		pointer to i2c client
> - * @reg:		regulator info for the power supply of the device
>   * @r_sense_uohm:	current sense resistor value
>   * @alert_threshold_ua:	current limit for shutdown
>   * @vrange_high:	internal voltage divider
>   */
>  struct adm1177_state {
>  	struct i2c_client	*client;
> -	struct regulator	*reg;
>  	u32			r_sense_uohm;
>  	u32			alert_threshold_ua;
>  	bool			vrange_high;
> @@ -189,13 +187,6 @@ static const struct hwmon_chip_info adm1177_chip_info = {
>  	.info = adm1177_info,
>  };
>  
> -static void adm1177_remove(void *data)
> -{
> -	struct adm1177_state *st = data;
> -
> -	regulator_disable(st->reg);
> -}
> -
>  static int adm1177_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -210,21 +201,9 @@ static int adm1177_probe(struct i2c_client *client)
>  
>  	st->client = client;
>  
> -	st->reg = devm_regulator_get_optional(&client->dev, "vref");
> -	if (IS_ERR(st->reg)) {
> -		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		st->reg = NULL;
> -	} else {
> -		ret = regulator_enable(st->reg);
> -		if (ret)
> -			return ret;
> -		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
> -					       st);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = devm_regulator_get_enable_optional(&client->dev, "vref");
> +	if (ret == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
>  
>  	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
>  				     &st->r_sense_uohm))
> -- 
> 2.37.1
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 


