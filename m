Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB39C5A8D70
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiIAFkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiIAFkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:40:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D83B12AAF;
        Wed, 31 Aug 2022 22:39:57 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2815dfXP039408;
        Thu, 1 Sep 2022 00:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662010781;
        bh=CLucAmRdzDQNvBoahPBI20arD+x2VD/6P7PmYblwV0w=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PtqD6COknhqeDRNxeq7zKOLAKIJ520MiOV7zYVHpHL/wP/0NWXSM3sYK/pJhT8XGz
         w2SOohw4tDw+/+1jy2CDvrajXYvUQqagVMIjQimgiQHtD0plXV4mG29vggaAqRqbQg
         f1ykGIwKo2Bfew8PM9XH/cLXaBUZ5m/S7W35X39U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2815dfLt017466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 00:39:41 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 00:39:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 00:39:41 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2815dbxu031523;
        Thu, 1 Sep 2022 00:39:38 -0500
Message-ID: <f4b54ddb-3364-e765-f683-9af19076db13@ti.com>
Date:   Thu, 1 Sep 2022 11:09:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/4] arm64: dts: ti: Introduce AM62A7 family of SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
References: <20220829082200.241653-1-vigneshr@ti.com>
 <20220829082200.241653-4-vigneshr@ti.com>
 <dc971b60-c2be-aabb-20d6-181ea34d55c4@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <dc971b60-c2be-aabb-20d6-181ea34d55c4@linaro.org>
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



On 30/08/22 15:26, Krzysztof Kozlowski wrote:
> On 29/08/2022 11:21, Vignesh Raghavendra wrote:
> 
> (...)
> 
>> +		/*
>> +		 * vcpumntirq:
>> +		 * virtual CPU interface maintenance interrupt
>> +		 */
>> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +		gic_its: msi-controller@1820000 {
>> +			compatible = "arm,gic-v3-its";
>> +			reg = <0x00 0x01820000 0x00 0x10000>;
>> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
>> +			msi-controller;
>> +			#msi-cells = <1>;
>> +		};
>> +	};
>> +
>> +	main_conf: syscon@100000 {
>> +		compatible = "syscon", "simple-mfd";
> 
> No, these are not allowed alone.

Will add device specific compatible

compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";

> 
>> +		reg = <0x00 0x00100000 0x00 0x20000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x00 0x00 0x00100000 0x20000>;
>> +	};
>> +
>> +	dmss: bus@48000000 {
>> +		compatible = "simple-mfd";
> 
> No. Not allowed alone.

This can be "simple-bus". Will change accordingly

> 
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		dma-ranges;
>> +		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06000000>;
>> +
>> +		ti,sci-dev-id = <25>;
>> +
>> +		secure_proxy_main: mailbox@4d000000 {
>> +			compatible = "ti,am654-secure-proxy";
>> +			#mbox-cells = <1>;
>> +			reg-names = "target_data", "rt", "scfg";
>> +			reg = <0x00 0x4d000000 0x00 0x80000>,
>> +			      <0x00 0x4a600000 0x00 0x80000>,
>> +			      <0x00 0x4a400000 0x00 0x80000>;
>> +			interrupt-names = "rx_012";
>> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +	};
>> +
>> +	dmsc: system-controller@44043000 {
>> +		compatible = "ti,k2g-sci";
>> +		ti,host-id = <12>;
>> +		mbox-names = "rx", "tx";
>> +		mboxes= <&secure_proxy_main 12>,
>> +			<&secure_proxy_main 13>;
>> +		reg-names = "debug_messages";
>> +		reg = <0x00 0x44043000 0x00 0xfe0>;
> 
> First compatible, then reg, then the reset of properties.  This applies
> everywhere.

Will fix

> 
>> +
>> +		k3_pds: power-controller {
>> +			compatible = "ti,sci-pm-domain";
>> +			#power-domain-cells = <2>;
>> +		};
>> +
>> +		k3_clks: clock-controller {
>> +			compatible = "ti,k2g-sci-clk";
>> +			#clock-cells = <2>;
>> +		};
>> +
>> +		k3_reset: reset-controller {
>> +			compatible = "ti,sci-reset";
>> +			#reset-cells = <2>;
>> +		};
>> +	};
>> +
[...]
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
>> new file mode 100644
>> index 000000000000..fe6d682a0f33
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for AM62A SoC Family Wakeup Domain peripherals
>> + *
>> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +&cbass_wakeup {
>> +	wkup_conf: syscon@43000000 {
>> +		compatible = "syscon", "simple-mfd";
> 
> No. Not allowed alone.

Will change to

compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";

> 
>> +		reg = <0x00 0x43000000 0x00 0x20000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x00 0x00 0x43000000 0x20000>;
>> +
>> +		chipid: chipid@14 {
>> +			compatible = "ti,am654-chipid";
>> +			reg = <0x14 0x4>;
>> +		};
>> +	};
>> +
> 
> 

Thanks for the review!
-- 
Regards
Vignesh
