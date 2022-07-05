Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C95676B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiGESlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGESlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:41:06 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98141EEF3;
        Tue,  5 Jul 2022 11:41:04 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l144so10906760ybl.5;
        Tue, 05 Jul 2022 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4u67+p/Nu3+Q0UJ56xQ5Fha52WVbpH8uRPOmpE02Jg0=;
        b=ZomR1mTqsYAUCR+qm0cE91Ae68j3xBV+eRW9M0D2y9mEdgyewNovpbU6FESGzMYECM
         NWoENR81zx5vVXPbCBCMvTJrXXQboogAs32sH1djQJ3SM6w8dkmJlSB9wZlmuo6cAiVk
         oB0osK72kK6AxC2dXtC4GqZ4wfdHqNylIEfHQYAj9Plo4M+kSDDdGSe55rTnoL9kmL6e
         QilFL0oLAtnSwEJcJQ9e8T1mbjNFY51zCxcdgPn78jemWH13q8w7IVQvtSKMzIzI1TsK
         eI7wzomJwvVmewUrYvJT4a4LafGdrWT5DpYcTSR47MlUs/n7gtjaZpNM9Rpsxb743oF4
         xtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4u67+p/Nu3+Q0UJ56xQ5Fha52WVbpH8uRPOmpE02Jg0=;
        b=6kM+9tzGIAtyCYhn9TGZ7ie/tGM5hyWLZFVXlvSXG41h/Cencm8pdP43NQUVUpKbYo
         G8y5BFm/hAl8/r+6YDnuKqCw/4A69AcQq3wFHmEI1MIcVnzFTj73QrmDLYU9BS2z0dph
         2C6dSxsfLNHkp6EUZTQ7ThxJFQJGhx5qNzqvDSwDww+lNcpDdS1LC6UGemHYKhrnjM2y
         +0qPhrbjWI66zfr/FG0x1XioF6oPH6QY/Z8bOOeJc+EadYzTronsRJSof36k2k/I+QED
         pdZBvNED2ggUNxVj2iaOiPu1RnWG9NsK4t7zlzSVnMdj6qZPuuvLbt1NGrGmnKk5tpqv
         Gk0g==
X-Gm-Message-State: AJIora+blW6K0hCTku1SUmEi4WX/7L/v0cyg6RLrvDlW67QSsTE9/tsX
        cImP2nBZ6xJVkYeAFixTD3YdfCUvd2mYcp9ifmQgTFbOaxJTLA==
X-Google-Smtp-Source: AGRyM1vinUWGqY837l1rMGUYrfzYflSfCpVTv8YCPklCZHNtdQC9oPLLEhW3f3PeDr1Cv1aFhi/QyKxDNNxbbAhnL9s=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr2692289ybg.460.1657046463689; Tue, 05
 Jul 2022 11:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220705000448.14337-1-pali@kernel.org> <20220705155929.25565-1-pali@kernel.org>
 <20220705155929.25565-2-pali@kernel.org>
In-Reply-To: <20220705155929.25565-2-pali@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 20:40:26 +0200
Message-ID: <CAHp75Vcr6o2rm+T6Tr8sS4VXCLVHtmLPWy-njOKAvO4AcZoW=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: Add support for Turris 1.x LEDs
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 6:11 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This adds support for the RGB LEDs found on the front panel of the
> Turris 1.x routers. There are 8 RGB LEDs that are controlled by
> CZ.NIC CPLD firmware running on Lattice FPGA.
>
> CPLD firmware provides HW triggering mode for all LEDs except WiFi LED
> which is automatically enabled after power on reset. LAN LEDs share HW
> registers for RGB colors settings, so it is not possible to set different
> colors for individual LAN LEDs.
>
> CZ.NIC CPLD firmware is open source and available at:
> https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_C=
PLD.v
>
> This driver uses the multicolor LED framework and HW led triggers.

Pardon me, but this driver seems like 3 years old by the APIs it's
using... I have to say this, because I was surprised a lot to see some
calls.

...

> +config LEDS_TURRIS_1X
> +       tristate "LED support for CZ.NIC's Turris 1.x"
> +       depends on LEDS_CLASS_MULTICOLOR

> +       depends on OF

Why?

If it's a functional (not compile time) dependency, make it

  depends on OF || COMPILE_TEST

> +       select LEDS_TRIGGERS
> +       help
> +         This option enables support for LEDs found on the front side of
> +         CZ.NIC's Turris 1.x routers.

...

> +#include <linux/i2c.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

> +#include <linux/of.h>

