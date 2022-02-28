Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129C94C65B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiB1Jdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1Jdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:33:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322E63D4AD;
        Mon, 28 Feb 2022 01:33:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r13so23489241ejd.5;
        Mon, 28 Feb 2022 01:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CLX9p46LTKB/Eq3eNvJoQTNYHBrAzPGjbvot9brS2qA=;
        b=mSjmrvh595YDAVZMgNjYK7iY9jJsf6ffteY5LNQ7hkjPy8URdKSh/qC0gfCqmJ1my1
         Qpi25Q25zJe+wBpMWjGFKTVrbWF4JlOaa7Y7EQUzQF2NKs8guyjP5sa73inWcL2rPKgL
         Z4Mc/DuqqWuniGLKhle7vMI0AJPo+4gPPnauSdIChzhacanwS0ZKPzxodvbMVU2uN65q
         pvEyoL1aghlRdEgJYh1S6JnW3PpAoxj/hcpIx2oaIspTFDPQuhKgCL5yYcBD2tnTOdyZ
         NAbWn9L8+oM/g+Bhim9dLNKblHtOvHd5kVm+hHX4E3zlglPs6P2PmGVpDp10Umy20wMP
         cgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CLX9p46LTKB/Eq3eNvJoQTNYHBrAzPGjbvot9brS2qA=;
        b=sJAy50ELQStQ7LQYNmXh7WI6VILyJpVSUyur+KyVAyA9nXI69u6yvnriRUq4tqmIa9
         hC0pRMPR/UjDVv4WhfAe5rRbeg9ePfjv4QwEX7OLemSlVOTj7N4umB9LZEaNb9h9YOB6
         i/SUNyQdnAlLsmOQoQiChKnJwKaPKlWh4UkvaMYy9RkYzJNacITufk+KUwyM+fCckhkb
         wnDNguM0rvJIGYSz2kmBQ/KbHANlhM5uM8cAfZkkp2c938qrfq8xqt5m+STnzTxBZ95K
         9XMiNMx4P/ySfCR875pRRm5f1zBzs9avmWSkTO9l27GCCyOxOGOWdqz2sn5FzFfeszGh
         /xdg==
X-Gm-Message-State: AOAM530MLMaRBxpqyxS0vWyDroc4GRRs+nIEnslV/uZyI5koXPrmQk+y
        Ifj/DCK/U0RvlTTcHpHZKPg=
X-Google-Smtp-Source: ABdhPJyGNPCf5gF83CrzPwGUn65KVEOklQP88mDv1lM7Oxdsd9c3Gvs+2/MhV9t3bc5Qjjfaeyy8Vw==
X-Received: by 2002:a17:906:6b8e:b0:6ce:9879:ff88 with SMTP id l14-20020a1709066b8e00b006ce9879ff88mr14387553ejr.147.1646040778557;
        Mon, 28 Feb 2022 01:32:58 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n24-20020a509358000000b00410bedd9eb4sm5932397eda.88.2022.02.28.01.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:32:58 -0800 (PST)
Message-ID: <14a29a3f-c886-89b0-e453-1e8bee469536@gmail.com>
Date:   Mon, 28 Feb 2022 10:32:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Add sata nodes to rk356x
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        "devicetree @ vger . kernel . org Damien Le Moal" 
        <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-4-linux@fw-web.de>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220227182800.275572-4-linux@fw-web.de>
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

Hi Frank,

On 2/27/22 19:28, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> RK356x supports up to 3 sata controllers which were compatible with the
> existing snps,dwc-ahci binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v3:
>   - fix combphy error by moving sata0 to rk3568.dtsi
>   - remove clock-names and interrupt-names
> changes in v2:
>   - added sata0 + 1, but have only tested sata2
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 +++++++++++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 26 ++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 5b0f528d6818..2a2f65899d47 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -8,6 +8,19 @@
>  / {
>  	compatible = "rockchip,rk3568";
>  
> +	sata0: sata@fc000000 {

> +		compatible = "snps,dwc-ahci";

		compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";

Compatible strings must be SoC orientated.
By using a fall back string the driver doesn't have to be changed for
every new SoC.
Add binding in extra patch.

> +		reg = <0 0xfc000000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA0>, <&cru CLK_SATA0_PMALIVE>,
> +			 <&cru CLK_SATA0_RXOOB>;
> +		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +		phys = <&combphy0 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
>  	pipe_phy_grf0: syscon@fdc70000 {
>  		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
>  		reg = <0x0 0xfdc70000 0x0 0x1000>;
> @@ -114,3 +127,4 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..484c5ace718a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,32 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  
> +	sata1: sata@fc400000 {

> +		compatible = "snps,dwc-ahci";

dito

> +		reg = <0 0xfc400000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA1>, <&cru CLK_SATA1_PMALIVE>,
> +			 <&cru CLK_SATA1_RXOOB>;
> +		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +		phys = <&combphy1 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
> +	sata2: sata@fc800000 {

> +		compatible = "snps,dwc-ahci";

dito

> +		reg = <0 0xfc800000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA2>, <&cru CLK_SATA2_PMALIVE>,
> +			 <&cru CLK_SATA2_RXOOB>;
> +		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +		phys = <&combphy2 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller@fd400000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
