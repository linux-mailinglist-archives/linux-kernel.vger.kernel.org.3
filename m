Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404114B79C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiBOU45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:56:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiBOU44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:56:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08FE031;
        Tue, 15 Feb 2022 12:56:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso2331834wme.5;
        Tue, 15 Feb 2022 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lmjxJ/HX8zGfT6H556z4OpqIKIUYUUDa4hoyC0X1UWM=;
        b=WhzMDST3m6CGIlEC/+Ec73454Pbxhrsyf/RrKyQYY1INFcJCOj9u25pCpwnJB4tSJq
         lDWuZ3WzOLN5dlSQUNrgQNDlnSNvEUOBaB9MVV08uHlHz3QXzGdwpeuqkMDlXYN+nzT+
         Ixl4Dnz3m1reXHsEAXufpOMSPjZXfZWopzfnZOgTpHuXhdz569x3PVrpTrMmgGgWn9he
         UqgReELkFajtYgdcSczBW3fXGPMAmnsEKl+n5JWVzIGctBo816WIFD6x/EgD+VSLyiSU
         FGanT7l9WuPA71YRvB9PsRYucCCiypnCx4tBlAyABLqYeDbuLJCG6nLHkxaQ1Fpun6a3
         imAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmjxJ/HX8zGfT6H556z4OpqIKIUYUUDa4hoyC0X1UWM=;
        b=cPm4UH6Pe3wYjzyjkv0fGBaV1KCUWdV6lB+qLGzGqBffKT7V0sTtaFb13O7cXEyLT6
         QKeQMQvnAxVI4g8hOjxsyVRK1QJaFmAebxrEY4fk18ms4yK6OxvCmbFoj7M0XvMBl3lE
         tAGdNCT3SP7CsjnjVQKvKDPupcXActlOQdqMhA9SKqPVwTdfWEGeX7HA9PfO12zmahSz
         CLx36ywfc1tseEci/MFpzo0jE6rVF+NMLmjRyPZOL+lZ6VSKzhi0V0oO5jPosv2TbVvj
         shw1kx+1vynS6r7FSw7fNqUHOiTHMV1NRIxqzh8KDks044vMx00ur1qgAtTaPfQSVdsW
         UqPQ==
X-Gm-Message-State: AOAM533qh7vweB+9D1i00DV8C+NuHVEJYzz6APc8rm44j2XXlas9gtjB
        gHjsHvF2sAPCBP+dlr6jUK0koug2r588Ryav7jXGHg25LqB7LQ==
X-Google-Smtp-Source: ABdhPJxNzjJWU0uY4VBFZxf0pOb2YsfgoeY17375EhBuPmd19FfF9ugV+3Z68GpTCJXUFadps5NUIo+DIwpfCSPgMDY=
X-Received: by 2002:a05:600c:354e:b0:37c:815f:8a3f with SMTP id
 i14-20020a05600c354e00b0037c815f8a3fmr4546180wmq.15.1644958603160; Tue, 15
 Feb 2022 12:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20220215163926.894-1-paweldembicki@gmail.com> <Ygvv/CWUYumhKoCh@lunn.ch>
In-Reply-To: <Ygvv/CWUYumhKoCh@lunn.ch>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Tue, 15 Feb 2022 21:56:32 +0100
Message-ID: <CAJN1Kkz3_z8M1j_mtOJzriUWj1m6iAEdZSZFg-zB2Gw2BYY4wA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Ctera C-200 V1 board
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

wt., 15 lut 2022 o 19:25 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Tue, Feb 15, 2022 at 05:39:22PM +0100, Pawel Dembicki wrote:
> > Ctera C200 V1 is kirkwood-based 2-Bay NAS.
> >
> > Hardware:
> >   - SoC: Marvell 88F6281-A1 ARMv5TE Processor 1.2GHz
> >   - Ram: 512MB (4x Nanya NT5TU128M8GE-AC)
> >   - NAND Flash: 256MB (Samsung 216 K9F2G08U0C)
> >   - Lan: 1x GBE (Marvell 88E1116R-NNC1)
> >   - Storage: 2x SATA HDD 3.5" Slot
> >   - USB: 2x USB 2.0 port
> >   - Console: Internal J3 connector (1: Vcc, 2: Rx, 3: Tx, 4: GND)
> >   - LEDs: 13x GPIO controlled
> >   - Buttons: 2x GPIO controlled
> >
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> > v2:
> > - removed 2x\n spacing issue
> > - removed unused pcie node
> > - made information about buzzer more comprehensive
>
> Hi Pawel
>

