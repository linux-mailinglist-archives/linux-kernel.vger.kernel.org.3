Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA67450142B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiDNNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbiDNNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:30:29 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8BC1B6;
        Thu, 14 Apr 2022 06:28:04 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2eba37104a2so55825307b3.0;
        Thu, 14 Apr 2022 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qoW3lI87WPtNC6g/akscPtAGYfv/Gc0QD6dDprON0Hw=;
        b=CO9tjZaDUA1Y9n0llTJA6XFQCkNFcZb5gIfC7GUCnHrG8483Lm42P+TISaCJ3MkMxS
         /I2IYub33pRoYbJMcClPIMV+/xWRUeAm9AZ11XUV5jR6+QEuGGPzyI3Wlqf4bgNEJnp3
         KhPOckgXyBvlvc795fmduhNKRDQ3pqiwgso6a/J1Dnx5qn7tPN9Ep6unxlPd67bjv1pX
         sPGMuXJ8zh6OVzhvI3k2VDdq4hFSjZk9KixmHYr+Rs+s+K16WPFNj2/bJgEUrvjEYqpT
         aKGkMTqtVu9zkk4t5xAX5FNo4eLvAe5TMtl2HjuXczCgOGw5VlKSooEhma8Hq+mp04Gn
         MUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qoW3lI87WPtNC6g/akscPtAGYfv/Gc0QD6dDprON0Hw=;
        b=RpCiJkDNxXJOrzJI/3jf4+hcRYJsZtaWj8UqePUz2R168Fapl+3/9X4+dSqptbd1WS
         9KE/dXy+kpfrMmfkRsyH9zNmbYs+mN3HEkm/YADispByOjUDyO0StJIBB7PIOZPqSPgc
         PAB7APIzUyJNg1c1Q2s4Pg5cqNYSZmd3lCd+ZTWHrr7C6i85LqO3FNhtOW43fkRPunpf
         EretnJauwwi+Eg+y2XJD5YumtcAkVuhLVmP5DoZmFdjqUM9SUu6qfOPlatrzyQOHBLUo
         O3L9jJOk8RhHPRXTI+JNzKJGrwAl51zMU1NeoFadJSn7FvcnvXiOr9TPOjlAk8zsuf22
         ZIZQ==
X-Gm-Message-State: AOAM533cadhn/XbrKWh4qKNkZrxmqupieITbcqikO3ddw8I9cxGb3nOR
        N2u8eYGLhAeW8w1+oOQKkxNA7rr9jzE0jUGZPF8=
X-Google-Smtp-Source: ABdhPJym7Y/qROf2ctgLrInnaj4tAPu1m0qOvNNITz8Y3QeAb1xoqFTMamaUvHMbDVYkMxORY5EMU14oMN8ae+6xui0=
X-Received: by 2002:a81:6d94:0:b0:2ef:5430:977 with SMTP id
 i142-20020a816d94000000b002ef54300977mr1874620ywc.227.1649942883677; Thu, 14
 Apr 2022 06:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649662002.git.lhjeff911@gmail.com> <c59e0a5c53f055b7159bc896083538d1f8ac9ad8.1649662002.git.lhjeff911@gmail.com>
In-Reply-To: <c59e0a5c53f055b7159bc896083538d1f8ac9ad8.1649662002.git.lhjeff911@gmail.com>
From:   =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Date:   Thu, 14 Apr 2022 21:25:46 +0800
Message-ID: <CAGcXWkxZPT3BFDJ0nD1axMB+ZdpASCvQfGnMrEwqD_pcHdbQsw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] thermal: Add thermal driver for Sunplus SP7021
To:     krzk@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>,
        "lh.kuo" <lh.kuo@sunplus.com>
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

Hi

>> +
>> +     cell =3D nvmem_cell_get(dev, "calib");
>> +     if (IS_ERR(cell))
>> +             return PTR_ERR(cell);
>> +
>> +     otp_v =3D nvmem_cell_read(cell, &otp_l);
>> +     nvmem_cell_put(cell);

