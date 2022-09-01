Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D005AA3E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiIAXrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAXrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:47:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4DD7C1A3;
        Thu,  1 Sep 2022 16:47:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281NldvM018827;
        Thu, 1 Sep 2022 18:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662076059;
        bh=X0R2Nc7hg+2Cfk1XYECmL5p1E+6HguckcPRv4Y+RnaU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=n1LmTHXWBcyw+ftRvvbq9IbR1+xvE2NmIARbJAxUX2L9zRJUOn/qx2HeUvQwtfbpk
         vQmKfwPpMoiUSaaLvSniFhfOeDue9U95+20euGDhSUlYSYBRAkGZDhaUtUuqP6y6bv
         q7PH+P3lkii4dXI/Z9mATS/I3FbdKDQ29vgP9hUE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281NldFn008844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 18:47:39 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 18:47:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 18:47:38 -0500
Received: from ubuntu (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id 281NlW8t026402;
        Thu, 1 Sep 2022 18:47:34 -0500
Date:   Thu, 1 Sep 2022 16:47:31 -0700
From:   Matt Ranostay <mranostay@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH RESEND 2/6] arm64: dts: ti: k3-j721s2-main: Add SERDES
 and WIZ device tree node
Message-ID: <YxFEk5zU4l9Yraek@ubuntu>
References: <20220810094000.248487-1-mranostay@ti.com>
 <20220810094000.248487-2-mranostay@ti.com>
 <8c130e92-9970-54d3-d263-37ae2f722b34@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c130e92-9970-54d3-d263-37ae2f722b34@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 02:15:28PM +0530, Vignesh Raghavendra wrote:
> 
> 
> On 10/08/22 15:09, Matt Ranostay wrote:
> > From: Aswath Govindraju <a-govindraju@ti.com>
> > 
> > Add dt node for the single instance of WIZ (SERDES wrapper) and
> > SERDES module shared by PCIe, eDP and USB.
> > 
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Acked-by: Matt Ranostay <mranostay@ti.com>
> > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 70 ++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > index f7e359da8690..f1e02d896168 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > @@ -5,6 +5,13 @@
> >   * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> >   */
> >  
> > +/ {
> > +	serdes_refclk: serdes-refclk {
> 
> clk-X
>

So something like 'serdes_refclk: clock-cmnrefclk' would seem to match the current
naming style of other K3 platforms (albeit except j7200).

> > +		#clock-cells = <0>;
> > +		compatible = "fixed-clock";
> > +	};
> > +};
> > +
> >  &cbass_main {
> >  	msmc_ram: sram@70000000 {
> >  		compatible = "mmio-sram";
> > @@ -33,6 +40,13 @@ scm_conf: scm-conf@104000 {
> >  		#size-cells = <1>;
> >  		ranges = <0x00 0x00 0x00104000 0x18000>;
> >  
> > +		serdes_ln_ctrl: mux-controller@80 {
> 
> mux-controller-X
> 

80 is the index into the mmio region. So should it still have @ for the node
name?

Also this is how the rest of the K3 platforms reference the mux controller.

> > +			compatible = "mmio-mux";
> > +			#mux-control-cells = <1>;
> > +			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
> > +					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
> > +		};
> > +
> >  		usb_serdes_mux: mux-controller@0 {
> >  			compatible = "mmio-mux";
> >  			#mux-control-cells = <1>;
> > @@ -728,6 +742,62 @@ usb0: usb@6000000 {
> >  		};
> >  	};
> >  
> > +	serdes_wiz0: wiz@5060000 {
> > +		compatible = "ti,j721e-wiz-10g";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&k3_clks 365 0>, <&k3_clks 365 3>, <&serdes_refclk>;
> > +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> > +		num-lanes = <4>;
> > +		#reset-cells = <1>;
> > +		ranges = <0x5060000 0x0 0x5060000 0x10000>;
> > +
> > +		assigned-clocks = <&k3_clks 365 3>;
> > +		assigned-clock-parents = <&k3_clks 365 7>;
> > +
> > +		wiz0_pll0_refclk: pll0-refclk {
> 
> please use generic node name clk-X here and elsewhere in the patch

So something like 'wiz0_pll0_refclk: clk-refpll0'?

- Matt

> 
> > +			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
> > +			clock-output-names = "wiz0_pll0_refclk";
> > +			#clock-cells = <0>;
> > +			assigned-clocks = <&wiz0_pll0_refclk>;
> > +			assigned-clock-parents = <&k3_clks 365 3>;
> > +		};
> > +
> > +		wiz0_pll1_refclk: pll1-refclk {
> 
> ditto
> 
> > +			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
> > +			clock-output-names = "wiz0_pll1_refclk";
> > +			#clock-cells = <0>;
> > +			assigned-clocks = <&wiz0_pll1_refclk>;
> > +			assigned-clock-parents = <&k3_clks 365 3>;
> > +		};
> > +
> > +		wiz0_refclk_dig: refclk-dig {
> 
> ditto
> 
> > +			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
> > +			clock-output-names = "wiz0_refclk_dig";
> > +			#clock-cells = <0>;
> > +			assigned-clocks = <&wiz0_refclk_dig>;
> > +			assigned-clock-parents = <&k3_clks 365 3>;
> > +		};
> > +
> > +		wiz0_cmn_refclk_dig_div: cmn-refclk-dig-div {
> 
> ditto
> 
> > +			clocks = <&wiz0_refclk_dig>;
> > +			#clock-cells = <0>;
> > +		};
> > +
> > +		serdes0: serdes@5060000 {
> > +			compatible = "ti,j721e-serdes-10g";
> > +			reg = <0x05060000 0x00010000>;
> > +			reg-names = "torrent_phy";
> > +			resets = <&serdes_wiz0 0>;
> > +			reset-names = "torrent_reset";
> > +			clocks = <&wiz0_pll0_refclk>;
> > +			clock-names = "refclk";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +	};
> > +
> >  	main_mcan0: can@2701000 {
> >  		compatible = "bosch,m_can";
> >  		reg = <0x00 0x02701000 0x00 0x200>,
> 
> -- 
> Regards
> Vignesh
