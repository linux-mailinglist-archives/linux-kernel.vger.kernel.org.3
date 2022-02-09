Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A874AFDFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiBIUFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:05:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiBIUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:05:13 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3864E0519B1;
        Wed,  9 Feb 2022 12:05:14 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 219J4AVL057913;
        Wed, 9 Feb 2022 13:04:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644433450;
        bh=vXr7PyHlLCxr3Mak7Y1E4B+7VKMEhpaIDB2baQk3cqo=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=Qiuic9MyT7YPTF3NsyzPWE2eki3y33Q7UryiKPFQLQMbXR5FiUh1vNdCskDqTI/7A
         AVa7O750kXDVYllFTQMtxgpjJ4zjt7IuxSlqXe97sFtEn4vVPFr1MtF3nyLykBDMSv
         aOwqPUWqSmF5GQ0h+kTJMCH8XKDeJ3+YW++psHU4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 219J4ATI007704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 13:04:10 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 13:04:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 13:04:10 -0600
Received: from [10.250.235.90] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 219J47po019361;
        Wed, 9 Feb 2022 13:04:08 -0600
Message-ID: <b32d1d4b-4188-2e35-6242-5217f1d955d7@ti.com>
Date:   Thu, 10 Feb 2022 00:34:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-5-vigneshr@ti.com>
 <3221dd42-7a14-7ac6-0b61-634a77a45753@canonical.com>
Content-Language: en-US
In-Reply-To: <3221dd42-7a14-7ac6-0b61-634a77a45753@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 08/02/22 10:35 pm, Krzysztof Kozlowski wrote:
[...]
> 
> (...)
> 
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
>> new file mode 100644
>> index 000000000000..f1a46be27c37
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for AM62 SoC Family
>> + *
>> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/pinctrl/k3.h>
>> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +
>> +/ {
>> +	model = "Texas Instruments K3 AM625 SoC";
>> +	compatible = "ti,am625";
> 
> This is am625, but the file is am62. Why having the split?


Hierarchy is:

am62.dtsi:
-> base SoC skeleton ie arch timers and interconnects which is common
across am62xx family of SoCs
 -> includes am62-main.dtsi, am62-mcu.dtsi and am62-wakeup.dtsi
representing 3 domains and peripherals in each of these domain
-> describes all peripherals in the family (except CPU cluster)


am625.dtsi:
-> describes CPU cluster (Quad A53s). Since, am625 is a current superset
device with all peripherals, am625.dtsi includes am62.dtsi completing
SoC definition.
-> individual EVMs using this SoC will just need to include am625.dtsi
thus making things easier for Board and SOM Vendors.


In future:
am62{1-9}{1-9}.dtsi:
-> Includes am625.dtsi
-> Overrides top compatible: ti,am62{1-9}{1-9}
-> disables CPUs and peripherals not present (cutdowns of current SoC).
-> -> individual EVM dts files using this SoC will just need to include
am625.dtsi as starting point, thus making things easier for Board and
SOM Vendors.

Top level compatible is set to "ti,am625.dtsi" which is first device in
family and superset.

Hope this clears up? Will add this to commit msg

> 
>> +	interrupt-parent = <&gic500>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	chosen { };
>> +
>> +	firmware {
>> +		optee {
>> +			compatible = "linaro,optee-tz";
>> +			method = "smc";
>> +		};
>> +
>> +		psci: psci {
>> +			compatible = "arm,psci-1.0";
>> +			method = "smc";
>> +		};
>> +	};
>> +
>> +	a53_timer0: timer-cl0-cpu0 {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
>> +	};
>> +
>> +	pmu: pmu {
>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>> +	cbass_main: bus@f0000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +
>> +		ranges = <0x00 0x000f0000 0x00 0x000f0000 0x00 0x00030000>, /* Main MMRs */
>> +			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
>> +			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
>> +			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
>> +			 <0x00 0x0070C000 0x00 0x0070C000 0x00 0x00000200>, /* USB1 debug trace */
>> +			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
>> +			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
>> +			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
>> +			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
>> +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
>> +			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
>> +			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
>> +			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
>> +			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
>> +			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* sa3 sproxy data */
>> +			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
>> +			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* sa3 sproxy config */
>> +			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
>> +			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
>> +			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
>> +			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
>> +			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
>> +			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
>> +
>> +			 /* MCU Domain Range */
>> +			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
>> +
>> +			 /* Wakeup Domain Range */
>> +			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
>> +			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
>> +
>> +		cbass_mcu: bus@4000000 {
>> +			compatible = "simple-bus";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
>> +		};
>> +
>> +		cbass_wakeup: bus@2b000000 {
>> +			compatible = "simple-bus";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
>> +				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
>> +		};
>> +	};
>> +};
>> +
>> +/* Now include the peripherals for each bus segments */
>> +#include "k3-am62-main.dtsi"
>> +#include "k3-am62-mcu.dtsi"
>> +#include "k3-am62-wakeup.dtsi"
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
>> new file mode 100644
>> index 000000000000..887f31c23fef
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
>> @@ -0,0 +1,103 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for AM625 SoC family in Quad core configuration
>> + *
>> + * TRM: https://www.ti.com/lit/pdf/spruiv7
>> + *
>> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "k3-am62.dtsi"
>> +
>> +/ {
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
> 
> This file is not included anywhere, so does it mean that your SoC comes
> without the cores and each board designer plugs the cores separately?
> 

Please see above for explanation. File is included in am625-sk.dts (see
5/5).

> 
> Best regards,
> Krzysztof
