Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF8494E15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbiATMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:42:00 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:41798 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbiATMl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1642682516; x=1674218516;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2UbXw6rwh7Qg3GbuvgvfQfsz8Tl8HW62dc2qMyTtY2Y=;
  b=OZEcP7mpYSTr7iSwZ6aB1+sKlRlcFOeLUDQyvlimGvkyhBayEjg4fVf/
   qEjZIA1Vkpd4KCsn0sQPA32ZLxzvmaA2efOPNVYQM6MWunxQaS6JuNwE6
   GMTxgIWSXtdV1Rmkevl8s61VLoO+H+Et4fKM/Yb0q0butHYcHUZMaGPDk
   f5fvglitSp9Xo2xSHFr8/5bY0kGg8Gv4zUFgM4AmyWOSTNnE6k6/ZFv0v
   1iXUlIfHAS4AWqFiELRvnBRxdj+hDVgYvI89jNU7czgtKGfW1AEslWBDg
   iMiJKJf7mQljEpU12EV8qm7t+MEe9tw2x4D5rBrLvwvbxYeMAtgTxtP50
   A==;
X-IronPort-AV: E=Sophos;i="5.88,302,1635199200"; 
   d="scan'208";a="21614559"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Jan 2022 13:41:54 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 20 Jan 2022 13:41:54 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 20 Jan 2022 13:41:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1642682514; x=1674218514;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2UbXw6rwh7Qg3GbuvgvfQfsz8Tl8HW62dc2qMyTtY2Y=;
  b=b0VufRiBR5MTrVGfR5D0iz1FtNRo2s+djWXsEF3xNf/uFcXyqeojWDDY
   Y0T4XrrLQiCt+QucTyvfm/los5/nCqNybS/XzAiEuST0l5F+pndM0kj6s
   1KxPjFPYix16jJY0+2Hd+qUG9+G5pnsP9lGkak+DE3p2VmL/ATZLO0NK3
   XUk5CPdFPSNAa92kV/4T9+TF02Q0wSIg0hApl2caNKAUwodCX/t70EIb8
   LyVvp6MGuXjBo6FnQ1KG6CETHIoQEx0L4oF512qrJrhf2E38vo7cT6e0N
   uWbP55NrghpiOhb6AwKKR6uJ+7vRiG0dnCayd45DrU5LN9GzEx5QI5D+2
   g==;
X-IronPort-AV: E=Sophos;i="5.88,302,1635199200"; 
   d="scan'208";a="21614558"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Jan 2022 13:41:54 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8D045280065;
        Thu, 20 Jan 2022 13:41:54 +0100 (CET)
Message-ID: <0a362c8ed3d3552befa9cf57ab778365d8cd0734.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jan.kiszka@siemens.com
Date:   Thu, 20 Jan 2022 13:41:52 +0100
In-Reply-To: <2982ff768a71247dfe0acb0e7af97a36041193bd.camel@ew.tq-group.com>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
         <2982ff768a71247dfe0acb0e7af97a36041193bd.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-20 at 13:32 +0100, Matthias Schiffer wrote:
> On Tue, 2022-01-11 at 12:25 +0100, Matthias Schiffer wrote:
> > All peripharals that require pinmuxing or other configuration to
> > work
> > should be disabled by default. Dependent DTS are adjusted
> > accordingly.
> > 
> > The following nodes are now "disabled" according to dtx_diff and
> > were
> > not
> > overridden to "okay", as they define no pinctrl:
> > 
> > k3-am654-base-board:
> > - mcu_i2c0
> > - mcu_spi0..2
> > - cal
> > - main_i2c3
> > - ehrpwm0..5
> > - main_uart1..2
> > - main_spi1..4
> > 
> > k3-am65-iot2050*:
> > - mci_spi1..2
> > - cal
> > - ehrpwm0..5
> > - main_spi0..4
> 
> I noticed that I didn't disable mcu_uart0 in k3-am65-mcu.dtsi, which
> would make sense for consistency. It is currently not disabled in
> k3-am654-base-board.dts either, but it doesn't have a pinmuxing
> defined. Does it work with the default muxing, or should it rather be
> disabled for that board?
> 

Ah, I found a mcu_uart0 pinmuxing in ti-u-boot's k3-am654-r5-base-
board.dts. So I assume that the muxing is installed by the bootloader,
and the kernel expects that this muxing is already in place, so that
mcu_uart0 can work? Is there a reason not to make the pinmuxing
explicit by copying it to the kernel's k3-am654-base-board.dts?



