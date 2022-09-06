Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131CD5AE3D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiIFJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbiIFJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:07:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3629C4C63E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:07:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b5so14421288wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=mPKulpM1VmePhCn9NGeORJeSVx0ds/dPcNDxI2woRLQ=;
        b=OnHReX1D+oWmtqnZ/eFIfyCAVGEYKicV1nUmVMnE1mq0ZW5TQo+VrwL3LMDXAnzThh
         PgsTdHm9zm/bb7llMOIcm0mtien4mSyFLB5tYIzK6YkwWNWKz7yEGvSfRHugyPOMfBXV
         Rwt8GR7JXHfGD3sqSn1ZU/Jn8vmyWiZEuJdxBodcD2mq1gkeGnw3bq7R90r7KJvGbj08
         G2frli139Xk75iDvNHb6a6pm+sC6JCwwFXCyWKaVwkIgtHVobIBV3C/z6b2TQNWvyEtm
         8KxxsliBUqVXyyuGmSxUjgtz7uKO2Uhgy3fQKEvUPxq8Gi00lSsB9rwqR4TvDGO3caCt
         8/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=mPKulpM1VmePhCn9NGeORJeSVx0ds/dPcNDxI2woRLQ=;
        b=cnzggNne3zaNsP45fk65dNj9xGF41PeUr+haIA3BejUj6dVVk7zrSsh/A1G4yoC+gE
         kbYrooS9yN6RcDpKdLUiizxatCxnpDlXKsCbBZvkjFAWaj8rNLq/zXzgqmcdTM0FxDWV
         13wtdGkxNRPcuZ/azljY0hG3sT0T+zxod7T8qpWc0wAE8GuboyNgcKnUc+UOnkAkt0MS
         QUKLRyHRorHjCd+MKKFMuwiYngOVw3tsyhgNezhpdteeWvzaXKOUm5gP0ZDiIYdqR0FZ
         EM0jzJ0XsVSTEQfLf1fAVinaZ0twzY33EAm6F29vgGbqx+ZVjl8IPzJHUs9c3WUUaN17
         o2WA==
X-Gm-Message-State: ACgBeo2VsI+CKRBFs/cTKSmmn8lKZADtHMTECz46wPVsj+UwJbAbimYs
        i0z8fzmx+DktvjaxYFZmUJA1AA==
X-Google-Smtp-Source: AA6agR5YFhKwTFveLQ1zRnD0V87OI95Pez8WScCVXHUXaL7rQSxXDThAljQ2vlZ/LsGOpe9j9yPxfA==
X-Received: by 2002:a05:6000:1f83:b0:228:6278:796b with SMTP id bw3-20020a0560001f8300b002286278796bmr7167060wrb.520.1662455228586;
        Tue, 06 Sep 2022 02:07:08 -0700 (PDT)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c1c9b00b003a845fa1edfsm33016456wms.3.2022.09.06.02.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 02:07:08 -0700 (PDT)
Message-ID: <b0d45e18-c92d-d187-2eac-851d975fbb7e@baylibre.com>
Date:   Tue, 6 Sep 2022 11:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] pinctrl: meson: Switch to use fwnode instead of
 of_node
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220905180034.73132-1-andriy.shevchenko@linux.intel.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220905180034.73132-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 20:00, Andy Shevchenko wrote:
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/pinctrl/meson/pinctrl-meson.c | 7 +++----
>   drivers/pinctrl/meson/pinctrl-meson.h | 4 +++-
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index cc2cd73ff8f9..530f3f934e19 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -608,6 +608,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
>   
>   	pc->chip.label = pc->data->name;
>   	pc->chip.parent = pc->dev;
> +	pc->chip.fwnode = pc->fwnode;
>   	pc->chip.request = gpiochip_generic_request;
>   	pc->chip.free = gpiochip_generic_free;
>   	pc->chip.set_config = gpiochip_generic_config;
> @@ -619,8 +620,6 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
>   	pc->chip.base = -1;
>   	pc->chip.ngpio = pc->data->num_pins;
>   	pc->chip.can_sleep = false;
> -	pc->chip.of_node = pc->of_node;
> -	pc->chip.of_gpio_n_cells = 2;
>   
>   	ret = gpiochip_add_data(&pc->chip, pc);
>   	if (ret) {
> @@ -678,8 +677,8 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc)
>   		return -EINVAL;
>   	}
>   
> -	gpio_np = to_of_node(gpiochip_node_get_first(pc->dev));
> -	pc->of_node = gpio_np;
> +	pc->fwnode = gpiochip_node_get_first(pc->dev);
> +	gpio_np = to_of_node(pc->fwnode);
>   
>   	pc->reg_mux = meson_map_resource(pc, gpio_np, "mux");
>   	if (IS_ERR_OR_NULL(pc->reg_mux)) {
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
> index b197827027bd..34fc4e8612e4 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.h
> +++ b/drivers/pinctrl/meson/pinctrl-meson.h
> @@ -12,6 +12,8 @@
>   #include <linux/types.h>
>   #include <linux/module.h>
>   
> +struct fwnode_handle;
> +
>   struct meson_pinctrl;
>   
>   /**
> @@ -131,7 +133,7 @@ struct meson_pinctrl {
>   	struct regmap *reg_gpio;
>   	struct regmap *reg_ds;
>   	struct gpio_chip chip;
> -	struct device_node *of_node;
> +	struct fwnode_handle *fwnode;
>   };
>   
>   #define FUNCTION(fn)							\

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
