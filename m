Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CE47212A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhLMGl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhLMGl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:41:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0848C06173F;
        Sun, 12 Dec 2021 22:41:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b40so28877114lfv.10;
        Sun, 12 Dec 2021 22:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4C0uo0FkTEbupD5zDs1HjJiOHkOgPnFQD77QAX7qmos=;
        b=H/j8JckHH2Tw0QAQp1rZKnr6dAKfsr9nRmJxABFKCUe+gn4ke703L9ftjTSwZiRR4O
         g/ERIAs5YbQfYB51vZVOIqt9ykf4kfKkJDprqSHeA0jqWpMSFHYNFjMmAyVqk4W+C7NG
         ZNnna6VvPV/xdRclNWU54WLiKg7OqDJfndp81z7qOjgHzxAdqruNRyqmUKsoQtf51xvq
         QcV9Ul0o/XihzjDrXsf+PQbhGQ6kntipQcdj6+J+xRB6TvU1J18vjRoziqXaNAbuPjnU
         +EKUvnBaq//2W97xuYDLB6QGYT9Jwk6U3W4I9F/umuo1qkAKDBEDTrSqymGZrFY5kAa6
         PN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4C0uo0FkTEbupD5zDs1HjJiOHkOgPnFQD77QAX7qmos=;
        b=CRuRAJ8G4LAUNdeyUCC9LE7fu/0AbQOtT1X6/p4qeu9R+B+lz8NoZVnJ+gss1H3Vvz
         E9T+EKFZ7W0Jnderm3eoRJaNW8kgQSm5K9twExO/12e3O+9LowMfpBQPi+E+osktpgRR
         WvAKWLOKWlJpG11PuVJwvCdr6nw91UmULlVE2PAmIDnUhJvLD4veDGR3kqddDEl6kBhh
         dziDZ5AFnySsTe7K8Q5ipKpCG29YkTY5aCuh+zcsehgpMGsF8NglTnNkt3DKIugB9KV8
         PsmQQLJkWtN7MNjI44RhRGqovRxgz75SjSnvC3wV+GCk45N7ZnhqYvqhIvOB+3DanVEw
         9Www==
X-Gm-Message-State: AOAM5319VoBi4cKwVrpRpeOxcNbp+LDJJK3OKfytv0hs/8MwT2edfzhY
        KJfvMBYv7ZmjcFq5zEkKX5EX7nlmRG28bdifVi0=
X-Google-Smtp-Source: ABdhPJw2NVb3r3al0+zxtEzVFJ70fbuoyfstES1ICeJjTZWd0MgL9BUuO5x/pWRZ4iW4KdrBubNaCEN8NCkl5PPG4dU=
X-Received: by 2002:a05:6512:2081:: with SMTP id t1mr27321030lfr.348.1639377713726;
 Sun, 12 Dec 2021 22:41:53 -0800 (PST)
MIME-Version: 1.0
References: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
 <1638867233-8383-2-git-send-email-vincent.sunplus@gmail.com> <1b336b98-7546-93e3-f1ed-92d041c2df35@linaro.org>
In-Reply-To: <1b336b98-7546-93e3-f1ed-92d041c2df35@linaro.org>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Mon, 13 Dec 2021 14:45:03 +0800
Message-ID: <CAPvp3RgYxinTDU65wPL1t6b1AR3qNnZz4KDMJUp8ou97GvkJpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> =E6=96=BC 2021=E5=B9=
=B412=E6=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:50=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
>
>
> On 07/12/2021 08:53, Vincent Shih wrote:
> > Add driver for OCOTP in Sunplus SP7021
> >
> > Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> > ---
> > Changes in v2:
> >   - Merge sunplus-ocotp.h and sunplus-ocotp0.c to sunplus-ocotp.c
> >   - Clean up codes.
> >
> >   MAINTAINERS                   |   5 +
> >   drivers/nvmem/Kconfig         |  12 ++
> >   drivers/nvmem/Makefile        |   2 +
> >   drivers/nvmem/sunplus-ocotp.c | 268 +++++++++++++++++++++++++++++++++=
+++++++++
> >   4 files changed, 287 insertions(+)
> >   create mode 100644 drivers/nvmem/sunplus-ocotp.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 80eebc1..0e6593a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17947,6 +17947,11 @@ L:   netdev@vger.kernel.org
> >   S:  Maintained
> >   F:  drivers/net/ethernet/dlink/sundance.c
> >
> > +SUNPLUS OCOTP DRIVER
> > +M:   Vincent Shih <vincent.sunplus@gmail.com>
> > +S:   Maintained
> > +F:   drivers/nvmem/sunplus-ocotp.c
> > +
> >   SUPERH
> >   M:  Yoshinori Sato <ysato@users.sourceforge.jp>
> >   M:  Rich Felker <dalias@libc.org>
> > diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> > index da41461..fb053d6 100644
> > --- a/drivers/nvmem/Kconfig
> > +++ b/drivers/nvmem/Kconfig
> > @@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
> >         This driver provides support for Broadcom's NVRAM that can be a=
ccessed
> >         using I/O mapping.
> >
> > +config NVMEM_SUNPLUS_OCOTP
> > +     tristate "Sunplus SoC OTP support"
> > +     depends on SOC_SP7021
>
> COMPILE_TEST ?
>

