Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94F59E616
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiHWPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiHWPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:34:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89B8250341;
        Tue, 23 Aug 2022 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661253448; x=1692789448;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=xtDNU8UiOB8VZnhym+s1uLfNOjHCLSoYSsA83kkfttk=;
  b=2BT9BqBOJGkW0qkNgqBXTu6gM3/tijTBgTwm7+0ei1QvPaArHHwAZ0GQ
   L1cT0FyJSEKoEHqh0MBIcOFFsw4ctYeJIbFLtnmB3OKiOGG5qa/AZqY/L
   DNpf1KGGMWodx7dKsXUXVZpW4NQCB26T1Yy9Z7SE8bPHtmRLb1B+Bhtuk
   f0uG1dpTyqH3+2/qsAdSkSaUuzIVK/cxtoLfER6S4gNNVc3Lt9Uw434cJ
   UcG5vcfTN2g/aI5HS7vvteBuuT8hwCQprxE8fWgQe6EDXespk5XvIc5b0
   x1H9ABSWFlMPz78DjsxpW7ibwtIKGBzN0YqM+/LUGH9QD9H0+bj232OzL
   g==;
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="173692075"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2022 04:16:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 23 Aug 2022 04:16:55 -0700
Received: from [10.159.205.135] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 23 Aug 2022 04:16:53 -0700
Message-ID: <6482df4e-ec7b-04fc-f2a3-f75a67a69eff@microchip.com>
Date:   Tue, 23 Aug 2022 13:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [linux][PATCH v2 2/2] dts: arm: at91: Add SAMA5D3-EDS Board
Content-Language: en-US
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        Jerry Ray - C33025 <Jerry.Ray@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220822181314.8325-1-jerry.ray@microchip.com>
 <20220822181314.8325-2-jerry.ray@microchip.com>
 <59d1675d-89ae-787d-9743-e19c19ba0f97@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
In-Reply-To: <59d1675d-89ae-787d-9743-e19c19ba0f97@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On 23/08/2022 at 09:28, Claudiu Beznea - M18063 wrote:
> On 22.08.2022 21:13, Jerry Ray wrote:
>> The SAMA5D3-EDS board is an Ethernet Development Platform allowing for
>> evaluating many Microchip ethernet switch and PHY products.  Various
>> daughter cards can connect up via an RGMII connector or an RMII connector.
>>
>> The EDS board is not intended for stand-alone use and has no ethernet
>> capabilities when no daughter board is connected.  As such, this device
>> tree is intended to be used with a DT overlay defining the add-on board.
>> To better ensure consistency, some items are defined here as a form of
>> documentation so that all add-on overlays will use the same terms.
>>
>> Google search keywords: "Microchip SAMA5D3-EDS"
>>
>> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
>> ---
>> v1->v2:
>>   - Modified the compatible field in the device tree to reflect Microchip
>>     Ethernet Development System Board.
>> ---
>>   arch/arm/boot/dts/at91-sama5d3_eds.dts | 314 +++++++++++++++++++++++++
>>   1 file changed, 314 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts b/arch/arm/boot/dts/at91-sama5d3_eds.dts
>> new file mode 100644
> 
> You have to add this file to Makefile to be compiled.
> 
>> index 000000000000..626f7bbe0164
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
>> @@ -0,0 +1,314 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later

I would prefer that we also allow MIT:

// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

>> +/*
>> + * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
>> + *    Development System board.
>> + *
>> + *  Copyright (C) 2022 Microchip Technology, Inc. and its subsidiarie >> + *               2022 Jerry Ray <jerry.ray@microchip.com>

Let's have only Microchip as a copyright holder and add yourself as 
Author like:

// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
/*
  * Brief description goes here.
  *
  * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
  *
  * Author: John Doe <john.doe@microchip.com>
  *
  * Longer description goes here.
  * Even on multiple lines.
  */

>> + */
>> +/dts-v1/;
>> +#include "sama5d36.dtsi"
>> +
>> +/ {
>> +       model = "SAMA5D3 Ethernet Development System";
>> +       compatible = "microchip,sama5d3-eds", "atmel,sama5d3", "atmel,sama5";
>> +

[..]

>> +&pinctrl {
>> +       board {
>> +               pinctrl_i2c0_pu: i2c0_pu {
>> +                       atmel,pins =
>> +                               <AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
>> +                               <AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
>> +               };
>> +
>> +               pinctrl_i2c2_pu: i2c2_pu {
>> +                       atmel,pins =
>> +                               <AT91_PIOA 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>,
>> +                               <AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
>> +               };
>> +
>> +               pinctrl_key_gpio: key_gpio_0 {
>> +                       atmel,pins =
>> +                               <AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
>> +               };
>> +
>> +               pinctrl_mmc0_cd: mmc0_cd {
>> +                       atmel,pins =
>> +                               <AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
>> +               };
>> +
>> +               pinctrl_spi0_cs: spi0_cs_default {
>> +                       atmel,pins =
>> +                               <AT91_PIOD 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>> +                                AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>> +               };
>> +
>> +               pinctrl_spi1_cs: spi1_cs_default {
>> +                       atmel,pins = <AT91_PIOC 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>> +                                     AT91_PIOC 28 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>> +               };
>> +
>> +               pinctrl_usba_vbus: usba_vbus {
>> +                       atmel,pins =
>> +                               <AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
>> +               };
>> +
>> +               pinctrl_usb_default: usb_default {
>> +                       atmel,pins =
>> +                               <AT91_PIOE 3 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>> +                                AT91_PIOE 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>> +               };
>> +
>> +               pinctrl_vcc_mmc0_reg_gpio: vcc_mmc0_reg_gpio_default {
>> +                       atmel,pins = <AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
>> +               };
>> +
>> +               /* Reserved for reset signal to the RGMII connector. */
>> +               pinctrl_rgmii_rstn: rgmii_rstn {

It's better if you sort these nodes alphabetically: please rearrange the 
end of this list of pinctrl nodes.

>> +                       atmel,pins =
>> +                               <AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
>> +               };
>> +
>> +               /* Reserved for an interrupt line from the RMII and RGMII connectors. */
>> +               pinctrl_spi_irqn: spi_irqn {
>> +                       atmel,pins =
>> +                               <AT91_PIOB 28 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
>> +               };
>> +
>> +               /* Reserved for VBUS fault interrupt. */
>> +               pinctrl_vbusfault_irqn: vbusfault_irqn {
>> +                       atmel,pins =
>> +                               <AT91_PIOE 5 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
>> +               };
>> +       };
>> +};

Thanks for your patch Jerry. Best regards,
   Nicolas


-- 
Nicolas Ferre