Hi Andrew.

> Thanks for adding the mvebu Maintainers to the list of recipients.
>
> One more process point. It would be normal to set the To: to whoever
> you think should actually accept this patch. There are a lot of
> Maintainers listed in Cc: so actually pointing a finger at somebody
> can help.
>

I used get_maintainer script. But I will pick manually addresses for cc.

> Gregory will be the person to actually take this patch.
>
> >
> >  arch/arm/boot/dts/Makefile             |   1 +
> >  arch/arm/boot/dts/kirkwood-c200-v1.dts | 310 +++++++++++++++++++++++++
> >  2 files changed, 311 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-c200-v1.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 235ad559acb2..31616f6ae173 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -281,6 +281,7 @@ dtb-$(CONFIG_ARCH_KEYSTONE) +=3D \
> >  dtb-$(CONFIG_MACH_KIRKWOOD) +=3D \
> >       kirkwood-b3.dtb \
> >       kirkwood-blackarmor-nas220.dtb \
> > +     kirkwood-c200-v1.dtb \
> >       kirkwood-cloudbox.dtb \
> >       kirkwood-d2net.dtb \
> >       kirkwood-db-88f6281.dtb \
> > diff --git a/arch/arm/boot/dts/kirkwood-c200-v1.dts b/arch/arm/boot/dts=
/kirkwood-c200-v1.dts
> > new file mode 100644
> > index 000000000000..f59ff7578dfc
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/kirkwood-c200-v1.dts
> > @@ -0,0 +1,310 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Ctera C200 V1 Board Description
> > + * Copyright 2021-2022 Pawel Dembicki <paweldembicki@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "kirkwood.dtsi"
> > +#include "kirkwood-6281.dtsi"
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +     model =3D "Ctera C200 V1";
> > +     compatible =3D "ctera,c200-v1", "marvell,kirkwood-88f6281", "marv=
ell,kirkwood";
> > +
> > +     chosen {
> > +             bootargs =3D "console=3DttyS0,115200";
> > +             stdout-path =3D &uart0;
> > +     };
> > +
> > +     memory@0 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x20000000>;
> > +     };
> > +
> > +     keys {
> > +             compatible =3D "gpio-keys";
> > +             pinctrl-0 =3D <&pmx_buttons>;
> > +             pinctrl-names =3D "default";
> > +
> > +             power {
> > +                     label =3D "Power Button";
> > +                     linux,code =3D <KEY_POWER>;
> > +                     gpios =3D <&gpio1 16 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             reset {
> > +                     label =3D "Reset Button";
> > +                     linux,code =3D <KEY_RESTART>;
> > +                     gpios =3D <&gpio1 17 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             usb1 {
> > +                     label =3D "USB1 Button";
> > +                     linux,code =3D <BTN_0>;
> > +                     gpios =3D <&gpio0 28 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             usb2 {
> > +                     label =3D "USB2 Button";
> > +                     linux,code =3D <BTN_1>;
> > +                     gpios =3D <&gpio0 29 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
> > +
> > +     gpio-poweroff {
> > +             compatible =3D "gpio-poweroff";
> > +             pinctrl-0 =3D <&pmx_poweroff>;
> > +             pinctrl-names =3D "default";
> > +             gpios =3D <&gpio1 2 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     leds {
> > +             compatible =3D "gpio-leds";
> > +             pinctrl-0 =3D <&pmx_leds>;
> > +             pinctrl-names =3D "default";
> > +
> > +             led-0 {
> > +                     function =3D LED_FUNCTION_DISK;
> > +                     function-enumerator =3D <2>;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio0 14 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-1 {
> > +                     function =3D LED_FUNCTION_DISK;
> > +                     function-enumerator =3D <1>;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio0 15 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-2 {
> > +                     function =3D LED_FUNCTION_DISK;
> > +                     function-enumerator =3D <2>;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio0 16 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-3 {
> > +                     function =3D LED_FUNCTION_DISK;
> > +                     function-enumerator =3D <1>;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio0 17 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-4 {
> > +                     function =3D LED_FUNCTION_STATUS;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio1 6 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-5 {
> > +                     function =3D LED_FUNCTION_STATUS;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio1 7 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-6 {
> > +                     function =3D LED_FUNCTION_INDICATOR;
> > +                     color =3D <LED_COLOR_ID_BLUE>;
> > +                     gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-7 {
> > +                     function =3D LED_FUNCTION_DISK_ERR;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-8 {
> > +                     function =3D LED_FUNCTION_DISK_ERR;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio1 11 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-9 {
> > +                     function =3D LED_FUNCTION_USB;
> > +                     function-enumerator =3D <1>;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio1 12 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-10 {
> > +                     function =3D LED_FUNCTION_USB;
> > +                     function-enumerator =3D <1>;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio1 13 GPIO_ACTIVE_LOW>;
> > +                     linux,default-trigger =3D "usbport";
> > +                     trigger-sources =3D <&hub_port2>;
> > +             };
> > +
> > +             led-11 {
> > +                     function =3D LED_FUNCTION_USB;
> > +                     function-enumerator =3D <2>;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-12 {
> > +                     function =3D LED_FUNCTION_USB;
> > +                     function-enumerator =3D <2>;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> > +                     linux,default-trigger =3D "usbport";
> > +                     trigger-sources =3D <&hub_port1>;
> > +             };
> > +     };
> > +};
> > +
> > +&eth0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&eth0port {
> > +     phy-handle =3D <&ethphy9>;
> > +};
> > +
> > +&i2c0 {
> > +     status =3D "okay";
> > +
> > +     rtc@30 {
> > +             compatible =3D "s35390a";
> > +             reg =3D <0x30>;
> > +     };
> > +
> > +     lm63@4c {
> > +             compatible =3D "national,lm63";
> > +             reg =3D <0x4c>;
> > +     };
> > +};
> > +
> > +&mdio {
> > +     status =3D "okay";
> > +
> > +     ethphy9: ethernet-phy@9 {
> > +             reg =3D <9>;
> > +     };
> > +};
> > +
> > +&nand {
> > +     status =3D "okay";
> > +     chip-delay =3D <40>;
> > +
> > +     partition@0 {
> > +             label =3D "uboot";
> > +             reg =3D <0x0000000 0x200000>;
> > +     };
> > +
> > +     partition@200000 {
> > +             label =3D "certificate";
> > +             reg =3D <0x0200000 0x100000>;
> > +     };
> > +
> > +     partition@300000 {
> > +             label =3D "preset_cfg";
> > +             reg =3D <0x0300000 0x100000>;
> > +     };
> > +
> > +     partition@400000 {
> > +             label =3D "dev_params";
> > +             reg =3D <0x0400000 0x100000>;
> > +     };
> > +
> > +     partition@500000 {
> > +             label =3D "active_bank";
> > +             reg =3D <0x0500000 0x0100000>;
> > +     };
> > +
> > +     partition@600000 {
> > +             label =3D "magic";
> > +             reg =3D <0x0600000 0x0100000>;
> > +     };
> > +
> > +     partition@700000 {
> > +             label =3D "bank1";
> > +             reg =3D <0x0700000 0x2800000>;
> > +     };
> > +
> > +     partition@2f00000 {
> > +             label =3D "bank2";
> > +             reg =3D <0x2f00000 0x2800000>;
> > +     };
> > +
> > +     /* 0x5700000-0x5a00000 undefined in vendor firmware */
> > +
> > +     partition@5a00000 {
> > +             label =3D "reserved";
> > +             reg =3D <0x5a00000 0x2000000>;
> > +     };
> > +
> > +     partition@7a00000 {
> > +             label =3D "rootfs";
> > +             reg =3D <0x7a00000 0x8600000>;
> > +     };
> > +};
> > +
> > +&pinctrl {
> > +     /* Buzzer gpios are connected to two pins of buzzer.
> > +      * This buzzer require a modulated signal from gpio.
> > +      * Leave it as is due lack of proper driver.
> > +      */
>
> Thanks for adding a comment. So you need something like a PWM driving
> it? Have you tried playing with drivers/input/misc/pwm-beeper.c ?

It use a PWM device. Driver gpio-pwm isn't accepted in mainline so far.

> Some of the mvebu family have a simple PWM functionality as part of
> the GPIO controller. I don't remember if kirkwood has this.

Kirkwood have very simple blink mode only: GPIO pin make visible blinks.

>
>     Andrew

Pawel
