Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203BB50B06C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444289AbiDVGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444183AbiDVGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:24:26 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AD62CE09;
        Thu, 21 Apr 2022 23:21:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23M6LQpX051143;
        Fri, 22 Apr 2022 01:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650608486;
        bh=A24qXtg6ENxZu5Qu9i6NW5x6WgjCcKsBzjH9iSfdUeI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lZG8Gv2M7D0mXezgUnU1xF8HZbWhYZoOQ+Z7tFpnfA/Vdjsb0GL7LysvZoMN8+jmM
         w22qAfPq9411lBCsA6oJJXyUL1t6VmIfZy5Km1tn2AtpEFN61HCL7t/OMGJt2Iu0HE
         R1ghYiBZm6Ty00zwLjL8Bs2awBrZHFfctvM1Y1Yc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23M6LQnD005906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 01:21:26 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 01:21:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 01:21:26 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23M6LMVo029852;
        Fri, 22 Apr 2022 01:21:23 -0500
Message-ID: <85619322-c014-ea58-9ede-473b31b174f1@ti.com>
Date:   Fri, 22 Apr 2022 11:51:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am625-sk: Enable on board
 peripherals
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20220415131917.431137-1-vigneshr@ti.com>
 <20220415131917.431137-3-vigneshr@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220415131917.431137-3-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/22 6:49 pm, Vignesh Raghavendra wrote:
> Add nodes for I2C IO expander, OSPI Flash, Eth PHYs, SD and eMMC that
> are present on AM625 SK board.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 271 +++++++++++++++++++++++++
>  1 file changed, 271 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index 0de4113ccd5d..a0ea2cc66b31 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -9,6 +9,7 @@
>  
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/net/ti-dp83867.h>
>  #include "k3-am625.dtsi"
>  
>  / {
> @@ -17,6 +18,10 @@ / {
>  
>  	aliases {
>  		serial2 = &main_uart0;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> +		mmc2 = &sdhci2;
> +		spi0 = &ospi0;

Grygorii pointed out we are missing ethernet aliases:

		ethernet0 = &cpsw_port1;
		ethernet0 = &cpsw_port2;

Will send v2 with this update.

>  	};
>  
