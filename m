Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8E5562C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiGAG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiGAG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:58:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC04EB86;
        Thu, 30 Jun 2022 23:58:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e2so1775306edv.3;
        Thu, 30 Jun 2022 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Ke8W2BSsmfzJ2fet5OSAhH+C4CUozy/ET/m/GnwveY=;
        b=e0k+IywRcmdoghPPWyPP1jrLnj4xQv3ER/FL0yWFLAbj6HW69AHQ09kjYW8lPPJ75T
         GmrJaS5y6CCHn7UKeKwB+Avs6TAlwHKAa8VEQEF3H3hgBqvaIduH/OdftHEdZdbEmyHq
         ZeYlRfS+vHS+xyYVyTEvGJi7iZV6A+V+2yCYu8J5LJEP9N1vnLQvwHeL6XoKjLqcWWoy
         2dx7Wo9ZEQkel14bF6Q1v2SqL4U1iaGXSaPJqy2kFv0gZWY+lRSlutFWhepZqq5LhzwB
         dB1BuOd/IFqy6A1MLI026IRGoPNkPvuAsiLLhn9cnu3GBbFW5dc+LFFf5jvH8VlQHM3e
         +6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Ke8W2BSsmfzJ2fet5OSAhH+C4CUozy/ET/m/GnwveY=;
        b=wIMwrkw2n8LmtXeocVeAP2KSUM4O+fpkMhvsbw6yceR0VcNHyJkzwY2NSi+Wivt863
         uONj7Xt9Gi9cmmSFbbNh9b/4kbL8Wr3rjzUjhFdp491nLikTiUDnLLn0JT8Vwkn8e434
         rs1pJAS8IC12bZ0di0K5cMVNTA5VxhwVjtgyl/BJsgCbS7x2j0jzx27cDqqXmu0FR/BZ
         nzsZjRdqqn5U2LNvmM+tZm3wLe995yDZ6NUlgwZ3q7Y+bf/lwuubopJdTp1AArREBWnX
         XyxotdXNG4a5rl9ocrVSNt7CotJu2BFbrp/ZXoGcvP3nSnSjzYDDtJu+15rxy8n3Xioi
         0I6g==
X-Gm-Message-State: AJIora+GAi8gmpI4YSXCaylgjMLLNqosAGVSyVccirDkWEQzu5fTjPkZ
        bzZDo0x/AU3uAadAJ4RvJFr49z0ozQH/WHOv5bo=
X-Google-Smtp-Source: AGRyM1tMHwG4GVnv1Ul5esZA3/+W5n3oehl10Z2VQEGQR31sIAW5qxdWesoT9Jw6QcI6jnqLln+n4jAsRO0NSkiMFKA=
X-Received: by 2002:a05:6402:2789:b0:435:ac82:e8c3 with SMTP id
 b9-20020a056402278900b00435ac82e8c3mr16720643ede.250.1656658690705; Thu, 30
 Jun 2022 23:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-3-git-send-email-u0084500@gmail.com> <Yrm9ObaltUiQUTqS@google.com>
 <CADiBU3802sLTPjrGiaQ-xw-2jep1UXo+t7pYc6bCC4MiJLhOyA@mail.gmail.com>
