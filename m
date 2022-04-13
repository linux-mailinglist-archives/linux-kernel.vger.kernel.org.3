Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31F4FF34E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiDMJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiDMJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:23:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DD29804;
        Wed, 13 Apr 2022 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649841689; x=1681377689;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qktRHzb5w6MjQwDn++yxvT1A6/rqIxV5B2DXzWDApvg=;
  b=atN7qgexw5hxilrA7HUY5uOtFS8INNvVsPMoId56V3mm+Ad+0zD0yBj8
   8l5uZrNB9lkkZzSHTDFDxpE2+SDSA9GWxxOR/tY4IvdyalylQWto/JJ+F
   hhFnszfG0h9QHwRRKKAvTsY7j78aOUnNVCk5jjGqXtxro1r6SJsR3KCl9
   CuFQ3xdPnYmnMnLyiQKxU5IkthkbNgAH8KxHtqS4DilkobrvO+enc6WIv
   Ye2x1Mzt8xvrx8aPUEDs4ay7jHNSk+0EUwwCBihZpGeR3rR3ZQZn9OTZw
   0xFlRdXkBxunozVRRPrm/g78OXOohjpp0RCxohaIEBkDVQeaVwgiJ/TuB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643698800"; 
   d="scan'208";a="160374583"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 02:21:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 02:21:28 -0700
Received: from [10.12.72.146] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Apr 2022 02:21:25 -0700
Message-ID: <1d67baa4-48d1-67dd-7d9e-60a8ecbea3f4@microchip.com>
Date:   Wed, 13 Apr 2022 11:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: dts: at91: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        Lars Povlsen - M31675 <Lars.Povlsen@microchip.com>,
        Steen Hegelund - M31857 <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220407143223.295344-1-krzysztof.kozlowski@linaro.org>
 <8eb6621b-78ca-e5f9-def9-47809dab9bb4@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <8eb6621b-78ca-e5f9-def9-47809dab9bb4@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 at 12:32, Tudor Ambarus - M18064 wrote:
> On 4/7/22 17:32, Krzysztof Kozlowski wrote:
>> The node names should be generic and SPI NOR dtschema expects "flash".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I think that without this patch, errors are generated while checking DT, 
so I would put this patch in my "fixes" branch for 5.18: tell me if you 
disagree.

Best regards,
   Nicolas


