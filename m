Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7775551791
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiFTLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiFTLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:42:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932571659E;
        Mon, 20 Jun 2022 04:42:29 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25KBgM6x061455;
        Mon, 20 Jun 2022 06:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655725342;
        bh=4plFmT78RjcqN4kVC76hW4KGxAhnAgKqHE3Pr4lusVA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XoLD3Y4ltUZxIMljk5+60Ub/MNz2dDZKSRTwdj6DUVYfjhA7P8itoEBX3jIckGnwu
         mLYjWdt/bLw51fQg9ELd0O846zPrAVvtS0CWIwSnw5MeYF84QPtzflmDso8AozBFON
         pRKtuTJXsAvY/IWEPr+mfivcXFZegEK4MJY0ayds=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25KBgMU4087171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jun 2022 06:42:22 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Jun 2022 06:42:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Jun 2022 06:42:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25KBgKsC130217;
        Mon, 20 Jun 2022 06:42:21 -0500
Date:   Mon, 20 Jun 2022 17:12:19 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <kishon@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Vijay Pothukuchi <vijayp@ti.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-j721e-*: Add dts nodes for
 EHRPWMs
Message-ID: <20220620114218.fqkf6vnyxafla23z@uda0490373>
References: <20220530101031.11357-1-r-ravikumar@ti.com>
 <20220530101031.11357-3-r-ravikumar@ti.com>
 <20220618021949.i5m4saxi2celzanz@kahuna>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220618021949.i5m4saxi2celzanz@kahuna>
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

On 21:19-20220617, Nishanth Menon wrote:
> On 15:40-20220530, Rahul T R wrote:
> > From: Vijay Pothukuchi <vijayp@ti.com>
> > 
> > Add dts nodes for 6 EHRPWM instances on SoC
> > 
> > Signed-off-by: Vijay Pothukuchi <vijayp@ti.com>
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> >  .../dts/ti/k3-j721e-common-proc-board.dts     | 24 +++++++
> >  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 62 ++++++++++++++++++-
> >  arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 24 +++++++
> >  3 files changed, 109 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > index 2bc26a296496..f7d02fa4d6fc 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> > @@ -995,3 +995,27 @@
> >  &main_mcan13 {
> >  	status = "disabled";
> >  };
> > +
> > +&main_ehrpwm0 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm1 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm2 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm3 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm4 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm5 {
> > +	status = "disabled";
> > +};
> 
> 
> Do the pwm driver croak and die OR it is un-usable on proc-board or
> disabled due to not-primary function (ideally drivers should shut things
> off when unused)?
> 

Hi Nishanth,

Nodes are disabled since
EHRPWM is not primary function
and pins are configured for
different interfaces like MCASP10 etc..

> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > index 43b6cf5791ee..1ee00b73905d 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > @@ -66,7 +66,67 @@
> >  			#mux-control-cells = <1>;
> >  			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
> >  					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
> > -	    };
> > +		};
> > +
> > +		ehrpwm_tbclk: clock-controller@4140 {
> > +			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> > +			reg = <0x4140 0x18>;
> > +			#clock-cells = <1>;
> > +		};
> > +	};
> > +
> > +	main_ehrpwm0: pwm@3000000 {
> > +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> > +		#pwm-cells = <3>;
> > +		reg = <0x0 0x3000000 0x0 0x100>;
> 
> would suggest 0x00 instead of 0x0

will fix this in the respin

Regards
Rahul T R

> 
> > +		power-domains = <&k3_pds 83 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 83 0>;
> > +		clock-names = "tbclk", "fck";
> > +	};
> > +
> > +	main_ehrpwm1: pwm@3010000 {
> > +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> > +		#pwm-cells = <3>;
> > +		reg = <0x0 0x3010000 0x0 0x100>;
> > +		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 84 0>;
> > +		clock-names = "tbclk", "fck";
> > +	};
> > +
> > +	main_ehrpwm2: pwm@3020000 {
> > +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> > +		#pwm-cells = <3>;
> > +		reg = <0x0 0x3020000 0x0 0x100>;
> > +		power-domains = <&k3_pds 85 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 85 0>;
> > +		clock-names = "tbclk", "fck";
> > +	};
> > +
> > +	main_ehrpwm3: pwm@3030000 {
> > +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> > +		#pwm-cells = <3>;
> > +		reg = <0x0 0x3030000 0x0 0x100>;
> > +		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 86 0>;
> > +		clock-names = "tbclk", "fck";
> > +	};
> > +
> > +	main_ehrpwm4: pwm@3040000 {
> > +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> > +		#pwm-cells = <3>;
> > +		reg = <0x0 0x3040000 0x0 0x100>;
> > +		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 87 0>;
> > +		clock-names = "tbclk", "fck";
> > +	};
> > +
> > +	main_ehrpwm5: pwm@3050000 {
> > +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> > +		#pwm-cells = <3>;
> > +		reg = <0x0 0x3050000 0x0 0x100>;
> > +		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 88 0>;
> > +		clock-names = "tbclk", "fck";
> >  	};
> >  
> >  	gic500: interrupt-controller@1800000 {
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > index 80358cba6954..98a55778f3fe 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> > @@ -1129,3 +1129,27 @@
> >  	memory-region = <&c71_0_dma_memory_region>,
> >  			<&c71_0_memory_region>;
> >  };
> > +
> > +&main_ehrpwm0 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm1 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm2 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm3 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm4 {
> > +	status = "disabled";
> > +};
> > +
> > +&main_ehrpwm5 {
> > +	status = "disabled";
> > +};
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
