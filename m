Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7304B8609
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiBPKk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:40:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiBPKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:40:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484682BA283;
        Wed, 16 Feb 2022 02:40:40 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id n24so2590213ljj.10;
        Wed, 16 Feb 2022 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ObOknCuy2uLyXQZw3dTKU5e6KPeVkDnmAFovr9tv14=;
        b=iF4uu0la2Vj9KB6lrMgavliWjPzVGw8z6EpkrCyNL0OY6t77iWzzE941cD6QHhjuyu
         4TmHec5PiCQMhX1DABqYrmz5QAtKcGW4iiarraPcByhdPdzpOfkRSV4Cusc+wXJHIQdN
         WUl3734a2ngzFPaBdheE8J9k3RYmjKlWQioQz7QdkZlcw7KoNUoCXphxXLsUC9cjkgM+
         njpwK0BZ85UwS42M/dbbEzP1u6JKZkj5ZkolmQPV4WWAjgNE0LpbTJsKBIlKi5zuadIr
         8waySa2+Zf8QPJGouiY+wceLX3WlxUUYtpL2p8dQ3H6aR25hBklViWFsHtA8vJTMPJ36
         P9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ObOknCuy2uLyXQZw3dTKU5e6KPeVkDnmAFovr9tv14=;
        b=Q8wkueXRD8dN63d+I+bNYnVphBP2CYKvQxRb8Es72SiEDC014qPAl9mJaIKoprIePX
         ZqWSlx7uyI86vhZPosEm2z1iQ0kPx6P5RgFR8yftZTgz8V1y39gu8OYIUq9Y2RnTih9d
         wh/T/DLBtksxjBmFQtIUvHf/XSti6xcd8P7WjFgiyycn46MWUIBV/EKUGW2TN6tnL8HT
         FOdnl2fCD4V5fRvfcEc+OfA3T1bgcbMPMywhCXCES6FOoT095sd1Vk05m6fp9Rynv/wj
         0OUbXun02n19QrI5WxuhbHI8ZoQqtHNAW5e9swcXrVa3I5oANhNZXHdlNF6cDwxBKaCr
         9dNw==
X-Gm-Message-State: AOAM533zBCBXqAQQtOh20SjarpdY5f4SKX5Wg0sI4CMSg9fcsa12Mqxt
        Kpk/17NiU5PcYKWZgUI4xkr1EF59CbdDMU0HfVE=
X-Google-Smtp-Source: ABdhPJwJMI1M1BT0ckwc9FIE6oK8ZjLXO1SoI0KXkJoDldcH6RRuG9yRNglCKuEBQcgCwtQE2QqPIfIt9a3iOhB1/cs=
X-Received: by 2002:a2e:b90e:0:b0:239:3332:c83c with SMTP id
 b14-20020a2eb90e000000b002393332c83cmr1561219ljb.426.1645008038470; Wed, 16
 Feb 2022 02:40:38 -0800 (PST)
MIME-Version: 1.0
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
 <1644827562-17244-2-git-send-email-vincent.sunplus@gmail.com> <YgoVBv/z1uCsR1Y0@kroah.com>
In-Reply-To: <YgoVBv/z1uCsR1Y0@kroah.com>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Wed, 16 Feb 2022 18:41:46 +0800
Message-ID: <CAPvp3Rg1BSMFF+gApC+VYyeCT9Qfr5OQEW3nzbc+d_z-GpwcYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
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

