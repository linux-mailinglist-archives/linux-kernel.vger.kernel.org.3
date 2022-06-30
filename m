Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F105613F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiF3H7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiF3H7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:59:09 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A1C41319;
        Thu, 30 Jun 2022 00:59:07 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-317a66d62dfso171009787b3.7;
        Thu, 30 Jun 2022 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wzp+0Ca5DBgGqXHIatlXSPmTeEJ8VcvhTsReClfiz3I=;
        b=fcJRnvlrEwLctduY40xOq44ATbs8o33Boc/pFvwq9Vzv/x0aI/7eBELkUaUY2YrHpa
         cD9Gls4dh+70scT6EfgRKk9W9/FqbotPrdFRerYOzfp4AifNhx/dG3qZBjiIbWgNQOK7
         kXwO9U7pp8/yuOuhuPXUADjZWkc6/3UzcWgOvYGTNrmhJ0NhEuAmhyyKnUyr+T+iIwuM
         +e/YDBNUTquCR1TvLkQNbUIl97Q+A8UrVkJ0NoSrpE8XijNpJ6y397TMl0PqrWzZc/cA
         mfwJQbHS5JPVGggYYlDHwLCggCfyTnJwgOV+LZ+HLY6JEhOQTy4/6NI41kOzBzGzCNhx
         1+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wzp+0Ca5DBgGqXHIatlXSPmTeEJ8VcvhTsReClfiz3I=;
        b=OfA0OldPPRS1gTmg3T84DnxrcKh4F6jqG5Q5cSGggfRv8CI1+XOoZP+796BFkdO/oJ
         C2pIO7jl2puigacGmpk/nTpHzw+RK/llA4br0sIqQGfBFnxp5FmfSdi5mOAmVnzXu0Ba
         Z4K+InQ4b176FKDV7i54ld6//iZFFrKyrHn0vahzyNLYP6MCbrqbK52Ym76MeAuE9a7S
         Wp6bFvm9ytWckvYg0eCpe563Q9/5TdIUWJBd+XeLlrYb5ECLFy1kCmTJicic1erUaI2R
         7u9ELfMDfDEfFt2IDOH0ISuON0vPY4H8S9XybiOVn0prYswdT9y/NB+Qan7blxRhNX0U
         N2PQ==
X-Gm-Message-State: AJIora9vNl1hhn7RAZvE4YMsEPuTYq6h4C9cEL/bBMmT87iVFD6Odpx3
        9QB/ZrUDJq+nPnv9chz4KdILAmzDNRfq3QlEyf4=
X-Google-Smtp-Source: AGRyM1uW1tm4RgeNJdIpXjCO46GUp0F/56c9Nd32bamzq8p05fH4mWEnaDtnFVe/pVck0EFdNmmSic7VvYWEYfXw4lw=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr8814171ywj.195.1656575946260; Thu, 30
 Jun 2022 00:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-9-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:58:26 +0200
