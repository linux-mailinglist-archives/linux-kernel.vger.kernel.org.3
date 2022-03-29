Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40624EAF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbiC2OZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiC2OZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:25:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2FB3615D;
        Tue, 29 Mar 2022 07:24:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r64so10428066wmr.4;
        Tue, 29 Mar 2022 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8+ESXIDQ43In4w2S+9YeNSeR3/Wbpimnmf/TCBFJHtU=;
        b=bnbL9zL9uAaVNPPUVQrRWFkhCEwdSoAHStj9cvpMFVn05rCjNQ3yo1RwuMDZH69YXQ
         KSuDqcX/Bs8AfobwtB9AEGV7KR7adTk/XW3SPFDBc9GdAjJvsWSM+nT3gzgYdMKQpq7Q
         Iyxu4g8xG6O4OcIFThN7eRYoezcBFvXBzvdm4hgdeJRI7dNti6hU2mGm70fU3hfNEA3O
         nH1dR+PUyjoopAC1D1SAb6PbBuybeCOamrXP0hv6+SClfoKHPwoTLL9E93pQoLVNDOZ3
         +pW7Xb6PLewsLfmiwicv0kBwGIODPKtgLzBBrAd9vSW9XFIX4msK7OcmtTrcnQvbsRCv
         4LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8+ESXIDQ43In4w2S+9YeNSeR3/Wbpimnmf/TCBFJHtU=;
        b=oXoKoKVRSbnysdEIU6dXOUTi3wjIHTp8/JiOEGGcXX9wKugqjsW4ThuaO0eGiRbXlH
         pbWgvXqHfugLNRl5OvEPnv0tVcommhldrplX9OMg52DaS8xr/LH4z5R1dZqPPjant0kR
         F9aguLnDFg24bTlvy4ZRcD8CsJUOgd8ScKgBRliqVSpxgAVqVh12k5gIIIxgjSAvqeCt
         lAMqMU6RN4uW0HEUO4KWAFXr++/07/+l7gD5NsD9dip9bHyxVS1r2N3+K0AqZevzxbeU
         UofFEAPEi+es18BRJ134FV939hP9DeKqxt5C75P8JrENmnUdYLwgUyn3+jnfzfiTDY2T
         mLvg==
X-Gm-Message-State: AOAM530oUaSthTjzsUGWSUVVGMP+UQ3AvIniddwkVxfF8bEiQSSqTrBl
        I4BYaoqbConstVLI9OXUsWk=
X-Google-Smtp-Source: ABdhPJyGnGcNdx4fw1ne8yj9sknMRD4sCgvBzbStS3HWG8F/ys9fmwQ6Jqxh4VRZLUXUf/zyg27Xnw==
X-Received: by 2002:a05:600c:4fc4:b0:38c:d622:f445 with SMTP id o4-20020a05600c4fc400b0038cd622f445mr7355060wmq.73.1648563840690;
        Tue, 29 Mar 2022 07:24:00 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i1-20020a1c5401000000b0038caef28acbsm2354922wmb.47.2022.03.29.07.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:24:00 -0700 (PDT)
Message-ID: <3a93babf-7217-da88-11b4-9e3b9e9730f2@gmail.com>
Date:   Tue, 29 Mar 2022 16:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 3/3] arm64: dts: Add mediatek SoC mt8195 and
 evaluation board
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
 <cf16ed58-6e75-cd9f-38ab-540d62ff03b5@gmail.com>
 <7283dd6732ae8c188c6f12183a977fb980cc8617.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <7283dd6732ae8c188c6f12183a977fb980cc8617.camel@mediatek.com>
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