> 
>> ---
>>   arch/arm/boot/dts/at91-dvk_su60_somc.dtsi     | 2 +-
>>   arch/arm/boot/dts/at91-q5xr5.dts              | 2 +-
>>   arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 2 +-
>>   arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 2 +-
>>   arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 2 +-
>>   arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi     | 2 +-
>>   arch/arm/boot/dts/at91-sama5d4ek.dts          | 2 +-
>>   arch/arm/boot/dts/at91-vinco.dts              | 2 +-
>>   arch/arm/boot/dts/at91sam9n12ek.dts           | 2 +-
>>   arch/arm/boot/dts/at91sam9x5ek.dtsi           | 2 +-
>>   arch/arm/boot/dts/sama5d3xmb.dtsi             | 2 +-
>>   arch/arm/boot/dts/sama5d3xmb_cmp.dtsi         | 2 +-
>>   12 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
>> index c1c8650dafce..3542ad8a243e 100644
>> --- a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
>> +++ b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
>> @@ -44,7 +44,7 @@ &spi0 {
>>          status = "okay";
>>
>>          /* spi0.0: 4M Flash Macronix MX25R4035FM1IL0 */
>> -       spi-flash@0 {
>> +       flash@0 {
>>                  compatible = "mxicy,mx25u4035", "jedec,spi-nor";
>>                  spi-max-frequency = <33000000>;
>>                  reg = <0>;
>> diff --git a/arch/arm/boot/dts/at91-q5xr5.dts b/arch/arm/boot/dts/at91-q5xr5.dts
>> index 47a00062f01f..9cf60b6f695c 100644
>> --- a/arch/arm/boot/dts/at91-q5xr5.dts
>> +++ b/arch/arm/boot/dts/at91-q5xr5.dts
>> @@ -125,7 +125,7 @@ &spi0 {
>>          cs-gpios = <&pioA 3 GPIO_ACTIVE_HIGH>, <&pioC 11 GPIO_ACTIVE_LOW>, <0>, <0>;
>>          status = "okay";
>>
>> -       m25p80@0 {
>> +       flash@0 {
>>                  compatible = "jedec,spi-nor";
>>                  spi-max-frequency = <20000000>;
>>                  reg = <0>;
>> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
>> index 21c86171e462..ba621783acdb 100644
>> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
>> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
>> @@ -214,7 +214,7 @@ &qspi1 {
>>          pinctrl-0 = <&pinctrl_qspi1_default>;
>>          status = "disabled";
>>
>> -       qspi1_flash: spi_flash@0 {
>> +       qspi1_flash: flash@0 {
>>                  #address-cells = <1>;
>>                  #size-cells = <1>;
>>                  compatible = "jedec,spi-nor";
>> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
>> index c145c4e5ef58..5e8755f22784 100644
>> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
>> @@ -191,7 +191,7 @@ &pwm0 {
>>   &qspi1 {
>>          status = "okay";
>>
>> -       qspi1_flash: spi_flash@0 {
>> +       qspi1_flash: flash@0 {
>>                  status = "okay";
>>          };
>>   };
>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> index 9bf2ec0ba3e2..cdfe891f9a9e 100644
>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> @@ -137,7 +137,7 @@ spi0: spi@f8000000 {
>>                                  pinctrl-0 = <&pinctrl_spi0_default>;
>>                                  status = "okay";
>>
>> -                               m25p80@0 {
>> +                               flash@0 {
>>                                          compatible = "atmel,at25df321a";
>>                                          reg = <0>;
>>                                          spi-max-frequency = <50000000>;
>> diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
>> index 710cb72bda5a..fd1086f52b40 100644
>> --- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
>> +++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
>> @@ -49,7 +49,7 @@ spi0: spi@f8010000 {
>>                                  cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
>>                                  status = "okay";
>>
>> -                               m25p80@0 {
>> +                               flash@0 {
>>                                          compatible = "atmel,at25df321a";
>>                                          spi-max-frequency = <50000000>;
>>                                          reg = <0>;
>> diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
>> index fe432b6b7e95..7017f626f362 100644
>> --- a/arch/arm/boot/dts/at91-sama5d4ek.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
>> @@ -65,7 +65,7 @@ ssc0: ssc@f8008000 {
>>                          spi0: spi@f8010000 {
>>                                  cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
>>                                  status = "okay";
>> -                               m25p80@0 {
>> +                               flash@0 {
>>                                          compatible = "atmel,at25df321a";
>>                                          spi-max-frequency = <50000000>;
>>                                          reg = <0>;
>> diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
>> index a51a3372afa1..ebeaa6ab500e 100644
>> --- a/arch/arm/boot/dts/at91-vinco.dts
>> +++ b/arch/arm/boot/dts/at91-vinco.dts
>> @@ -59,7 +59,7 @@ slot@0 {
>>                          spi0: spi@f8010000 {
>>                                  cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
>>                                  status = "okay";
>> -                               m25p80@0 {
>> +                               flash@0 {
>>                                          compatible = "n25q32b", "jedec,spi-nor";
>>                                          spi-max-frequency = <50000000>;
>>                                          reg = <0>;
>> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
>> index 2bc4e6e0a923..c905d7bfc771 100644
>> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
>> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
>> @@ -119,7 +119,7 @@ pinctrl_usb1_vbus_sense: usb1_vbus_sense {
>>                          spi0: spi@f0000000 {
>>                                  status = "okay";
>>                                  cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
>> -                               m25p80@0 {
>> +                               flash@0 {
>>                                          compatible = "atmel,at25df321a";
>>                                          spi-max-frequency = <50000000>;
>>                                          reg = <0>;
>> diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
>> index 6d1264de6060..5f4eaa618ab4 100644
>> --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
>> @@ -125,7 +125,7 @@ &spi0 {
>>          cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
>>          status = "disabled"; /* conflicts with mmc1 */
>>
>> -       m25p80@0 {
>> +       flash@0 {
>>                  compatible = "atmel,at25df321a";
>>                  spi-max-frequency = <50000000>;
>>                  reg = <0>;
>> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
>> index a499de8a7a64..3652c9e24124 100644
>> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
>> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
>> @@ -26,7 +26,7 @@ slot@0 {
>>                          spi0: spi@f0004000 {
>>                                  dmas = <0>, <0>;        /*  Do not use DMA for spi0 */
>>
>> -                               m25p80@0 {
>> +                               flash@0 {
>>                                          compatible = "atmel,at25df321a";
>>                                          spi-max-frequency = <50000000>;
>>                                          reg = <0>;
>> diff --git a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
>> index fa9e5e2a745d..5d9e97fecf83 100644
>> --- a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
>> +++ b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
>> @@ -25,7 +25,7 @@ slot@0 {
>>                          spi0: spi@f0004000 {
>>                                  dmas = <0>, <0>;        /*  Do not use DMA for spi0 */
>>
>> -                               m25p80@0 {
>> +                               flash@0 {
>>                                          compatible = "atmel,at25df321a";
>>                                          spi-max-frequency = <50000000>;
>>                                          reg = <0>;
>> --
>> 2.32.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
