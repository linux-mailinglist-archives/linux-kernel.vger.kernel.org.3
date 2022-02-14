Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE0D4B451D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiBNJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:01:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiBNJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:01:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CCE5FF0C;
        Mon, 14 Feb 2022 01:01:18 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u20so623145lff.2;
        Mon, 14 Feb 2022 01:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1V98+2B3mlcmhbqigRqRaS+rwkmQF8FuuX24nDtv+RY=;
        b=ajnydObLtfkklvI1+0dUug1EXZ7v5O9eaDT4GLztjWiLGCkhJpApM0OY4v/jnBSA28
         QfNFsxDfs1QFtPeZSroH8HO16X6jQ+X/8CGBa+xyn0KLUboHJJ/DJroUntZ/Gdm7CuM9
         UoX0a/krUSPoBFIxm7czKknuK8LKY/z24+7j71QSJJ7sBqCmW9shu5Vyx+LUhLc1PRzI
         HIaWWuptu0U0I0POGGImqvdfvAJqFoxRIyvVjuzXjAu3DgYn1CMGbvpN9SQBQphypveW
         LH4F8KbOOwFSw29TgN51v86J/hipxmU2A4ymqH7piOc/byHCBuFKXjlZxbNbwVAhGcix
         VLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1V98+2B3mlcmhbqigRqRaS+rwkmQF8FuuX24nDtv+RY=;
        b=jBAHAPhA4yVa2NH+zXNIqDDvywpufqHwk6ETUUbl987Jt8qhvMCI21B/FaPX5FRsSS
         SkdkUMZaPHv6kVuTcCX5tVNCWBw9vpgy5Jl0TubXucFu+p/a5wXvXsOP+N6qX0Q/KHGB
         Uv7rqyenuqCjb8tYLVT+wSKp28ABpLS4jfOKJnNsq2NG/+lFdFJHU4hN1KcPZ5tu+74y
         PASuZV9ZmC6TeZMPzGXZbVOr4NvNzfOaUrUAHGs9BQgMC39KB+Lu1DvjMD6sT4sgRMdJ
         iOdJWk0xqbY/5Pd885TCkLgSF8uOKJ+G07vVdVcijoxlDwDq2Y5cShizV8HigtuViKQ/
         cMdw==
X-Gm-Message-State: AOAM531CvO+ooZIub1zlkEDmrTokZfUk1i1V7mVaYDF3F+EHDMQ5mxq8
        7Ho0npPIefdu3v/JaDEufNNtENycRP6T8NYRkpbY+lb41zg=
X-Google-Smtp-Source: ABdhPJwUTQie6ptZydNLjbSBScPhN2BY6z/KogXtG9dFheA1hdoRRERJE2tO7RSjITVyGh9xn5DHAcAKfn8fPt5UCqI=
X-Received: by 2002:a05:6512:234c:: with SMTP id p12mr9835417lfu.579.1644829276618;
 Mon, 14 Feb 2022 01:01:16 -0800 (PST)
MIME-Version: 1.0
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
 <1644827562-17244-2-git-send-email-vincent.sunplus@gmail.com> <YgoVBv/z1uCsR1Y0@kroah.com>
In-Reply-To: <YgoVBv/z1uCsR1Y0@kroah.com>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Mon, 14 Feb 2022 17:03:00 +0800
Message-ID: <CAPvp3Rhtb-g1A5FG6_1irzX2fG-VACU3T4tST1Xo99cnnL==MQ@mail.gmail.com>
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

Hi, Greg
    About this issue, my colleague Hammer Hsieh has explained it to
you recently in the mail of "[PATCH v7 2/2] serial: sunplus-uart: Add
Sunplus
SoC UART Driver". The ehci driver and uart one are in the same Sunplus Soc.
    Thanks for your review.

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
> > +     /* reset UPHY0 */
> > +     writel(RF_MASK_V(UPHY0_RESET, UPHY0_RESET), sp_priv->moon0_regs +=
 HARDWARE_RESET_CONTROL2);
> > +     writel(RF_MASK_V_CLR(UPHY0_RESET), sp_priv->moon0_regs + HARDWARE=
_RESET_CONTROL2);
> > +     mdelay(1);
>
> Again, read()?
>
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
> Same for elsewhere in the file.
>
> thanks,
>
> greg k-h
