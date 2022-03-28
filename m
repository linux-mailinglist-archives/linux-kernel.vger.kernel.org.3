Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24544E968B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiC1M2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiC1M2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:28:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58C4D601;
        Mon, 28 Mar 2022 05:27:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a1so20130351wrh.10;
        Mon, 28 Mar 2022 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=YHmfb4C20ZoeF4fGdGnIMRNg2Ab4fGRbukJuULGv0VE=;
        b=Rn2VRIKKTMYH0yGjj6/JzkBq5XY4ktF6G/tZP1Vqjt6I0q0eAq5zdkcOPGTV9SAv2I
         ZuppgbjsbGpU6wLhW1u8/uBgrLU17DSTimYg/Ob86znS9Hy4ahBKHDajdGAXW3e0wREY
         E8GtjAOpl4zW9zQgcKdqHf6nsBqPe4bX5a+hPYnyoGrXzzcNLuSgXU9KECgx6viPKz4+
         s/CY4/qZ8rXUTk8JEPQMex4aKwruAlQi6DJUlkVKlDIlc7JN6WmSlHbL7b5ofvkbbZZv
         jbulstqHaloI0xLK2Yc1/xdKW6ucP9IOxmYs4S6OYPZBVEwYC7dshIo+B6tem7pnV5bQ
         NWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=YHmfb4C20ZoeF4fGdGnIMRNg2Ab4fGRbukJuULGv0VE=;
        b=jr2btJuxdTR35+9rVtdLGA537V+m7VOp9ODeCveGbi0T+HCcqG9cjRK7/KO8uhUD7b
         EwQqcAabm/QdUv3z7BWtFPEKSfxgSeFEhVI7pvezI734xnapfkDkCQTWhAsbNxE7idw8
         TvCP+6iIw5LHaEvbgTb3UkNcI+h36MqJGInpjaJ/JAZnV1IzSKElrgNCft+2BQ7t7NJq
         XgKLuFP/rJOkY7Jjdx58XLKj5wsm2vpx89FmHjF6in+B4dr1E/MAX0+uKeE+Q9lsVske
         +ENB6Jq9dgk5/Zyk0G1i4reHXfaiwCCxgFbl2GQjiLQorfI9fm0Luj6x/bdtVNiSZFE0
         AqOA==
X-Gm-Message-State: AOAM532ArTRb6vou/9V7gGvitXlwzLMK5o7erI2DryosEAx/K5Hl7pT6
        O+7oHeii81L5nGQ7RSunQOI=
X-Google-Smtp-Source: ABdhPJyiHrWJXyMDhrMDjDB4l+tCjNQM71rNdhpB3Zd65zAJs+JwqjnbI8s1k+iMfKs1ojBAj+zBeA==
X-Received: by 2002:adf:f2c6:0:b0:203:f0ba:424c with SMTP id d6-20020adff2c6000000b00203f0ba424cmr22901124wrp.663.1648470422115;
        Mon, 28 Mar 2022 05:27:02 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id c4-20020a056000184400b0020584c40778sm12946276wri.103.2022.03.28.05.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:27:01 -0700 (PDT)
Message-ID: <cf16ed58-6e75-cd9f-38ab-540d62ff03b5@gmail.com>
Date:   Mon, 28 Mar 2022 14:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org,
        chunfeng.yun@mediatek.com, Seiya Wang <seiya.wang@mediatek.com>
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
 <20220216113131.13145-4-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v11 3/3] arm64: dts: Add mediatek SoC mt8195 and
 evaluation board
In-Reply-To: <20220216113131.13145-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/02/2022 12:31, Tinghan Shen wrote:
> Add basic chip support for mediatek mt8195.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>   arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  161 +++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 1049 +++++++++++++++++++
>   3 files changed, 1211 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 8c1e18032f9f..5da29e7223e4 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -38,4 +38,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> new file mode 100644
> index 000000000000..51633d91d984
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> @@ -0,0 +1,161 @@
[...]
> +
> +&u2port0 {
> +	status = "okay";
> +};
> +
> +&u2port1 {
> +	status = "okay";
> +};
> +
> +&u3phy0 {
> +	status="okay";
> +};
> +
> +&u3phy1 {
> +	status="okay";
> +};
> +

So we enable phys for xhci but not the device. Are we missing anything to enable 
them on the EVB?

> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pin>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> new file mode 100644
> index 000000000000..a363e82f6988
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -0,0 +1,1049 @@
[...]
> +
> +	clk32k: oscillator-32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "clk32k";

I suppose the 32KHz oscillator is really present on the board also not used by 
any device (up to now?).

[...]
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
[...]
> +
> +		pwrap: pwrap@10024000 {
> +			compatible = "mediatek,mt8195-pwrap", "syscon";
> +			reg = <0 0x10024000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
> +				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>;
> +			clock-names = "spi", "wrap";

Binding mandates resets but not present here. It also mandates two register 
regions, but only one is given here.

> +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
> +		};
> +
> +		scp_adsp: clock-controller@10720000 {
> +			compatible = "mediatek,mt8195-scp_adsp";
> +			reg = <0 0x10720000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +

[...]

> +
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt8195-mmc",
> +				     "mediatek,mt8183-mmc";
> +			reg = <0 0x11230000 0 0x10000>,
> +			      <0 0x11f50000 0 0x1000>;

Seems to be an oversight when adding support for mt8183-mmc support to the 
driver. The binding description is missing the optional host top register base. 
Chaotian can you please help to fix this in the binding description.

> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
[...]
> +
> +		xhci3: usb@112b0000 {
> +			compatible = "mediatek,mt8195-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x112b0000 0 0x1000>,
> +			      <0 0x112b3e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port3 PHY_TYPE_USB2>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
> +				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
> +			clock-names = "sys_ck", "ref_ck", "xhci_ck";
> +			/* This controller is connected with a BT device.
> +			 * Disable usb2 lpm to prevent konwn issues.
> +			 */
> +			usb2-lpm-disable;

My understanding is, that this depends on the board and not the SoC. Which means 
usb2-lpm-disable should go into any board that has a BT device connected to the 
xhci device (I don't see any active xhci node in mt8195-evb so far).

Regards,
Matthias
