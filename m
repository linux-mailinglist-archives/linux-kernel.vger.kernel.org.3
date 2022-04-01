Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95D4EE781
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiDAFF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbiDAFF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:05:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BA211BCE7;
        Thu, 31 Mar 2022 22:03:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23153N1O001351;
        Fri, 1 Apr 2022 00:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648789403;
        bh=+ruPXu8lGjfl8T2XS9PrIMnCggAYuJ8buRv16efJeN8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nFor8yBMJLpGqHDGJtj7X+aFj9m6OkUB4vvrT7Nii+Mnk4ziBVxT2hNzRV1o++DR6
         y0MBsqBgwjXEDCI0zDapFOPfVgcQMa0gO1GTv7X7iKZzZKN579cTFSkMoD2MfgrHzu
         Duk1lcOKReUHX3Dj0EGdp9/Z774HBCqoRgaGJp5M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23153NVV116401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Apr 2022 00:03:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 1
 Apr 2022 00:03:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 1 Apr 2022 00:03:22 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23153Irm016650;
        Fri, 1 Apr 2022 00:03:18 -0500
Message-ID: <3ae1a0b5-236c-20b0-ac2a-a93f0b4ced97@ti.com>
Date:   Fri, 1 Apr 2022 10:33:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j721e-common-proc-board: add DP
 to j7 evm
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, <nm@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
References: <20220331143035.16210-1-r-ravikumar@ti.com>
 <20220331143035.16210-3-r-ravikumar@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220331143035.16210-3-r-ravikumar@ti.com>
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

Hi Rahul,

On 31/03/22 8:00 pm, Rahul T R wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Add the endpoint nodes to describe connection from
> DSS => MHDP => DisplayPort connector.
> Also add the phy link node and required pinmux nodes
> for hotplug.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 78 ++++++++++++++++++-
>  1 file changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index f5ca8e26ed99..8ddc0d3bd058 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -148,6 +148,28 @@
>  		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
>  		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
>  	};
> +
> +	dp_pwr_3v3: fixedregulator-dp-prw {

Please use standard node name: regulator-X as per DT spec [1]


[1]
https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3

> +		compatible = "regulator-fixed";
> +		regulator-name = "dp-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&exp4 0 0>;	/* P0 - DP0_PWR_SW_EN */

Please use GPIO_ACTIVE_* macros as appropriate.

> +		enable-active-high;
> +	};
> +
[...]
