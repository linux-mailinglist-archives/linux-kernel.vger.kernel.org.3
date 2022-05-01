Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70F516444
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbiEALvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiEALvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:51:39 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46CCAE6F;
        Sun,  1 May 2022 04:48:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f7d621d1caso123879057b3.11;
        Sun, 01 May 2022 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X+TH5SKck4yWzLo1Cg2jnvVaiWnIEj/UD97CyPselfw=;
        b=G637iZTSMYRktzcyEfCLLTQr68TFiujVx0g9ZLDuLlYOXeolr+6zY3ANU9Tq31YJM1
         Dz0iXCcm1Zlq0KZJU8z/IcLcRMyWYK8IFL/QeVO5AgUw7rRrdKnPZhlR7gUkK81XQyJP
         4pr3FaNFM9kha/bKW9viy78IsH+Pj7NSfZ4TIlWkHRSHWGbsGLScKZc4zEiU1TCgkscs
         v90aMXuygSHGWaYB6CgQhetC8jPrw86TQd742sRciFIGcWBRymV9LSmBitistgGfF8GR
         Uh09K7dV+ri4UXHO2E3EzNLV0aJIJMLHvNIVemHxXbTtmSOjh2vEwLn7zJnrBkLrnzN4
         RzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X+TH5SKck4yWzLo1Cg2jnvVaiWnIEj/UD97CyPselfw=;
        b=Q4/q0HpfeDy0jFwaHhdNsnXt0l8KsnQrSTBYrRohbSSDNQgOW12EkgLqZ6ubSGUbsi
         3EX7hxYdMdgH53m0B3nPudI9qYtPrF/4BEtUm5AFs0lzDgIZ9ZBEuQKGvgFDB5Chv7pw
         w9+30FYqGwy3xJFoLOxS1Hhjl1AkuWrl3yJR9vUlaNuOmV6NiM3cmbVVizx9/8hOqAH9
         g/VGRq6nXp2x7fXs0f2E6JNPQ09WY/jGkoYKoP7/q6ttdKXQKUuJioWSRzoaYs4uic7k
         kDjunLmHE2hHc60hEdBOSASoWdAsOfOBH3dKI6ZaUeapsv7Ky3xIaR2JrrFPJgXJuwIL
         Ytyg==
X-Gm-Message-State: AOAM531He//xaE0QWBKrmSVwV/Kzv+202mRYfU1pi05fbjfQvSz2+DJi
        Pj3SrNR8cyX8lYiPstYBdoGxgfJ7frcwXv6mec4=
X-Google-Smtp-Source: ABdhPJxZoImwLGMN7FRSlQjSFTWRKatK4sbrvghvFWalrL7rvR3wp5mPwRgbQ0mOHmDmbpvkJsD9MSXKViG2HPBp9bM=
X-Received: by 2002:a05:690c:89:b0:2d7:fb7d:db7 with SMTP id
 be9-20020a05690c008900b002d7fb7d0db7mr7787106ywb.219.1651405692862; Sun, 01
 May 2022 04:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220429115252.2360496-1-pgwipeout@gmail.com> <20220429115252.2360496-6-pgwipeout@gmail.com>
 <46548c93-4e6d-858c-8b79-03be9326c92a@gmail.com> <3428030.iIbC2pHGDl@diego>
In-Reply-To: <3428030.iIbC2pHGDl@diego>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 1 May 2022 07:48:02 -0400
Message-ID: <CAMdYzYpStDyKxrWgeMyQNs6tGzzVKCbVR_8JZck8Q_0NVU6jxQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: rockchip: add Pine64 Quartz64-B device tree
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
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

On Sun, May 1, 2022 at 7:31 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Sonntag, 1. Mai 2022, 09:06:33 CEST schrieb Johan Jonker:
> >
> > On 4/29/22 13:52, Peter Geis wrote:
> > > Add a device tree for the Pine64 Quartz64 Model B single board comput=
er.
> > > This board ouputs debug on uart2 and supports the following component=
s:
> > > Gigabit Ethernet
> > > USB2 x2 (one port otg capable)
> > > USB3
> > > PCIe/SATA M2
> > > HDMI
> > > DSI (RPi compatible pinout)
> > > CSI (RPi compatible pinout)
> > > A/B/G/N WiFi
> > > Bluetooth
> > > SDMMC
> > > eMMC
> > > SPI Flash
> > > PI-40 compatible pin header
> > >
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> > >  .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 615 ++++++++++++++++=
++
> > >  2 files changed, 616 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dt=
s
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/=
dts/rockchip/Makefile
> > > index 4ae9f35434b8..252ee47b8a1d 100644
> > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > @@ -59,5 +59,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399pro-rock-pi-=
n10.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-pinenote-v1.1.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-pinenote-v1.2.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-quartz64-a.dtb
> > > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-quartz64-b.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-bpi-r2-pro.dtb
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arc=
h/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > > new file mode 100644
> > > index 000000000000..184ab7e1d178
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > > @@ -0,0 +1,615 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + *
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/pinctrl/rockchip.h>
> > > +#include "rk3566.dtsi"
> > > +
> > > +/ {
> > > +   model =3D "Pine64 RK3566 Quartz64-B Board";
> > > +   compatible =3D "pine64,quartz64-b", "rockchip,rk3566";
> > > +
> >
> > [..]
> >
> > > +
> > > +&mdio1 {
> >
> > > +   rgmii_phy1: ethernet-phy@0 {
> > > +           compatible =3D "ethernet-phy-ieee802.3-c22";
> > > +           reg =3D <0x1>;
> >
> > Hi,
> >
> > The reg value doesn't match the node name.
> > Other 2 boards use "reg =3D <0>" with label "rgmii_phy1".
> > Could you check?
>
> I do have an older Quartz-B in my boardfarm and in that older
> devicetree the phy-reg also is "0" instead of the "1" used here.
>
> Is that a hardware-change?

The ethernet maintainers previously brought up that 0x0 is the
broadcast address for the mdio-bus. They requested we put the actual
bus id of the phy even on single phy busses. This is the first one
I've confirmed the bus address on.

Though I realized ethernet-phy@0 should be ethernet-phy@1 since you
mentioned this. Strange dtbs-check doesn't catch this, would you fix
it in line Heiko or do you want another revision?

>
> Thanks
> Heiko
>
>