Rather property.h. See below how.

...

> +/* LEDs 1-5 share common register for setting brightness */
> +#define TURRIS1X_LED_BRIGHTNESS_OFF(idx)       ({ const u8 _idx =3D (idx=
) & 7; \

Can you start with the GCC expression on a new line? I may give a much
shorter next line and increase readability.

> +                                                  (_idx =3D=3D 0) ? 0 : =
\
> +                                                  (_idx <=3D 5) ? 1 : \
> +                                                  (_idx - 4); })
> +
> +#define TURRIS1X_LED_BRIGHTNESS_REG(idx, color)        TURRIS1X_LED_REG_=
OFF(0x13 + \
> +                                                 3 * TURRIS1X_LED_BRIGHT=
NESS_OFF(idx) + \
> +                                                 ((color) & 3))

Ditto.

...

> +static enum led_brightness turris1x_led_brightness_get(struct led_classd=
ev *cdev)
> +{
> +       struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(cdev);
> +       struct turris1x_leds *leds =3D dev_get_drvdata(cdev->dev->parent)=
;
> +       struct turris1x_led *led =3D to_turris1x_led(mc_cdev);
> +
> +       if (!(readb(leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG) & BIT(led-=
>reg)))
> +               return 1;
> +       else if (!(readb(leds->regs + TURRIS1X_LED_SW_DISABLE_REG) & BIT(=
led->reg)))
> +               return 1;
> +       else

Redundant 'else' in both cases.

> +               return 0;
> +}

...

> +               /*
> +                * LEDs 1-5 (LAN) share common color settings in same set=
s
> +                * of HW registers and therefore it is not possible to se=
t
> +                * different colors. So when chaning color of one LED the=
n

chaining

> +                * reflect color change for all of them.
> +                */

> +               if (led->reg >=3D 1 && led->reg <=3D 5) {

Same is used in the macro above. Maybe you can provide a shortcut for
this instead of duplicating?

> +                       for (j =3D 0; j < ARRAY_SIZE(leds->leds); j++) {

> +                               if (leds->leds[j].reg < 1 ||
> +                                   leds->leds[j].reg > 5 ||

Ditto.

> +                                   leds->leds[j].reg =3D=3D led->reg)
> +                                       continue;
> +                               for (i =3D 0; i < ARRAY_SIZE(led->subled_=
info); i++)
> +                                       leds->leds[j].mc_cdev.subled_info=
[i].intensity =3D
> +                                               mc_cdev->subled_info[i].i=
ntensity;
> +                       }
> +               }
> +       }

...

