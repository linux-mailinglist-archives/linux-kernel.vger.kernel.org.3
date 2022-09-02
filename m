Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06ED5AA62B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiIBDIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiIBDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:08:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070AF7FE6F;
        Thu,  1 Sep 2022 20:08:32 -0700 (PDT)
X-UUID: 4c4b8e6d2b244028a50808572218b0c3-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EbFnlhXDg72eWTDx+a0rxuRSm17IARkT6d/ukeMGhDU=;
        b=QsBN6Rh7i+yimV7GRwPsygtcntdY/Uo6DlqqUcsK115rFsctNPGee4Co+5Pg3b6HPQTAj9mub2RO0psdy300RkKXO8ZoBnW6YfG/Scu9xnHX9TwIPwph75u5z3RuF7ZzRgCufM6RSKg6TvHRMM4zABSzeiuUP/3pE5Yu1Xfgg+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:415d4169-a62f-48d2-ba59-170034728bd4,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:1f3ce420-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4c4b8e6d2b244028a50808572218b0c3-20220902
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 823729715; Fri, 02 Sep 2022 11:08:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 2 Sep 2022 11:08:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 2 Sep 2022 11:08:28 +0800
Message-ID: <63ee30f9febd94dbfd1d3f50825e9f5328465f78.camel@mediatek.com>
Subject: Re: [PATCH v5] arm64: dts: mt7986: add built-in Wi-Fi device nodes
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
Date:   Fri, 2 Sep 2022 11:08:27 +0800
In-Reply-To: <aac98d72-863d-eb7b-caab-73bb0fddeb83@gmail.com>
References: <20220901130552.26234-1-chui-hao.chiu@mediatek.com>
         <aac98d72-863d-eb7b-caab-73bb0fddeb83@gmail.com>
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

On Thu, 2022-09-01 at 16:31 +0200, Matthias Brugger wrote:
> 
> On 01/09/2022 15:05, Peter Chiu wrote:
> > This enables built-in 802.11ax Wi-Fi support.
> > 
> > Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> > Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> > 
> 
> That won't work without the pinctrl yaml file updated. Please send
> both together 
> so that we can review them.
> 

Thanks for your kind reminder. I just sent the pinctrl yaml patch.

https://patchwork.kernel.org/project/linux-mediatek/patch/20220902024719.31943-1-chui-hao.chiu@mediatek.com/

Best Regards,
Peter Chiu
> Regards,
> Matthias
> 
> > ---
> > v2: add clocks and clock-names.
> > v3: rename wmac to wifi and change underscores to dash in node
> > names.
> > v4: rebase to the latest codebase.
> > v5: remove useless pins in wf_dbdc_pins node.
> > ---
> >   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 38
> > +++++++++++++++++++
> >   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 23 +++++++++++
> >   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 40
> > ++++++++++++++++++++
> >   3 files changed, 101 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > index 882277a52b69..afe37b702eef 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> > @@ -115,6 +115,13 @@
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
> > @@ -129,4 +136,35 @@
> >   			groups = "uart2";
> >   		};
> >   	};
> > +
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
> > +			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> > +			drive-strength = <4>;
> > +		};
> > +	};
> >   };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> > index e3a407d03551..890ded0efc51 100644
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
> > @@ -70,6 +71,11 @@
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
> > @@ -261,6 +267,23 @@
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
> > index 0f49d5764ff3..3443013b5971 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> > @@ -98,3 +98,43 @@
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
> > +			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> > +			drive-strength = <4>;
> > +		};
> > +	};
> > +};

