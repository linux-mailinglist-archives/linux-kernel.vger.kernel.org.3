Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007204C430A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiBYLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbiBYLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:04:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC046223219;
        Fri, 25 Feb 2022 03:04:07 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d10so10052632eje.10;
        Fri, 25 Feb 2022 03:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=J1vtATe8xS2rnhXfuGjs3otCLwyKXCCg9BTOffjh3gk=;
        b=DKjBKIQcroCN2WWwSd8HkCbHtJiS+c+4hFc3dx+D7uXixR9RFIlIE4Lj/m2fx83HEp
         6OCethccFO7W3Mm0eqMw6X6vq7Wx1l9fNHzegavQDCqvT20o6Pbq5WwrN+7EEuOmmlW/
         xyW0ZLNe2Z0LMgjAfnWtGIk0VXOK2rOpnisw+QsdxbjTh6advilSCX2pDsRwfm8PwSf2
         z5xnbHgkRQRD4AJZJaEgFqOmJ2Vtmw2q3bp9hApB4R2Fp8faiaA8+MqdTzzcsXn4ag6x
         4QBJhEKaM2XzCr590DSPD9oNzKE0cLTjUgTXOZbFbCnBFHdufdmBYLb7uoxHOaVrnQ1z
         eMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=J1vtATe8xS2rnhXfuGjs3otCLwyKXCCg9BTOffjh3gk=;
        b=2Y/yCnGjBFGxYzSIuFCdWuWx/K3ULcc6y1QSaoUt8YJm34oKjNDdVajqwqw1oVF8xT
         F4AaKx8r+o8UnU0LtXvw6g/eMs3VpyiywQPuEqflCKuzdujpjWlOcZ7ySSTrIcnMhcHq
         jNEicXJNeywsg28FgsCoXG6CorsO2DgsHBBZAfirWVwkCwvHjyivg7bcUHNeIML0c/he
         6RqS1O8WfuPnJsIyWb3e3K9h3HyvD0oyNPV4PqJfCe/pkIIGr6e6eNusBv/wYJUJNN4s
         V8IQuywm6Ds9VQkx8/OzpxMD2qF/KGHgonoOWe4mGgyqMbTcV6S+LaZFhLv4m/00cakM
         KTRw==
X-Gm-Message-State: AOAM531DSGmLPb4bg32NXngq97ueo+yivA6wcWWsvxHV8+3yCOyV1/qi
        HdBIpjnJwvr4O/CiIOQqkO8=
X-Google-Smtp-Source: ABdhPJwH7GUb7aprXSwoupidbtjf/OXY/8xeFuVk5HLbvAPx14fCA8zgXvelMEtG/AdqFFFzPzSmcw==
X-Received: by 2002:a17:907:7711:b0:6ce:e03c:e1e2 with SMTP id kw17-20020a170907771100b006cee03ce1e2mr5780203ejc.769.1645787046076;
        Fri, 25 Feb 2022 03:04:06 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402231500b0041327b58030sm1231150eda.2.2022.02.25.03.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 03:04:05 -0800 (PST)
Message-ID: <3c7494bc-cff2-5b69-9c3c-b5f5560d0fbc@gmail.com>
Date:   Fri, 25 Feb 2022 12:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add the usb3 nodes to rk356x
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
References: <20220225100943.2115933-1-michael.riesch@wolfvision.net>
 <20220225100943.2115933-2-michael.riesch@wolfvision.net>
 <3e3d0e25-cea4-5b1a-e181-15e793ecba91@gmail.com>
In-Reply-To: <3e3d0e25-cea4-5b1a-e181-15e793ecba91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops...