I am sorry. I did not send the e-mail to others, I reply it again.

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B42=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Feb 14, 2022 at 04:32:41PM +0800, Vincent Shih wrote:
> > Add driver for ehci in Sunplus SP7021
> >
> > Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> > ---
> >  MAINTAINERS                     |   6 +
> >  drivers/usb/host/Kconfig        |  11 +
> >  drivers/usb/host/Makefile       |   1 +
> >  drivers/usb/host/ehci-sunplus.c | 527 ++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 545 insertions(+)
> >  create mode 100644 drivers/usb/host/ehci-sunplus.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 80eebc1..6c2faf3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17947,6 +17947,12 @@ L:   netdev@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/net/ethernet/dlink/sundance.c
> >
> > +SUNPLUS USB EHCI DRIVER
> > +M:   Vincent Shih <vincent.sunplus@gmail.com>
> > +L:   linux-usb@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/usb/host/ehci-sunplus.c
> > +
> >  SUPERH
> >  M:   Yoshinori Sato <ysato@users.sourceforge.jp>
> >  M:   Rich Felker <dalias@libc.org>
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index c4736d1..9728d3b 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -339,6 +339,17 @@ config USB_OCTEON_EHCI
> >         USB 2.0 device support.  All CN6XXX based chips with USB are
> >         supported.
> >
> > +config USB_EHCI_SUNPLUS
> > +     tristate "EHCI support for Sunplus USB controller"
> > +     depends on SOC_SP7021
> > +     select NVMEM_SUNPLUS_OCOTP
> > +     help
> > +       Enables support for the on-chip EHCI controller in Sunplus
> > +       SoCs. It supports 32-bit AHB/AXI config bus and 64-bit AXI
> > +       data bus.
> > +       This driver can also be built as a module. If so, the module
> > +       will be called ehci-sunplus.
> > +
> >  endif # USB_EHCI_HCD
> >
> >  config USB_OXU210HP_HCD
> > diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> > index 171de4d..7e9b5f1 100644
> > --- a/drivers/usb/host/Makefile
> > +++ b/drivers/usb/host/Makefile
> > @@ -46,6 +46,7 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)      +=3D ehci-st.o
> >  obj-$(CONFIG_USB_EHCI_EXYNOS)        +=3D ehci-exynos.o
> >  obj-$(CONFIG_USB_EHCI_HCD_AT91) +=3D ehci-atmel.o
> >  obj-$(CONFIG_USB_EHCI_BRCMSTB)       +=3D ehci-brcm.o
> > +obj-$(CONFIG_USB_EHCI_SUNPLUS)       +=3D ehci-sunplus.o
> >
> >  obj-$(CONFIG_USB_OXU210HP_HCD)       +=3D oxu210hp-hcd.o
> >  obj-$(CONFIG_USB_ISP116X_HCD)        +=3D isp116x-hcd.o
> > diff --git a/drivers/usb/host/ehci-sunplus.c b/drivers/usb/host/ehci-su=
nplus.c
> > new file mode 100644
> > index 0000000..007923a
> > --- /dev/null
> > +++ b/drivers/usb/host/ehci-sunplus.c
> > @@ -0,0 +1,527 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * The EHCI driver for Sunplus SP7021
> > + *
> > + * Copyright (C) 2019 Sunplus Technology Inc., All rights reserved.
>
> You have not touched this file since 2019?
>
I did not notice it. I will modify it.
>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/ehci_pdriver.h>
> > +#include <linux/usb/hcd.h>
> > +
> > +#include "ehci.h"
> > +
> > +#define RF_MASK_V(mask, val)                 (((mask) << 16) | (val))
> > +#define RF_MASK_V_CLR(mask)                  (((mask) << 16) | 0)
> > +
> > +#define USB_PORT0_ID                         0
> > +#define USB_PORT1_ID                         1
> > +#define USB_PORT_NUM                         2
> > +
> > +#define MASK_BITS                            0xffff
> > +
> > +#define OTP_DISC_LEVEL_DEFAULT                       0xd
> > +#define OTP_DISC_LEVEL_BITS                  0x5
> > +
> > +// GROUP 140/150 UPHY0/UPHY1
> > +#define CONFIG1                                      0x4
> > +#define J_HS_TX_PWRSAV                               BIT(5)
> > +#define CONFIG3                                      0xc
> > +#define J_FORCE_DISC_ON                              BIT(5)
> > +#define J_DEBUG_CTRL_ADDR_MACRO                      BIT(0)
> > +#define CONFIG7                                      0x1c
> > +#define J_DISC                                       0X1f
> > +#define CONFIG9                                      0x24
> > +#define J_ECO_PATH                           BIT(6)
> > +#define CONFIG16                             0x40
> > +#define J_TBCWAIT_MASK                               GENMASK(6, 5)
> > +#define J_TBCWAIT_1P1_MS                     FIELD_PREP(J_TBCWAIT_MASK=
, 0)
> > +#define J_TVDM_SRC_DIS_MASK                  GENMASK(4, 3)
> > +#define J_TVDM_SRC_DIS_8P2_MS                        FIELD_PREP(J_TVDM=
_SRC_DIS_MASK, 3)
> > +#define J_TVDM_SRC_EN_MASK                   GENMASK(2, 1)
> > +#define J_TVDM_SRC_EN_1P6_MS                 FIELD_PREP(J_TVDM_SRC_EN_=
MASK, 0)
> > +#define J_BC_EN                                      BIT(0)
> > +#define CONFIG17                             0x44
> > +#define IBG_TRIM0_MASK                               GENMASK(7, 5)
> > +#define IBG_TRIM0_SSLVHT                     FIELD_PREP(IBG_TRIM0_MASK=
, 4)
> > +#define J_VDATREE_TRIM_MASK                  GENMASK(4, 1)
> > +#define J_VDATREE_TRIM_DEFAULT                       FIELD_PREP(J_VDAT=
REE_TRIM_MASK, 9)
> > +#define CONFIG23                             0x5c
> > +#define PROB_MASK                            GENMASK(5, 3)
> > +#define PROB                                 FIELD_PREP(PROB_MASK, 7)
> > +
> > +// GROUP 0 MOON 0
> > +#define HARDWARE_RESET_CONTROL2                      0x5c
> > +#define UPHY1_RESET                          BIT(14)
> > +#define UPHY0_RESET                          BIT(13)
> > +#define USBC1_RESET                          BIT(11)
> > +#define USBC0_RESET                          BIT(10)
> > +
> > +// GROUP 4 MOON 4
> > +#define USBC_CONTROL                         0x44
> > +#define MO1_USBC1_USB0_SEL                   BIT(13)
> > +#define MO1_USBC1_USB0_CTRL                  BIT(12)
> > +#define MO1_USBC0_USB0_SEL                   BIT(5)
> > +#define MO1_USBC0_USB0_CTRL                  BIT(4)
> > +#define UPHY0_CONTROL0                               0x48
> > +#define UPHY0_CONTROL1                               0x4c
> > +#define UPHY0_CONTROL2                               0x50
> > +#define MO1_UPHY0_RX_CLK_SEL                 BIT(6)
> > +#define UPHY0_CONTROL3                               0x54
> > +#define MO1_UPHY0_PLL_POWER_OFF_SEL          BIT(7)
> > +#define MO1_UPHY0_PLL_POWER_OFF                      BIT(3)
> > +#define UPHY1_CONTROL0                               0x58
> > +#define UPHY1_CONTROL1                               0x5c
> > +#define UPHY1_CONTROL2                               0x60
> > +#define MO1_UPHY1_RX_CLK_SEL                 BIT(6)
> > +#define UPHY1_CONTROL3                               0x64
> > +#define MO1_UPHY1_PLL_POWER_OFF_SEL          BIT(7)
> > +#define MO1_UPHY1_PLL_POWER_OFF                      BIT(3)
> > +
> > +#define hcd_to_sp_ehci_priv(h) \
> > +             ((struct sp_ehci_priv *)hcd_to_ehci(h)->priv)
> > +
> > +struct sp_ehci_priv {
> > +     struct resource *uphy_res_mem[USB_PORT_NUM];
> > +     struct resource *moon0_res_mem;
> > +     struct resource *moon4_res_mem;
> > +     struct clk *uphy_clk[USB_PORT_NUM];
> > +     struct clk *ehci_clk[USB_PORT_NUM];
> > +     void __iomem *uphy_regs[USB_PORT_NUM];
> > +     void __iomem *moon0_regs;
> > +     void __iomem *moon4_regs;
> > +};
> > +
> > +static int ehci_sunplus_reset(struct usb_hcd *hcd)
> > +{
> > +     struct platform_device *pdev =3D to_platform_device(hcd->self.con=
troller);
> > +     struct usb_ehci_pdata *pdata =3D pdev->dev.platform_data;
> > +     struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> > +     int retval;
> > +
> > +     hcd->has_tt =3D pdata->has_tt;
> > +     ehci->has_synopsys_hc_bug =3D pdata->has_synopsys_hc_bug;
> > +     ehci->big_endian_desc =3D pdata->big_endian_desc;
> > +     ehci->big_endian_mmio =3D pdata->big_endian_mmio;
> > +
> > +     ehci->caps =3D hcd->regs + pdata->caps_offset;
> > +     retval =3D ehci_setup(hcd);
> > +
> > +     return retval;
> > +}
> > +
> > +static struct hc_driver __read_mostly ehci_sunplus_driver;
> > +
> > +static const struct ehci_driver_overrides ehci_sunplus_overrides __ini=
tconst =3D {
> > +     .reset =3D                ehci_sunplus_reset,
> > +     .extra_priv_size =3D      sizeof(struct sp_ehci_priv),
> > +};
> > +
> > +static int uphy0_init(struct platform_device *pdev, struct sp_ehci_pri=
v *sp_priv)
> > +{
> > +     struct nvmem_cell *cell;
> > +     char *disc_name =3D "disc_vol";
> > +     ssize_t otp_l =3D 0;
> > +     char *otp_v;
> > +     int port =3D pdev->id - 1;
> > +     u32 val, set, pll_pwr_on, pll_pwr_off;
> > +
> > +     /* Default value modification */
> > +     writel(RF_MASK_V(MASK_BITS, 0x4002), sp_priv->moon4_regs + UPHY0_=
CONTROL0);
> > +     writel(RF_MASK_V(MASK_BITS, 0x8747), sp_priv->moon4_regs + UPHY0_=
CONTROL1);
> > +
> > +     /* PLL power off/on twice */
> > +     pll_pwr_off =3D (readl(sp_priv->moon4_regs + UPHY0_CONTROL3) & ~M=
ASK_BITS)
> > +                     | MO1_UPHY0_PLL_POWER_OFF_SEL | MO1_UPHY0_PLL_POW=
ER_OFF;
> > +     pll_pwr_on =3D (readl(sp_priv->moon4_regs + UPHY0_CONTROL3) & ~MA=
SK_BITS)
> > +                     | MO1_UPHY0_PLL_POWER_OFF_SEL;
> > +
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_off), sp_priv->moon4_regs + U=
PHY0_CONTROL3);
> > +     mdelay(1);
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_on), sp_priv->moon4_regs + UP=
HY0_CONTROL3);
> > +     mdelay(1);
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_off), sp_priv->moon4_regs + U=
PHY0_CONTROL3);
> > +     mdelay(1);
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_on), sp_priv->moon4_regs + UP=
HY0_CONTROL3);
> > +     mdelay(1);
> > +     writel(RF_MASK_V(MASK_BITS, 0x0), sp_priv->moon4_regs + UPHY0_CON=
TROL3);
> > +
>
> Why not just do a read after a write so that you know that is the
> correct delay?  Doing a sleep like this seems slow and possibly wrong.
>
The purposes of these delays are for discharging the voltages of the
capacitors in the circuit.
They have nothing to do with the registers.