> I can send a v2 if this patch is acceptable at all (which would be
> desirable for the addition of our TQMa65xx SoM and MBa65xx carrier
> board, as it allows for a similar reduction of DTS lines as the one
> seen in the diffstat below for k3-am65-iot2050-common.dtsi and
> k3-am654-base-board.dts).




> 
> Kind regards,
> Matthias
> 
> 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> > 
> > These changes were not tested on hardware, and I'm not familiar
> > with
> > any of these boards, so it would be great if someone could check
> > whether the effective changes listed above are correct, or if some
> > of
> > these devices (in particular I2C, UART and PWM) are actually
> > connected
> > and work with the default pinmuxing.
> > 
> > There were also a few devices where I was unsure whether they are
> > optional
> > or not - for example one of the io2050 disables all the txpru
> > nodes,
> > so
> > maybe it would make sense to disable these in the SoC DTSI as well?
> > I
> > left
> > these nodes unchanged for now.
> > 
> >  .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |   4 -
> >  .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   7 +
> >  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 132 +++++---------
> > --
> > --
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  52 +++++++
> >  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  10 ++
> >  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |   2 +
> >  .../ti/k3-am6528-iot2050-basic-common.dtsi    |   6 +-
> >  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 129 +++-----------
> > --
> > -
> >  .../ti/k3-am6548-iot2050-advanced-common.dtsi |   5 +-
> >  9 files changed, 134 insertions(+), 213 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> > b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> > index 51f902fa35a7..746f0e89a305 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> > @@ -13,10 +13,6 @@ &dss {
> >  	assigned-clock-parents = <&k3_clks 67 5>;
> >  };
> >  
> > -&serdes0 {
> > -	status = "disabled";
> > -};
> > -
> >  &sdhci1 {
> >  	no-1-8-v;
> >  };
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> > b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> > index e73458ca6900..b769fe6fc072 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> > @@ -35,6 +35,7 @@ &dss {
> >  &serdes0 {
> >  	assigned-clocks = <&k3_clks 153 4>, <&serdes0
> > AM654_SERDES_CMU_REFCLK>;
> >  	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
> > +	status = "okay";
> >  };
> >  
> >  &dwc3_0 {
> > @@ -42,10 +43,16 @@ &dwc3_0 {
> >  				 <&k3_clks 151 8>;  /* set
> > PIPE3_TXB_CLK to WIZ8B2M4VSB */
> >  	phys = <&serdes0 PHY_TYPE_USB3 0>;
> >  	phy-names = "usb3-phy";
> > +	status = "okay";
> >  };
> >  
> >  &usb0 {
> >  	maximum-speed = "super-speed";
> >  	snps,dis-u1-entry-quirk;
> >  	snps,dis-u2-entry-quirk;
> > +	status = "okay";
> > +};
> > +
> > +&usb0_phy {
> > +	status = "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> > b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> > index 3079eaee01c0..873c123c611e 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> > @@ -362,15 +362,13 @@ &wkup_uart0 {
> >  &main_uart1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_uart1_pins_default>;
> > -};
> > -
> > -&main_uart2 {
> > -	status = "disabled";
> > +	status = "okay";
> >  };
> >  
> >  &mcu_uart0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&arduino_uart_pins_default>;
> > +	status = "okay";
> >  };
> >  
> >  &main_gpio0 {
> > @@ -416,12 +414,14 @@ &wkup_i2c0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&wkup_i2c0_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  };
> >  
> >  &mcu_i2c0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&mcu_i2c0_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  
> >  	psu: regulator@60 {
> >  		compatible = "ti,tps62363";
> > @@ -481,6 +481,7 @@ &main_i2c0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_i2c0_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  
> >  	rtc: rtc8564@51 {
> >  		compatible = "nxp,pcf8563";
> > @@ -498,12 +499,14 @@ &main_i2c1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_i2c1_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  };
> >  
> >  &main_i2c2 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_i2c2_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  };
> >  
> >  &main_i2c3 {
> > @@ -514,6 +517,8 @@ &main_i2c3 {
> >  	#address-cells = <1>;
> >  	#size-cells = <0>;
> >  
> > +	status = "okay";
> > +
> >  	edp-bridge@f {
> >  		compatible = "toshiba,tc358767";
> >  		reg = <0x0f>;
> > @@ -541,13 +546,10 @@ bridge_in: endpoint {
> >  	};
> >  };
> >  
> > -&mcu_cpsw {
> > -	status = "disabled";
> > -};
> > -
> >  &ecap0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&ecap0_pins_default>;
> > +	status = "okay";
> >  };
> >  
> >  &sdhci1 {
> > @@ -555,20 +557,38 @@ &sdhci1 {
> >  	pinctrl-0 = <&main_mmc1_pins_default>;
> >  	ti,driver-strength-ohm = <50>;
> >  	disable-wp;
> > +	status = "okay";
> > +};
> > +
> > +&dwc3_0 {
> > +	status = "okay";
> >  };
> >  
> > +
> >  &usb0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&usb0_pins_default>;
> >  	dr_mode = "host";
> >  };
> >  
> > +&usb0_phy {
> > +	status = "okay";
> > +};
> > +
> > +&dwc3_1 {
> > +	status = "okay";
> > +};
> > +
> >  &usb1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&usb1_pins_default>;
> >  	dr_mode = "host";
> >  };
> >  
> > +&usb1_phy {
> > +	status = "okay";
> > +};
> > +
> >  &mcu_spi0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&mcu_spi0_pins_default>;
> > @@ -576,13 +596,12 @@ &mcu_spi0 {
> >  	#address-cells = <1>;
> >  	#size-cells= <0>;
> >  	ti,pindir-d0-out-d1-in;
> > -};
> > -
> > -&tscadc0 {
> > -	status = "disabled";
> > +	status = "okay";
> >  };
> >  
> >  &tscadc1 {
> > +	status = "okay";
> > +
> >  	adc {
> >  		ti,adc-channels = <0 1 2 3 4 5>;
> >  	};
> > @@ -591,6 +610,7 @@ adc {
> >  &ospi0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> > +	status = "okay";
> >  
> >  	flash@0 {
> >  		compatible = "jedec,spi-nor";
> > @@ -611,6 +631,7 @@ flash@0 {
> >  &dss {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&dss_vout1_pins_default>;
> > +	status = "okay";
> >  
> >  	assigned-clocks = <&k3_clks 67 2>;
> >  	assigned-clock-parents = <&k3_clks 67 5>;
> > @@ -628,17 +649,14 @@ dpi_out: endpoint {
> >  	};
> >  };
> >  
> > -&pcie0_rc {
> > -	status = "disabled";
> > -};
> > -
> > -&pcie0_ep {
> > -	status = "disabled";
> > +&serdes1 {
> > +	status = "okay";
> >  };
> >  
> >  &pcie1_rc {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&minipcie_pins_default>;
> > +	status = "okay";
> >  
> >  	num-lanes = <1>;
> >  	phys = <&serdes1 PHY_TYPE_PCIE 0>;
> > @@ -646,20 +664,9 @@ &pcie1_rc {
> >  	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
> >  };
> >  
> > -&m_can0 {
> > -	status = "disabled";
> > -};
> > -
> > -&m_can1 {
> > -	status = "disabled";
> > -};
> > -
> > -&pcie1_ep {
> > -	status = "disabled";
> > -};
> > -
> >  &mailbox0_cluster0 {
> >  	interrupts = <436>;
> > +	status = "okay";
> >  
> >  	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
> >  		ti,mbox-tx = <1 0 0>;
> > @@ -669,6 +676,7 @@ mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
> >  
> >  &mailbox0_cluster1 {
> >  	interrupts = <432>;
> > +	status = "okay";
> >  
> >  	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
> >  		ti,mbox-tx = <1 0 0>;
> > @@ -676,46 +684,6 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
> >  	};
> >  };
> >  
> > -&mailbox0_cluster2 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster3 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster4 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster5 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster6 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster7 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster8 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster9 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster10 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster11 {
> > -	status = "disabled";
> > -};
> > -
> >  &mcu_r5fss0_core0 {
> >  	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> >  			<&mcu_r5fss0_core0_memory_region>;
> > @@ -727,27 +695,3 @@ &mcu_r5fss0_core1 {
> >  			<&mcu_r5fss0_core1_memory_region>;
> >  	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
> >  };
> > -
> > -&icssg0_mdio {
> > -	status = "disabled";
> > -};
> > -
> > -&icssg1_mdio {
> > -	status = "disabled";
> > -};
> > -
> > -&icssg2_mdio {
> > -	status = "disabled";
> > -};
> > -
> > -&mcasp0 {
> > -	status = "disabled";
> > -};
> > -
> > -&mcasp1 {
> > -	status = "disabled";
> > -};
> > -
> > -&mcasp2 {
> > -	status = "disabled";
> > -};
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > index ce8bb4a61011..5aa425d1ba80 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > @@ -64,6 +64,7 @@ serdes0: serdes@900000 {
> >  		ti,serdes-clk = <&serdes0_clk>;
> >  		#clock-cells = <1>;
> >  		mux-controls = <&serdes_mux 0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	serdes1: serdes@910000 {
> > @@ -79,6 +80,7 @@ serdes1: serdes@910000 {
> >  		ti,serdes-clk = <&serdes1_clk>;
> >  		#clock-cells = <1>;
> >  		mux-controls = <&serdes_mux 1>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_uart0: serial@2800000 {
> > @@ -88,6 +90,7 @@ main_uart0: serial@2800000 {
> >  		clock-frequency = <48000000>;
> >  		current-speed = <115200>;
> >  		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_uart1: serial@2810000 {
> > @@ -96,6 +99,7 @@ main_uart1: serial@2810000 {
> >  		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> >  		clock-frequency = <48000000>;
> >  		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_uart2: serial@2820000 {
> > @@ -104,6 +108,7 @@ main_uart2: serial@2820000 {
> >  		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> >  		clock-frequency = <48000000>;
> >  		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	crypto: crypto@4e00000 {
> > @@ -152,6 +157,7 @@ main_i2c0: i2c@2000000 {
> >  		clock-names = "fck";
> >  		clocks = <&k3_clks 110 1>;
> >  		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_i2c1: i2c@2010000 {
> > @@ -163,6 +169,7 @@ main_i2c1: i2c@2010000 {
> >  		clock-names = "fck";
> >  		clocks = <&k3_clks 111 1>;
> >  		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_i2c2: i2c@2020000 {
> > @@ -174,6 +181,7 @@ main_i2c2: i2c@2020000 {
> >  		clock-names = "fck";
> >  		clocks = <&k3_clks 112 1>;
> >  		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_i2c3: i2c@2030000 {
> > @@ -185,6 +193,7 @@ main_i2c3: i2c@2030000 {
> >  		clock-names = "fck";
> >  		clocks = <&k3_clks 113 1>;
> >  		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	ecap0: pwm@3100000 {
> > @@ -194,6 +203,7 @@ ecap0: pwm@3100000 {
> >  		power-domains = <&k3_pds 39 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&k3_clks 39 0>;
> >  		clock-names = "fck";
> > +		status = "disabled";
> >  	};
> >  
> >  	main_spi0: spi@2100000 {
> > @@ -206,6 +216,7 @@ main_spi0: spi@2100000 {
> >  		#size-cells = <0>;
> >  		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
> >  		dma-names = "tx0", "rx0";
> > +		status = "disabled";
> >  	};
> >  
> >  	main_spi1: spi@2110000 {
> > @@ -218,6 +229,7 @@ main_spi1: spi@2110000 {
> >  		#size-cells = <0>;
> >  		assigned-clocks = <&k3_clks 137 1>;
> >  		assigned-clock-rates = <48000000>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_spi2: spi@2120000 {
> > @@ -228,6 +240,7 @@ main_spi2: spi@2120000 {
> >  		power-domains = <&k3_pds 139 TI_SCI_PD_EXCLUSIVE>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_spi3: spi@2130000 {
> > @@ -238,6 +251,7 @@ main_spi3: spi@2130000 {
> >  		power-domains = <&k3_pds 140 TI_SCI_PD_EXCLUSIVE>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	main_spi4: spi@2140000 {
> > @@ -248,6 +262,7 @@ main_spi4: spi@2140000 {
> >  		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	sdhci0: mmc@4f80000 {
> > @@ -272,6 +287,7 @@ sdhci0: mmc@4f80000 {
> >  		ti,otap-del-sel-hs400 = <0x0>;
> >  		ti,trm-icp = <0x8>;
> >  		dma-coherent;
> > +		status = "disabled";
> >  	};
> >  
> >  	sdhci1: mmc@4fa0000 {
> > @@ -295,6 +311,7 @@ sdhci1: mmc@4fa0000 {
> >  		ti,otap-del-sel = <0x2>;
> >  		ti,trm-icp = <0x8>;
> >  		dma-coherent;
> > +		status = "disabled";
> >  	};
> >  
> >  	scm_conf: scm-conf@100000 {
> > @@ -361,6 +378,7 @@ dwc3_0: dwc3@4000000 {
> >  		assigned-clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
> >  		assigned-clock-parents = <&k3_clks 151 4>,	/*
> > set REF_CLK to 20MHz i.e. PER0_PLL/48 */
> >  					 <&k3_clks 151 9>;	/*
> > set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
> > +		status = "disabled";
> >  
> >  		usb0: usb@10000 {
> >  			compatible = "snps,dwc3";
> > @@ -386,6 +404,7 @@ usb0_phy: phy@4100000 {
> >  		clocks = <&k3_clks 151 0>, <&k3_clks 151 1>;
> >  		clock-names = "wkupclk", "refclk";
> >  		#phy-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	dwc3_1: dwc3@4020000 {
> > @@ -400,6 +419,7 @@ dwc3_1: dwc3@4020000 {
> >  		clocks = <&k3_clks 152 2>;
> >  		assigned-clocks = <&k3_clks 152 2>;
> >  		assigned-clock-parents = <&k3_clks 152 4>;	/*
> > set REF_CLK to 20MHz i.e. PER0_PLL/48 */
> > +		status = "disabled";
> >  
> >  		usb1: usb@10000 {
> >  			compatible = "snps,dwc3";
> > @@ -424,6 +444,7 @@ usb1_phy: phy@4110000 {
> >  		clocks = <&k3_clks 152 0>, <&k3_clks 152 1>;
> >  		clock-names = "wkupclk", "refclk";
> >  		#phy-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	intr_main_gpio: interrupt-controller@a00000 {
> > @@ -497,6 +518,7 @@ mailbox0_cluster0: mailbox@31f80000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster1: mailbox@31f81000 {
> > @@ -506,6 +528,7 @@ mailbox0_cluster1: mailbox@31f81000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster2: mailbox@31f82000 {
> > @@ -515,6 +538,7 @@ mailbox0_cluster2: mailbox@31f82000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster3: mailbox@31f83000 {
> > @@ -524,6 +548,7 @@ mailbox0_cluster3: mailbox@31f83000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster4: mailbox@31f84000 {
> > @@ -533,6 +558,7 @@ mailbox0_cluster4: mailbox@31f84000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster5: mailbox@31f85000 {
> > @@ -542,6 +568,7 @@ mailbox0_cluster5: mailbox@31f85000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster6: mailbox@31f86000 {
> > @@ -551,6 +578,7 @@ mailbox0_cluster6: mailbox@31f86000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster7: mailbox@31f87000 {
> > @@ -560,6 +588,7 @@ mailbox0_cluster7: mailbox@31f87000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster8: mailbox@31f88000 {
> > @@ -569,6 +598,7 @@ mailbox0_cluster8: mailbox@31f88000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster9: mailbox@31f89000 {
> > @@ -578,6 +608,7 @@ mailbox0_cluster9: mailbox@31f89000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster10: mailbox@31f8a000 {
> > @@ -587,6 +618,7 @@ mailbox0_cluster10: mailbox@31f8a000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		mailbox0_cluster11: mailbox@31f8b000 {
> > @@ -596,6 +628,7 @@ mailbox0_cluster11: mailbox@31f8b000 {
> >  			ti,mbox-num-users = <4>;
> >  			ti,mbox-num-fifos = <16>;
> >  			interrupt-parent = <&intr_main_navss>;
> > +			status = "disabled";
> >  		};
> >  
> >  		ringacc: ringacc@3c000000 {
> > @@ -703,6 +736,7 @@ pcie0_rc: pcie@5500000 {
> >  		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
> >  		msi-map = <0x0 &gic_its 0x0 0x10000>;
> >  		device_type = "pci";
> > +		status = "disabled";
> >  	};
> >  
> >  	pcie0_ep: pcie-ep@5500000 {
> > @@ -716,6 +750,7 @@ pcie0_ep: pcie-ep@5500000 {
> >  		max-link-speed = <2>;
> >  		dma-coherent;
> >  		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
> > +		status = "disabled";
> >  	};
> >  
> >  	pcie1_rc: pcie@5600000 {
> > @@ -736,6 +771,7 @@ pcie1_rc: pcie@5600000 {
> >  		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
> >  		msi-map = <0x0 &gic_its 0x10000 0x10000>;
> >  		device_type = "pci";
> > +		status = "disabled";
> >  	};
> >  
> >  	pcie1_ep: pcie-ep@5600000 {
> > @@ -749,6 +785,7 @@ pcie1_ep: pcie-ep@5600000 {
> >  		max-link-speed = <2>;
> >  		dma-coherent;
> >  		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
> > +		status = "disabled";
> >  	};
> >  
> >  	mcasp0: mcasp@2b00000 {
> > @@ -766,6 +803,7 @@ mcasp0: mcasp@2b00000 {
> >  		clocks = <&k3_clks 104 0>;
> >  		clock-names = "fck";
> >  		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	mcasp1: mcasp@2b10000 {
> > @@ -783,6 +821,7 @@ mcasp1: mcasp@2b10000 {
> >  		clocks = <&k3_clks 105 0>;
> >  		clock-names = "fck";
> >  		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	mcasp2: mcasp@2b20000 {
> > @@ -800,6 +839,7 @@ mcasp2: mcasp@2b20000 {
> >  		clocks = <&k3_clks 106 0>;
> >  		clock-names = "fck";
> >  		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	cal: cal@6f03000 {
> > @@ -813,6 +853,7 @@ cal: cal@6f03000 {
> >  		clock-names = "fck";
> >  		clocks = <&k3_clks 2 0>;
> >  		power-domains = <&k3_pds 2 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  
> >  		ports {
> >  			#address-cells = <1>;
> > @@ -857,6 +898,8 @@ dss: dss@4a00000 {
> >  
> >  		dma-coherent;
> >  
> > +		status = "disabled";
> > +
> >  		dss_ports: ports {
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> > @@ -870,6 +913,7 @@ ehrpwm0: pwm@3000000 {
> >  		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 40 0>;
> >  		clock-names = "tbclk", "fck";
> > +		status = "disabled";
> >  	};
> >  
> >  	ehrpwm1: pwm@3010000 {
> > @@ -879,6 +923,7 @@ ehrpwm1: pwm@3010000 {
> >  		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 41 0>;
> >  		clock-names = "tbclk", "fck";
> > +		status = "disabled";
> >  	};
> >  
> >  	ehrpwm2: pwm@3020000 {
> > @@ -888,6 +933,7 @@ ehrpwm2: pwm@3020000 {
> >  		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 42 0>;
> >  		clock-names = "tbclk", "fck";
> > +		status = "disabled";
> >  	};
> >  
> >  	ehrpwm3: pwm@3030000 {
> > @@ -897,6 +943,7 @@ ehrpwm3: pwm@3030000 {
> >  		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 43 0>;
> >  		clock-names = "tbclk", "fck";
> > +		status = "disabled";
> >  	};
> >  
> >  	ehrpwm4: pwm@3040000 {
> > @@ -906,6 +953,7 @@ ehrpwm4: pwm@3040000 {
> >  		power-domains = <&k3_pds 44 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 44 0>;
> >  		clock-names = "tbclk", "fck";
> > +		status = "disabled";
> >  	};
> >  
> >  	ehrpwm5: pwm@3050000 {
> > @@ -915,6 +963,7 @@ ehrpwm5: pwm@3050000 {
> >  		power-domains = <&k3_pds 45 TI_SCI_PD_EXCLUSIVE>;
> >  		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 45 0>;
> >  		clock-names = "tbclk", "fck";
> > +		status = "disabled";
> >  	};
> >  
> >  	icssg0: icssg@b000000 {
> > @@ -1055,6 +1104,7 @@ icssg0_mdio: mdio@32400 {
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> >  			bus_freq = <1000000>;
> > +			status = "disabled";
> >  		};
> >  	};
> >  
> > @@ -1196,6 +1246,7 @@ icssg1_mdio: mdio@32400 {
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> >  			bus_freq = <1000000>;
> > +			status = "disabled";
> >  		};
> >  	};
> >  
> > @@ -1337,6 +1388,7 @@ icssg2_mdio: mdio@32400 {
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> >  			bus_freq = <1000000>;
> > +			status = "disabled";
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > index 8d592bf41d6f..50f26e96276f 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > @@ -46,6 +46,7 @@ mcu_i2c0: i2c@40b00000 {
> >  		clock-names = "fck";
> >  		clocks = <&k3_clks 114 1>;
> >  		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	mcu_spi0: spi@40300000 {
> > @@ -56,6 +57,7 @@ mcu_spi0: spi@40300000 {
> >  		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	mcu_spi1: spi@40310000 {
> > @@ -66,6 +68,7 @@ mcu_spi1: spi@40310000 {
> >  		power-domains = <&k3_pds 143 TI_SCI_PD_EXCLUSIVE>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	mcu_spi2: spi@40320000 {
> > @@ -76,6 +79,7 @@ mcu_spi2: spi@40320000 {
> >  		power-domains = <&k3_pds 144 TI_SCI_PD_EXCLUSIVE>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		status = "disabled";
> >  	};
> >  
> >  	tscadc0: tscadc@40200000 {
> > @@ -89,6 +93,7 @@ tscadc0: tscadc@40200000 {
> >  		dmas = <&mcu_udmap 0x7100>,
> >  			<&mcu_udmap 0x7101 >;
> >  		dma-names = "fifo0", "fifo1";
> > +		status = "disabled";
> >  
> >  		adc {
> >  			#io-channel-cells = <1>;
> > @@ -107,6 +112,7 @@ tscadc1: tscadc@40210000 {
> >  		dmas = <&mcu_udmap 0x7102>,
> >  			<&mcu_udmap 0x7103>;
> >  		dma-names = "fifo0", "fifo1";
> > +		status = "disabled";
> >  
> >  		adc {
> >  			#io-channel-cells = <1>;
> > @@ -172,6 +178,7 @@ m_can0: mcan@40528000 {
> >  			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
> >  		interrupt-names = "int0", "int1";
> >  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> > +		status = "disabled";
> >  	};
> >  
> >  	m_can1: mcan@40568000 {
> > @@ -187,6 +194,7 @@ m_can1: mcan@40568000 {
> >  			     <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>;
> >  		interrupt-names = "int0", "int1";
> >  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> > +		status = "disabled";
> >  	};
> >  
> >  	fss: fss@47000000 {
> > @@ -252,6 +260,8 @@ mcu_cpsw: ethernet@46000000 {
> >  			    "tx4", "tx5", "tx6", "tx7",
> >  			    "rx";
> >  
> > +		status = "disabled";
> > +
> >  		ethernet-ports {
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> > b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> > index 9c69d0917f69..8f0c505a16ed 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> > @@ -54,6 +54,7 @@ wkup_uart0: serial@42300000 {
> >  		clock-frequency = <48000000>;
> >  		current-speed = <115200>;
> >  		power-domains = <&k3_pds 150 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	wkup_i2c0: i2c@42120000 {
> > @@ -65,6 +66,7 @@ wkup_i2c0: i2c@42120000 {
> >  		clock-names = "fck";
> >  		clocks = <&k3_clks 115 1>;
> >  		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> >  	};
> >  
> >  	intr_wkup_gpio: interrupt-controller@42200000 {
> > diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-
> > common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-
> > common.dtsi
> > index 4a9bf7d7c07d..29f539cc2392 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> > @@ -29,11 +29,6 @@ cpu-map {
> >  	/delete-node/ l2-cache1;
> >  };
> >  
> > -/* eMMC */
> > -&sdhci0 {
> > -	status = "disabled";
> > -};
> > -
> >  &main_pmx0 {
> >  	main_uart0_pins_default: main-uart0-pins-default {
> >  		pinctrl-single,pins = <
> > @@ -52,6 +47,7 @@ AM65X_IOPAD(0x0194, PIN_INPUT,  1)  /* (E24)
> > UART0_RIN */
> >  &main_uart0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_uart0_pins_default>;
> > +	status = "okay";
> >  };
> >  
> >  &mcu_r5fss0 {
> > diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> > b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> > index 9043f91c9bec..821ee7f2eff0 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> > @@ -275,12 +275,14 @@ &main_uart0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_uart0_pins_default>;
> >  	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> > +	status = "okay";
> >  };
> >  
> >  &wkup_i2c0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&wkup_i2c0_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  
> >  	pca9554: gpio@39 {
> >  		compatible = "nxp,pca9554";
> > @@ -300,6 +302,7 @@ &main_i2c0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_i2c0_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  
> >  	pca9555: gpio@21 {
> >  		compatible = "nxp,pca9555";
> > @@ -313,17 +316,20 @@ &main_i2c1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_i2c1_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  };
> >  
> >  &main_i2c2 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_i2c2_pins_default>;
> >  	clock-frequency = <400000>;
> > +	status = "okay";
> >  };
> >  
> >  &ecap0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&ecap0_pins_default>;
> > +	status = "okay";
> >  };
> >  
> >  &main_spi0 {
> > @@ -332,6 +338,7 @@ &main_spi0 {
> >  	#address-cells = <1>;
> >  	#size-cells= <0>;
> >  	ti,pindir-d0-out-d1-in;
> > +	status = "okay";
> >  
> >  	flash@0{
> >  		compatible = "jedec,spi-nor";
> > @@ -351,6 +358,7 @@ &sdhci0 {
> >  	non-removable;
> >  	ti,driver-strength-ohm = <50>;
> >  	disable-wp;
> > +	status = "okay";
> >  };
> >  
> >  /*
> > @@ -364,6 +372,11 @@ &sdhci1 {
> >  	pinctrl-0 = <&main_mmc1_pins_default>;
> >  	ti,driver-strength-ohm = <50>;
> >  	disable-wp;
> > +	status = "okay";
> > +};
> > +
> > +&dwc3_1 {
> > +	status = "okay";
> >  };
> >  
> >  &usb1 {
> > @@ -372,60 +385,29 @@ &usb1 {
> >  	dr_mode = "otg";
> >  };
> >  
> > -&dwc3_0 {
> > -	status = "disabled";
> > -};
> > -
> > -&usb0_phy {
> > -	status = "disabled";
> > +&usb1_phy {
> > +	status = "okay";
> >  };
> >  
> >  &tscadc0 {
> > +	status = "okay";
> > +
> >  	adc {
> >  		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> >  	};
> >  };
> >  
> >  &tscadc1 {
> > +	status = "okay";
> > +
> >  	adc {
> >  		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> >  	};
> >  };
> >  
> > -&serdes0 {
> > -	status = "disabled";
> > -};
> > -
> > -&serdes1 {
> > -	status = "disabled";
> > -};
> > -
> > -&pcie0_rc {
> > -	status = "disabled";
> > -};
> > -
> > -&pcie0_ep {
> > -	status = "disabled";
> > -};
> > -
> > -&pcie1_rc {
> > -	status = "disabled";
> > -};
> > -
> > -&pcie1_ep {
> > -	status = "disabled";
> > -};
> > -
> > -&m_can0 {
> > -	status = "disabled";
> > -};
> > -
> > -&m_can1 {
> > -	status = "disabled";
> > -};
> > -
> >  &mailbox0_cluster0 {
> >  	interrupts = <436>;
> > +	status = "okay";
> >  
> >  	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
> >  		ti,mbox-tx = <1 0 0>;
> > @@ -435,6 +417,7 @@ mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
> >  
> >  &mailbox0_cluster1 {
> >  	interrupts = <432>;
> > +	status = "okay";
> >  
> >  	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
> >  		ti,mbox-tx = <1 0 0>;
> > @@ -442,46 +425,6 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
> >  	};
> >  };
> >  
> > -&mailbox0_cluster2 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster3 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster4 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster5 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster6 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster7 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster8 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster9 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster10 {
> > -	status = "disabled";
> > -};
> > -
> > -&mailbox0_cluster11 {
> > -	status = "disabled";
> > -};
> > -
> >  &mcu_r5fss0_core0 {
> >  	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> >  			<&mcu_r5fss0_core0_memory_region>;
> > @@ -497,6 +440,7 @@ &mcu_r5fss0_core1 {
> >  &ospi0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> > +	status = "okay";
> >  
> >  	flash@0{
> >  		compatible = "jedec,spi-nor";
> > @@ -517,6 +461,7 @@ flash@0{
> >  &mcu_cpsw {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
> > +	status = "okay";
> >  };
> >  
> >  &davinci_mdio {
> > @@ -531,31 +476,3 @@ &cpsw_port1 {
> >  	phy-mode = "rgmii-rxid";
> >  	phy-handle = <&phy0>;
> >  };
> > -
> > -&mcasp0 {
> > -	status = "disabled";
> > -};
> > -
> > -&mcasp1 {
> > -	status = "disabled";
> > -};
> > -
> > -&mcasp2 {
> > -	status = "disabled";
> > -};
> > -
> > -&dss {
> > -	status = "disabled";
> > -};
> > -
> > -&icssg0_mdio {
> > -	status = "disabled";
> > -};
> > -
> > -&icssg1_mdio {
> > -	status = "disabled";
> > -};
> > -
> > -&icssg2_mdio {
> > -	status = "disabled";
> > -};
> > diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-
> > common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-
> > common.dtsi
> > index d25e8b26187f..731224ec5c36 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> > @@ -49,8 +49,5 @@ &sdhci0 {
> >  	non-removable;
> >  	ti,driver-strength-ohm = <50>;
> >  	disable-wp;
> > -};
> > -
> > -&main_uart0 {
> > -	status = "disabled";
> > +	status = "okay";
> >  };

