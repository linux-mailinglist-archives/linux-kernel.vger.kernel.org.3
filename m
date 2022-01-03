Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C0C48340D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiACPSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiACPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:18:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A825C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:18:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so70616109wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCaHyP5ebl213km5STCt5+zOoJt9LjhnFcS42FC3TYI=;
        b=7VDW7DnekEMpLtUjkrLruXmrj7LanTofrDr8lwJYDR6cGPDvRRZ7QaFnt3ti531DGs
         NG6m3a0rGNmqOlLqHynzbAZWpKzrATHOEabLmLbelnzWE8oGaY7eyydvCQSVrTdiIEM/
         sBAP1KaSdVsRX+fM0+AhIMC/53tY8a1sFR7Vzr8kRg9ono/8wqAJfsVtyC19+weX2eay
         iurlsBnuvLe5KfD2yVGBQDFdk2ksuPAVLvlAEp+BoPWvpJFwUZ3OW1LTl+lxHbe0gbKb
         NTFzWKLDxyWDuSHXS6xLDq1gfiw3QqTgoRlaT7+zRfWfhFWKn+47qo1GFBIyFW+jRxv4
         VkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RCaHyP5ebl213km5STCt5+zOoJt9LjhnFcS42FC3TYI=;
        b=HIZeMNhaRkUxEeBEpROF5pBVhByFAhyozm3uBeS/Q0q9viKTHsCA4iCwJO8v+h1Chg
         xO0qYiKvFtyBXVdiDQDsRpPBsDdndFp2JWUjTfhhLIfse1vdOqecHV9XK59oWyePFLdV
         qu4kgI3bI5S8yFFcg77eL5DUM0jdNDu9+V7XlrCm/sFnLE9WkQMMpcNvdl+oZXPOZL5I
         qOLxSApoX6O8S2dBwMvmrXPlA3JLBr+jA9McYY3jMYdFSnn8jQe+tirW//SQpxXc08xj
         dIogNm8nR8c42vxVUzfX2WnN+tvWeFmSDChhMPPV2hqpafDjFlVzEKuTiNS2P7ONuKCi
         wB2Q==
X-Gm-Message-State: AOAM531S1peL0F5FQokbi0exF7+bz/3G0Rc7WdzKIGHl8kM9FOjO4iFY
        Zrg/GOdGOPmkWfJWOgRxonX+5A==
X-Google-Smtp-Source: ABdhPJwbSTS4oam1MAa06aQBgF89Uhw69k911CPsHZgOi4vqcoTlEc/QPIkleuaGl1naux23SCbdHA==
X-Received: by 2002:a5d:6c6c:: with SMTP id r12mr39501803wrz.706.1641223090126;
        Mon, 03 Jan 2022 07:18:10 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id i8sm44072453wry.108.2022.01.03.07.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 07:18:09 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
References: <20211215030236.340841-1-art@khadas.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <67d8cefc-d7c7-daba-bfe3-5935ded52beb@baylibre.com>
Date:   Mon, 3 Jan 2022 16:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215030236.340841-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 04:02, Artem Lapkin wrote:
> Add spdifin spdifout nodes for Amlogic SM1 SoCs.
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
> 
> SPDIF IN and SPDIF OUT both tested and works fine for VIM3L (meson-sm1)
> same as for VIM3 (meson-g12)
> 
> SPDIF in and SPDIF OUT both pins available via GPIO header (SPDIF_OUT PIN
> 13 spdif_ao_out_pins and SPDIF_IN PIN 35 - same PWM_F spdif_in_h_pins)
> 
> https://lore.kernel.org/linux-arm-kernel/1jtuhwvqxa.fsf@starbuckisacylon.baylibre.com/t/
> 
> ALSA spdifin test example
> =========================
> 
> # arecord -fS16_LE -r48000 -c2 -Dplug:spdifin
> 
> # cat .asoundrc
> pcm.spdifin {
> type iec958
> slave {
> pcm "hw:0,1"
> format IEC958_SUBFRAME_LE
> }
> }
> 
> DT sound card configs for testing
> =================================
> 
> &spdifout {
>     pinctrl-0 = <&spdif_ao_out_pins>;
>     pinctrl-names = "default";
>     status = "okay";
> };
> 
> &spdifin {
>     pinctrl-0 = <&spdif_in_h_pins>;
>     pinctrl-names = "default";
>     status = "okay";
> };
> 
> ...
>     spdif_dit: audio-codec-1 {
> 	#sound-dai-cells = <0>;
> 	compatible = "linux,spdif-dit";
> 	status = "okay";
> 	sound-name-prefix = "DIT";
>     };
> 
>     spdif_dir: audio-codec-2 {
> 	#sound-dai-cells = <0>;
> 	compatible = "linux,spdif-dir";
> 	status = "okay";
> 	sound-name-prefix = "DIR";
>     };
> ...
> 	audio-routing = ...
> 		"TODDR_B IN 3", "SPDIFIN Capture",
> 		"SPDIFOUT IN 0", "FRDDR_A OUT 3";
> 
> ...
> 	dai-link-10 {
> 	    sound-dai = <&spdifout>;
> 
> 	    codec-0 {
> 		sound-dai = <&spdif_dit>;
> 	    };
> 	};
> 
> 	/* spdif or toslink interface */
> 	dai-link-11 {
> 	    sound-dai = <&spdifin>;
> 
> 	    codec-0 {
> 		sound-dai = <&spdif_dir>;
> 	    };
> 	};
> ...
> 
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 3d8b1f4f2001..1e0adf259d61 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
>  			status = "disabled";
>  		};
>  
> +		spdifin: audio-controller@400 {
> +			compatible = "amlogic,g12a-spdifin",
> +			"amlogic,axg-spdifin";
> +			reg = <0x0 0x400 0x0 0x30>;
> +			#sound-dai-cells = <0>;
> +			sound-name-prefix = "SPDIFIN";
> +			interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
> +			<&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
> +			clock-names = "pclk", "refclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
> +			status = "disabled";
> +		};
> +
> +		spdifout: audio-controller@480 {
> +			compatible = "amlogic,g12a-spdifout",
> +			"amlogic,axg-spdifout";
> +			reg = <0x0 0x480 0x0 0x50>;
> +			#sound-dai-cells = <0>;
> +			sound-name-prefix = "SPDIFOUT";
> +			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
> +			<&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
> +			clock-names = "pclk", "mclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
> +			status = "disabled";
> +		};
> +
>  		tdmout_a: audio-controller@500 {
>  			compatible = "amlogic,sm1-tdmout";
>  			reg = <0x0 0x500 0x0 0x40>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
