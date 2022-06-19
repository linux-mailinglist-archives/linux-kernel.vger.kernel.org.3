Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA3550831
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiFSD5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSD5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:57:10 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76911C01;
        Sat, 18 Jun 2022 20:57:09 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id d39so7594267vsv.7;
        Sat, 18 Jun 2022 20:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=GbS9TDOHV4jf2htfhwIeIm8TpA0asWaDoPdyofcHL38=;
        b=N7ZoypqMi1X63sj47YYzSqMlx18uwKWNrZZKoTFBfrqRA5Z8n9VIm+O+bB7WyRBzy9
         ZbsS6jtzS6hufj6HZIUvgiseKETZSjywPqOsInvgF38FvnlsTdhUiWLaMZDDuKS2xAyg
         Z81u0R+yDvsKCxkjdOKDKotE9B9No6gJgVYjqicBV+pqBUzMkFD/EUdNRQlRmuWuoSyX
         8q1SSHpTGTzRkftVSxPDe01aX4+HiLqeCPVsVqvBuIOycWjdWA/GlmAvWyWzq+GpKR5e
         +f5rIQkUkFD87nnCiVIoIswT41JVmtsbml89P8Q1vUW+VRyqDVOOxp0F7ZjSWIMN/sDp
         XEew==
X-Gm-Message-State: AJIora8Gn/TdOPDm2AWbY9+4m2P7qb+bnIJ4Wn1slinwrUNGUrUJ3OyZ
        6Qnf7hUs/9iiMFnIWoKH9SPdmYOmOvSTcg==
X-Google-Smtp-Source: AGRyM1uSfh6aSI/zfFzk668qTBuf6A1RkVJ3RCGLtrFnuGhW+BYOq1ahRenUh+Jg1zsvvrZ3yPWFbg==
X-Received: by 2002:a05:6102:32c8:b0:34c:2358:1824 with SMTP id o8-20020a05610232c800b0034c23581824mr8083413vss.65.1655611028583;
        Sat, 18 Jun 2022 20:57:08 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id k26-20020ab0715a000000b0037f029bcf0bsm809913uao.21.2022.06.18.20.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 20:57:08 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id r15so2852271uaf.13;
        Sat, 18 Jun 2022 20:57:08 -0700 (PDT)
X-Received: by 2002:a9f:37a2:0:b0:379:2023:a630 with SMTP id
 q31-20020a9f37a2000000b003792023a630mr6647474uaq.73.1655611028267; Sat, 18
 Jun 2022 20:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-11-aidanmacdonald.0x0@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 19 Jun 2022 11:56:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PLTcy53zjHA83qAaNq4y-Mmxfv4xvSuwqRLGBiwgjDQ@mail.gmail.com>
Message-ID: <CAGb2v65PLTcy53zjHA83qAaNq4y-Mmxfv4xvSuwqRLGBiwgjDQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] iio: adc: axp20x_adc: Minor code cleanups
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, michael@walle.cc,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 5:40 AM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The code may be clearer if parameters are not re-purposed to hold
> temporary results like register values, so introduce local variables
> as necessary to avoid that. Also, use the common FIELD_PREP macro
> instead of a hand-rolled version.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 53bf7d4899d2..041511280e1e 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -15,6 +15,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> +#include <linux/bitfield.h>

Sort this group of headers alphabetically please.

>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
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

Please also mention "grouping macros based on chip type" in the commit log.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
