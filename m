Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3606B4C2EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiBXOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiBXOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:52:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57212AA3;
        Thu, 24 Feb 2022 06:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645714296; x=1677250296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L0zmCwiD7vuNBOYriZw0musQW6dJtfFikRQDVX2lAFs=;
  b=wnYXX5ik2oE7X7Sv4AHnm+qePlq54cmcYuWDxKyMVqFvIByBLahmG4eo
   JOXaiVQ7NIWGgn15T0DDH0UnNs5Lt7igS9pIM0fePKPE4BKuN0Yi43GW8
   5auuIh4dvCz3TKvmeUo0j9UsWQhZgAiBRHiFyHEjrTbeUZ6qZVUs1IcP5
   cIuYelHhNtoffTtoxrBPXUMXws60sB1F6nmnRQ12tsiyRYDeBNCwZUfn4
   u1PPHGN/QEETqR8gGDFrJDITuwrpyUTe6UZd3oSTLizO5yzmYYpLC1gmI
   HbvcXNgzKqG5IGh7O1X6G/WcyJ+UKMEc7v9AM9EEt7EACpeL0QLld2ELq
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="163502760"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 07:51:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 07:51:30 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 07:51:28 -0700
Message-ID: <85566f97-dcfc-f477-1ebb-5cac955b791a@microchip.com>
Date:   Thu, 24 Feb 2022 15:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
CC:     <arnd@arndb.de>, <alexandre.belloni@bootlin.com>, <olof@lixom.net>,
        <soc@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Manohar.Puri@microchip.com>
References: <20220221080858.14233-1-kavyasree.kotagiri@microchip.com>
 <3b4c56201a478876783e69243c901cd8@walle.cc>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <3b4c56201a478876783e69243c901cd8@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

