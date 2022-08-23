Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F159ED08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiHWUE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiHWUED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:04:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B03E084;
        Tue, 23 Aug 2022 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661282278; x=1692818278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=od9EKCDhRArRaGPV2RxuCjiGWzeVGL06v4Tyo/Ik6Ls=;
  b=TMy7qufY/YNWxZ1Tfohep6rWZSi5WMlwyh/QBGCVT/8ylsO1FAMQX20B
   iEND5axQAKeVmDPnSAN5acEFJBbra9GYwtbGsRzKJdy5XCxH1sgVfBLXH
   wgvaRPsu68WnDvr41T0HWtktERkikmf/xvQFtghBGSF4KiwsYXK01qBiK
   42GKozRxtaWIKJwhbvSY5glMH04TvMKWIjYP+XqMZm2R6EOr4F/UfqrFm
   qq3mleOGV5qaWuTsF3cVpSIOu+RdoxnyoYWLM9lEF6jSlltxnkNn7/Jcx
   NzyV21WAxKdR+6VhHQOxNPOy9j5P7ngkY3OVfO473V9j/O9uxnaB8zVKj
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="187761601"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2022 12:17:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 23 Aug 2022 12:17:56 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 23 Aug 2022 12:17:56 -0700
Date:   Tue, 23 Aug 2022 21:22:10 +0200
From:   Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH] ARM: dts: lan966x: add support for pcb8290
Message-ID: <20220823192210.cnkxmdb2eryg4hnz@soft-dev3-1.localhost>
References: <20220817190027.1632721-1-horatiu.vultur@microchip.com>
 <8e6c780e-28ee-1f37-c14c-f0ca5f590743@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <8e6c780e-28ee-1f37-c14c-f0ca5f590743@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/23/2022 07:11, Claudiu Beznea - M18063 wrote:

Hi Claudiu,

> > +&gpio {
> > +	miim_a_pins: mdio-pins {
> > +		/* MDC, MDIO */
> > +		pins =  "GPIO_28", "GPIO_29";
> > +		function = "miim_a";
> > +	};
> > +
> > +	pps_out_pins: pps-out-pins {
> 
> Can you also document this one as well? I can do it while applying if you
> provide the strings.

Yes, I will do that.
I will send a new version because I have seen that there is also a small
error in the commit message.

> 
> > +		pins = "GPIO_38";
> > +		function = "ptpsync_3";
> > +	};
> > +
> > +	ptp_ext_pins: ptp-ext-pins {
> 
> Ditto
> 
> Thank you,
> Claudiu Beznea
> 
> > +		pins = "GPIO_35";
> > +		function = "ptpsync_0";
> > +	};
> > +
> > +	udc_pins: ucd-pins {
> > +		/* VBUS_DET B */
> > +		pins = "GPIO_8";
> > +		function = "usb_slave_b";
> > +	};
> > +};
> > +
> > +&mdio0 {
> > +	pinctrl-0 = <&miim_a_pins>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +
> > +	ext_phy0: ethernet-phy@7 {
> > +		reg = <7>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	ext_phy1: ethernet-phy@8 {
> > +		reg = <8>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	ext_phy2: ethernet-phy@9 {
> > +		reg = <9>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	ext_phy3: ethernet-phy@10 {
> > +		reg = <10>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	ext_phy4: ethernet-phy@15 {
> > +		reg = <15>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	ext_phy5: ethernet-phy@16 {
> > +		reg = <16>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	ext_phy6: ethernet-phy@17 {
> > +		reg = <17>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	ext_phy7: ethernet-phy@18 {
> > +		reg = <18>;
> > +		coma-mode-gpios = <&gpio 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +};
> > +
> > +&port0 {
> > +	reg = <2>;
> > +	phy-handle = <&ext_phy2>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 0 SERDES6G(1)>;
> > +	status = "okay";
> > +};
> > +
> > +&port1 {
> > +	reg = <3>;
> > +	phy-handle = <&ext_phy3>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 1 SERDES6G(1)>;
> > +	status = "okay";
> > +};
> > +
> > +&port2 {
> > +	reg = <0>;
> > +	phy-handle = <&ext_phy0>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 2 SERDES6G(1)>;
> > +	status = "okay";
> > +};
> > +
> > +&port3 {
> > +	reg = <1>;
> > +	phy-handle = <&ext_phy1>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 3 SERDES6G(1)>;
> > +	status = "okay";
> > +};
> > +
> > +&port4 {
> > +	reg = <6>;
> > +	phy-handle = <&ext_phy6>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 4 SERDES6G(2)>;
> > +	status = "okay";
> > +};
> > +
> > +&port5 {
> > +	reg = <7>;
> > +	phy-handle = <&ext_phy7>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 5 SERDES6G(2)>;
> > +	status = "okay";
> > +};
> > +
> > +&port6 {
> > +	reg = <4>;
> > +	phy-handle = <&ext_phy4>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 6 SERDES6G(2)>;
> > +	status = "okay";
> > +};
> > +
> > +&port7 {
> > +	reg = <5>;
> > +	phy-handle = <&ext_phy5>;
> > +	phy-mode = "qsgmii";
> > +	phys = <&serdes 7 SERDES6G(2)>;
> > +	status = "okay";
> > +};
> > +
> > +&serdes {
> > +	status = "okay";
> > +};
> > +
> > +&switch {
> > +	pinctrl-0 = <&pps_out_pins>, <&ptp_ext_pins>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};
> > +
> > +&udc {
> > +	pinctrl-0 = <&udc_pins>;
> > +	pinctrl-names = "default";
> > +	atmel,vbus-gpio = <&gpio 8 GPIO_ACTIVE_HIGH>;
> > +	status = "okay";
> > +};
> 

-- 
/Horatiu
