Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6E4EAD24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiC2MbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiC2MbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:31:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8438751E63
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:29:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m30so24595883wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JWAxhkpD2i8UZ8j248lkUJk4oN/7cNs/WUDnK2ILLuA=;
        b=GXvbOt7cHYG+zEcO53/N0pAGW4E6Xl+/x6z8j5FHdbaoRxQOml+aT8B7lfjtZDLDui
         A/AoLBLJRQq07raSX00sgQ2CsnEcSVC84nB88L8RHknLhGnBmoSHcYDjTY3WRgStgsgG
         7J3Q5gETTjx0A6/QY1WSynU7lnhuDecPZcXuP5MXNu0h847ctq1I0oqN1+tua6wWIw71
         0trbdunuN57IRr4bDy7d6h5MqwDacimQr8DiODsFuAN1AtPJet0vWJbzHqCb7k7SdcmJ
         DvUvwp03o2m/oD1pGx+YU65rt+A7TpHp0yiKvac1jsO9r9b9mb5Xf1tf4VZFMfVlrDd6
         df2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JWAxhkpD2i8UZ8j248lkUJk4oN/7cNs/WUDnK2ILLuA=;
        b=yiru0cLazpGOwEE2FkRKzF+eTdd6O8y8ODbnKZIXgfUhuOZrYn6bXpyH23/xh9HiP4
         bELOwLkpnzjcikygSOKRAJTiH1KlSOM5e3u4QJ6KpKkMh69GlnnktVaSheh/R6tk5bVE
         nm072mnwS5WsO5ev87F+chIiicRCUlCIMkUE1gQOdQsOx4jLE2tYT4myD/oBnJOn9PYY
         vifRJtTGW/sbmqBCQD3b4xCKyPrvY4yAhrj/SVLZ5N9uqH52WCW0XPOb3rQupNtRdtAm
         DOs1uvF6o4ickSINeNFyL5mNJ05iwBcx4kWjGORg3IAnQCZFuH3kqP1w9zbnuGG2TXQZ
         4YoA==
X-Gm-Message-State: AOAM530FYEwKJM/E7S24Ri0KRXoYFKhhEHJtKk3+j/rvdvOD+MIJVLLP
        r7XmN8up+IoSWxjIEfM/Q0GvJA==
X-Google-Smtp-Source: ABdhPJxkcUlDSsFDn76pfiNwEFTu8HNkSQvKzGIgeEr33H8pn3eGua5djb1jxK+d7MFlXjOAHbcZlw==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr30848053wrf.315.1648556962971;
        Tue, 29 Mar 2022 05:29:22 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:a663:978b:3ffb:7dc3? ([2001:861:44c0:66c0:a663:978b:3ffb:7dc3])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm2195017wms.25.2022.03.29.05.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:29:22 -0700 (PDT)
Message-ID: <3697fe0f-7b6b-764f-8cdb-d925c0944fb0@baylibre.com>
Date:   Tue, 29 Mar 2022 14:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 4/5] pinctrl: meson: Replace custom code by
 gpiochip_count() call
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
 <20220325200338.54270-4-andriy.shevchenko@linux.intel.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220325200338.54270-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 21:03, Andy Shevchenko wrote:
> Since we have generic function to count GPIO controller nodes
> under given device, there is no need to open code it. Replace
> custom code by gpiochip_count() call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/pinctrl/meson/pinctrl-meson.c | 28 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 49851444a6e3..7db70d4e214a 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -49,6 +49,7 @@
>   #include <linux/pinctrl/pinctrl.h>
>   #include <linux/pinctrl/pinmux.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/regmap.h>
>   #include <linux/seq_file.h>
>   
> @@ -662,27 +663,22 @@ static struct regmap *meson_map_resource(struct meson_pinctrl *pc,
>   	return devm_regmap_init_mmio(pc->dev, base, &meson_regmap_config);
>   }
>   
> -static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
> -				  struct device_node *node)
> +static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc)
>   {
> -	struct device_node *np, *gpio_np = NULL;
> +	struct device_node *gpio_np;
> +	unsigned int chips;
>   
> -	for_each_child_of_node(node, np) {
> -		if (!of_find_property(np, "gpio-controller", NULL))
> -			continue;
> -		if (gpio_np) {
> -			dev_err(pc->dev, "multiple gpio nodes\n");
> -			of_node_put(np);
> -			return -EINVAL;
> -		}
> -		gpio_np = np;
> -	}
> -
> -	if (!gpio_np) {
> +	chips = gpiochip_count(pc->dev);
> +	if (!chips) {
>   		dev_err(pc->dev, "no gpio node found\n");
>   		return -EINVAL;
>   	}
> +	if (chips > 1) {
> +		dev_err(pc->dev, "multiple gpio nodes\n");
> +		return -EINVAL;
> +	}
>   
> +	gpio_np = to_of_node(device_get_named_child_node(pc->dev, "gpio-controller"));
>   	pc->of_node = gpio_np;
>   
>   	pc->reg_mux = meson_map_resource(pc, gpio_np, "mux");
> @@ -751,7 +747,7 @@ int meson_pinctrl_probe(struct platform_device *pdev)
>   	pc->dev = dev;
>   	pc->data = (struct meson_pinctrl_data *) of_device_get_match_data(dev);
>   
> -	ret = meson_pinctrl_parse_dt(pc, dev->of_node);
> +	ret = meson_pinctrl_parse_dt(pc);
>   	if (ret)
>   		return ret;
>   

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
