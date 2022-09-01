Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC775A9550
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiIALDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIALDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:03:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26745077;
        Thu,  1 Sep 2022 04:03:07 -0700 (PDT)
X-UUID: 0aca0395703f49f68b4f39bc7a8ce050-20220901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zGXbG85OwSaQ9RW6b5zZ9K/RY/riE4Y898TbFDyAPXs=;
        b=YoUGhJ8SdaP2ws2KsiR0idhrElWngUVmnVilK9LryiVP5lW2L45OcvN0zeaTC43oyyk4PdDcz2P2XNP8XgMt6GVxwsv/MB0jEd2CXKBUCsv2Q97qNCbXArIfF9/cJ0cGg5zDeny6N4GqnZL17SQzBvBPWgbe44T+XrFZAraVo3Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:fa68c62d-6813-4884-9845-3ee0925c8edb,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:c112d220-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0aca0395703f49f68b4f39bc7a8ce050-20220901
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1245573146; Thu, 01 Sep 2022 19:03:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Sep 2022 19:03:00 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 1 Sep 2022 19:03:00 +0800
Message-ID: <28d62f85365b2a718e143cf5bd0c1230bee8168f.camel@mediatek.com>
Subject: Re: [PATCH v4] arm64: dts: mt7986: add built-in Wi-Fi device nodes
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, Ryder Lee <ryder.Lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 1 Sep 2022 19:03:00 +0800
In-Reply-To: <079c023c-fa2d-1a5a-41ec-6d364067eb7d@gmail.com>
References: <20220630094909.8014-1-chui-hao.chiu@mediatek.com>
         <b6524da2-34d6-cb7b-c8bf-19809e8932ed@gmail.com>
         <deb84c968ba615201619e5c4ef0445f09de6fc7e.camel@mediatek.com>
         <079c023c-fa2d-1a5a-41ec-6d364067eb7d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-01 at 10:13 +0200, Matthias Brugger wrote:
