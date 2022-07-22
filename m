Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9345E57E189
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiGVMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiGVMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:42:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48DE0CA;
        Fri, 22 Jul 2022 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658493735; x=1690029735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=khPSA7SdeZvexVlLJVFq2jEQ1fN3eCp5D1jxG3kOEnY=;
  b=LtIxRKMZLMD/LHGNwY9MP6yohL7DBQ5jdcy424nN09S/elT5Ingf1pqe
   f+FzD0erzChbLkJniH/F7My98Z802xQiGSoKZyAW/GtDL2X6AdDv96mGw
   S+Ut1DpVylrzN3GVfGkQKkuQiYlZGMn+RTpShN3FqcOXWEMnnzGUkqPwX
   /oPQ48qDRo2aSTWG0m2Epoj/SSDy+seF73L7VDo5C+7F3t8rQZ1F+Qo4t
   XmQ4jwz5KveIH5d6Dnvimsu0GHf/av0Vc9XIqoaWXX08hP2MbNBFxyEBg
   2Hj6yoZg0TlzzPenKntrWpbCIJswGgVx0LFJGksr+lDWUjLTXtXiWpepI
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="169063672"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2022 05:42:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Jul 2022 05:42:12 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 22 Jul 2022 05:42:12 -0700
Date:   Fri, 22 Jul 2022 14:46:20 +0200
From:   Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To:     Kavyasree Kotagiri - I30978 <Kavyasree.Kotagiri@microchip.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea - M18063" <Claudiu.Beznea@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: lan966x: add support for pcb8309
Message-ID: <20220722124620.khueuxinijmwgot5@soft-dev3-1.localhost>
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
 <20220720194904.2025384-3-horatiu.vultur@microchip.com>
 <CO1PR11MB4865A1118ACB74B06408BBC792919@CO1PR11MB4865.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4865A1118ACB74B06408BBC792919@CO1PR11MB4865.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/21/2022 06:08, Kavyasree Kotagiri - I30978 wrote:
> > +	i2c-mux {
> > +		compatible = "i2c-mux";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		mux-controls = <&mux>;
> > +		i2c-parent = <&i2c4>;
> > +
> > +		i2c102: i2c-sfp@1 {
> > +			reg = <1>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> Why do you need #address-cells and #size-cells here?
> > +		};
> > +
> > +		i2c103: i2c-sfp@2 {
> > +			reg = <2>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> Same here
> > +		};
> > +	};

They are not needed. I will remove them in the next version.
> > +
> > +	mux: mux-controller {
> > +		compatible = "gpio-mux";
> > +		#mux-control-cells = <0>;
> > +
> > +		mux-gpios = <&sgpio_out 11 0 GPIO_ACTIVE_HIGH>, /*
> > p11b0 */
> > +			    <&sgpio_out 11 1 GPIO_ACTIVE_HIGH>; /* p11b1
> > */
> > +	};

...

> > +&i2c4 {
> > +	compatible = "microchip,sam9x60-i2c";
> > +	reg = <0x600 0x200>;
> > +	interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> 
> Same here 
> 

Also here.

-- 
/Horatiu