On 2/25/22 11:53, Johan Jonker wrote:
> Hi Michael,
> 
> On 2/25/22 11:09, Michael Riesch wrote:
>> The Rockchip RK3566 and RK3568 feature two USB 3.0 xHCI controllers,
>> one of them with Dual Role Device (DRD) capability.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  5 ++
>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 58 ++++++++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> index 91a0b798b857..0cd4ef36066a 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> @@ -116,3 +116,8 @@ power-domain@RK3568_PD_PIPE {
>>  		#power-domain-cells = <0>;
>>  	};
>>  };
>> +
>> +&usb_host0_dwc3 {
>> +	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
>> +	phy-names = "usb2-phy", "usb3-phy";
>> +};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index 8b9fae3d348a..b46794486037 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -230,6 +230,64 @@ scmi_shmem: sram@0 {
>>  		};
>>  	};
>>  
>> +	usb_host0_xhci: usb@fcc00000 {
> 
>> +		compatible = "rockchip,rk3399-dwc3";
> 
> Add string to rockchip,dwc3.yaml
> and check with dtsb_check
> 

> compatible = "rockchip,rk3399-dwc3", "snps,dwc3";

compatible = "rockchip,rk3568-dwc3", "snps,dwc3";

> 
>> +		#address-cells = <2>;
> 
> remove
> 
>> +		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> 
>> +			 <&cru ACLK_USB3OTG0>, <&cru PCLK_PIPE>;
> 
> PCLK_PIPE part of an other node, probably only to enable PD_PIPE.
> 
> 	combphy1: phy@fe830000 {
> 		compatible = "rockchip,rk3568-naneng-combphy";
> 		reg = <0x0 0xfe830000 0x0 0x100>;
> 		clocks = <&pmucru CLK_PCIEPHY1_REF>,
> 			 <&cru PCLK_PIPEPHY1>,
> 			 <&cru PCLK_PIPE>;
> 		clock-names = "ref", "apb", "pipe";
> 		assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
> 		assigned-clock-rates = <100000000>;
> 		resets = <&cru SRST_PIPEPHY1>;
> 		rockchip,pipe-grf = <&pipegrf>;
> 		rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
> 		#phy-cells = <1>;
> 		status = "disabled";
> 	};
> 
> Rockchip RK3568 TRM Part1 V1.0-20210111.pdf
> page 475
> 
> PD_PIPE:
> 
> BIU_PIPE
> USB3OTG
> PCIE20
> PCIE30
> SATA
> XPCS
> 
> PCIE, SATA USB clocks are child of aclk_pipe
> Yet PCLK_PIPE is the only clock that enables RK3568_PD_PIPE.
> 
> 
> 	COMPOSITE_NOMUX(PCLK_PIPE, "pclk_pipe", "aclk_pipe", 0,
> 			RK3568_CLKSEL_CON(29), 4, 4, DFLAGS,
> 			RK3568_CLKGATE_CON(10), 1, GFLAGS),
> 
> &power {
> 	power-domain@RK3568_PD_PIPE {
> 		reg = <RK3568_PD_PIPE>;
> 
> 		clocks = <&cru PCLK_PIPE>;
> 
> Do we need more clocks here for USB for example?
> 
> 		pm_qos = <&qos_pcie2x1>,
> 			 <&qos_pcie3x1>,
> 			 <&qos_pcie3x2>,
> 			 <&qos_sata0>,
> 			 <&qos_sata1>,
> 			 <&qos_sata2>,
> 			 <&qos_usb3_0>,
> 			 <&qos_usb3_1>;
> 		#power-domain-cells = <0>;
> 	};
> };
> 
>> +		clock-names = "ref_clk", "suspend_clk", "bus_clk", "grf_clk";
> 
> grf_clk only related to rk3399 ACLK_USB3_GRF and not to PCLK_PIPE.
> 
>> +		ranges;
>> +		#size-cells = <2>;
> 
> remove
> 
>> +		status = "disabled";
>> +
>> +		usb_host0_dwc3: usb@fcc00000 {
> 
> No subnode for "snps,dwc3"
> No more subdriver like rk3399.
> Use dwc core only and fix things/quirks there.
> 
>> +			compatible = "snps,dwc3";
>> +			reg = <0x0 0xfcc00000 0x0 0x400000>;
>> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
>> +			dr_mode = "otg";
>> +			phy_type = "utmi_wide";
>> +			power-domains = <&power RK3568_PD_PIPE>;
>> +			resets = <&cru SRST_USB3OTG0>;
>> +			reset-names = "usb3-otg";
>> +			snps,dis-del-phy-power-chg-quirk;
>> +			snps,dis_enblslpm_quirk;
>> +			snps,dis_rxdet_inp3_quirk;
>> +			snps,dis-tx-ipgap-linecheck-quirk;
>> +			snps,dis-u2-freeclk-exists-quirk;
> 
>> +			snps,xhci-trb-ent-quirk;
> 
> Not in mainline.
> See snps,dwc3.yaml
> 
>> +		};
>> +	};
>> +
>> +	usb_host1_xhci: usb@fd000000 {

>> +		compatible = "rockchip,rk3399-dwc3";

compatible = "rockchip,rk3568-dwc3", "snps,dwc3";

>> +		#address-cells = <2>;
>> +		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
>> +			 <&cru ACLK_USB3OTG1>, <&cru PCLK_PIPE>;
>> +		clock-names = "ref_clk", "suspend_clk", "bus_clk", "grf_clk";
>> +		ranges;
>> +		#size-cells = <2>;
>> +		status = "disabled";
>> +
>> +		usb_host1_dwc3: usb@fd000000 {
>> +			compatible = "snps,dwc3";
>> +			reg = <0x0 0xfd000000 0x0 0x400000>;
>> +			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>> +			dr_mode = "host";
>> +			phy_type = "utmi_wide";
>> +			phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
>> +			phy-names = "usb2-phy", "usb3-phy";
>> +			power-domains = <&power RK3568_PD_PIPE>;
>> +			resets = <&cru SRST_USB3OTG1>;
> 
>> +			reset-names = "usb3-host";
> 
>   reset-names:
>     const: usb3-otg
> 
> Fix binding or DT ??
> 
>> +			snps,dis-del-phy-power-chg-quirk;
>> +			snps,dis_enblslpm_quirk;
>> +			snps,dis_rxdet_inp3_quirk;
>> +			snps,dis-tx-ipgap-linecheck-quirk;
>> +			snps,dis-u2-freeclk-exists-quirk;
> 
>> +			snps,xhci-trb-ent-quirk;
> 
> Not in mainline ??
> 
>> +		};
>> +	};
>> +
> 
> 
> 	usbdrd3_1: usb@fd000000 {

> 		compatible = "rockchip,rk3399-dwc3", "snps,dwc3";

compatible = "rockchip,rk3568-dwc3", "snps,dwc3";

> 		reg = <0x0 0xfd000000 0x0 0x400000>;
> 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks = <&cru CLK_USB3OTG1_REF>,
> 			 <&cru CLK_USB3OTG1_SUSPEND>,
> 			 <&cru ACLK_USB3OTG1>;
> 		clock-names = "ref_clk", "suspend_clk", "bus_clk";
> 		dr_mode = "host";
> 		phy_type = "utmi_wide";
> 		phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
> 		phy-names = "usb2-phy", "usb3-phy";
> 		power-domains = <&power RK3568_PD_PIPE>;
> 		resets = <&cru SRST_USB3OTG1>;
> 		reset-names = "usb3-otg";
> 		snps,dis-del-phy-power-chg-quirk;
> 		snps,dis_enblslpm_quirk;
> 		snps,dis_rxdet_inp3_quirk;
> 		snps,dis-tx-ipgap-linecheck-quirk;
> 		snps,dis-u2-freeclk-exists-quirk;
> 		status = "disabled";
> 	};
> 
> 
>>  	gic: interrupt-controller@fd400000 {
>>  		compatible = "arm,gic-v3";
>>  		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
