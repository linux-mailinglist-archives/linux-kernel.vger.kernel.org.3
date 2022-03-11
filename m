Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896BC4D5D20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiCKIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiCKIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:18:27 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C41B8CB5;
        Fri, 11 Mar 2022 00:17:24 -0800 (PST)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MpUpW-1nwThm1qzk-00prhv; Fri, 11 Mar 2022 09:17:22 +0100
Received: by mail-wr1-f46.google.com with SMTP id u1so11704418wrg.11;
        Fri, 11 Mar 2022 00:17:22 -0800 (PST)
X-Gm-Message-State: AOAM533ellch/TqZN+Q5xc7nIy2XGsw4SOZkbtAe2aIAgWPned9+a5kF
        ciI7Qx6ZWqDCPpFBjni1jjy4SHTxj2VdampZyLw=
X-Google-Smtp-Source: ABdhPJxW9i4kWyg9zMNuwRBJdGfRXF75+O2MaNREzCYFAU5RyTteMHh2HAc2KSsF8wE4U2Ykbk+U4J8RF+irfdK2wIA=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr3565281wrq.192.1646986642028; Fri, 11
 Mar 2022 00:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
In-Reply-To: <20220310195229.109477-9-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 11 Mar 2022 09:17:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Wsd31DhPKZefm9742M-4B3ofg=CsS9+P4nXxM=4HsVg@mail.gmail.com>
Message-ID: <CAK8P3a0Wsd31DhPKZefm9742M-4B3ofg=CsS9+P4nXxM=4HsVg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8cocoZevybXR4kFILZyRCw0eiL4NGtsI9VyU2vmi95kWWuEXy08
 LnHCZ7jFwXvyZIE6sbWIQVLGPqhu67xmWBJ8tdfeJdwURslZg58LFxwz09eHPUwJO3aUWD1
 Lhtcc14o8TwF4LdZpk7xBMDW7roRqW95Zc/gVXU5AXdllx+arD4NpZg1UHAbpESsSRsmfh0
 GqTxCqL4ValazBMydxwzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:79isolIR82c=:W2atddsB7BLkCvWXUgr6Lu
 u/kFoy3wDM2y1+6UrOcieW7yJi4B/TpURGNAOLahn2lYxfvhUMq/OZxbeojL0b0wLF6Ky3n/d
 qyEj5jVzgy1S4Dj9PZ9RCapN6NzBJEWmVD2HS5ERTp+DlL2I/LIgnFL5bRHYxeIRUnOYRsGFl
 HHWl0oimivPlcgUF/+IBSTlxih74yfGm1LSdaYkEuD+ucCOyaiy7gGGVNH4FIRFJzcf3mN8P6
 Ea83TDGNBGvIhkADVFJL+cZ0OeyZjaE08wH00cJFA2slA7IrSTEfx0K2ucOns7FCeoTUAkMUl
 S+12RLEwk2qChqAxAG0gfwEeNT82sT2hCxrqoHPS58s67YYUvuGa5ryhtmUqXKjtjIKl2t3h6
 ydA1A0pjwLXRRheb8SJHB93BdrCglMMM1LdyPRePX0zMaBw2zejP+TqgotoaPGkTGzpTYMRqo
 bnwq1QsIV1C6iffxutwbYQ/jkhoN6uYm7rgFhvfkxhbUIzgQ5tzcmudyThKWtooYnlSiNNQPU
 8qfs1CR7IsMoRNA/f2C3ik+hLdanlQMy5DqPJsiAG86DA6M0vFVOLUn5YuWPlT83Abc8ziRpV
 74C31+CqaU8n824srPfFgWZnUHol2jYAEOySxqlrfcO9UlLDLJilmIN4Yh1VqiAZrL15RHSHp
 gBB/0uMqa58ShOayJ8DrDSqxGt7KWMoOmPINDPTaR1rLiwzL935FoJQ1p+HbMuCRs3vHNJeD7
 iomSYQtycGyo6Dz4R08Hb1LTyG4BE19U3BHIZIwbBuluc+RL6K63az2i3iPaDicn/CGHZAgcm
 4lGWIP8cjL0rEqeiWtblAQ0xcOuDKbmWjF0tiPU2jVYglA2UOY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 8:52 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The HPE SoC is new to linux. This patch
> creates the basic device tree layout with minimum required
> for linux to boot. This includes timer and watchdog
> support.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       compatible = "hpe,gxp";
> +       model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
> +
> +       chosen {
> +               bootargs = "earlyprintk console=ttyS2,115200";
> +       };

Please drop the bootargs here, you definitely should not have 'earlyprintk'
in the bootargs because that is incompatible with cross-platform kernels.

Instead of passing the console in the bootargs, use the "stdout-path"
property.

The "compatible" property should be a list that contains at least the specific
SoC variant and an identifier for the board. "hpe,gxp" is way too generic
to be the only property here.
> +       gxp-init@cefe0010 {
> +               compatible = "hpe,gxp-cpu-init";
> +               reg = <0xcefe0010 0x04>;
> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0x40000000 0x20000000>;
> +       };
> +
> +       ahb {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               device_type = "soc";
> +               ranges;
> +
> +               vic0: interrupt-controller@ceff0000 {
> +                       compatible = "arm,pl192-vic";
> +                       interrupt-controller;
> +                       reg = <0xceff0000 0x1000>;
> +                       #interrupt-cells = <1>;
> +               };

I don't think this represents the actual hierarchy of the devices:
the register range of the "vic0" and the "gxp-init" is very close
together, which usually indicates that they are also on the same
bus.



> +               vic1: interrupt-controller@80f00000 {
> +                       compatible = "arm,pl192-vic";
> +                       interrupt-controller;
> +                       reg = <0x80f00000 0x1000>;
> +                       #interrupt-cells = <1>;
> +               };
> +
> +               timer0: timer@c0000080 {
> +                       compatible = "hpe,gxp-timer";
> +                       reg = <0xc0000080 0x1>, <0xc0000094 0x01>, <0xc0000088 0x08>;
> +                       interrupts = <0>;
> +                       interrupt-parent = <&vic0>;
> +                       clock-frequency = <400000000>;
> +               };
> +
> +               uarta: serial@c00000e0 {
> +                       compatible = "ns16550a";
> +                       reg = <0xc00000e0 0x8>;
> +                       interrupts = <17>;
> +                       interrupt-parent = <&vic0>;
> +                       clock-frequency = <1846153>;
> +                       reg-shift = <0>;
> +               };

In turn, you seem to have a lot of other devices on low addresses
of the 0xc0000000 range, which would be an indication that these
are on a different bus from the others.

Please see if you can find an internal datasheet that describes the
actual device hierarchy, and then try to model this in the device tree.

Use non-empty "ranges" properties to describe the address ranges
and how they get translated between these buses, and add
"dma-ranges" for any high-speed buses that have DMA master
capable devices like USB on them.

> +               i2cg: syscon@c00000f8 {
> +                       compatible = "simple-mfd", "syscon";
> +                       reg = <0xc00000f8 0x08>;
> +               };
> +       };

It's odd to have a "syscon" device that only has 8 bytes worth of registers.

What are the contents of this? Is it possible to have a proper abstraction
for it as something that has a specific purpose rather than being a
random collection of individual bits?

       Arnd
