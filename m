Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0317D51FD8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiEINLd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 May 2022 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiEINLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:11:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F423EB57;
        Mon,  9 May 2022 06:07:34 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1no36j-0006No-PZ; Mon, 09 May 2022 15:07:25 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        mail@conchuod.ie, Conor.Dooley@microchip.com
Cc:     Cyril.Jean@microchip.com, Daire.McNamara@microchip.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        palmer@rivosinc.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 8/8] riscv: dts: microchip: add the sundance polarberry
Date:   Mon, 09 May 2022 15:07:24 +0200
Message-ID: <3665104.kQq0lBPeGt@diego>
In-Reply-To: <5de89e89-c30d-d9fc-4ef7-f4c0327a28e8@microchip.com>
References: <20220504203051.1210355-1-mail@conchuod.ie> <8060906.T7Z3S40VBb@diego> <5de89e89-c30d-d9fc-4ef7-f4c0327a28e8@microchip.com>
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

Am Montag, 9. Mai 2022, 13:24:12 CEST schrieb Conor.Dooley@microchip.com:
> On 09/05/2022 12:10, Heiko Stübner wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Am Mittwoch, 4. Mai 2022, 22:30:52 CEST schrieb Conor Dooley:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> Add a minimal device tree for the PolarFire SoC based Sundance
> >> PolarBerry.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>   arch/riscv/boot/dts/microchip/Makefile        |  1 +
> >>   .../dts/microchip/mpfs-polarberry-fabric.dtsi | 16 +++
> >>   .../boot/dts/microchip/mpfs-polarberry.dts    | 97 +++++++++++++++++++
> >>   3 files changed, 114 insertions(+)
> >>   create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
> >>   create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> >>
> >> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> >> index af3a5059b350..39aae7b04f1c 100644
> >> --- a/arch/riscv/boot/dts/microchip/Makefile
> >> +++ b/arch/riscv/boot/dts/microchip/Makefile
> >> @@ -1,3 +1,4 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >>   dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
> >> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
> >>   obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
> >> diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
> >> new file mode 100644
> >> index 000000000000..49380c428ec9
> >> --- /dev/null
> >> +++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
> >> @@ -0,0 +1,16 @@
> >> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >> +/* Copyright (c) 2020-2022 Microchip Technology Inc */
> >> +
> >> +/ {
> >> +     fabric_clk3: fabric-clk3 {
> >> +             compatible = "fixed-clock";
> >> +             #clock-cells = <0>;
> >> +             clock-frequency = <62500000>;
> >> +     };
> >> +
> >> +     fabric_clk1: fabric-clk1 {
> >> +             compatible = "fixed-clock";
> >> +             #clock-cells = <0>;
> >> +             clock-frequency = <125000000>;
> >> +     };
> >> +};
> >> diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> >> new file mode 100644
> >> index 000000000000..1cad5b0d42e1
> >> --- /dev/null
> >> +++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> >> @@ -0,0 +1,97 @@
> >> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >> +/* Copyright (c) 2020-2022 Microchip Technology Inc */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "mpfs.dtsi"
> >> +#include "mpfs-polarberry-fabric.dtsi"
> >> +
> >> +/* Clock frequency (in Hz) of the rtcclk */
> >> +#define MTIMER_FREQ  1000000
> >> +
> >> +/ {
> >> +     model = "Sundance PolarBerry";
> >> +     compatible = "sundance,polarberry", "microchip,mpfs";
> >> +
> >> +     aliases {
> >> +             ethernet0 = &mac1;
> >> +             serial0 = &mmuart0;
> >> +     };
> >> +
> >> +     chosen {
> >> +             stdout-path = "serial0:115200n8";
> >> +     };
> >> +
> >> +     cpus {
> >> +             timebase-frequency = <MTIMER_FREQ>;
> >> +     };
> >> +
> >> +     ddrc_cache_lo: memory@80000000 {
> >> +             device_type = "memory";
> >> +             reg = <0x0 0x80000000 0x0 0x2e000000>;
> >> +     };
> >> +
> >> +     ddrc_cache_hi: memory@1000000000 {
> >> +             device_type = "memory";
> >> +             reg = <0x10 0x00000000 0x0 0xC0000000>;
> >> +     };
> >> +};
> >> +
> >> +/*
> >> + * phy0 is connected to mac0, but the port itself is on the (optional) carrier
> >> + * board.
> >> + */
> >> +&mac0 {
> >> +     status = "disabled";
> >> +     phy-mode = "sgmii";
> >> +     phy-handle = <&phy0>;
> > 
> > nit: it makes it was easier recognizing the status if it's in the
> > same place all the time (for example as the last property)
> > like in &mmc below.
> > 
> > Though that may just be my preference ;-) .
> > The other option would be to adhere to stricter sorting
> > because right now status is neither in one place nor sorted.
> 
> My I had it in my head (and correct me if I am wrong please), that it is
> okay to sort the phys after the status. It doesn't matter either way to
> me, but there are plenty of dts that do it this way.
> 
> I don't care either way, so I am happy to change if those are bad examples
> to follow!

I guess which order to follow really is more a matter of taste and I
don't think there is a definitive rulebook on what belongs where ;-) .

Though from past experience I do know that it makes reading devicetrees
easier when you know which property to expect in which place - especially
when their number increases and right now you have status above here,
and below everything else in the mmc node for example.

In the end Palmer might not care that much about tiny odering
differences, but I do think following one scheme is definitively an
advantage over mixing different ones.


Heiko


> >> +};
> >> +
> >> +&mac1 {
> >> +     status = "okay";
> >> +     phy-mode = "sgmii";
> >> +     phy-handle = <&phy1>;
> > 
> > nit (1): same as above
> > nit (2): blank line between properties and subnodes makes
> >    everything more readable.
> 
> Aye, not wrong. I'll fix this regardless of what happens with
> the status ordering.
> Thanks,
> Conor.
> 
> > 
> >> +     phy1: ethernet-phy@5 {
> >> +             reg = <5>;
> >> +             ti,fifo-depth = <0x01>;
> >> +     };
> > 
> > nit: blank line?
> > 
> > Otherwise:
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > 
> >> +     phy0: ethernet-phy@4 {
> >> +             reg = <4>;
> >> +             ti,fifo-depth = <0x01>;
> >> +     };
> >> +};
> >> +
> >> +&mbox {
> >> +     status = "okay";
> >> +};
> >> +
> >> +&mmc {
> >> +     bus-width = <4>;
> >> +     disable-wp;
> >> +     cap-sd-highspeed;
> >> +     cap-mmc-highspeed;
> >> +     card-detect-delay = <200>;
> >> +     mmc-ddr-1_8v;
> >> +     mmc-hs200-1_8v;
> >> +     sd-uhs-sdr12;
> >> +     sd-uhs-sdr25;
> >> +     sd-uhs-sdr50;
> >> +     sd-uhs-sdr104;
> >> +     status = "okay";
> >> +};
> >> +
> >> +&mmuart0 {
> >> +     status = "okay";
> >> +};
> >> +
> >> +&refclk {
> >> +     clock-frequency = <125000000>;
> >> +};
> >> +
> >> +&rtc {
> >> +     status = "okay";
> >> +};
> >> +
> >> +&syscontroller {
> >> +     status = "okay";
> >> +};
> >>
> > 
> > 
> > 
> > 
> 
> 




