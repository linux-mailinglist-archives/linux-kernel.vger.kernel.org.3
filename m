Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C3560B78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiF2VPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiF2VP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:15:28 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E920E3EA80;
        Wed, 29 Jun 2022 14:15:27 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-317741c86fdso160920067b3.2;
        Wed, 29 Jun 2022 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQm/Y0pRhZo0EQ3hGxGXsSwZ7m4Ckh1ldpjFHGlQngM=;
        b=RKGKxa+RvT3LNthm+jbo2945D36VjmFCeZDQz7wa+r3im7uo76EeA1vonXqshC9wEZ
         ts05NmsnVEfq1AvDJX2gydJgnHhyjACZ2w+UB0YrLg6v0WiayzT071jUSP8KdP29mHGf
         tt/jpfr5yCP0Zq/TIUwm+V2UE5In4HUir4zwCN7M6lmuSjqgYqAJZOa0Acouu5QwNAYM
         wZ+NCoK9G1a+QQgyM+P0LpmEYZO8xJ+QDUq+LZp8Y0VRCwPg5ZKlfybI1KrjduRBYqCz
         x840nHc2PsKPUvB4+h5X0hwVwlbgjwgXwL+BfI4gQkf5zInEnEIWJX79657jUjA5ytcO
         oMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQm/Y0pRhZo0EQ3hGxGXsSwZ7m4Ckh1ldpjFHGlQngM=;
        b=UgCa17LNlKU19R6QlL8JNl5gtax2X9Jjqkt1MF3LhTtFpFtVTLxxI8WT5YJLM+QxaJ
         os8AZA52b11Y1GHJ6oMd9Zf79VBXUt1ZWRYj7xeFev3l1GYg6aoz0KDOYQ0SGYAc4nKZ
         tVqnl3BPzgtvVyBTDykYV6aiTJI/xQNfcMOFZ3nVF+Xaq4zrVX60r2WPhxtlOzDCnt1q
         DME8Hv0vUQWP/L58BwDa+1UdDVqssI2MGcz5hgZuTJA+rwJZx5+nZ9kHa2Kz2dmLX21/
         odB0n1K6bMf0/uyKpmb173e8BeELJYp0loiCn21hlR1VUCB0orrRDAGG2JfBy3NAyVTc
         A2zA==
X-Gm-Message-State: AJIora/GfpqmL7sfjFIwGm8j+2sRfLX3d/xmteBqXyEsbXzhxNix8sVu
        64+onibjOOASqYpuy9nqdvwm29uhu7Hu6hxJtfY=
X-Google-Smtp-Source: AGRyM1vjTl+ZTBxNHWU7Y+SKVUM+7l7LoPrU/pxB0LB56DuBzTjfBNb4B6t6o1yh5uYgXRiLqzSki4Kio/rVHJpTbdI=
X-Received: by 2002:a81:6fd7:0:b0:317:964a:c7a4 with SMTP id
 k206-20020a816fd7000000b00317964ac7a4mr6476899ywc.131.1656537327032; Wed, 29
 Jun 2022 14:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 23:14:49 +0200
Message-ID: <CAHp75Vc=PWXauEKDNX+vmqv=oO1LDv8-GgU3OFZXjf8yJrG8wA@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for AXP192 PMIC
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

On Wed, Jun 29, 2022 at 4:29 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Changes in v4:
>
> * Drop regmap-irq patches and rebase on top of the regmap-irq
>   refactoring series[1], which implements the same functionality.
> * Reorder mfd_cells, putting one-line entries at the bottom.
> * Fix incorrect example in axp192-gpio device tree bindings.
> * Perform adc_en2 flag -> adc_en2_mask conversion in axp20x_adc
>   as a separate patch.
> * Simplify axp192_usb_power_set_current_max().
> * Drop unneeded OF dependency in pin control driver, and document
>   tables used for describing register layouts.
> * Various style fixups suggested by Andy Shevchenko.