In-Reply-To: <CADiBU3802sLTPjrGiaQ-xw-2jep1UXo+t7pYc6bCC4MiJLhOyA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 1 Jul 2022 14:57:59 +0800
Message-ID: <CADiBU3838Mgi3sqv+R_=8g-ROTrbN45AKPaTS_9GCWVDYASMyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: rt5120: Add Richtek PMIC support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Lee:

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:56=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:22=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Wed, 22 Jun 2022, cy_huang wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add Richtek RT5120 PMIC I2C driver.
> >
> > Why a whole new driver?
> >
> > How different is this to rt5033?
> >
> > Looks like this could easily be woven into this existing support?
> >
> It's different with the function domain.
> RT5033 is most like as the SubPMIC that includes PMU (battery
> charger/gauge/led/few buck and ldo)
> RT5120 is a main PMIC with default-on power that follows the boot on sequ=
ence.
> RT5120 only integrates regulator and power key report module.
>
Since I have explained the chip difference, do you still think it's
better to merge this code into rt5033 mfd?
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >  drivers/mfd/Kconfig  |  12 +++++
> > >  drivers/mfd/Makefile |   1 +
> > >  drivers/mfd/rt5120.c | 125 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 138 insertions(+)
> > >  create mode 100644 drivers/mfd/rt5120.c
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 3b59456..866619c 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1127,6 +1127,18 @@ config MFD_RT5033
> > >         sub-devices like charger, fuel gauge, flash LED, current sour=
ce,
> > >         LDO and Buck.
> > >
> > > +config MFD_RT5120
> > > +     tristate "Richtek RT5120 Power Management IC"
> > > +     depends on I2C
> > > +     select MFD_CORE
> > > +     select REGMAP_I2C
> > > +     select REGMAP_IRQ
> > > +     help
> > > +       The enables support for Richtek RT5120 PMIC. It includes four=
 high
> > > +       efficiency buck converters and one LDO voltage regulator. The=
 device