> 
> On 01/09/2022 05:47, Peter Chiu wrote:
> > On Tue, 2022-08-30 at 10:43 +0200, Matthias Brugger wrote:
> > > 
> > > On 30/06/2022 11:49, Peter Chiu wrote:
> > > > This enables built-in 802.11ax Wi-Fi support.
> > > > 
> > > > Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> > > > Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> > > > Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> > > > ---
> > > > v2: add clocks and clock-names.
> > > > v3: rename wmac to wifi and change underscores to dash in node
> > > > names.
> > > > v4: rebase to the latest codebase.
> > > > ---
> > > >    arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 41
> > > > +++++++++++++++++++
> > > >    arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 23
> > > > +++++++++++
> > > >    arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 43
> > > > ++++++++++++++++++++
> > > >    3 files changed, 107 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > > > b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > > > index 882277a..28cd168 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > > > @@ -115,6 +115,13 @@ &uart2 {
> > > >    	status = "okay";
> > > >    };
> > > >    
> > > > +&wifi {
> > > > +	status = "okay";
> > > > +	pinctrl-names = "default", "dbdc";
> > > > +	pinctrl-0 = <&wf_2g_5g_pins>;
> > > > +	pinctrl-1 = <&wf_dbdc_pins>;
> > > > +};
> > > > +
> > > >    &pio {
> > > >    	uart1_pins: uart1-pins {
> > > >    		mux {
> > > > @@ -129,4 +136,38 @@ mux {
> > > >    			groups = "uart2";
> > > >    		};
> > > >    	};
> > > > +
> > > > +	wf_2g_5g_pins: wf-2g-5g-pins {
> > > > +		mux {
> > > > +			function = "wifi";
> > > > +			groups = "wf_2g", "wf_5g";
> > > 
> > > yaml says:
> > >            - if:
> > >                 properties:
> > >                   function:
> > >                     const: wifi
> > >               then:
> > >                 properties:
> > >                   groups:
> > >                     enum: [wf_2g, wf_5g, wf_dbdc]
> > > 
> > > 
> > > Did you run the binding checker against this DTS?
> > 
> > The binding checker showed the groups setting is too long. We will
> > send
> > a patch to fix yaml by setting groups as string-array.
> > 
> 
> Wait, does this mean the binding was wrong in the first place, as you
> can't set 
> all three groups in one node?

Yes, we need to set two groups in a node for the board which supports
wifi 2g and wifi 5g simultaneously. The bindings lack the following
code which set groups to string-array.
$ref: /schemas/types.yaml#/definitions/string-array

> 
> > > Why can't we just merge wf_2g_5g_pins with wf_dbdc_pins?
> > 
> > Since they use different pinmux settings on the same pin, we need
> > to
> > distinguish them.
> > 
> 
> wf-2g-5g-pins and wf-dbdc-pins set the same drive-strength to the
> very same 
> group of pins. What do you mean exactly? Sorry I'm not an expert on
> the pinctrl 
> infrastructure.

wf-2g-5g-pins and wf-dbdc-pins use different functions by setting
different groups. But I set useless drive-strength in the wf-dbdc-pins
node. I will remove them in the next version.

Best Regards,
Peter Chiu

> 
> Regards,
> Matthias
> 
> 
> > Best Regards,
> > Peter Chiu
> > > 
> > > Regards,
> > > Matthias
> > > 
> > > > +		};
> > > > +		conf {
> > > > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > > > "WF0_HB4",
> > > > +			       "WF0_HB0", "WF0_HB0_B",
> > > > "WF0_HB5",
> > > > "WF0_HB6",
> > > > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > > > "WF0_HB10",
> > > > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > > > "WF1_HB1",
> > > > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > > > "WF1_HB0",
> > > > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > > > "WF1_HB8",
> > > > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > > > +			drive-strength = <4>;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	wf_dbdc_pins: wf-dbdc-pins {
> > > > +		mux {
> > > > +			function = "wifi";
> > > > +			groups = "wf_dbdc";
> > > > +		};
> > > > +		conf {
> > > > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > > > "WF0_HB4",
> > > > +			       "WF0_HB0", "WF0_HB0_B",
> > > > "WF0_HB5",
> > > > "WF0_HB6",
> > > > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > > > "WF0_HB10",
> > > > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > > > "WF1_HB1",
> > > > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > > > "WF1_HB0",
> > > > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > > > "WF1_HB8",
> > > > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > > > +			drive-strength = <4>;
> > > > +		};
> > > > +	};
> > > >    };
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > > > b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > > > index e3a407d..890ded0 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > > > @@ -7,6 +7,7 @@
> > > >    #include <dt-bindings/interrupt-controller/irq.h>
> > > >    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > >    #include <dt-bindings/clock/mt7986-clk.h>
> > > > +#include <dt-bindings/reset/mt7986-resets.h>
> > > >    
> > > >    / {
> > > >    	interrupt-parent = <&gic>;
> > > > @@ -70,6 +71,11 @@ secmon_reserved: secmon@43000000 {
> > > >    			reg = <0 0x43000000 0 0x30000>;
> > > >    			no-map;
> > > >    		};
> > > > +
> > > > +		wmcpu_emi: wmcpu-reserved@4fc00000 {
> > > > +			no-map;
> > > > +			reg = <0 0x4fc00000 0 0x00100000>;
> > > > +		};
> > > >    	};
> > > >    
> > > >    	timer {
> > > > @@ -261,6 +267,23 @@ eth: ethernet@15100000 {
> > > >    			#size-cells = <0>;
> > > >    			status = "disabled";
> > > >    		};
> > > > +
> > > > +		wifi: wifi@18000000 {
> > > > +			compatible = "mediatek,mt7986-wmac";
> > > > +			resets = <&watchdog
> > > > MT7986_TOPRGU_CONSYS_SW_RST>;
> > > > +			reset-names = "consys";
> > > > +			clocks = <&topckgen
> > > > CLK_TOP_CONN_MCUSYS_SEL>,
> > > > +				 <&topckgen
> > > > CLK_TOP_AP2CNN_HOST_SEL>;
> > > > +			clock-names = "mcu", "ap2conn";
> > > > +			reg = <0 0x18000000 0 0x1000000>,
> > > > +			      <0 0x10003000 0 0x1000>,
> > > > +			      <0 0x11d10000 0 0x1000>;
> > > > +			interrupts = <GIC_SPI 213
> > > > IRQ_TYPE_LEVEL_HIGH>,
> > > > +				     <GIC_SPI 214
> > > > IRQ_TYPE_LEVEL_HIGH>,
> > > > +				     <GIC_SPI 215
> > > > IRQ_TYPE_LEVEL_HIGH>,
> > > > +				     <GIC_SPI 216
> > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > +			memory-region = <&wmcpu_emi>;
> > > > +		};
> > > >    	};
> > > >    
> > > >    };
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > > > b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > > > index 0f49d57..7f21b10 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > > > @@ -98,3 +98,46 @@ fixed-link {
> > > >    		};
> > > >    	};
> > > >    };
> > > > +
> > > > +&wifi {
> > > > +	status = "okay";
> > > > +	pinctrl-names = "default", "dbdc";
> > > > +	pinctrl-0 = <&wf_2g_5g_pins>;
> > > > +	pinctrl-1 = <&wf_dbdc_pins>;
> > > > +};
> > > > +
> > > > +&pio {
> > > > +	wf_2g_5g_pins: wf-2g-5g-pins {
> > > > +		mux {
> > > > +			function = "wifi";
> > > > +			groups = "wf_2g", "wf_5g";
> > > > +		};
> > > > +		conf {
> > > > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > > > "WF0_HB4",
> > > > +			       "WF0_HB0", "WF0_HB0_B",
> > > > "WF0_HB5",
> > > > "WF0_HB6",
> > > > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > > > "WF0_HB10",
> > > > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > > > "WF1_HB1",
> > > > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > > > "WF1_HB0",
> > > > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > > > "WF1_HB8",
> > > > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > > > +			drive-strength = <4>;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	wf_dbdc_pins: wf-dbdc-pins {
> > > > +		mux {
> > > > +			function = "wifi";
> > > > +			groups = "wf_dbdc";
> > > > +		};
> > > > +		conf {
> > > > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > > > "WF0_HB4",
> > > > +			       "WF0_HB0", "WF0_HB0_B",
> > > > "WF0_HB5",
> > > > "WF0_HB6",
> > > > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > > > "WF0_HB10",
> > > > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > > > "WF1_HB1",
> > > > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > > > "WF1_HB0",
> > > > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > > > "WF1_HB8",
> > > > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > > > +			drive-strength = <4>;
> > > > +		};
> > > > +	};
> > > > +};