For patches 6-11
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> [1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
>
> Changes in v3:
>
> * Update pinctrl driver to address Andy Shevchenko's review comments
>   from v1, and fix a few other issues.
> * Add gpio-ranges property and example snippet to gpio DT bindings.
> * Update commit message of patch 01/16 to point out that all register
>   addresses are obtained using sub_irq_reg().
> * Document ccc_table in axp20x_battery. Also update commit message to
>   note a small fix that is part of that patch.
> * Drop axp20x_adc consolidation patch in favor of using separate adc_raw
>   functions. It's a minor code size optimization that may not be worth
>   the effort due to implementation complexity.
> * Use the FIELD_GET macro in axp20x_adc to further clarify intent.
> * Fix a typo in the regulator driver where an AXP20X regulator ID was
>   mistakenly used instead of an AXP192 regulator ID. Also carry over
>   an Acked-by: tag from v1. Hope that's okay.
> * Accumulate Acked-by: tags from v1 on DT patches.
> * Accumulate Acked-by: tags from v2.
>
> Note that regmap maintainer Mark Brown has said the first two patches to
> regmap-irq aren't suitable for inclusion into the kernel in their current
> state. I'm including them for v3 so the series remains testable.
>
> Changes in v2:
>
> * Do a little cleanup of axp20x_adc suggested by Jonathan Cameron
> * Consolidate ADC read functions in axp20x_adc
> * Drop the axp192's read_label callback in axp20x_adc
> * Clean up the axp192-gpio dt bindings
> * Rewrite a problematic bit of code in axp20x_usb_power reported
>   by kernel test robot
> * Support AXP192 in axp20x_battery
> * Split up regmap-irq changes to two separate patches
>
> Cover letter from v1:
>
> Hi all,
>
> This patch series adds support for the X-Powers AXP192 PMIC to the
> AXP20x driver framework.
>
> The first patch is a small change to regmap-irq to support the AXP192's
> unusual IRQ register layout. It isn't possible to include all of the
> IRQ registers in one regmap-irq chip without this.
>
> The rest of the changes are pretty straightforward, I think the only
> notable parts are the axp20x_adc driver where there seems to be some
> opportunities for code reuse (the axp192 is nearly a duplicate of the
> axp20x) and the addition of a new pinctrl driver for the axp192, since
> the axp20x pinctrl driver was not very easy to adapt.
>
> Aidan MacDonald (15):
>   dt-bindings: mfd: add bindings for AXP192 MFD device
>   dt-bindings: iio: adc: axp209: Add AXP192 compatible
>   dt-bindings: power: supply: axp20x: Add AXP192 compatible
>   dt-bindings: gpio: Add AXP192 GPIO bindings
>   dt-bindings: power: axp20x-battery: Add AXP192 compatible
>   mfd: axp20x: Add support for AXP192
>   regulator: axp20x: Add support for AXP192
>   iio: adc: axp20x_adc: Minor code cleanups
>   iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
>   iio: adc: axp20x_adc: Add support for AXP192
>   power: supply: axp20x_usb_power: Add support for AXP192
>   pinctrl: Add AXP192 pin control driver
>   power: axp20x_battery: Add constant charge current table
>   power: axp20x_battery: Support battery status without fuel gauge
>   power: axp20x_battery: Add support for AXP192
>
>  .../bindings/gpio/x-powers,axp192-gpio.yaml   |  68 ++
>  .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
>  .../bindings/mfd/x-powers,axp152.yaml         |   1 +
>  .../x-powers,axp20x-battery-power-supply.yaml |   1 +
>  .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
>  drivers/iio/adc/axp20x_adc.c                  | 356 +++++++++--
>  drivers/mfd/axp20x-i2c.c                      |   2 +
>  drivers/mfd/axp20x.c                          | 152 +++++
>  drivers/pinctrl/Kconfig                       |  13 +
>  drivers/pinctrl/Makefile                      |   1 +
>  drivers/pinctrl/pinctrl-axp192.c              | 598 ++++++++++++++++++
>  drivers/power/supply/axp20x_battery.c         | 142 ++++-
>  drivers/power/supply/axp20x_usb_power.c       |  84 ++-
>  drivers/regulator/axp20x-regulator.c          | 100 ++-
>  include/linux/mfd/axp20x.h                    |  84 +++
>  15 files changed, 1547 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>  create mode 100644 drivers/pinctrl/pinctrl-axp192.c
>
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