>See my previous comments in v4, this is wrong. Move the nvmem_cell_put()
>after FIELD_PREP() ... below where otp_v is no longer used.

> +     if (otp_l < 3)
> +             return -EINVAL;

>Please replace '3' by a macro

>Why this check is needed by the way ? Sounds like only 0 and 1 indexes
>are used here.

you mean the following?

 sp_data->otp_temp0 =3D nvmem_cell_read(cell, &otp_l);
nvmem_cell_put(cell);

> +static const struct of_device_id of_sp7021_thermal_ids[] =3D {
> +     { .compatible =3D "sunplus,sp7021-thermal" },
> +     { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_sp7021_thermal_ids);
> +
> +static struct platform_driver sp7021_thermal_driver =3D {
> +     .probe  =3D sp7021_thermal_probe,

>and .remove ?

If the remove function just returns 0; must it still exist?

Li-hao Kuo <lhjeff911@gmail.com> =E6=96=BC 2022=E5=B9=B44=E6=9C=8811=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add thermal driver for Sunplus SP7021.
>
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v7:
>  - Modify yaml file.
>
>  MAINTAINERS                       |   6 ++
>  drivers/thermal/Kconfig           |  10 +++
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/sunplus_thermal.c | 139 ++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 156 insertions(+)
>  create mode 100644 drivers/thermal/sunplus_thermal.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f11..307570c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18885,6 +18885,12 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>  F:     drivers/spi/spi-sunplus-sp7021.c
>
> +SUNPLUS THERMAL DRIVER
> +M:     Li-hao Kuo <lhjeff911@gmail.com>
> +L:     linux-pm@vger.kernel.org
> +S:     Maintained
> +F:     drivers/thermal/sunplus_thermal.c
> +
>  SUNPLUS UART DRIVER
>  M:     Hammer Hsieh <hammerh0314@gmail.com>
>  S:     Maintained
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e37691e..66316c3 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -502,4 +502,14 @@ config KHADAS_MCU_FAN_THERMAL
>           If you say yes here you get support for the FAN controlled
>           by the Microcontroller found on the Khadas VIM boards.
>
> +config SUNPLUS_THERMAL
> +       tristate "Sunplus thermal drivers"
> +       depends on SOC_SP7021 || COMPILE_TEST
> +       help
> +         This the Sunplus SP7021 thermal driver, which supports the prim=
itive
> +         temperature sensor embedded in Sunplus SP7021 SoC.
> +
> +         If you have a Sunplus SP7021 platform say Y here and enable thi=
s option
> +         to have support for thermal management
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index f0c36a1..38a76f9 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)        +=3D uniphier_the=
rmal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     +=3D amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)     +=3D sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)   +=3D khadas_mcu_fan.o
> +obj-$(CONFIG_SUNPLUS_THERMAL)  +=3D sunplus_thermal.o
> diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_=
thermal.c
> new file mode 100644
> index 0000000..9a9b348
> --- /dev/null
> +++ b/drivers/thermal/sunplus_thermal.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Li-hao Kuo <lhjeff911@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>
> +
> +#define DISABLE_THERMAL                (BIT(31) | BIT(15))
> +#define ENABLE_THERMAL         BIT(31)
> +#define SP_THERMAL_MASK                GENMASK(10, 0)
> +#define SP_TCODE_HIGH_MASK     GENMASK(10, 8)
> +#define SP_TCODE_LOW_MASK      GENMASK(7, 0)
> +
> +#define TEMP_RATE              608
> +#define TEMP_BASE              3500
> +#define TEMP_OTP_BASE          1518
> +
> +#define SP_THERMAL_CTL0_REG    0x0000
> +#define SP_THERMAL_STS0_REG    0x0030
> +
> +/* common data structures */
> +struct sp_thermal_data {
> +       struct thermal_zone_device *pcb_tz;
> +       struct platform_device *pdev;
> +       enum thermal_device_mode mode;
> +       void __iomem *regs;
> +       int otp_temp0;
> +       u32 id;
> +};
> +
> +static int sp7021_get_otp_temp_coef(struct sp_thermal_data *sp_data, str=
uct device *dev)
> +{
> +       struct nvmem_cell *cell;
> +       ssize_t otp_l;
> +       char *otp_v;
> +
> +       cell =3D nvmem_cell_get(dev, "calib");
> +       if (IS_ERR(cell))
> +               return PTR_ERR(cell);
> +
> +       otp_v =3D nvmem_cell_read(cell, &otp_l);
> +       nvmem_cell_put(cell);
> +
> +       if (otp_l < 3)
> +               return -EINVAL;
> +       sp_data->otp_temp0 =3D FIELD_PREP(SP_TCODE_LOW_MASK, otp_v[0]) |
> +                            FIELD_PREP(SP_TCODE_HIGH_MASK, otp_v[1]);
> +       if (sp_data->otp_temp0 =3D=3D 0)
> +               sp_data->otp_temp0 =3D TEMP_OTP_BASE;
> +       return 0;
> +}
> +
> +/*
> + *When remanufacturing, the 35 degree T_CODE will be read and stored in =
nvcell.
> + *TEMP_RATE is the SP7021 temperature slope.
> + *T_CODE : 11 digits in total
> + */
> +
> +static int sp_thermal_get_sensor_temp(void *data, int *temp)
> +{
> +       struct sp_thermal_data *sp_data =3D data;
> +       int t_code;
> +
> +       t_code =3D readl(sp_data->regs + SP_THERMAL_STS0_REG);
> +       t_code =3D FIELD_GET(SP_THERMAL_MASK, t_code);
> +       *temp =3D ((sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + T=
EMP_BASE;
> +       *temp *=3D 10;
> +       return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sp_of_thermal_ops =3D {
> +       .get_temp =3D sp_thermal_get_sensor_temp,
> +};
> +
> +static int sp_thermal_register_sensor(struct platform_device *pdev,
> +                                     struct sp_thermal_data *data, int i=
ndex)
> +{
> +       data->id =3D index;
> +       data->pcb_tz =3D devm_thermal_zone_of_sensor_register(&pdev->dev,
> +                                                           data->id,
> +                                                           data, &sp_of_=
thermal_ops);
> +       if (IS_ERR_OR_NULL(data->pcb_tz))
> +               return PTR_ERR(data->pcb_tz);
> +       return 0;
> +}
> +
> +static int sp7021_thermal_probe(struct platform_device *pdev)
> +{
> +       struct sp_thermal_data *sp_data;
> +       struct resource *res;
> +       int ret;
> +
> +       sp_data =3D devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL=
);
> +       if (!sp_data)
> +               return -ENOMEM;
> +
> +       sp_data->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(sp_data->regs)) {
> +               dev_err(&pdev->dev, "resource get fail\n");
> +               return PTR_ERR(sp_data->regs);
> +       }
> +
> +       writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
> +
> +       platform_set_drvdata(pdev, sp_data);
> +       ret =3D sp7021_get_otp_temp_coef(sp_data, &pdev->dev);
> +       if (ret)
> +               return ret;
> +       ret =3D sp_thermal_register_sensor(pdev, sp_data, 0);
> +       return ret;
> +}
> +
> +static const struct of_device_id of_sp7021_thermal_ids[] =3D {
> +       { .compatible =3D "sunplus,sp7021-thermal" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_sp7021_thermal_ids);
> +
> +static struct platform_driver sp7021_thermal_driver =3D {
> +       .probe  =3D sp7021_thermal_probe,
> +       .driver =3D {
> +               .name   =3D "sp7021-thermal",
> +               .of_match_table =3D of_sp7021_thermal_ids,
> +               },
> +};
> +module_platform_driver(sp7021_thermal_driver);
> +
> +MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
> +MODULE_DESCRIPTION("Thermal driver for SP7021 SoC");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
