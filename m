Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F85501F6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383683AbiFRCUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFRCT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:19:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3195B6A026;
        Fri, 17 Jun 2022 19:19:57 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I2JoCu085186;
        Fri, 17 Jun 2022 21:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655518790;
        bh=KowOwt7/uxj0mtFxMJgrFeb9wkGNGAaHQTQP51WraPU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YC2CpplwEfAHMODHKuX94Or71h6bo+AxVsGWHI2EdH/4gQOjJfZY2BuZbTngbE7cb
         Ce/HjkD98UokeR5J/5nCSVgqxKbj7g0jxBgIfEfSzNCpZGeJiOdoQivRmeDbS5Wzfe
         jjl04jxLe7e60XlKn/5mmh5XU3/tnECDmq52w57I=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I2JnPk008623
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 21:19:49 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 21:19:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 21:19:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I2JnAL128179;
        Fri, 17 Jun 2022 21:19:49 -0500
Date:   Fri, 17 Jun 2022 21:19:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rahul T R <r-ravikumar@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <kishon@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Vijay Pothukuchi <vijayp@ti.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-j721e-*: Add dts nodes for
 EHRPWMs
Message-ID: <20220618021949.i5m4saxi2celzanz@kahuna>
References: <20220530101031.11357-1-r-ravikumar@ti.com>
 <20220530101031.11357-3-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220530101031.11357-3-r-ravikumar@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:40-20220530, Rahul T R wrote:
> From: Vijay Pothukuchi <vijayp@ti.com>
> 
> Add dts nodes for 6 EHRPWM instances on SoC
> 
> Signed-off-by: Vijay Pothukuchi <vijayp@ti.com>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 24 +++++++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 62 ++++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 24 +++++++
>  3 files changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 2bc26a296496..f7d02fa4d6fc 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -995,3 +995,27 @@
>  &main_mcan13 {
>  	status = "disabled";
>  };
> +
> +&main_ehrpwm0 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm1 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm2 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm3 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm4 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm5 {
> +	status = "disabled";
> +};


Do the pwm driver croak and die OR it is un-usable on proc-board or
disabled due to not-primary function (ideally drivers should shut things
off when unused)?

> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 43b6cf5791ee..1ee00b73905d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -66,7 +66,67 @@
>  			#mux-control-cells = <1>;
>  			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
>  					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
> -	    };
> +		};
> +
> +		ehrpwm_tbclk: clock-controller@4140 {
> +			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> +			reg = <0x4140 0x18>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
> +	main_ehrpwm0: pwm@3000000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3000000 0x0 0x100>;

would suggest 0x00 instead of 0x0

> +		power-domains = <&k3_pds 83 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 83 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	main_ehrpwm1: pwm@3010000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3010000 0x0 0x100>;
> +		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 84 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	main_ehrpwm2: pwm@3020000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3020000 0x0 0x100>;
> +		power-domains = <&k3_pds 85 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 85 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	main_ehrpwm3: pwm@3030000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3030000 0x0 0x100>;
> +		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 86 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	main_ehrpwm4: pwm@3040000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3040000 0x0 0x100>;
> +		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 87 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	main_ehrpwm5: pwm@3050000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3050000 0x0 0x100>;
> +		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 88 0>;
> +		clock-names = "tbclk", "fck";
>  	};
>  
>  	gic500: interrupt-controller@1800000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 80358cba6954..98a55778f3fe 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -1129,3 +1129,27 @@
>  	memory-region = <&c71_0_dma_memory_region>,
>  			<&c71_0_memory_region>;
>  };
> +
> +&main_ehrpwm0 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm1 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm2 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm3 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm4 {
> +	status = "disabled";
> +};
> +
> +&main_ehrpwm5 {
> +	status = "disabled";
> +};
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