Yes, I will add it.

> > +     depends on HAS_IOMEM
> > +     help
> > +       This is a driver for the On-chip OTP controller (OCOTP) availab=
le
> > +       on Sunplus SoCs. It provids access to 128 bytes of one-time
>
> s/provids/provides
>

Yes, I will modify it.


> > +       programmable eFuse.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called nvmem-sunplus-ocotp.
> > +
> >   endif
> > diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> > index dcbbde3..0f14cd9 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > @@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM)    +=3D nvmem-rmem.o
> >   nvmem-rmem-y                        :=3D rmem.o
> >   obj-$(CONFIG_NVMEM_BRCM_NVRAM)      +=3D nvmem_brcm_nvram.o
> >   nvmem_brcm_nvram-y          :=3D brcm_nvram.o
> > +obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)    +=3D nvmem_sunplus_ocotp.o
> > +nvmem_sunplus_ocotp-y                :=3D sunplus-ocotp.o
> > diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocot=
p.c
> > new file mode 100644
> > index 0000000..2997b29
> > --- /dev/null
> > +++ b/drivers/nvmem/sunplus-ocotp.c
> > @@ -0,0 +1,268 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * The OCOTP driver for Sunplus      SP7021
> > + *
> > + * Copyright (C) 2019 Sunplus Technology Inc., All rights reseerved.
>
> reserved ?
>

Yes, I will modify it.

> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +/*
> > + * OTP memory
> > + * Each bank contains 4 words (32 bits).
> > + * Bank 0 starts at offset 0 from the base.
> > + */
> > +
> > +#define OTP_WORDS_PER_BANK           4
> > +#define OTP_WORD_SIZE                        sizeof(u32)
> > +#define OTP_BIT_ADDR_OF_BANK         (8 * OTP_WORD_SIZE * OTP_WORDS_PE=
R_BANK)
> > +#define QAC628_OTP_NUM_BANKS            8
> > +#define QAC628_OTP_SIZE                 (QAC628_OTP_NUM_BANKS * OTP_WO=
RDS_PER_BANK * OTP_WORD_SIZE)
> > +#define OTP_READ_TIMEOUT                20000
> > +
> > +/* HB_GPIO */
> > +#define ADDRESS_8_DATA                       0x20
> > +
> > +/* OTP_RX */
> > +#define OTP_CONTROL_2                        0x48
> > +#define OTP_RD_PERIOD                        GENMASK(15, 8)
> > +#define OTP_RD_PERIOD_MASK           ~GENMASK(15, 8)
> > +#define ONE_CPU_CLOCK                        0x1
> > +#define SEL_BAK_KEY2                 BIT(5)
> > +#define SEL_BAK_KEY2_MASK            ~BIT(5)
> > +#define SW_TRIM_EN                   BIT(4)
> > +#define SW_TRIM_EN_MASK                      ~BIT(4)
> > +#define SEL_BAK_KEY                  BIT(3)
> > +#define SEL_BAK_KEY_MASK             ~BIT(3)
> > +#define OTP_READ                     BIT(2)
> > +#define OTP_LOAD_SECURE_DATA         BIT(1)
> > +#define OTP_LOAD_SECURE_DATA_MASK    ~BIT(1)
> > +#define OTP_DO_CRC                   BIT(0)
> > +#define OTP_DO_CRC_MASK                      ~BIT(0)
> > +#define OTP_STATUS                   0x4c
> > +#define OTP_READ_DONE                        BIT(4)
> > +#define OTP_READ_DONE_MASK           ~BIT(4)
> > +#define OTP_LOAD_SECURE_DONE_MASK    ~BIT(2)
> > +#define OTP_READ_ADDRESS             0x50
> > +
> > +enum base_type {
> > +     HB_GPIO,
> > +     OTPRX,
> > +     BASEMAX,
> > +};
> > +
> > +struct sp_otp_data_t {
> > +     struct device *dev;
> > +     void __iomem *base[BASEMAX];
> > +     struct clk *clk;
> > +     struct nvmem_config *config;
>
> totally redundant to store config in this stucture as you will never use
> this after probe.
>

Yes, I will remove it.

> > +};
> > +
> > +struct sp_otp_vX_t {
>
> does X needs to be caps?
>

Yes, I will modify it.

> > +     int size;
> > +};
> > +
> > +const struct sp_otp_vX_t  sp_otp_v0 =3D {
> > +     .size =3D QAC628_OTP_SIZE,
> > +};
> > +
> > +static int sp_otp_wait(void __iomem *reg_base)
> > +{
> > +     int timeout =3D OTP_READ_TIMEOUT;
> > +     unsigned int status;
> > +
> > +     do {
> > +             usleep_range(10);
>
> Doesn't this take two arguments?
>

I will replace sp_otp_wait() with readl_poll_timeout().

> > +             if (timeout-- =3D=3D 0)
> > +                     return -ETIMEDOUT;
> > +
> > +             status =3D readl(reg_base + OTP_STATUS);
> > +     } while ((status & OTP_READ_DONE) !=3D OTP_READ_DONE);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sp_otp_read_real(struct sp_otp_data_t *otp, int addr, char =
*value)
> > +{
> > +     unsigned int addr_data;
> > +     unsigned int byte_shift;
> > +     int ret =3D 0;
>
> unnecessary initializatoin here.
>

Yes, I will modify it.

> > +
> > +     addr_data =3D addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
> > +     addr_data =3D addr_data / OTP_WORD_SIZE;
> > +
> > +     byte_shift =3D addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
> > +     byte_shift =3D byte_shift % OTP_WORD_SIZE;
> > +
> > +     addr =3D addr / (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
> > +     addr =3D addr * OTP_BIT_ADDR_OF_BANK;
> > +
> > +     writel(readl(otp->base[OTPRX] + OTP_STATUS) & OTP_READ_DONE_MASK =
&
> > +                  OTP_LOAD_SECURE_DONE_MASK, otp->base[OTPRX] + OTP_ST=
ATUS);
> > +     writel(addr, otp->base[OTPRX] + OTP_READ_ADDRESS);
> > +     writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) | OTP_READ,
> > +            otp->base[OTPRX] + OTP_CONTROL_2);
> > +     writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) & SEL_BAK_KEY2_MAS=
K & SW_TRIM_EN_MASK
> > +            & SEL_BAK_KEY_MASK & OTP_LOAD_SECURE_DATA_MASK & OTP_DO_CR=
C_MASK,
> > +            otp->base[OTPRX] + OTP_CONTROL_2);
> > +     writel((readl(otp->base[OTPRX] + OTP_CONTROL_2) & OTP_RD_PERIOD_M=
ASK) |
> > +            ((ONE_CPU_CLOCK * 0x1e) << 8), otp->base[OTPRX] + OTP_CONT=
ROL_2);
> > +
> > +     ret =3D sp_otp_wait(otp->base[OTPRX]);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *value =3D (readl(otp->base[HB_GPIO] + ADDRESS_8_DATA + addr_data=
 * OTP_WORD_SIZE)
> > +                     >> (8 * byte_shift)) & 0xFF;
> > +
> > +     return ret;
> > +}
> > +
> > +static int sp_ocotp_read(void *priv, unsigned int offset, void *value,=
 size_t bytes)