On 21/02/2022 at 10:10, Michael Walle wrote:
> Am 2022-02-21 09:08, schrieb Kavyasree Kotagiri:
>> This patch adds basic DT for Microchip lan966x SoC and associated board
>> pcb8291(2-port EVB). Adds peripherals required to allow booting:
>> Interrupt
>> Controller, Clock, Generic ARMv7 Timers, Synopsys Timer, Flexcoms,
>> GPIOs.
>> Also adds other peripherals like crypto(AES/SHA), DMA, Watchdog Timer,
>> TRNG
>> and MCAN0.
>>
>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>> ---
>> v6 -> v7:
>> - Removed "arm,cpu-registers-not-fw-configured" property, as not
>> required.
>> - Corrected "PPI interrupt cpu mask" and order of interrupts.
>>
>> v5 -> v6:
>> - Renamed dts file to lan966x-pcb8291.dts file.
>> - Disabled optional watchdog in dtsi file and enabled it in dts file.
>>
>> v4 -> v5:
>> - Modified AES, SHA, TRNG node names as per generic names recommended.
>>
>> v3 -> v4:
>> - Removed character 'x' from compatible string.
>> - Removed memory node as handled by bootloader.
>> - Renamed flexcom3 usart0 to usart3
>> - Added /chosen and /aliases nodes in dts file.
>>
>> v2 -> v3:
>> - Enabling trng in dtsi itself.
>> - Removed "status=okay" dma0.
>> - Add gpio pin settings for can0(missed adding this in previous
>> version)
>>
>> v1 -> v2:
>> - Moved flx3 usart0 node to dtsi file.
>> - Removed status="okay" for dma0 to maintain consistency across nodes
>>    (which means enabling dma0 by default)
>>
>>   arch/arm/boot/dts/Makefile            |   2 +
>>   arch/arm/boot/dts/lan966x-pcb8291.dts |  64 +++++++
>>   arch/arm/boot/dts/lan966x.dtsi        | 237 ++++++++++++++++++++++++++
>>   3 files changed, 303 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/lan966x-pcb8291.dts
>>   create mode 100644 arch/arm/boot/dts/lan966x.dtsi
>>
> 
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/lan966x.dtsi
>> @@ -0,0 +1,237 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * lan966x.dtsi - Device Tree Include file for Microchip LAN966 family
>> SoC
>> + *
>> + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
>> + *
>> + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>> + *
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/mfd/atmel-flexcom.h>
>> +#include <dt-bindings/dma/at91.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/clock/microchip,lan966x.h>
>> +
>> +/ {
>> +     model = "Microchip LAN966 family SoC";
>> +     compatible = "microchip,lan966";
> 
> As mentioned earlier, this isn't a documented compatible string. So,
> I guess without overwriting this in the board dts it will throw an
> error with the dt schema validator. OTOH, there are many dtsi files
> in arch/arm/boot/dts/ doing this. I don't know what is correct here.

I see it documented here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/atmel-at91.yaml#n165

Isn't it what is expected?

> Everthing else looks good.

Thanks a lot for your reviews.

> Reviewed-by: Michael Walle <michael@walle.cc>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
I'm queuing it to at91-dt branch for reaching arm-soc in 5.18 merge window.

Best regards,
   Nicolas

>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <1>;
>> +     #size-cells = <1>;
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu@0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     clock-frequency = <600000000>;
>> +                     reg = <0x0>;
>> +             };
>> +     };
>> +
>> +     clocks {
>> +             sys_clk: sys_clk {
>> +                     compatible = "fixed-clock";
>> +                     #clock-cells = <0>;
>> +                     clock-frequency = <162500000>;
>> +             };
>> +
>> +             cpu_clk: cpu_clk {
>> +                     compatible = "fixed-clock";
>> +                     #clock-cells = <0>;
>> +                     clock-frequency = <600000000>;
>> +             };
>> +
>> +             ddr_clk: ddr_clk {
>> +                     compatible = "fixed-clock";
>> +                     #clock-cells = <0>;
>> +                     clock-frequency = <300000000>;
>> +             };
>> +
>> +             nic_clk: nic_clk {
>> +                     compatible = "fixed-clock";
>> +                     #clock-cells = <0>;
>> +                     clock-frequency = <200000000>;
>> +             };
>> +     };
>> +
>> +     clks: clock-controller@e00c00a8 {
>> +             compatible = "microchip,lan966x-gck";
>> +             #clock-cells = <1>;
>> +             clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
>> +             clock-names = "cpu", "ddr", "sys";
>> +             reg = <0xe00c00a8 0x38>;
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv7-timer";
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
>> +             clock-frequency = <37500000>;
>> +     };
>> +
>> +     soc {
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges;
>> +
>> +             flx0: flexcom@e0040000 {
>> +                     compatible = "atmel,sama5d2-flexcom";
>> +                     reg = <0xe0040000 0x100>;
>> +                     clocks = <&clks GCK_ID_FLEXCOM0>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges = <0x0 0xe0040000 0x800>;
>> +                     status = "disabled";
>> +             };
>> +
>> +             flx1: flexcom@e0044000 {
>> +                     compatible = "atmel,sama5d2-flexcom";
>> +                     reg = <0xe0044000 0x100>;
>> +                     clocks = <&clks GCK_ID_FLEXCOM1>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges = <0x0 0xe0044000 0x800>;
>> +                     status = "disabled";
>> +             };
>> +
>> +             trng: rng@e0048000 {
>> +                     compatible = "atmel,at91sam9g45-trng";
>> +                     reg = <0xe0048000 0x100>;
>> +                     clocks = <&nic_clk>;
>> +             };
>> +
>> +             aes: crypto@e004c000 {
>> +                     compatible = "atmel,at91sam9g46-aes";
>> +                     reg = <0xe004c000 0x100>;
>> +                     interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
>> +                     dmas = <&dma0 AT91_XDMAC_DT_PERID(13)>,
>> +                            <&dma0 AT91_XDMAC_DT_PERID(12)>;
>> +                     dma-names = "rx", "tx";
>> +                     clocks = <&nic_clk>;
>> +                     clock-names = "aes_clk";
>> +             };
>> +
>> +             flx2: flexcom@e0060000 {
>> +                     compatible = "atmel,sama5d2-flexcom";
>> +                     reg = <0xe0060000 0x100>;
>> +                     clocks = <&clks GCK_ID_FLEXCOM2>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges = <0x0 0xe0060000 0x800>;
>> +                     status = "disabled";
>> +             };
>> +
>> +             flx3: flexcom@e0064000 {
>> +                     compatible = "atmel,sama5d2-flexcom";
>> +                     reg = <0xe0064000 0x100>;
>> +                     clocks = <&clks GCK_ID_FLEXCOM3>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges = <0x0 0xe0064000 0x800>;
>> +                     status = "disabled";
>> +
>> +                     usart3: serial@200 {
>> +                             compatible = "atmel,at91sam9260-usart";
>> +                             reg = <0x200 0x200>;
>> +                             interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>> +                             clocks = <&nic_clk>;
>> +                             clock-names = "usart";
>> +                             atmel,fifo-size = <32>;
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +
>> +             dma0: dma-controller@e0068000 {
>> +                     compatible = "microchip,sama7g5-dma";
>> +                     reg = <0xe0068000 0x1000>;
>> +                     interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>> +                     #dma-cells = <1>;
>> +                     clocks = <&nic_clk>;
>> +                     clock-names = "dma_clk";
>> +             };
>> +
>> +             sha: crypto@e006c000 {
>> +                     compatible = "atmel,at91sam9g46-sha";
>> +                     reg = <0xe006c000 0xec>;
>> +                     interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>> +                     dmas = <&dma0 AT91_XDMAC_DT_PERID(14)>;
>> +                     dma-names = "tx";
>> +                     clocks = <&nic_clk>;
>> +                     clock-names = "sha_clk";
>> +             };
>> +
>> +             flx4: flexcom@e0070000 {
>> +                     compatible = "atmel,sama5d2-flexcom";
>> +                     reg = <0xe0070000 0x100>;
>> +                     clocks = <&clks GCK_ID_FLEXCOM4>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges = <0x0 0xe0070000 0x800>;
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer0: timer@e008c000 {
>> +                     compatible = "snps,dw-apb-timer";
>> +                     reg = <0xe008c000 0x400>;
>> +                     clocks = <&nic_clk>;
>> +                     clock-names = "timer";
>> +                     interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> +             };
>> +
>> +             watchdog: watchdog@e0090000 {
>> +                     compatible = "snps,dw-wdt";
>> +                     reg = <0xe0090000 0x1000>;
>> +                     interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>> +                     clocks = <&nic_clk>;
>> +                     status = "disabled";
>> +             };
>> +
>> +             can0: can@e081c000 {
>> +                     compatible = "bosch,m_can";
>> +                     reg = <0xe081c000 0xfc>, <0x00100000 0x4000>;
>> +                     reg-names = "m_can", "message_ram";
>> +                     interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>> +                                  <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
>> +                     interrupt-names = "int0", "int1";
>> +                     clocks = <&clks GCK_ID_MCAN0>, <&clks GCK_ID_MCAN0>;
>> +                     clock-names = "hclk", "cclk";
>> +                     assigned-clocks = <&clks GCK_ID_MCAN0>;
>> +                     assigned-clock-rates = <40000000>;
>> +                     bosch,mram-cfg = <0x0 0 0 64 0 0 32 32>;
>> +                     status = "disabled";
>> +             };
>> +
>> +             gpio: pinctrl@e2004064 {
>> +                     compatible = "microchip,lan966x-pinctrl";
>> +                     reg = <0xe2004064 0xb4>,
>> +                         <0xe2010024 0x138>;
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     gpio-ranges = <&gpio 0 0 78>;
>> +                     interrupt-controller;
>> +                     interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>> +                     #interrupt-cells = <2>;
>> +             };
>> +
>> +             gic: interrupt-controller@e8c11000 {
>> +                     compatible = "arm,gic-400", "arm,cortex-a7-gic";
>> +                     #interrupt-cells = <3>;
>> +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +                     interrupt-controller;
>> +                     reg = <0xe8c11000 0x1000>,
>> +                           <0xe8c12000 0x2000>,
>> +                           <0xe8c14000 0x2000>,
>> +                           <0xe8c16000 0x2000>;
>> +             };
>> +     };
>> +};
> 
> --
> -michael


-- 
Nicolas Ferre
