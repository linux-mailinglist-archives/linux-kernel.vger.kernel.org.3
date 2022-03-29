Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C134EAB20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiC2KT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiC2KTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758BE23EC73;
        Tue, 29 Mar 2022 03:17:56 -0700 (PDT)
X-UUID: 38bee88dd45f4697a2316eb31b09bafe-20220329
X-UUID: 38bee88dd45f4697a2316eb31b09bafe-20220329
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1410312814; Tue, 29 Mar 2022 18:17:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 29 Mar 2022 18:17:48 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 18:17:47 +0800
Message-ID: <7283dd6732ae8c188c6f12183a977fb980cc8617.camel@mediatek.com>
Subject: Re: [PATCH v11 3/3] arm64: dts: Add mediatek SoC mt8195 and
 evaluation board
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Chaotian Jing" <chaotian.jing@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>
Date:   Tue, 29 Mar 2022 18:17:47 +0800
In-Reply-To: <cf16ed58-6e75-cd9f-38ab-540d62ff03b5@gmail.com>
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
         <20220216113131.13145-4-tinghan.shen@mediatek.com>
         <cf16ed58-6e75-cd9f-38ab-540d62ff03b5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for your comment.

On Mon, 2022-03-28 at 14:26 +0200, Matthias Brugger wrote:
> 
> On 16/02/2022 12:31, Tinghan Shen wrote:
> > Add basic chip support for mediatek mt8195.
> > 
> > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile       |    1 +
> >   arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  161 +++
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 1049 +++++++++++++++++++
> >   3 files changed, 1211 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index 8c1e18032f9f..5da29e7223e4 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -38,4 +38,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-
> > evb.dts
> > new file mode 100644
> > index 000000000000..51633d91d984
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> > @@ -0,0 +1,161 @@
> 
> [...]
> > +
> > +&u2port0 {
> > +	status = "okay";
> > +};
> > +
> > +&u2port1 {
> > +	status = "okay";
> > +};
> > +
> > +&u3phy0 {
> > +	status="okay";
> > +};
> > +
> > +&u3phy1 {
> > +	status="okay";
> > +};
> > +
> 
> So we enable phys for xhci but not the device. Are we missing anything to enable 
> them on the EVB?

after discussed with usb expert, we think that we're missing the xhci nodes.
I'll add xhci nodes at next version.

> 
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_pin>;
> > +	status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > new file mode 100644
> > index 000000000000..a363e82f6988
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -0,0 +1,1049 @@
> 
> [...]
> > +
> > +	clk32k: oscillator-32k {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <32768>;
> > +		clock-output-names = "clk32k";
> 
> I suppose the 32KHz oscillator is really present on the board also not used by 
> any device (up to now?).

Yes. 32KHz clock is still available on MT8195.
Some modules can choose 32K as clock source depending on requirements.

> 
> [...]
> > +
> > +	soc {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		compatible = "simple-bus";
> > +		ranges;
> > +
> 
> [...]
> > +
> > +		pwrap: pwrap@10024000 {
> > +			compatible = "mediatek,mt8195-pwrap", "syscon";
> > +			reg = <0 0x10024000 0 0x1000>;
> > +			reg-names = "pwrap";
> > +			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
> > +				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>;
> > +			clock-names = "spi", "wrap";
> 
> Binding mandates resets but not present here. It also mandates two register 
> regions, but only one is given here.

After discussed with pwrap experts, the pwrap binding is out-of-date for mt8195.
They will send a patch to fix pwrap binding.

> 
> > +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC>;
> > +			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
> > +		};
> > +
> > +		scp_adsp: clock-controller@10720000 {
> > +			compatible = "mediatek,mt8195-scp_adsp";
> > +			reg = <0 0x10720000 0 0x1000>;
> > +			#clock-cells = <1>;
> > +		};
> > +
> 
> [...]
> 
> > +
> > +		mmc0: mmc@11230000 {
> > +			compatible = "mediatek,mt8195-mmc",
> > +				     "mediatek,mt8183-mmc";
> > +			reg = <0 0x11230000 0 0x10000>,
> > +			      <0 0x11f50000 0 0x1000>;
> 
> Seems to be an oversight when adding support for mt8183-mmc support to the 
> driver. The binding description is missing the optional host top register base. 
> Chaotian can you please help to fix this in the binding description.

Ok. I'll fix it at next version.

> 
> > +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			clocks = <&topckgen CLK_TOP_MSDC50_0>,
> > +				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> > +				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
> > +			clock-names = "source", "hclk", "source_cg";
> > +			status = "disabled";
> > +		};
> > +
> 
> [...]
> > +
> > +		xhci3: usb@112b0000 {
> > +			compatible = "mediatek,mt8195-xhci",
> > +				     "mediatek,mtk-xhci";
> > +			reg = <0 0x112b0000 0 0x1000>,
> > +			      <0 0x112b3e00 0 0x0100>;
> > +			reg-names = "mac", "ippc";
> > +			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			phys = <&u2port3 PHY_TYPE_USB2>;
> > +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
> > +					  <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
> > +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> > +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> > +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
> > +				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
> > +				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
> > +			clock-names = "sys_ck", "ref_ck", "xhci_ck";
> > +			/* This controller is connected with a BT device.
> > +			 * Disable usb2 lpm to prevent konwn issues.
> > +			 */
> > +			usb2-lpm-disable;
> 
> My understanding is, that this depends on the board and not the SoC. Which means 
> usb2-lpm-disable should go into any board that has a BT device connected to the 
> xhci device (I don't see any active xhci node in mt8195-evb so far).

Ok. I'll move this property to evb board in a xhci node.

Best regards,
TingHan

> 
> Regards,
> Matthias