On 29/03/2022 12:17, Tinghan Shen wrote:
> Hi Matthias,
> 
> Thanks for your comment.
> 
> On Mon, 2022-03-28 at 14:26 +0200, Matthias Brugger wrote:
>>
>> On 16/02/2022 12:31, Tinghan Shen wrote:
>>> Add basic chip support for mediatek mt8195.
>>>
>>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>>>    arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  161 +++
>>>    arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 1049 +++++++++++++++++++
>>>    3 files changed, 1211 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>> index 8c1e18032f9f..5da29e7223e4 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -38,4 +38,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-
>>> evb.dts
>>> new file mode 100644
>>> index 000000000000..51633d91d984
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>>> @@ -0,0 +1,161 @@
>>
>> [...]
>>> +
>>> +&u2port0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2port1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u3phy0 {
>>> +	status="okay";
>>> +};
>>> +
>>> +&u3phy1 {
>>> +	status="okay";
>>> +};
>>> +
>>
>> So we enable phys for xhci but not the device. Are we missing anything to enable
>> them on the EVB?
> 
> after discussed with usb expert, we think that we're missing the xhci nodes.
> I'll add xhci nodes at next version.
> 
>>
>>> +&uart0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&uart0_pin>;
>>> +	status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> new file mode 100644
>>> index 000000000000..a363e82f6988
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> @@ -0,0 +1,1049 @@
>>
>> [...]
>>> +
>>> +	clk32k: oscillator-32k {
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <32768>;
>>> +		clock-output-names = "clk32k";
>>
>> I suppose the 32KHz oscillator is really present on the board also not used by
>> any device (up to now?).
> 
> Yes. 32KHz clock is still available on MT8195.
> Some modules can choose 32K as clock source depending on requirements.
> 

Thanks for the confirmation.

>>
>> [...]
>>> +
>>> +	soc {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		compatible = "simple-bus";
>>> +		ranges;
>>> +
>>
>> [...]
>>> +
>>> +		pwrap: pwrap@10024000 {
>>> +			compatible = "mediatek,mt8195-pwrap", "syscon";
>>> +			reg = <0 0x10024000 0 0x1000>;
>>> +			reg-names = "pwrap";
>>> +			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
>>> +				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>;
>>> +			clock-names = "spi", "wrap";
>>
>> Binding mandates resets but not present here. It also mandates two register
>> regions, but only one is given here.
> 
> After discussed with pwrap experts, the pwrap binding is out-of-date for mt8195.
> They will send a patch to fix pwrap binding.
> 

If possible can you add the patch fixing the pwrap binding in this series, then 
I don't have to search for the dependencies in my inbox. That would be of great 
help.

>>
>>> +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC>;
>>> +			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
>>> +		};
>>> +
>>> +		scp_adsp: clock-controller@10720000 {
>>> +			compatible = "mediatek,mt8195-scp_adsp";
>>> +			reg = <0 0x10720000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>
>> [...]
>>
>>> +
>>> +		mmc0: mmc@11230000 {
>>> +			compatible = "mediatek,mt8195-mmc",
>>> +				     "mediatek,mt8183-mmc";
>>> +			reg = <0 0x11230000 0 0x10000>,
>>> +			      <0 0x11f50000 0 0x1000>;
>>
>> Seems to be an oversight when adding support for mt8183-mmc support to the
>> driver. The binding description is missing the optional host top register base.
>> Chaotian can you please help to fix this in the binding description.
> 
> Ok. I'll fix it at next version.
> 

I'm not sure what you mean. I suppose the way forward is to fix the binding 
description, correct?

Thanks,
Matthias

>>
>>> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +			clocks = <&topckgen CLK_TOP_MSDC50_0>,
>>> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
>>> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
>>> +			clock-names = "source", "hclk", "source_cg";
>>> +			status = "disabled";
>>> +		};
>>> +
>>
>> [...]
>>> +
>>> +		xhci3: usb@112b0000 {
>>> +			compatible = "mediatek,mt8195-xhci",
>>> +				     "mediatek,mtk-xhci";
>>> +			reg = <0 0x112b0000 0 0x1000>,
>>> +			      <0 0x112b3e00 0 0x0100>;
>>> +			reg-names = "mac", "ippc";
>>> +			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +			phys = <&u2port3 PHY_TYPE_USB2>;
>>> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
>>> +					  <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
>>> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
>>> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
>>> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
>>> +				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
>>> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
>>> +			clock-names = "sys_ck", "ref_ck", "xhci_ck";
>>> +			/* This controller is connected with a BT device.
>>> +			 * Disable usb2 lpm to prevent konwn issues.
>>> +			 */
>>> +			usb2-lpm-disable;
>>
>> My understanding is, that this depends on the board and not the SoC. Which means
>> usb2-lpm-disable should go into any board that has a BT device connected to the
>> xhci device (I don't see any active xhci node in mt8195-evb so far).
> 
> Ok. I'll move this property to evb board in a xhci node.
> 
> Best regards,
> TingHan
> 
>>
>> Regards,
>> Matthias
> 
