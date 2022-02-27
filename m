Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361EF4C5DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiB0RvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0RvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:51:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C440913;
        Sun, 27 Feb 2022 09:50:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w3so14431151edu.8;
        Sun, 27 Feb 2022 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6fQlqoO+oGr4+WusT747tAtiTGYFGKirj0tZQ8ZySRs=;
        b=eRtNNeiLpw9SEksUxP6FC0b4W73NJdHOFUA2tOzglyNEVKL+R3xBGFWajkq9YYHScs
         45x10ov9KEFHRecqvJhISA+AJmHylyqjhTm+j7ff+AVGgCnDCRr433qr9kFZ2ztJcNlu
         VmedHA47nRtPijwhHOYkehFgWWVRGWndGf9aqYa0C/FDEGxjAZqq42lGnjAyV197x+Y0
         213taRggz+pIx+xPZI8GLeGNdBAeEOmjOl97zXpTb29lT8MTcrwcShDOkRKqAe2CEPN3
         0D7FUMwSMcqXTsWh4/PcPg/Zi8hoxC9qSsEcLRT2WoHgEcRd+r2a/DHumL0YQ1UbGGju
         HUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6fQlqoO+oGr4+WusT747tAtiTGYFGKirj0tZQ8ZySRs=;
        b=kvgCADUG6CByvEEooZI7y2WOC3atwT0HxKVp/6KJY8JoT/cHMdt/WdLh7kV5pDBoso
         YdxYiyr8HyrlSHbDk2ry2ZF+fwS42QCeNIibNFuo27JQsout+5WcLVwujc0OCQR8oCXg
         2da+gOy66vSTLmCVIqcINKaHiKTn5B6kXFen1ei68bgiuYltSj7bC5I7vHqRqnQPYHeD
         iblvXBGuscoc618OFbgxGlU+blumTYn1BPyZhOxpkW0O3kwbMpK4gxYj9NXV5jKQ3qaK
         ugap9FOzivZeXh1No/jrVBGcOw+3kbCd4JZqs6N6G8dreWfe3wwjaWXZBT8R/R5QIgnr
         d1Lw==
X-Gm-Message-State: AOAM532gpi14Aq+5UhBOSLYZPni3BtXXPBgKNv3zejaJJvcF8QK2mbDp
        MKBBZdaNFXkw2qrWTfMj8HU=
X-Google-Smtp-Source: ABdhPJyVHvjhFYnWTgyVC5w07SKobhLC6lklAAnZEXrx/5b0sBKDQ/QqPTcQ8ygmfU6BvEZqCUDrKw==
X-Received: by 2002:a05:6402:190b:b0:412:8cfc:c266 with SMTP id e11-20020a056402190b00b004128cfcc266mr16204469edz.274.1645984238568;
        Sun, 27 Feb 2022 09:50:38 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906940700b006b86e95dc1fsm3595926ejx.41.2022.02.27.09.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 09:50:38 -0800 (PST)
Message-ID: <7b20fccd-4394-da3c-6556-4732d67cde3d@gmail.com>
Date:   Sun, 27 Feb 2022 18:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220227153016.950473-1-pgwipeout@gmail.com>
 <20220227153016.950473-6-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220227153016.950473-6-pgwipeout@gmail.com>
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



On 2/27/22 16:30, Peter Geis wrote:
> Add the dwc3 device nodes to the rk356x device trees.
> The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 11 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 ++++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 35 +++++++++++++++++++++++-
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> index 3839eef5e4f7..0b957068ff89 100644
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
> @@ -18,3 +22,10 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> +&usb_host0_xhci {
> +	phys = <&usb2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	extcon = <&usb2phy0>;
> +	maximum-speed = "high-speed";
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
> index 7cdef800cb3c..072bb9080cd6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,40 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  
> +	usb_host0_xhci: usb@fcc00000 {

> +		compatible = "snps,dwc3";

compatible = "rockchip,rk3568-dwc3", "snps,dwc3";

compatible strings must be SoC orientated.
Add binding like you did before.

> +		reg = <0x0 0xfcc00000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> +			 <&cru ACLK_USB3OTG0>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk";
> +		dr_mode = "host";
> +		phy_type = "utmi_wide";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		resets = <&cru SRST_USB3OTG0>;
> +		snps,dis_u2_susphy_quirk;
> +		status = "disabled";
> +	};
> +
> +	usb_host1_xhci: usb@fd000000 {

> +		compatible = "snps,dwc3";

compatible = "rockchip,rk3568-dwc3", "snps,dwc3";

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
> +		resets = <&cru SRST_USB3OTG1>;
> +		snps,dis_u2_susphy_quirk;
> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller@fd400000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
> @@ -297,7 +331,6 @@ pmu_io_domains: io-domains {
>  	};
>  
>  	pipegrf: syscon@fdc50000 {
> -		compatible = "rockchip,rk3568-pipe-grf", "syscon";
>  		reg = <0x0 0xfdc50000 0x0 0x1000>;
>  	};
>  