> > +     /* reset UPHY0 */
> > +     writel(RF_MASK_V(UPHY0_RESET, UPHY0_RESET), sp_priv->moon0_regs +=
 HARDWARE_RESET_CONTROL2);
> > +     writel(RF_MASK_V_CLR(UPHY0_RESET), sp_priv->moon0_regs + HARDWARE=
_RESET_CONTROL2);
> > +     mdelay(1);
>
> Again, read()?
>
The purpose of the delay is for discharging the voltages of the
capacitors in the circuit.
It has nothing to do with the registers.
> > +
> > +     /* board uphy 0 internal register modification for tid certificat=
ion */
> > +     cell =3D nvmem_cell_get(&pdev->dev, disc_name);
> > +     if (IS_ERR_OR_NULL(cell)) {
> > +             if (PTR_ERR(cell) =3D=3D -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +     }
> > +
> > +     otp_v =3D nvmem_cell_read(cell, &otp_l);
> > +     nvmem_cell_put(cell);
> > +
> > +     if (otp_v)
> > +             set =3D ((*otp_v >> OTP_DISC_LEVEL_BITS) |
> > +                     (*(otp_v + 1) << (sizeof(char) * 8 - OTP_DISC_LEV=
EL_BITS))) & J_DISC;
> > +
> > +     if (!otp_v || set =3D=3D 0)
> > +             set =3D OTP_DISC_LEVEL_DEFAULT;
> > +
> > +     val =3D readl(sp_priv->uphy_regs[port] + CONFIG7);
> > +     val =3D (val & ~J_DISC) | set;
> > +     writel(val, sp_priv->uphy_regs[port] + CONFIG7);
> > +
> > +     val =3D readl(sp_priv->uphy_regs[port] + CONFIG9);
> > +     val &=3D ~(J_ECO_PATH);
> > +     writel(val, sp_priv->uphy_regs[port] + CONFIG9);
> > +
> > +     val =3D readl(sp_priv->uphy_regs[port] + CONFIG1);
> > +     val &=3D ~(J_HS_TX_PWRSAV);
> > +     writel(val, sp_priv->uphy_regs[port] + CONFIG1);
> > +
> > +     val =3D readl(sp_priv->uphy_regs[port] + CONFIG23);
> > +     val =3D (val & ~PROB) | PROB;
> > +     writel(val, sp_priv->uphy_regs[port] + CONFIG23);
> > +
> > +     /* USBC 0 reset */
> > +     writel(RF_MASK_V(USBC0_RESET, USBC0_RESET), sp_priv->moon0_regs +=
 HARDWARE_RESET_CONTROL2);
> > +     writel(RF_MASK_V_CLR(USBC0_RESET), sp_priv->moon0_regs + HARDWARE=
_RESET_CONTROL2);
> > +
> > +     /* port 0 uphy clk fix */
> > +     writel(RF_MASK_V(MO1_UPHY0_RX_CLK_SEL, MO1_UPHY0_RX_CLK_SEL),
> > +            sp_priv->moon4_regs + UPHY0_CONTROL2);
> > +
> > +     /* switch to host */
> > +     writel(RF_MASK_V(MO1_USBC0_USB0_SEL | MO1_USBC0_USB0_CTRL,
> > +                      MO1_USBC0_USB0_SEL | MO1_USBC0_USB0_CTRL),
> > +            sp_priv->moon4_regs + USBC_CONTROL);
> > +
> > +     /* battery charger */
> > +     writel(J_TBCWAIT_1P1_MS | J_TVDM_SRC_DIS_8P2_MS | J_TVDM_SRC_EN_1=
P6_MS | J_BC_EN,
> > +            sp_priv->uphy_regs[port] + CONFIG16);
> > +     writel(IBG_TRIM0_SSLVHT | J_VDATREE_TRIM_DEFAULT, sp_priv->uphy_r=
egs[port] + CONFIG17);
> > +     writel(J_FORCE_DISC_ON | J_DEBUG_CTRL_ADDR_MACRO, sp_priv->uphy_r=
egs[port] + CONFIG3);
>
> What about all of these writes, are you sure they made it to the
> hardware ok?  No need to read?
>
Yes, they made it to the hardware and there is no need to read.
The write command of Sunplus SP7021 is posted write. But it
has a MSI (Message Signal Interrupt) mechanism to fix the data
incoherence issue between CPU and other bus masters. The
steps are shown below.
1. The master issues a MSI command after the last write command.
2. When SDCTRL receives the MSI command, the previous write
    command have been done and SDCTRL would issue an interrupt
    to interrupt controller.
3. The inerrupt controller issues a "done" signal to the master.
4. When the master receives the "done" signal, the write command has
    been done. Then the master can process the next write command
    or issue an interrupt.
> Same for elsewhere in the file.
>
> thanks,
>
> greg k-h

Thanks for your review.