> > > +       is targeted at providing the CPU voltage, memory, I/O and per=
ipheral
> > > +       power rails in home entertainment devices.
> > > +
> > >  config MFD_RC5T583
> > >       bool "Ricoh RC5T583 Power Management system device"
> > >       depends on I2C=3Dy
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 858cacf..27e8add 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -234,6 +234,7 @@ obj-$(CONFIG_MFD_HI655X_PMIC)   +=3D hi655x-pmic.=
o
> > >  obj-$(CONFIG_MFD_DLN2)               +=3D dln2.o
> > >  obj-$(CONFIG_MFD_RT4831)     +=3D rt4831.o
> > >  obj-$(CONFIG_MFD_RT5033)     +=3D rt5033.o
> > > +obj-$(CONFIG_MFD_RT5120)     +=3D rt5120.o
> > >  obj-$(CONFIG_MFD_SKY81452)   +=3D sky81452.o
> > >
> > >  intel-soc-pmic-objs          :=3D intel_soc_pmic_core.o intel_soc_pm=
ic_crc.o
> > > diff --git a/drivers/mfd/rt5120.c b/drivers/mfd/rt5120.c
> > > new file mode 100644
> > > index 00000000..e7c5f3c
> > > --- /dev/null
> > > +++ b/drivers/mfd/rt5120.c
> > > @@ -0,0 +1,125 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +#include <linux/i2c.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define RT5120_REG_INTENABLE 0x1D
> > > +#define RT5120_REG_INTSTAT   0x1E
> > > +#define RT5120_REG_FZCMODE   0x44
> > > +
> > > +#define RT5120_INT_HOTDIE    0
> > > +#define RT5120_INT_PWRKEY_REL        5
> > > +#define RT5120_INT_PWRKEY_PRESS      6
> > > +
> > > +static const struct regmap_range rt5120_rd_yes_ranges[] =3D {
> > > +     regmap_reg_range(0x03, 0x13),
> > > +     regmap_reg_range(0x1c, 0x20),
> > > +     regmap_reg_range(0x44, 0x44)
> > > +};
> > > +
> > > +static const struct regmap_range rt5120_wr_yes_ranges[] =3D {
> > > +     regmap_reg_range(0x06, 0x13),
> > > +     regmap_reg_range(0x1c, 0x20),
> > > +     regmap_reg_range(0x44, 0x44)
> > > +};
> > > +
> > > +static const struct regmap_access_table rt5120_rd_table =3D {
> > > +     .yes_ranges =3D rt5120_rd_yes_ranges,
> > > +     .n_yes_ranges =3D ARRAY_SIZE(rt5120_rd_yes_ranges),
> > > +};
> > > +
> > > +static const struct regmap_access_table rt5120_wr_table =3D {
> > > +     .yes_ranges =3D rt5120_wr_yes_ranges,
> > > +     .n_yes_ranges =3D ARRAY_SIZE(rt5120_wr_yes_ranges),
> > > +};
> > > +
> > > +static const struct regmap_config rt5120_regmap_config =3D {
> > > +     .reg_bits =3D 8,
> > > +     .val_bits =3D 8,
> > > +     .max_register =3D RT5120_REG_FZCMODE,
> > > +
> > > +     .wr_table =3D &rt5120_wr_table,
> > > +     .rd_table =3D &rt5120_rd_table,
> > > +};
> > > +
> > > +static const struct regmap_irq rt5120_irqs[] =3D {
> > > +     REGMAP_IRQ_REG_LINE(RT5120_INT_HOTDIE, 8),
> > > +     REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_REL, 8),
> > > +     REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_PRESS, 8)
> > > +};
> > > +
> > > +static const struct regmap_irq_chip rt5120_irq_chip =3D {
> > > +     .name =3D "rt5120-pmic",
> > > +     .status_base =3D RT5120_REG_INTSTAT,
> > > +     .mask_base =3D RT5120_REG_INTENABLE,
> > > +     .ack_base =3D RT5120_REG_INTSTAT,
> > > +     .mask_invert =3D true,
> > > +     .use_ack =3D true,
> > > +     .num_regs =3D 1,
> > > +     .irqs =3D rt5120_irqs,
> > > +     .num_irqs =3D ARRAY_SIZE(rt5120_irqs),
> > > +};
> > > +
> > > +static const struct resource rt5120_regulator_resources[] =3D {
> > > +     DEFINE_RES_IRQ(RT5120_INT_HOTDIE)
> > > +};
> > > +
> > > +static const struct resource rt5120_pwrkey_resources[] =3D {
> > > +     DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_PRESS, "pwrkey-press"),
> > > +     DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_REL, "pwrkey-release")
> > > +};
> > > +
> > > +static const struct mfd_cell rt5120_devs[] =3D {
> > > +     MFD_CELL_RES("rt5120-regulator", rt5120_regulator_resources),
> > > +     MFD_CELL_OF("rt5120-pwrkey", rt5120_pwrkey_resources, NULL, 0, =
0,
> > > +                 "richtek,rt5120-pwrkey")
> > > +};
> > > +
> > > +static int rt5120_probe(struct i2c_client *i2c)
> > > +{
> > > +     struct regmap *regmap;
> > > +     struct regmap_irq_chip_data *irq_data;
> > > +     int ret;
> > > +
> > > +     regmap =3D devm_regmap_init_i2c(i2c, &rt5120_regmap_config);
> > > +     if (IS_ERR(regmap)) {
> > > +             ret =3D PTR_ERR(regmap);
> > > +             dev_err(&i2c->dev, "Failed to init regmap (%d)\n", ret)=
;
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
> > > +                                    IRQF_ONESHOT, 0, &rt5120_irq_chi=
p,
> > > +                                    &irq_data);
> > > +     if (ret) {
> > > +             dev_err(&i2c->dev, "Failed to add irq chip (%d)\n", ret=
);
> > > +             return ret;
> > > +     }
> > > +
> > > +     return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, rt5=
120_devs,
> > > +                                 ARRAY_SIZE(rt5120_devs), NULL, 0,
> > > +                                 regmap_irq_get_domain(irq_data));
> > > +}
> > > +
> > > +static const struct of_device_id rt5120_device_match_table[] =3D {
> > > +     { .compatible =3D "richtek,rt5120", },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rt5120_device_match_table);
> > > +
> > > +static struct i2c_driver rt5120_driver =3D {
> > > +     .driver =3D {
> > > +             .name =3D "rt5120",
> > > +             .of_match_table =3D rt5120_device_match_table,
> > > +     },
> > > +     .probe_new =3D rt5120_probe,
> > > +};
> > > +module_i2c_driver(rt5120_driver);
> > > +
> > > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > > +MODULE_DESCRIPTION("Richtek RT5120 I2C driver");
> > > +MODULE_LICENSE("GPL v2");
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Principal Technical Lead - Developer Services
> > Linaro.org =E2=94=82 Open source software for Arm SoCs
> > Follow Linaro: Facebook | Twitter | Blog
