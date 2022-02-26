Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA94C589C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 00:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiBZXCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 18:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBZXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 18:02:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2C2BA9E1;
        Sat, 26 Feb 2022 15:01:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm8so12322123edb.3;
        Sat, 26 Feb 2022 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R4So/PECm61OZ01mIF7ODeZeqiQRsFB7JUYw8mQwSPY=;
        b=XSHSQZMIFy1PCnsKBq0jl90+qILq33ht8tz/Xdre/EaWzq/p6mn+6/gyRHpAA5cGaR
         V24tIgF8qYFvjC+GAGARLcawNs5kyk56EOOuviFaXza16oNVONmQGwZweOF2567rPw1A
         iTv/ROBiOgMntrxiQ08zK2WtUqoWayu86nQmOZfkaVNl0OqP42zbQfbyzflCgnFPWKOb
         /Gcp2jO2m5E8gLxGmrBeX8BqdwDjU3EvHcf2hzVyZwKJtFE3iTKNyWhhDYPTORlWyP1C
         k4+lLT1SgnfzPyxOsx6zm6p2zCI9X0Je8vRgD9bUxaV3njkDLtkipZ5gnppMvAz96+6c
         0GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R4So/PECm61OZ01mIF7ODeZeqiQRsFB7JUYw8mQwSPY=;
        b=1GKb+T0ek6skuEvDoOQw6e8/KyCZHRpxO8Rj9B+dDlpSQwKd8xgqUQ9hni9JUAgz6V
         WM2m54/M6IinEYsHqufcsdm6B+/9/5cQHDFK+QftYPntsc4sbdB6bbM8C7Ub65PrUCXY
         8NNZtKTpL3vUv0dZ7596Qx4D3k8Z5o38wxLRN6Oi5bc4baL/Sp25/u3T9hKkjeHa9Y3k
         f/QbwvWRZ2gnsF7g0VB3baQ5hawlLebEaL7ahcygW2+ZmAsd6AXeIO3pH2KA/5XDrDnz
         Q/9oLxN80IgTfCtMg64XQTWM0eQFWPP9afV01TLj/DTu9r6yKDYq21EW7qwEBbgM9pGI
         L2SQ==
X-Gm-Message-State: AOAM532iy3qK3J54CdT+T1dXoH0+ZtX9CHCWXRvFDgZXCxfVjKkeqFd4
        1+OyQrlDaUSBPGjTg1OJrmk=
X-Google-Smtp-Source: ABdhPJxNtOrcCupBKrlUQxBLUlOCFMWX+7jjUerqu/yUw4JMGzDwaCsVaaZx5RdKNh1zrG+bzUTHGw==
X-Received: by 2002:a05:6402:d6:b0:413:b81:6695 with SMTP id i22-20020a05640200d600b004130b816695mr13185716edu.176.1645916494025;
        Sat, 26 Feb 2022 15:01:34 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm3460151edq.50.2022.02.26.15.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 15:01:33 -0800 (PST)
Message-ID: <4a49ba17-436b-c6b3-4a7d-42902781d2f4@gmail.com>
Date:   Sun, 27 Feb 2022 00:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 09/11] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220226184147.769964-1-pgwipeout@gmail.com>
 <20220226184147.769964-10-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220226184147.769964-10-pgwipeout@gmail.com>
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



On 2/26/22 19:41, Peter Geis wrote:
> Add the dwc3 device nodes to the rk356x device trees.
> The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 12 +++++++
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 +++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 45 +++++++++++++++++++++++-
>  3 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> index 3839eef5e4f7..a57eb68faba2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> @@ -6,6 +6,10 @@ / {
>  	compatible = "rockchip,rk3566";
>  };
>  
> +&pipegrf {
> +	compatible = "rockchip,rk3566-pipe-grf", "syscon";
> +};
> +
>  &power {
>  	power-domain@RK3568_PD_PIPE {
>  		reg = <RK3568_PD_PIPE>;
> @@ -18,3 +22,11 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> +&usb_host0_xhci {
> +	phys = <&usb2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	extcon = <&usb2phy0>;
> +	maximum-speed = "high-speed";
> +	snps,dis_u2_susphy_quirk;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 5b0f528d6818..8ba9334f9753 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -99,6 +99,10 @@ opp-1992000000 {
>  	};
>  };
>  
> +&pipegrf {
> +	compatible = "rockchip,rk3568-pipe-grf", "syscon";
> +};
> +
>  &power {
>  	power-domain@RK3568_PD_PIPE {
>  		reg = <RK3568_PD_PIPE>;
> @@ -114,3 +118,8 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> +&usb_host0_xhci {
> +	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
> +	phy-names = "usb2-phy", "usb3-phy";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..b22e5a514ad7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,50 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  
> +	usb_host0_xhci: usb@fcc00000 {
> +		compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> +		reg = <0x0 0xfcc00000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> +			 <&cru ACLK_USB3OTG0>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk";
> +		dr_mode = "host";
> +		phy_type = "utmi_wide";

> +		power-domains = <&power RK3568_PD_PIPE>;

When both usb_host0_xhci and usb_host1_xhci are connected to a usb2phy
and the combphy's disabled there's no PCLK_PIPE enabled.
Fix logic for RK3568_PD_PIPE by adding the USB3 clocks.


> +		resets = <&cru SRST_USB3OTG0>;

> +		reset-names = "usb3-otg";

remove

snps,dwc3.yaml only mentions the "resets" because
devm_reset_control_array_get_optional_shared is used.
reset-names is only a rk3399 legacy that I included due to the YAML
conversion.
With unevaluatedProperties now working "resets" also could be removed
from rockchip,dwc3.yaml I think.

https://github.com/torvalds/linux/commit/2f8e928408885dad5d8d6afefacb82100b6b62c7
Added properties for rk3399 are:
  power-domains
  resets
  reset-names

> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;

sort

> +		snps,xhci-trb-ent-quirk;

???

check snps,dwc3.yaml

> +		status = "disabled";
> +	};
> +
> +	usb_host1_xhci: usb@fd000000 {
> +		compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> +		reg = <0x0 0xfd000000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
> +			 <&cru ACLK_USB3OTG1>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk";
> +		dr_mode = "host";
> +		phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
> +		phy-names = "usb2-phy", "usb3-phy";
> +		phy_type = "utmi_wide";

> +		power-domains = <&power RK3568_PD_PIPE>;

dito

> +		resets = <&cru SRST_USB3OTG1>;

> +		reset-names = "usb3-otg";

remove

> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis_u2_susphy_quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;

sort

> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller@fd400000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
> @@ -297,7 +341,6 @@ pmu_io_domains: io-domains {
>  	};
>  
>  	pipegrf: syscon@fdc50000 {
> -		compatible = "rockchip,rk3568-pipe-grf", "syscon";
>  		reg = <0x0 0xfdc50000 0x0 0x1000>;
>  	};
>  
