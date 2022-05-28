Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF75536E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiE1SUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiE1SUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 14:20:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1AF14D32;
        Sat, 28 May 2022 11:20:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B53455C00EE;
        Sat, 28 May 2022 14:20:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 28 May 2022 14:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1653762041; x=
        1653848441; bh=luRhvMmkAZ3heLTKp44XjFRoRWvALbzVkpsaVWW0WBc=; b=E
        5iDtypbKtVDe5r3eWckch83M57aK+Y0XRWBzdLcsP2ZiCxy/X9w3Ps2rZndODFDN
        KUbTYbHU1L0ZRy3D3hwXwxwz10eNuG8gc7u7qKI7EgWef71YwtZePgihLfzcUvWK
        9kkTqsM9sopM5uMY/YSQdcF40i/esBc/OEyW72PoQKpyEqvJQe7QWboUV/2L6mcp
        8ILa8wrQIdHX0jIz4HTN35GsFGfHBxEebCyizCjPRiB2vQbvY+wBugRgwzwmlVrJ
        fiBVPSAKRvG3C+1dFbc5eNDxw9WYXokDfdCBgS7vPYNpg+p72ZX0/YmPciLbQKHH
        Na5mVZUPHmZIiPocLC06A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1653762041; x=
        1653848441; bh=luRhvMmkAZ3heLTKp44XjFRoRWvALbzVkpsaVWW0WBc=; b=m
        0gce0H/6QsFcIrVi+wcXSbQJaZlN25jZmnfConeEKvrOYMpHv182lvI0UVjJLiyr
        IV6oO5cqB208z8e2VW8rmCf5XZkQGrgSqnHTY72HtyvLdch6iKlAM6z47l9pzLzv
        wteSRmD7E5N5dapoEzIrrtVnO0rqSnsdgfAqzvBxg5DYNQmLT/xCRKxopCswKFW1
        i3mycFDTmhDc23v0PfduPJkjM/ol2vIOm9EO5S+IbqorfFgUlxTprQ2cSaPYYPYa
        In2q4G/FsQ8fPk3kmozxPVT/HjRG1chtYPjPDXxT6CCZV4GeWP/TEV5rG0y4sZve
        SsMv+fRCi/TYy/TmPTkOA==
X-ME-Sender: <xms:-WeSYudHxMpB-OWYfo4m7pzjTjSGkzm7ZYqHQCHJWOFJXf5TmYrN-w>
    <xme:-WeSYoNDFpGeETBn-EMrYeOKPF6bd90ZiNfzTrA-981wajDBx0oDpexkI_j8LSJ6x
    J0YNpYMFqPsjBzAUA>
X-ME-Received: <xmr:-WeSYvjIRpX6wzNDD9gyPpuHwaGSFAQxsjJvUewbRXI9ghCklPVNHc5DuNYfbzjFlThkMDJx8A7hk2V88CS3e2CZeCdn-kF1NF1CD9NkufVIK1A3NSe7mRcZNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkedugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeelteejffdvgeehkedtkeevueeuteffteffhedufeeujedvudef
    udetieeijeevleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:-WeSYr_NNcF-Ouyk19IQgaGr-4r_7ZhRPLnldMbxSQig8LKtHGFNyQ>
    <xmx:-WeSYqv4GSXQs4zMODgTX12YYAH4JPPRW3ffmt22DPWgoHZEJLi2gQ>
    <xmx:-WeSYiEfAyo4abKr3Jwa3hw1Vl3efBLZ_wj0TNFLM2VU9ucgDs5QeQ>
    <xmx:-WeSYllbt7-Ty2lckJi7VgEHsQlre8vxsEC20_KEUjITkR2t9LesUA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 May 2022 14:20:40 -0400 (EDT)
Subject: Re: [PATCH v21 4/4] ARM: dts: imx7d-remarkable2: Enable lcdif
To:     Alistair Francis <alistair@alistair23.me>, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, alistair23@gmail.com,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220525115554.430971-1-alistair@alistair23.me>
 <20220525115554.430971-5-alistair@alistair23.me>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ea5e1659-5842-6685-52eb-f77ac4247a2d@sholland.org>
Date:   Sat, 28 May 2022 13:20:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220525115554.430971-5-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On 5/25/22 6:55 AM, Alistair Francis wrote:
> Connect the dispaly on the reMarkable2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 74 +++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 99ac0d242936..03a4029e1e57 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -68,6 +68,16 @@ reg_digitizer: regulator-digitizer {
>  		startup-delay-us = <100000>; /* 100 ms */
>  	};
>  
> +	reg_sdoe: regulator-sdoe {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SDOE";
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pinctrl_sdoe_reg>;
> +		pinctrl-1 = <&pinctrl_sdoe_reg>;
> +		gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		pinctrl-names = "default";
> @@ -76,6 +86,16 @@ wifi_pwrseq: wifi_pwrseq {
>  		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
>  		clock-names = "ext_clock";
>  	};
> +
> +	panel {
> +		compatible = "eink,vb3300-kca";
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&display_out>;
> +			};
> +		};
> +	};

From the discussion at [1], this is not safe to merge. It exposes an
electrophoretic display to fbcon/userspace as if it was an LCD, which it very
much is not. Trying to write RGB pixel data to the panel could damage it.

So at the very least before hooking this up, the LCD controller has to know that
the EPD needs special handling and that it cannot accept RGB.

That doesn't necessarily mean there is a problem with the content of this patch
-- the special handling may all be taken care of based on the compatible string
-- but I think it's a really bad idea to merge this with how "eink,vb3300-kca"
is currently represented in panel-simple.

Regards,
Samuel

[1]: https://lore.kernel.org/lkml/Yo5kz%2F9cSd6ewC5f@phenom.ffwll.local/

>  };
>  
>  &clks {
> @@ -132,6 +152,20 @@ reg_epdpmic: vcom {
>  	};
>  };
>  
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdif>;
> +	lcd-supply = <&reg_epdpmic>;
> +	lcd2-supply = <&reg_sdoe>;
> +	status = "okay";
> +
> +	port {
> +		display_out: endpoint {
> +			remote-endpoint = <&panel_in>;
> +		};
> +	};
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -246,6 +280,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
>  		>;
>  	};
>  
> +	pinctrl_lcdif: lcdifgrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
> +			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
> +			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
> +			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
> +			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
> +			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
> +			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
> +			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
> +			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
> +			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
> +			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
> +			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
> +			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
> +			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
> +			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
> +			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
> +
> +			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
> +			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
> +			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
> +			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
> +			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
> +
> +			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
> +			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
> +			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
> +			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
> +			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
> +			MX7D_PAD_LCD_RESET__LCD_RESET		0x79
> +		>;
> +	};
> +
> +	pinctrl_sdoe_reg: sdoereggrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x74
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> 

