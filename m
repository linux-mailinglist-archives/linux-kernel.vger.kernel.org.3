Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674924EDB87
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiCaORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiCaORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:17:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D15AEDD;
        Thu, 31 Mar 2022 07:15:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VEFHmC021598;
        Thu, 31 Mar 2022 09:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648736117;
        bh=psfq1z0RHn/I3okmGZt0F8Lscov57xnCw7rlyj0rgMA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LkdEmsG52G2u5jMIskHhR1dkrBFRaKR6lXmr7SxbwPNI0qRUc1TD+xb2afbZCtdW/
         23xAAADpihYlEp/ZGjBsVTlv34k/muf++htkvZxt6CLJTI5IGUqXnQwJqnHJMHICBv
         c/+wqrc+5Z5WwbdoRXVF/jQdHcTxiPpm1MEe2VuM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VEFHbl077710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 09:15:17 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 09:15:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 09:15:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VEFF9w104847;
        Thu, 31 Mar 2022 09:15:16 -0500
Date:   Thu, 31 Mar 2022 19:45:15 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: add DP & DP PHY
Message-ID: <20220331141514.kr2synsaodqd6w2c@uda0490373>
References: <20220222163230.1566-1-r-ravikumar@ti.com>
 <20220222163230.1566-2-r-ravikumar@ti.com>
 <069c1751-41a9-e47c-96d7-8ed83e1fe3f9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <069c1751-41a9-e47c-96d7-8ed83e1fe3f9@ti.com>
User-Agent: NeoMutt/20171215
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

On 09:47-20220228, Kishon Vijay Abraham I wrote:
> Hi Rahul,
> 
> On 22/02/22 10:02 pm, Rahul T R wrote:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Add DT nodes for DisplayPort and DisplayPort PHY. The DP is Cadence MHDP
> > 8546 and the PHY is a Cadence Torrent PHY with TI WIZ wrapper.
> > 
> > A slight irregularity in the bindings is the DPTX PHY register block,
> > which is in the MHDP IP, but is needed and mapped by the PHY.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 102 ++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > index 599861259a30..9e2b212100bb 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> > @@ -786,6 +786,82 @@
> >  		#size-cells = <2>;
> >  	};
> >  
> > +	serdes_wiz4: wiz@5050000 {
> > +		compatible = "ti,j721e-wiz-10g";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		power-domains = <&k3_pds 297 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&k3_clks 297 1>, <&k3_clks 297 9>, <&cmn_refclk>;
> > +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> > +		assigned-clocks = <&k3_clks 297 9>;
> > +		assigned-clock-parents = <&k3_clks 297 10>;
> > +		assigned-clock-rates = <19200000>;
> > +		num-lanes = <4>;
> > +		#reset-cells = <1>;
> > +		ranges = <0x5050000 0x0 0x5050000 0x10000>,
> > +			<0xa030a00 0x0 0xa030a00 0x40>;
> > +
> > +		wiz4_pll0_refclk: pll0-refclk {
> > +			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
> > +			clock-output-names = "wiz4_pll0_refclk";
> > +			#clock-cells = <0>;
> > +			assigned-clocks = <&wiz4_pll0_refclk>;
> > +			assigned-clock-parents = <&k3_clks 297 9>;
> > +		};
> > +
> > +		wiz4_pll1_refclk: pll1-refclk {
> > +			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
> > +			clock-output-names = "wiz4_pll1_refclk";
> > +			#clock-cells = <0>;
> > +			assigned-clocks = <&wiz4_pll1_refclk>;
> > +			assigned-clock-parents = <&k3_clks 297 9>;
> > +		};
> > +
> > +		wiz4_refclk_dig: refclk-dig {
> > +			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
> > +			clock-output-names = "wiz4_refclk_dig";
> > +			#clock-cells = <0>;
> > +			assigned-clocks = <&wiz4_refclk_dig>;
> > +			assigned-clock-parents = <&k3_clks 297 9>;
> > +		};
> > +
> > +		wiz4_cmn_refclk_dig_div: cmn-refclk-dig-div {
> > +			clocks = <&wiz4_refclk_dig>;
> > +			#clock-cells = <0>;
> > +		};
> > +
> > +		wiz4_cmn_refclk1_dig_div: cmn-refclk1-dig-div {
> > +			clocks = <&wiz4_pll1_refclk>;
> > +			#clock-cells = <0>;
> > +		};
> 
> I'd prefer we deprecate creating clock sub-nodes for new platform additions and
> use a similar approach as that used for AM64 (use phandle with a parameter to
> refer clocks). Please refer how this was created for AM64
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#n795
> 
> Since this is the same SERDES IP as used in AM64, you should be able to use the
> same DT binding as that used in AM64. But if you'd like to adapt
> "ti,j721e-wiz-10g" to use phandle with parameter in the WIZ driver (while making
> sure the existing sub-node based binding is not broken), that is highly welcomed.
>

Thanks Kishon,

Will address this in the respin

Regards
Rahul T R
 
> > +
> > +		serdes4: serdes@5050000 {
> > +			/*
> > +			 * Note: we also map DPTX PHY registers as the Torrent
> > +			 * needs to manage those.
> > +			 */
> > +			compatible = "ti,j721e-serdes-10g";
> > +			reg = <0x5050000 0x10000>,
> > +			      <0xa030a00 0x40>; /* DPTX PHY */
> > +			reg-names = "torrent_phy", "dptx_phy";
> > +
> > +			resets = <&serdes_wiz4 0>;
> > +			reset-names = "torrent_reset";
> > +			clocks = <&wiz4_pll0_refclk>;
> > +			clock-names = "refclk";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			torrent_phy_dp: phy@0 {
> > +				reg = <0>;
> > +				resets = <&serdes_wiz4 1>;
> > +				cdns,phy-type = <PHY_TYPE_DP>;
> > +				cdns,num-lanes = <4>;
> > +				cdns,max-bit-rate = <5400>;
> > +				#phy-cells = <0>;
> > +			};
> 
> The link sub-nodes should be in the board DTS file.
> 
> Thanks,
> Kishon
