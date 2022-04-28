Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5177C5135CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbiD1N4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243521AbiD1N4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:56:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A12762B6;
        Thu, 28 Apr 2022 06:53:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23SDr4Hk059239;
        Thu, 28 Apr 2022 08:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651153984;
        bh=SXWfGs93paC8+JGjukuUl/knJsXUK1oO0tYrUkQvlY0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vzgnbKqtApo9qDz7kUQyaEwuvgz4vqkAQWomCJsBZ13+tuuQnoZJDR5wlcoitBrQE
         Frd5pbaKFXGJxyjhnFjWUmH4GrTy2QSFvvx0Q4Ar0Xr8ADp15CXYVbiz80oSaMhKMt
         Bvq//eSJTmY+B+FRyI5fK8dT/WqMfEPig7qAxPIA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23SDr3MJ069887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Apr 2022 08:53:03 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Apr 2022 08:53:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Apr 2022 08:53:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23SDr14w086090;
        Thu, 28 Apr 2022 08:53:02 -0500
Date:   Thu, 28 Apr 2022 19:23:01 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: ti: k3-am625-sk: Add DSS ports, HDMI tx
 & peripherals
Message-ID: <20220428135300.rxu435u6yb2v5x3s@uda0490373>
References: <20220427090850.32280-1-a-bhatia1@ti.com>
 <20220427090850.32280-5-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427090850.32280-5-a-bhatia1@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:38-20220427, Aradhya Bhatia wrote:
> Add DT nodes for sil9022 HDMI transmitter (tx), HDMI connector and the
> HDMI fixed master clock on the am625-sk board.
> 
> Additionally, add and connect output port for DSS (vp2), input and output
> ports for the sil9022 HDMI tx and the input port for the HDMI connector.
> 
> The sil9022 HDMI tx is connected on the i2c1 bus. The HDMI connector on
> the board is of type "a". The clock frequency of the master clock that
> supports the HDMI tx is 12.288 MHz.
> 
> The dpi output signals from the vp2 of DSS are fed into the sil9022 HDMI
> transmitter. These signals are converted into HDMI signals which are
> further passed on to the HDMI connector on the board, on which display
> can be connected via appropriate HDMI cables.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 63 ++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index 96414c5dacf7..9567fa4a447b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -134,6 +134,23 @@ led-0 {
>  			default-state = "off";
>  		};
>  	};
> +
> +	hdmi_mstrclk: hdmi-mstrclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <12288000>;
> +	};
> +
> +	hdmi: connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&sii9022_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &main_pmx0 {
> @@ -385,6 +402,38 @@ exp1: gpio@22 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
>  	};
> +
> +	sii9022: sii9022@3b {
> +		compatible = "sil,sii9022";
> +		reg = <0x3b>;
> +
> +		clocks = <&hdmi_mstrclk>;
> +		clock-names = "mclk";
> +
> +		interrupt-parent = <&exp1>;
> +		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				sii9022_in: endpoint {
> +					remote-endpoint = <&dpi1_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				sii9022_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &main_i2c2 {
> @@ -450,6 +499,20 @@ &dss {
>  	pinctrl-0 = <&main_dss0_pins_default>;
>  };
>  
> +&dss_ports {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* VP2: DPI Output */
> +	port@1 {
> +		reg = <1>;
> +
> +		dpi1_out: endpoint {
> +			remote-endpoint = <&sii9022_in>;
> +		};
> +	};
> +};
> +
>  &mailbox0_cluster0 {
>  	mbox_m4_0: mbox-m4-0 {
>  		ti,mbox-rx = <0 0 0>;
> -- 
> 2.36.0
>

Reviewed-by: Rahul T R <r-ravikumar@ti.com>