> > +{
> > +     struct sp_otp_data_t *otp =3D priv;
> > +     unsigned int addr;
> > +     char *buf =3D value;
> > +     char val[4];
> > +     int ret;
> > +
> > +     dev_dbg(otp->dev, "OTP read %u bytes at %u", bytes, offset);
> > +
> why do we need all these debug ?
>

Yes, I will remove it.

> > +     if (offset >=3D QAC628_OTP_SIZE || bytes =3D=3D 0 || ((offset + b=
ytes) > QAC628_OTP_SIZE))
> > +             return -EINVAL;
>
> Core should already do this sanity test, if not these checks belong to
> nvmem core.
>

Yes, I will remove it.

> > +
> > +     ret =3D clk_enable(otp->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *buf =3D 0;
> > +     for (addr =3D offset; addr < (offset + bytes); addr++) {
> > +             ret =3D sp_otp_read_real(otp, addr, val);
> > +             if (ret < 0) {
> > +                     dev_err(otp->dev, "OTP read fail:%d at %d", ret, =
addr);
> > +                     goto disable_clk;
> > +             }
> > +
> > +             *buf++ =3D *val;
> > +     }
> > +
> > +disable_clk:
> > +     clk_disable(otp->clk);
> > +     dev_dbg(otp->dev, "OTP read complete");
> > +
> > +     return ret;
> > +}
> > +
> > +static struct nvmem_config sp_ocotp_nvmem_config =3D {
> > +     .name =3D "sp-ocotp",
> > +     .read_only =3D true,
> > +     .word_size =3D 1,
> > +     .size =3D QAC628_OTP_SIZE,
> > +     .stride =3D 1,
> > +     .reg_read =3D sp_ocotp_read,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int sp_ocotp_probe(struct platform_device *pdev)
> > +{
> > +     const struct of_device_id *match;
> > +     const struct sp_otp_vX_t *sp_otp_vX;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct nvmem_device *nvmem;
> > +     struct sp_otp_data_t *otp;
> > +     struct resource *res;
> > +     int ret;
> > +
>
> <---
> > +     match =3D of_match_device(dev->driver->of_match_table, dev);
> > +     if (match && match->data)
> > +             sp_otp_vX =3D match->data;
> > +     else
> > +             dev_err(dev, "OTP vX does not match");
> --->
>
> This looks like dead code, variable is set but not used anywhere.
> Error case is ignored.
>

Yes, I will remove it.

>
> > +
> > +     otp =3D devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
> > +     if (!otp)
> > +             return -ENOMEM;
> > +
> > +     otp->dev =3D dev;
> > +     otp->config =3D &sp_ocotp_nvmem_config;
> > +
> > +     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gp=
io");
> > +     otp->base[HB_GPIO] =3D devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(otp->base[HB_GPIO]))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(otp->base[HB_GPI=
O]),
> > +                                             "hb_gpio devm_ioremap_res=
ource fail\n");
>
> printing error here is totally redundant.
>
> you could just do
>
> if (IS_ERR(otp->base[HB_GPIO]))
>         return PTR_ERR(otp->base[HB_GPIO]);
>

Yes, I will modify it.

>
> > +
> > +     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx=
");
> > +     otp->base[OTPRX] =3D devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(otp->base[OTPRX]))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(otp->base[OTPRX]=
),
> > +                                             "otprx devm_ioremap_resou=
rce fail\n");
> > +
> same here,
>

Yes, I will modify it.

> > +     otp->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(otp->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(otp->clk),
> > +                                             "devm_clk_get fail\n");
> > +
> > +     ret =3D clk_prepare(otp->clk);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to prepare clk: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     sp_ocotp_nvmem_config.priv =3D otp;
> > +     sp_ocotp_nvmem_config.dev =3D dev;
> > +
> > +     nvmem =3D devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
> > +     if (IS_ERR(nvmem))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
> > +                                             "register nvmem device fa=
il\n");
> > +
> > +     platform_set_drvdata(pdev, nvmem);
> > +
> > +     dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d =3D %d",
> > +             QAC628_OTP_NUM_BANKS, OTP_WORDS_PER_BANK,
> > +             OTP_WORD_SIZE, QAC628_OTP_SIZE);
> > +
> > +     dev_info(dev, "by Sunplus (C) 2020");
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id sp_ocotp_dt_ids[] =3D {
> > +     { .compatible =3D "sunplus,sp7021-ocotp", .data =3D &sp_otp_v0 },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, sp_ocotp_dt_ids);
> > +
> > +static struct platform_driver sp_otp_driver =3D {
> > +     .probe     =3D sp_ocotp_probe,
> > +     .driver    =3D {
> > +             .name           =3D "sunplus,sp7021-ocotp",
> > +             .of_match_table =3D sp_ocotp_dt_ids,
> > +     }
> > +};
> > +
> > +static int __init sp_otp0_drv_new(void)
> > +{
> > +     return platform_driver_register(&sp_otp_driver);
> > +}
> > +subsys_initcall(sp_otp0_drv_new);
>
> Why this needs to be subsys_initcall() why can't it be module_init?
>

The otp driver stores the mac address for the ethernet driver and
disconnect voltage for USB2 one.
Therefore, it must take priority over the other ones for the probe.

>
> > +
> > +static void __exit sp_otp0_drv_del(void)
> > +{
> > +     platform_driver_unregister(&sp_otp_driver);
> > +}
> > +module_exit(sp_otp0_drv_del);
> > +
> > +MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
> > +MODULE_DESCRIPTION("Sunplus On-Chip OTP driver");
> > +MODULE_LICENSE("GPL v2");
>
> Just GPL should be good here.
>

Yes, I will modify it.

> --srini
> > +
> >

Thanks for your review.