Message-ID: <CAHp75VfFSOp1eNVOwoW4S6Z84aR52uoGuSty_Dgbs97+h5sdrg@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] iio: adc: axp20x_adc: Minor code cleanups
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The code may be clearer if parameters are not re-purposed to hold
> temporary results like register values, so introduce local variables
> as necessary to avoid that. Regroup macros based on chip type, and
> use the FIELD_PREP() macro instead of a hand-rolled version.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 53bf7d4899d2..ab25e6e1ff65 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -5,6 +5,7 @@
>   *     Quentin Schulz <quentin.schulz@free-electrons.com>
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -22,20 +23,20 @@
>  #include <linux/mfd/axp20x.h>
>
>  #define AXP20X_ADC_EN1_MASK                    GENMASK(7, 0)
> -
>  #define AXP20X_ADC_EN2_MASK                    (GENMASK(3, 2) | BIT(7))
> +
>  #define AXP22X_ADC_EN1_MASK                    (GENMASK(7, 5) | BIT(0))
>
>  #define AXP20X_GPIO10_IN_RANGE_GPIO0           BIT(0)
>  #define AXP20X_GPIO10_IN_RANGE_GPIO1           BIT(1)
> -#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)    ((x) & BIT(0))
> -#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)    (((x) & BIT(0)) << 1)
>
>  #define AXP20X_ADC_RATE_MASK                   GENMASK(7, 6)
> -#define AXP813_V_I_ADC_RATE_MASK               GENMASK(5, 4)
> -#define AXP813_ADC_RATE_MASK                   (AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>  #define AXP20X_ADC_RATE_HZ(x)                  ((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
> +
>  #define AXP22X_ADC_RATE_HZ(x)                  ((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
> +
> +#define AXP813_V_I_ADC_RATE_MASK               GENMASK(5, 4)
> +#define AXP813_ADC_RATE_MASK                   (AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>  #define AXP813_TS_GPIO0_ADC_RATE_HZ(x)         AXP20X_ADC_RATE_HZ(x)
>  #define AXP813_V_I_ADC_RATE_HZ(x)              ((ilog2((x) / 100) << 4) & AXP813_V_I_ADC_RATE_MASK)
>  #define AXP813_ADC_RATE_HZ(x)                  (AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_ADC_RATE_HZ(x))
> @@ -234,7 +235,7 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>                           struct iio_chan_spec const *chan, int *val)
>  {
>         struct axp20x_adc_iio *info = iio_priv(indio_dev);
> -       int size = 12;
> +       int ret, size;
>
>         /*
>          * N.B.:  Unlike the Chinese datasheets tell, the charging current is
> @@ -246,10 +247,11 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>         else
>                 size = 12;
>
> -       *val = axp20x_read_variable_width(info->regmap, chan->address, size);
> -       if (*val < 0)
> -               return *val;
> +       ret = axp20x_read_variable_width(info->regmap, chan->address, size);
> +       if (ret < 0)
> +               return ret;
>
> +       *val = ret;
>         return IIO_VAL_INT;
>  }
>
> @@ -257,11 +259,13 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
>                           struct iio_chan_spec const *chan, int *val)
>  {
>         struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +       int ret;
>
> -       *val = axp20x_read_variable_width(info->regmap, chan->address, 12);
> -       if (*val < 0)
> -               return *val;
> +       ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
> +       if (ret < 0)
> +               return ret;
>
> +       *val = ret;
>         return IIO_VAL_INT;
>  }
>
> @@ -269,11 +273,13 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
>                           struct iio_chan_spec const *chan, int *val)
>  {
>         struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +       int ret;
>
> -       *val = axp20x_read_variable_width(info->regmap, chan->address, 12);
> -       if (*val < 0)
> -               return *val;
> +       ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
> +       if (ret < 0)
> +               return ret;
>
> +       *val = ret;
>         return IIO_VAL_INT;
>  }
>
> @@ -443,27 +449,27 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>                                      int *val)
>  {
>         struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +       unsigned int regval;
>         int ret;
>
> -       ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, val);
> +       ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, &regval);
>         if (ret < 0)
>                 return ret;
>
>         switch (channel) {
>         case AXP20X_GPIO0_V:
> -               *val &= AXP20X_GPIO10_IN_RANGE_GPIO0;
> +               regval = FIELD_GET(AXP20X_GPIO10_IN_RANGE_GPIO0, regval);
>                 break;
>
>         case AXP20X_GPIO1_V:
> -               *val &= AXP20X_GPIO10_IN_RANGE_GPIO1;
> +               regval = FIELD_GET(AXP20X_GPIO10_IN_RANGE_GPIO1, regval);
>                 break;
>
>         default:
>                 return -EINVAL;
>         }
>
> -       *val = *val ? 700000 : 0;
> -
> +       *val = regval ? 700000 : 0;
>         return IIO_VAL_INT;
>  }
>
> @@ -548,7 +554,7 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>                             long mask)
>  {
>         struct axp20x_adc_iio *info = iio_priv(indio_dev);
> -       unsigned int reg, regval;
> +       unsigned int regmask, regval;
>
>         /*
>          * The AXP20X PMIC allows the user to choose between 0V and 0.7V offsets
> @@ -560,25 +566,22 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>         if (val != 0 && val != 700000)
>                 return -EINVAL;
>
> -       val = val ? 1 : 0;
> -
>         switch (chan->channel) {
>         case AXP20X_GPIO0_V:
> -               reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
> -               regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
> +               regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
> +               regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, !!val);
>                 break;
>
>         case AXP20X_GPIO1_V:
> -               reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
> -               regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
> +               regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
> +               regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, !!val);
>                 break;
>
>         default:
>                 return -EINVAL;
>         }
>
> -       return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, reg,
> -                                 regval);
> +       return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
>  }
>
>  static const struct iio_info axp20x_adc_iio_info = {
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