> +       ret =3D of_property_read_u32(np, "reg", &reg);
> +       if (ret || reg >=3D ARRAY_SIZE(leds->leds)) {
> +               dev_err(dev,
> +                       "Node %pOF: must contain 'reg' property with valu=
es between 0 and %u\n",
> +                       np, (unsigned int)ARRAY_SIZE(leds->leds) - 1);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D of_property_read_u32(np, "color", &color);
> +       if (ret || color !=3D LED_COLOR_ID_RGB) {
> +               dev_err(dev,
> +                       "Node %pOF: must contain 'color' property with va=
lue LED_COLOR_ID_RGB\n",
> +                       np);
> +               return -EINVAL;
> +       }
> +
> +       led =3D &leds->leds[reg];
> +
> +       if (led->registered) {
> +               dev_err(dev, "Node %pOF: duplicate 'reg' property %u\n",
> +                            np, reg);
> +               return -EINVAL;
> +       }

> +       init_data.fwnode =3D &np->fwnode;

Oh, no. We do not dereference fwnode, we have helpers for that.
Moreover, why not use fwnode to begin with?

> +       ret =3D devm_led_classdev_multicolor_register_ext(dev, &led->mc_c=
dev,
> +                                                       &init_data);
> +       if (ret) {
> +               dev_err(dev, "Cannot register LED %pOF: %i\n", np, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}

...

> +static ssize_t brightness_show(struct device *dev, struct device_attribu=
te *a,
> +                              char *buf)
> +{
> +       struct turris1x_leds *leds =3D dev_get_drvdata(dev);
> +       unsigned int brightness;
> +
> +       /*
> +        * Current brightness value is available in read-only register
> +        * TURRIS1X_LED_GET_GLOBAL_BRIGHTNESS_REG. Equivalent code is:
> +        * level =3D readb(leds->regs + TURRIS1X_LED_GLOBAL_LEVEL_REG) & =
7;
> +        * brightness =3D readb(leds->regs + TURRIS1X_LED_GLOBAL_BRIGHTNE=
SS_REG(level));
> +        */
> +       brightness =3D readb(leds->regs + TURRIS1X_LED_GET_GLOBAL_BRIGHTN=
ESS_REG);
> +
> +       return sprintf(buf, "%u\n", brightness);

sysfs_emit()

> +}

...

> +       if (kstrtoul(buf, 10, &brightness))
> +               return -EINVAL;

Why shadow the error code from kstrtoul()? Note it might return
something different.

Do you really need unsigned long? Can't you use u8 and kstrtou8() respectiv=
ely?

> +       if (brightness > 255)
> +               return -EINVAL;

Yeah, read above about u8.

...

> +       /*
> +        * Brightness can be set only to one of 8 predefined value levels
> +        * available in TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(level) registe=
rs.
> +        * Choose level which has nearest value to the specified brightne=
ss.

a level
the nearest

> +        */

...

> +               error =3D abs(value - (int)brightness);

Why casting?!

...

> +static ssize_t brightness_level_show(struct device *dev,
> +                                    struct device_attribute *a, char *bu=
f)
> +{
> +       struct turris1x_leds *leds =3D dev_get_drvdata(dev);
> +       unsigned int level;
> +
> +       level =3D readb(leds->regs + TURRIS1X_LED_GLOBAL_LEVEL_REG) & 7;
> +
> +       return sprintf(buf, "%u\n", level);

sysfs_emit()

> +}

...

> +       if (kstrtoul(buf, 10, &level))
> +               return -EINVAL;

As per above.

...

> +static ssize_t brightness_values_show(struct device *dev,
> +                                     struct device_attribute *a, char *b=
uf)
> +{
> +       struct turris1x_leds *leds =3D dev_get_drvdata(dev);
> +       unsigned int vals[8];
> +       int i;
> +
> +       for (i =3D 0; i < 8; i++)
> +               vals[i] =3D readb(leds->regs +
> +                               TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(i));
> +
> +       return sprintf(buf, "%u %u %u %u %u %u %u %u\n", vals[0], vals[1]=
,
> +                      vals[2], vals[3], vals[4], vals[5], vals[6], vals[=
7]);

sysfs_emit()
Wouldn't it be better to have CSV instead? I think for such cases we
usually have this kind of format.

> +}

...

> +static struct attribute *turris1x_leds_controller_attrs[] =3D {
> +       &dev_attr_brightness.attr,
> +       &dev_attr_brightness_level.attr,
> +       &dev_attr_brightness_values.attr,

> +       NULL,

No comma for terminator.

> +};

...

> +static int turris1x_leds_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;

> +       struct device_node *np =3D dev_of_node(dev);
> +       struct device_node *child;

Why not use fwnode to begin with?

> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +       if (!res)
> +               return -ENODEV;

Besides dup code, which actually does not print a message...

> +       regs =3D devm_ioremap_resource(dev, res);

...we have devm_platform_ioremap_resource() to combine two above into one.

> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);

...

> +       ret =3D devm_led_trigger_register(dev, &turris1x_hw_trigger);
> +       if (ret) {
> +               dev_err(dev, "Cannot register private LED trigger: %d\n",=
 ret);
> +               return ret;

return dev_err_probe(...);

> +       }

...

> +       for_each_available_child_of_node(np, child) {

device_for_each_child_node()

> +               ret =3D turris1x_led_register(dev, leds, child,
> +                                           val_sw_override, val_sw_disab=
le);
> +               if (ret) {

> +                       of_node_put(child);

fwnode_handle_put()

> +                       return ret;
> +               }
> +       }

...

> +       ret =3D devm_device_add_groups(dev, turris1x_leds_controller_grou=
ps);
> +       if (ret) {
> +               dev_err(dev, "Could not add attribute group!\n");
> +               return ret;

return dev_err_probe(...);

> +       }
> +
> +       return 0;
> +}

...

> +       /*
> +        * LED registers are persisent across board resets.

persistent

> +        * So reset LEDs to default state before kernel reboots.
> +        */

...

> +                       writeb(0xff,

GENMASK() ?

> +                              leds->regs + TURRIS1X_LED_BRIGHTNESS_REG(i=
, j));
> +       }
> +}

...

> +static const struct of_device_id of_turris1x_leds_match[] =3D {
> +       { .compatible =3D "cznic,turris1x-leds" },
> +       {},

No comma for terminator.

> +};

--=20
With Best Regards,
Andy Shevchenko
