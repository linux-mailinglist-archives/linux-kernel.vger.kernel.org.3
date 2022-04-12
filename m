Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0F4FE693
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358003AbiDLRM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344490AbiDLRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:12:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FA3EB8B;
        Tue, 12 Apr 2022 10:10:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23CH9x06054349;
        Tue, 12 Apr 2022 12:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649783399;
        bh=gkbreXK02oGII3XSANbrgsHYHJuMvjntCaE/6UPrzPQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BVLg3whoHh6uRCPNNRpmKSaUvdI9+05dXnq+edvvEUCFcI/OHrInIYQ/YgcB7Gwg/
         3PCv2XJLGv4k7ajn2RZ4VKfL8WzaDa8jmVdk7zmQl/lpZjRXnsONBhmJ95MViYQ7NZ
         0x5WTH1BXc/0QvxLKJGaWL09XopS99rB/Hytqr4c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23CH9x92017606
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 12:09:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 12:09:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 12:09:59 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23CH9tS0017746;
        Tue, 12 Apr 2022 12:09:56 -0500
Message-ID: <c1c2dc5b-5958-2b34-a963-6248e2817ca7@ti.com>
Date:   Tue, 12 Apr 2022 22:39:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/4] arm64: dts: ti: j721e: Add VTM node
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>, <kristo@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-3-j-keerthy@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220412101409.7980-3-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Keerthy

On 12/04/22 3:44 pm, Keerthy wrote:
> VTM stands for Voltage Thermal Management
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++
>  arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  | 73 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  4 +
>  3 files changed, 86 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index b4972dfb7da8..6290f563b8e7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -418,4 +418,13 @@
>  		interrupt-names = "int0", "int1";
>  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>  	};
> +
> +	wkup_vtm0: wkup_vtm0@42040000 {
> +		compatible = "ti,j721e-vtm";
> +		reg = <0x0 0x42040000 0x0 0x350>,
> +			<0x0 0x42050000 0x0 0x350>,
> +			<0x0 0x43000300 0x0 0x10>;

Please follow convention of using 0x00 as rest of the file:

		reg = <0x00 0x42040000 0x00 0x350>,
		....

> +		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> +		#thermal-sensor-cells = <1>;
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
> new file mode 100644
> index 000000000000..e922042f356f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +wkup_thermal: wkup_thermal {
> +	polling-delay-passive = <250>; /* milliseconds */
> +	polling-delay = <500>; /* milliseconds */
> +	thermal-sensors = <&wkup_vtm0 0>;
> +
> +	trips {
> +		wkup_crit: wkup_crit {


Here and elsewhere no "-" in node names please.

You can use:

https://github.com/nmenon/kernel_patch_verify
kpv -C -n <no of commits>

This catches most issues like above

> +			temperature = <125000>; /* milliCelsius */
> +			hysteresis = <2000>; /* milliCelsius */
> +			type = "critical";
> +		};
> +	};
> +};
> +
> +mpu_thermal: mpu_thermal {
> +	polling-delay-passive = <250>; /* milliseconds */
> +	polling-delay = <500>; /* milliseconds */
> +	thermal-sensors = <&wkup_vtm0 1>;
> +
> +	trips {
> +		mpu_crit: mpu_crit {
> +			temperature = <125000>; /* milliCelsius */
> +			hysteresis = <2000>; /* milliCelsius */
> +			type = "critical";
> +		};
> +	};
> +};
> +
> +c7x_thermal: c7x_thermal {
> +	polling-delay-passive = <250>; /* milliseconds */
> +	polling-delay = <500>; /* milliseconds */
> +	thermal-sensors = <&wkup_vtm0 2>;
> +
> +	trips {
> +		c7x_crit: c7x_crit {
> +			temperature = <125000>; /* milliCelsius */
> +			hysteresis = <2000>; /* milliCelsius */
> +			type = "critical";
> +		};
> +	};
> +};
> +
> +gpu_thermal: gpu_thermal {
> +	polling-delay-passive = <250>; /* milliseconds */
> +	polling-delay = <500>; /* milliseconds */
> +	thermal-sensors = <&wkup_vtm0 3>;
> +
> +	trips {
> +		gpu_crit: gpu_crit {
> +			temperature = <125000>; /* milliCelsius */
> +			hysteresis = <2000>; /* milliCelsius */
> +			type = "critical";
> +		};
> +	};
> +};
> +
> +r5f_thermal: r5f_thermal {
> +	polling-delay-passive = <250>; /* milliseconds */
> +	polling-delay = <500>; /* milliseconds */
> +	thermal-sensors = <&wkup_vtm0 4>;
> +
> +	trips {
> +		r5f_crit: r5f_crit {
> +			temperature = <125000>; /* milliCelsius */
> +			hysteresis = <2000>; /* milliCelsius */
> +			type = "critical";
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index 0e23886c9fd1..6979863eb500 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -181,6 +181,10 @@
>  				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		#include "k3-j721e-thermal.dtsi"
> +	};

Bit weird representation, any reason why thermal-zones {} cannot be
moved into k3-j721e-thermal.dtsi?

>  };
>  
>  /* Now include the peripherals for each bus segments */


Regards
Vignesh
