Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD35A8C04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiIADrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIADrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:47:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F77161682;
        Wed, 31 Aug 2022 20:47:08 -0700 (PDT)
X-UUID: e79253e932c3434abe699431a21d3435-20220901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xl5ebXbjbzQPJXHpd3wRratKYkzXi1VpgO2J7nGAbjs=;
        b=LXODQWm3pspRo+zpOOD4Rgrd9IYaB2to+cXoJdH6l2jyEHi0oYpro8hVSINxJn3ijb+t14y/ZvFjd1oSr2tgA2HKPuRIOjRvaTEZwA28aU36fOTBa6pp/12CoABTs7bMe08XvpdHlR/ZYTIst/33/M8Ux47pMGqSDZ0hgGZW6EE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:329dd0b9-7265-4c8a-ba7a-7d7bc5505560,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:cd1044d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e79253e932c3434abe699431a21d3435-20220901
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1167694257; Thu, 01 Sep 2022 11:47:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Sep 2022 11:47:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 1 Sep 2022 11:47:01 +0800
Message-ID: <deb84c968ba615201619e5c4ef0445f09de6fc7e.camel@mediatek.com>
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
Date:   Thu, 1 Sep 2022 11:47:01 +0800
In-Reply-To: <b6524da2-34d6-cb7b-c8bf-19809e8932ed@gmail.com>
References: <20220630094909.8014-1-chui-hao.chiu@mediatek.com>
         <b6524da2-34d6-cb7b-c8bf-19809e8932ed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-30 at 10:43 +0200, Matthias Brugger wrote:
> 
> On 30/06/2022 11:49, Peter Chiu wrote:
> > This enables built-in 802.11ax Wi-Fi support.
> > 
> > Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> > Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> > ---
> > v2: add clocks and clock-names.
> > v3: rename wmac to wifi and change underscores to dash in node
> > names.
> > v4: rebase to the latest codebase.
> > ---
> >   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 41
> > +++++++++++++++++++
> >   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 23 +++++++++++
> >   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 43
> > ++++++++++++++++++++
> >   3 files changed, 107 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > index 882277a..28cd168 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > @@ -115,6 +115,13 @@ &uart2 {
> >   	status = "okay";
> >   };
> >   
> > +&wifi {
> > +	status = "okay";
> > +	pinctrl-names = "default", "dbdc";
> > +	pinctrl-0 = <&wf_2g_5g_pins>;
> > +	pinctrl-1 = <&wf_dbdc_pins>;
> > +};
> > +
> >   &pio {
> >   	uart1_pins: uart1-pins {
> >   		mux {
> > @@ -129,4 +136,38 @@ mux {
> >   			groups = "uart2";
> >   		};
> >   	};
> > +
> > +	wf_2g_5g_pins: wf-2g-5g-pins {
> > +		mux {
> > +			function = "wifi";
> > +			groups = "wf_2g", "wf_5g";
> 
> yaml says:
>           - if:
>                properties:
>                  function:
>                    const: wifi
>              then:
>                properties:
>                  groups:
>                    enum: [wf_2g, wf_5g, wf_dbdc]
> 
> 
> Did you run the binding checker against this DTS?
The binding checker showed the groups setting is too long. We will send
a patch to fix yaml by setting groups as string-array.

> Why can't we just merge wf_2g_5g_pins with wf_dbdc_pins?
Since they use different pinmux settings on the same pin, we need to
distinguish them.

Best Regards,
Peter Chiu
> 
> Regards,
> Matthias
> 
> > +		};
> > +		conf {
> > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > "WF0_HB4",
> > +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5",
> > "WF0_HB6",
> > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > "WF0_HB10",
> > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > "WF1_HB1",
> > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > "WF1_HB0",
> > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > "WF1_HB8",
> > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > +			drive-strength = <4>;
> > +		};
> > +	};
> > +
> > +	wf_dbdc_pins: wf-dbdc-pins {
> > +		mux {
> > +			function = "wifi";
> > +			groups = "wf_dbdc";
> > +		};
> > +		conf {
> > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > "WF0_HB4",
> > +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5",
> > "WF0_HB6",
> > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > "WF0_HB10",
> > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > "WF1_HB1",
> > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > "WF1_HB0",
> > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > "WF1_HB8",
> > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > +			drive-strength = <4>;
> > +		};
> > +	};
> >   };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > index e3a407d..890ded0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > @@ -7,6 +7,7 @@
> >   #include <dt-bindings/interrupt-controller/irq.h>
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >   #include <dt-bindings/clock/mt7986-clk.h>
> > +#include <dt-bindings/reset/mt7986-resets.h>
> >   
> >   / {
> >   	interrupt-parent = <&gic>;
> > @@ -70,6 +71,11 @@ secmon_reserved: secmon@43000000 {
> >   			reg = <0 0x43000000 0 0x30000>;
> >   			no-map;
> >   		};
> > +
> > +		wmcpu_emi: wmcpu-reserved@4fc00000 {
> > +			no-map;
> > +			reg = <0 0x4fc00000 0 0x00100000>;
> > +		};
> >   	};
> >   
> >   	timer {
> > @@ -261,6 +267,23 @@ eth: ethernet@15100000 {
> >   			#size-cells = <0>;
> >   			status = "disabled";
> >   		};
> > +
> > +		wifi: wifi@18000000 {
> > +			compatible = "mediatek,mt7986-wmac";
> > +			resets = <&watchdog
> > MT7986_TOPRGU_CONSYS_SW_RST>;
> > +			reset-names = "consys";
> > +			clocks = <&topckgen CLK_TOP_CONN_MCUSYS_SEL>,
> > +				 <&topckgen CLK_TOP_AP2CNN_HOST_SEL>;
> > +			clock-names = "mcu", "ap2conn";
> > +			reg = <0 0x18000000 0 0x1000000>,
> > +			      <0 0x10003000 0 0x1000>,
> > +			      <0 0x11d10000 0 0x1000>;
> > +			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
> > +			memory-region = <&wmcpu_emi>;
> > +		};
> >   	};
> >   
> >   };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > index 0f49d57..7f21b10 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > @@ -98,3 +98,46 @@ fixed-link {
> >   		};
> >   	};
> >   };
> > +
> > +&wifi {
> > +	status = "okay";
> > +	pinctrl-names = "default", "dbdc";
> > +	pinctrl-0 = <&wf_2g_5g_pins>;
> > +	pinctrl-1 = <&wf_dbdc_pins>;
> > +};
> > +
> > +&pio {
> > +	wf_2g_5g_pins: wf-2g-5g-pins {
> > +		mux {
> > +			function = "wifi";
> > +			groups = "wf_2g", "wf_5g";
> > +		};
> > +		conf {
> > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > "WF0_HB4",
> > +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5",
> > "WF0_HB6",
> > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > "WF0_HB10",
> > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > "WF1_HB1",
> > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > "WF1_HB0",
> > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > "WF1_HB8",
> > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > +			drive-strength = <4>;
> > +		};
> > +	};
> > +
> > +	wf_dbdc_pins: wf-dbdc-pins {
> > +		mux {
> > +			function = "wifi";
> > +			groups = "wf_dbdc";
> > +		};
> > +		conf {
> > +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3",
> > "WF0_HB4",
> > +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5",
> > "WF0_HB6",
> > +			       "WF0_HB7", "WF0_HB8", "WF0_HB9",
> > "WF0_HB10",
> > +			       "WF0_TOP_CLK", "WF0_TOP_DATA",
> > "WF1_HB1",
> > +			       "WF1_HB2", "WF1_HB3", "WF1_HB4",
> > "WF1_HB0",
> > +			       "WF1_HB5", "WF1_HB6", "WF1_HB7",
> > "WF1_HB8",
> > +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> > +			drive-strength = <4>;
> > +		};
> > +	};
> > +};

