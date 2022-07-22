Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030157E18E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiGVMoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiGVMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:44:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4EB79ECA;
        Fri, 22 Jul 2022 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658493850; x=1690029850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W0sFA/l5oPmT6yt5Cj3SdBXAuDc79F8wDLQNYoDx+VI=;
  b=A+5uIvtQtLEPF7HHc17fyfUThTx/gZ577Zv/Gzt7n5jLiNAHpQG7SiMq
   I8FxEBauw5gm5L/Z//+gFDEwO/jO2H2wPv2watwRqNaURW6dpfkGg/PIY
   Aap8JACNCDPDLWsgwPIMQm8FLlq0Om0AK0H/lsLkYey/xIOvTX+4AO+6B
   g+fqGMaEvq+KevXLFADAybDqRjTu39hTc+DQgDKRcJXCOwxYbgYhwOZTv
   AMyVEg03SJ8dEw24FlfuOFU9TljMe7jfDUJtxJt3KHnFcCuIDqVfpOL2P
   GMDNp4Op5T6HTZG64lnLTxD1AroC6TFjdJ88A4viqClSUDNblEs2KY9Ds
   A==;
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="105696875"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2022 05:44:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Jul 2022 05:44:09 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 05:44:09 -0700
Date:   Fri, 22 Jul 2022 14:48:18 +0200
From:   Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/2] ARM: dts: lan966x: add support for pcb8309
Message-ID: <20220722124818.k42twnzd6wpz3inp@soft-dev3-1.localhost>
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
 <20220720194904.2025384-3-horatiu.vultur@microchip.com>
 <89d7f6cc-a22d-b428-4677-f918df25901d@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <89d7f6cc-a22d-b428-4677-f918df25901d@microchip.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/21/2022 07:39, Claudiu Beznea - M18063 wrote:
> > +&flx4 {
> > +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> > +	status = "okay";
> 
> Embed i2c4 node here as you did for usart3 above. It's easy to follow the
> connection b/w flx node and it's enabled child.

Yes, I will do that.

> 
> > +};
> > +
> > +&gpio {
> > +	fc3_b_pins: fc3-b-pins {
> > +		/* RXD, TXD */
> > +		pins = "GPIO_52", "GPIO_53";
> > +		function = "fc3_b";
> > +	};
> > +
> > +	fc4_b_pins: fc4-b-pins {
> > +		/* SCL, SDA */
> > +		pins = "GPIO_57", "GPIO_58";
> > +		function = "fc4_b";
> > +	};
> > +
> > +	sgpio_a_pins: sgpio-a-pins {
> > +		/* SCK, D0, D1, LD */
> > +		pins = "GPIO_32", "GPIO_33", "GPIO_34", "GPIO_35";
> > +		function = "sgpio_a";
> > +	};
> > +};
> > +
> > +&i2c4 {
> > +	compatible = "microchip,sam9x60-i2c";
> > +	reg = <0x600 0x200>;
> > +	interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	clocks = <&nic_clk>;
> > +	pinctrl-0 = <&fc4_b_pins>;
> > +	pinctrl-names = "default";
> > +	i2c-analog-filter;
> > +	i2c-digital-filter;
> > +	i2c-digital-filter-width-ns = <35>;
> > +	i2c-sda-hold-time-ns = <1500>;
> > +	status = "okay";
> > +};
> > +
> > +&mdio1 {
> > +	status = "okay";
> > +};
> > +
> > +&phy0 {
> > +	status = "okay";
> > +};
> > +
> > +&phy1 {
> > +	status = "okay";
> > +};
> > +
> > +&port0 {
> > +	status = "okay";
> 
> Keep status at the end of node description for uniformity with the nodes
> enabled above. Same for the rest of nodes below.

OK. I will do that in the next version.

> 
> > +	phy-handle = <&phy0>;
> > +	phy-mode = "gmii";
> > +	phys = <&serdes 0 CU(0)>;
> > +};
> > +
> > +&port1 {
> > +	status = "okay";
> > +	phy-handle = <&phy1>;
> > +	phy-mode = "gmii";
> > +	phys = <&serdes 1 CU(1)>;
> > +};
> > +
> > +&port2 {
> > +	status = "okay";
> > +	sfp = <&sfp2>;
> > +	managed = "in-band-status";
> > +	phy-mode = "sgmii";
> > +	phys = <&serdes 2 SERDES6G(0)>;
> > +};
> > +
> > +&port3 {
> > +	status = "okay";
> > +	sfp = <&sfp3>;
> > +	managed = "in-band-status";
> > +	phy-mode = "sgmii";
> > +	phys = <&serdes 3 SERDES6G(1)>;
> > +};
> > +
> > +&serdes {
> > +	status = "okay";
> > +};
> > +
> > +&sgpio {
> > +	status = "okay";
> > +	pinctrl-0 = <&sgpio_a_pins>;
> > +	pinctrl-names = "default";
> > +	microchip,sgpio-port-ranges = <0 3>, <8 11>;
> 
> Except this one. For this would be nice to have status here before
> describing childs.

OK. I will do that in the next version.

> 
> > +	gpio@0 {
> > +		ngpios = <64>;
> > +	};
> > +	gpio@1 {
> > +		ngpios = <64>;
> > +	};
> > +};
> > +
> > +&switch {
> > +	status = "okay";
> > +};
> 

-- 
/Horatiu
