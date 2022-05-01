Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA38516451
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbiEAMIJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 May 2022 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346812AbiEAMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:08:07 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202723172;
        Sun,  1 May 2022 05:04:40 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nl8JX-0005z2-51; Sun, 01 May 2022 14:04:35 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] arm64: dts: rockchip: add Pine64 Quartz64-B device tree
Date:   Sun, 01 May 2022 14:04:34 +0200
Message-ID: <1911020.usQuhbGJ8B@diego>
In-Reply-To: <CAMdYzYpStDyKxrWgeMyQNs6tGzzVKCbVR_8JZck8Q_0NVU6jxQ@mail.gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com> <3428030.iIbC2pHGDl@diego> <CAMdYzYpStDyKxrWgeMyQNs6tGzzVKCbVR_8JZck8Q_0NVU6jxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. Mai 2022, 13:48:02 CEST schrieb Peter Geis:
> On Sun, May 1, 2022 at 7:31 AM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Am Sonntag, 1. Mai 2022, 09:06:33 CEST schrieb Johan Jonker:
> > >
> > > On 4/29/22 13:52, Peter Geis wrote:
> > > > Add a device tree for the Pine64 Quartz64 Model B single board computer.
> > > > This board ouputs debug on uart2 and supports the following components:
> > > > Gigabit Ethernet
> > > > USB2 x2 (one port otg capable)
> > > > USB3
> > > > PCIe/SATA M2
> > > > HDMI
> > > > DSI (RPi compatible pinout)
> > > > CSI (RPi compatible pinout)
> > > > A/B/G/N WiFi
> > > > Bluetooth
> > > > SDMMC
> > > > eMMC
> > > > SPI Flash
> > > > PI-40 compatible pin header
> > > >
> > > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> > > >  .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 615 ++++++++++++++++++
> > > >  2 files changed, 616 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > > >
> > > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > > > index 4ae9f35434b8..252ee47b8a1d 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > > @@ -59,5 +59,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
> > > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > > > new file mode 100644
> > > > index 000000000000..184ab7e1d178
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > > > @@ -0,0 +1,615 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + *
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/pinctrl/rockchip.h>
> > > > +#include "rk3566.dtsi"
> > > > +
> > > > +/ {
> > > > +   model = "Pine64 RK3566 Quartz64-B Board";
> > > > +   compatible = "pine64,quartz64-b", "rockchip,rk3566";
> > > > +
> > >
> > > [..]
> > >
> > > > +
> > > > +&mdio1 {
> > >
> > > > +   rgmii_phy1: ethernet-phy@0 {
> > > > +           compatible = "ethernet-phy-ieee802.3-c22";
> > > > +           reg = <0x1>;
> > >
> > > Hi,
> > >
> > > The reg value doesn't match the node name.
> > > Other 2 boards use "reg = <0>" with label "rgmii_phy1".
> > > Could you check?
> >
> > I do have an older Quartz-B in my boardfarm and in that older
> > devicetree the phy-reg also is "0" instead of the "1" used here.
> >
> > Is that a hardware-change?
> 
> The ethernet maintainers previously brought up that 0x0 is the
> broadcast address for the mdio-bus. They requested we put the actual
> bus id of the phy even on single phy busses. This is the first one
> I've confirmed the bus address on.
> 
> Though I realized ethernet-phy@0 should be ethernet-phy@1 since you
> mentioned this. Strange dtbs-check doesn't catch this, would you fix
> it in line Heiko

no that's ok, I can fix that up. Just wanted to clarify what the intention
was first :-)

> or do you want another revision?
> 
> >
> > Thanks
> > Heiko
> >
> >
> 




