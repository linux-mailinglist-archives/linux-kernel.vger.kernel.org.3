Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80007483458
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiACPiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiACPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:37:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E939C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:37:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so81881wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=e7D8OcrNMYt5AXR05zcMqXWeBaERoAiAyxXlq5b2Tro=;
        b=qyfZ/UWDYLYSZ89MGw/VqfX58dPk0V+Tu6T3DOGQFUkCrnDO+soFOfMmGopNO975yt
         Wj5bATAymrGi9/1w8XGbBfpNiRbHRxE4O5Y+b51wKJV4lElM07/Yr8Q9MDE17rXzrJId
         PKOfTlpU5vwqj99YsMrTe2692uUh7kqdRDoBeLBw6GFot1eupOCyDhEk/94BLXX9lyJ0
         pyWnHo2CVYKgyiRPZ+iIEx9A29QYOwezsqVb4gAeNHJKerU+kP/dKQSpwRXNaavXDwXg
         S5hw4oXOquSHIhZzkunoPJkztBdJZJiMlrLcvLjlujlI1DLwu3EWXsJICoODzdzpeAvC
         sYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=e7D8OcrNMYt5AXR05zcMqXWeBaERoAiAyxXlq5b2Tro=;
        b=ca0zDFSpg96G7md26rpeHYFMgbCFhsXkLjHAui0VwEsuhLVyZ/4qc7K7a3hfKRuCeY
         tKCiVv+sF7LBWWaa0o885A4VsQGgiIitKlZPiP0scntMTRXlF0dE4W6PztApHeyJWOf6
         ZvSp3Pb5TlC6p2FN73M2sYldOPEULcM1L8lT0qfbdW0x2xYhspKs/yiDKL7Sm3zRRYo+
         D21z5sl5RmjKbVhblHqKd2XAttQG/jHJd40Em74uJUjJXhpAH0ga42S1uQcCdryW1qjG
         7FDJ7iymqMbZb5FqGCOMkgXfuIT+r5PtbUp4vlad2zfSKsoaNAxmypmoVW42KekbMNFf
         GjAA==
X-Gm-Message-State: AOAM531DYwCFvtSXtWu/jyYNkr7V2iwinnay+xUrUOGwQ11A9GMIDihP
        HYiwR2b+Jka7+NM8hjbRjuk8gA==
X-Google-Smtp-Source: ABdhPJwrKfLISt0WrSPCY8r0DcK76beZJqz85d43vUQWC78epqGLtBg9IGMOZW8FDsAeBrq8zQT3fg==
X-Received: by 2002:a05:600c:1e8b:: with SMTP id be11mr39690535wmb.51.1641224273795;
        Mon, 03 Jan 2022 07:37:53 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e13sm37841243wmq.10.2022.01.03.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:37:53 -0800 (PST)
References: <20211215030236.340841-1-art@khadas.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
Date:   Mon, 03 Jan 2022 16:35:23 +0100
In-reply-to: <20211215030236.340841-1-art@khadas.com>
Message-ID: <1jtuekrfsf.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 15 Dec 2021 at 11:02, Artem Lapkin <email2tema@gmail.com> wrote:

> Add spdifin spdifout nodes for Amlogic SM1 SoCs.
             ^ add (same in the title)

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

Node should still be named spdifout_a, even if the spdifout_b is not added yet

> +			compatible = "amlogic,g12a-spdifout",
> +			"amlogic,axg-spdifout";
> +			reg = <0x0 0x480 0x0 0x50>;
> +			#sound-dai-cells = <0>;
> +			sound-name-prefix = "SPDIFOUT";

Same here

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

