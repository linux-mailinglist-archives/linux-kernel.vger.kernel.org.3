Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6341B4FEB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiDLXtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiDLXs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:48:59 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564A15A0E;
        Tue, 12 Apr 2022 16:44:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23CNi0Hw051029;
        Tue, 12 Apr 2022 18:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649807041;
        bh=oc+HIh97XfczM9ecJOWeQVZz2RDSA8zgm3GE8d06OmM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DlBdKv2q02c0VTjJEKmcvt3g5TKP22WKCUxl9FvtuZ9uJMMp9oTh+nGeO62Pak96u
         gMHdR/fd1OGtxe2IZdfJRlZNkg04QM3w38kxNC21UgpnN9ZMpBJEh5ciOMQAGYK09d
         vaIF3N6yLT61U73WOiv8gk9fv/qzFS2/tsNY7cII=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23CNi0af047739
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 18:44:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 18:44:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 18:44:00 -0500
Received: from [10.250.234.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23CNhvxL019743;
        Tue, 12 Apr 2022 18:43:58 -0500
Message-ID: <88c59d74-f251-b444-7b99-71e3fe428482@ti.com>
Date:   Wed, 13 Apr 2022 05:13:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/4] arm64: dts: ti: j721e: Add VTM node
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>, <kristo@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-3-j-keerthy@ti.com>
 <c1c2dc5b-5958-2b34-a963-6248e2817ca7@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <c1c2dc5b-5958-2b34-a963-6248e2817ca7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2022 10:39 PM, Vignesh Raghavendra wrote:
> Hi Keerthy
> 
> On 12/04/22 3:44 pm, Keerthy wrote:
>> VTM stands for Voltage Thermal Management
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++
>>   arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  | 73 +++++++++++++++++++
>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  4 +
>>   3 files changed, 86 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> index b4972dfb7da8..6290f563b8e7 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> @@ -418,4 +418,13 @@
>>   		interrupt-names = "int0", "int1";
>>   		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>>   	};
>> +
>> +	wkup_vtm0: wkup_vtm0@42040000 {
>> +		compatible = "ti,j721e-vtm";
>> +		reg = <0x0 0x42040000 0x0 0x350>,
>> +			<0x0 0x42050000 0x0 0x350>,
>> +			<0x0 0x43000300 0x0 0x10>;
> 
> Please follow convention of using 0x00 as rest of the file:

Okay.

> 
> 		reg = <0x00 0x42040000 0x00 0x350>,
> 		....
> 
>> +		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>> +		#thermal-sensor-cells = <1>;
>> +	};
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
>> new file mode 100644
>> index 000000000000..e922042f356f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
>> @@ -0,0 +1,73 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +wkup_thermal: wkup_thermal {
>> +	polling-delay-passive = <250>; /* milliseconds */
>> +	polling-delay = <500>; /* milliseconds */
>> +	thermal-sensors = <&wkup_vtm0 0>;
>> +
>> +	trips {
>> +		wkup_crit: wkup_crit {
> 
> 
> Here and elsewhere no "-" in node names please.

I believe you meant no "_" ?

> 
> You can use:
> 
> https://github.com/nmenon/kernel_patch_verify
> kpv -C -n <no of commits>
> 
> This catches most issues like above

Okay

> 
>> +			temperature = <125000>; /* milliCelsius */
>> +			hysteresis = <2000>; /* milliCelsius */
>> +			type = "critical";
>> +		};
>> +	};
>> +};
>> +
>> +mpu_thermal: mpu_thermal {
>> +	polling-delay-passive = <250>; /* milliseconds */
>> +	polling-delay = <500>; /* milliseconds */
>> +	thermal-sensors = <&wkup_vtm0 1>;
>> +
>> +	trips {
>> +		mpu_crit: mpu_crit {
>> +			temperature = <125000>; /* milliCelsius */
>> +			hysteresis = <2000>; /* milliCelsius */
>> +			type = "critical";
>> +		};
>> +	};
>> +};
>> +
>> +c7x_thermal: c7x_thermal {
>> +	polling-delay-passive = <250>; /* milliseconds */
>> +	polling-delay = <500>; /* milliseconds */
>> +	thermal-sensors = <&wkup_vtm0 2>;
>> +
>> +	trips {
>> +		c7x_crit: c7x_crit {
>> +			temperature = <125000>; /* milliCelsius */
>> +			hysteresis = <2000>; /* milliCelsius */
>> +			type = "critical";
>> +		};
>> +	};
>> +};
>> +
>> +gpu_thermal: gpu_thermal {
>> +	polling-delay-passive = <250>; /* milliseconds */
>> +	polling-delay = <500>; /* milliseconds */
>> +	thermal-sensors = <&wkup_vtm0 3>;
>> +
>> +	trips {
>> +		gpu_crit: gpu_crit {
>> +			temperature = <125000>; /* milliCelsius */
>> +			hysteresis = <2000>; /* milliCelsius */
>> +			type = "critical";
>> +		};
>> +	};
>> +};
>> +
>> +r5f_thermal: r5f_thermal {
>> +	polling-delay-passive = <250>; /* milliseconds */
>> +	polling-delay = <500>; /* milliseconds */
>> +	thermal-sensors = <&wkup_vtm0 4>;
>> +
>> +	trips {
>> +		r5f_crit: r5f_crit {
>> +			temperature = <125000>; /* milliCelsius */
>> +			hysteresis = <2000>; /* milliCelsius */
>> +			type = "critical";
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> index 0e23886c9fd1..6979863eb500 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> @@ -181,6 +181,10 @@
>>   				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
>>   		};
>>   	};
>> +
>> +	thermal_zones: thermal-zones {
>> +		#include "k3-j721e-thermal.dtsi"
>> +	};
> 
> Bit weird representation, any reason why thermal-zones {} cannot be
> moved into k3-j721e-thermal.dtsi?

Okay. This could be moved. This is typically done when we have different 
zones defined under different dtsi files. Like in the case of 
omap5/dra7. The same was followed here. You are right this could be 
moved as we have all the zones under one dtsi.

Regards,
Keerthy

> 
>>   };
>>   
>>   /* Now include the peripherals for each bus segments */
> 
> 
> Regards
> Vignesh
