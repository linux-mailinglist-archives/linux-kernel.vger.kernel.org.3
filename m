Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5522C48C08B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349513AbiALI54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351817AbiALI5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:57:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80AC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:57:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so1127296wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wR5khnPxhK4CBR2Wab/qs/59R6BOAEdLfga3Tx4ANzY=;
        b=W+tcii0vpg0IJsUsZyclv1hfxchyR5W0H1AjVksk6v87Fymf3imE0ZbnVgIMWQlPoD
         NCRzEjtxyZ4BQpWzoi8rTBu3uaBG2lpxoEUSWV4XBOzmXvxJtORWyY8hvBAAf+0+PpeT
         xqh+0LnyKRT8V2Sp7wJ4nY9QZdSmoaLHpc3b2VZEyai9AhkfsDDX/nN/jWBsGDTcHECe
         EmrN/ZK0k4F0Q10rb1vNQ35smwsrICW+fwPfHZAuknOsRKVGUFe0Iyr0L8EkVZ5mNHv1
         jfBzSvmAGZcBVlXEsc6wB0aM5BaoCmdV021DqggTVis9irkrwNHlulnnDBB83y94Rx1J
         b+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wR5khnPxhK4CBR2Wab/qs/59R6BOAEdLfga3Tx4ANzY=;
        b=vhy2tSVIHX2aEFJfEIT3zj5dzaCM4j5O+H6nJ5SICFr41ux0f/I6roxDH8MDWXPTVn
         3RDY42StHzCrB7xsMCcDr8L9GHeabf0FvfjJasSwO/EzrprpL7WnxJB0DxgqsHa3AxuA
         CQ3HRhfLCIZqJjDO3hNfs9e8arMcd8KIjsKCIK4SXKOjvaK/tnNpYgUMOMtBFo41WPjU
         pz4GdbM/lWl6DDdT9RRyYqSf+39vm87sJ7qENNMPY5nRCQf29Sg7279XcCs8rd3vdNbp
         y86fpMD27t9Fx+/iUD1OYe/b9Nj5DLml7U5+/l+VJQ5rUChwPrp029twN4HGJNj+k4+a
         CvdA==
X-Gm-Message-State: AOAM532LeWY3o2UMIexPbn+w+HsF1XkK+wvt1UmBDnvtVAXsOpRoHorC
        7wVrjkCbLnm7QhwDPxIpQ+CcIg==
X-Google-Smtp-Source: ABdhPJy2wuTWz1YQufaNV4KyDqVVfw+Nh1t0+hHx9utE3ws3C795N0PeSF8Kv5633viZNQpjimxbmg==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr5641692wmk.75.1641977872694;
        Wed, 12 Jan 2022 00:57:52 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:381b:6e50:a892:5269? ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id i3sm3837499wrn.11.2022.01.12.00.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:57:52 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Artem Lapkin <email2tema@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
References: <20211215030236.340841-1-art@khadas.com>
 <1jtuekrfsf.fsf@starbuckisacylon.baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b4b62e3d-dc43-a56c-06c5-78e6ee7f6303@baylibre.com>
Date:   Wed, 12 Jan 2022 09:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1jtuekrfsf.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 16:35, Jerome Brunet wrote:
> 
> On Wed 15 Dec 2021 at 11:02, Artem Lapkin <email2tema@gmail.com> wrote:
> 
>> Add spdifin spdifout nodes for Amlogic SM1 SoCs.
>              ^ add (same in the title)
> 
>>
>> Signed-off-by: Artem Lapkin <art@khadas.com>
>> ---
>>
>> SPDIF IN and SPDIF OUT both tested and works fine for VIM3L (meson-sm1)
>> same as for VIM3 (meson-g12)
>>
>> SPDIF in and SPDIF OUT both pins available via GPIO header (SPDIF_OUT PIN
>> 13 spdif_ao_out_pins and SPDIF_IN PIN 35 - same PWM_F spdif_in_h_pins)
>>
>> https://lore.kernel.org/linux-arm-kernel/1jtuhwvqxa.fsf@starbuckisacylon.baylibre.com/t/
>>
>> ALSA spdifin test example
>> =========================
>>
>> # arecord -fS16_LE -r48000 -c2 -Dplug:spdifin
>>
>> # cat .asoundrc
>> pcm.spdifin {
>> type iec958
>> slave {
>> pcm "hw:0,1"
>> format IEC958_SUBFRAME_LE
>> }
>> }
>>
>> DT sound card configs for testing
>> =================================
>>
>> &spdifout {
>>     pinctrl-0 = <&spdif_ao_out_pins>;
>>     pinctrl-names = "default";
>>     status = "okay";
>> };
>>
>> &spdifin {
>>     pinctrl-0 = <&spdif_in_h_pins>;
>>     pinctrl-names = "default";
>>     status = "okay";
>> };
>>
>> ...
>>     spdif_dit: audio-codec-1 {
>> 	#sound-dai-cells = <0>;
>> 	compatible = "linux,spdif-dit";
>> 	status = "okay";
>> 	sound-name-prefix = "DIT";
>>     };
>>
>>     spdif_dir: audio-codec-2 {
>> 	#sound-dai-cells = <0>;
>> 	compatible = "linux,spdif-dir";
>> 	status = "okay";
>> 	sound-name-prefix = "DIR";
>>     };
>> ...
>> 	audio-routing = ...
>> 		"TODDR_B IN 3", "SPDIFIN Capture",
>> 		"SPDIFOUT IN 0", "FRDDR_A OUT 3";
>>
>> ...
>> 	dai-link-10 {
>> 	    sound-dai = <&spdifout>;
>>
>> 	    codec-0 {
>> 		sound-dai = <&spdif_dit>;
>> 	    };
>> 	};
>>
>> 	/* spdif or toslink interface */
>> 	dai-link-11 {
>> 	    sound-dai = <&spdifin>;
>>
>> 	    codec-0 {
>> 		sound-dai = <&spdif_dir>;
>> 	    };
>> 	};
>> ...
>>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 27 ++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> index 3d8b1f4f2001..1e0adf259d61 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
>>  			status = "disabled";
>>  		};
>>  
>> +		spdifin: audio-controller@400 {
>> +			compatible = "amlogic,g12a-spdifin",
>> +			"amlogic,axg-spdifin";
>> +			reg = <0x0 0x400 0x0 0x30>;
>> +			#sound-dai-cells = <0>;
>> +			sound-name-prefix = "SPDIFIN";
>> +			interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
>> +			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
>> +			<&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
>> +			clock-names = "pclk", "refclk";
>> +			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
>> +			status = "disabled";
>> +		};
>> +
>> +		spdifout: audio-controller@480 {
> 
> Node should still be named spdifout_a, even if the spdifout_b is not added yet
> 
>> +			compatible = "amlogic,g12a-spdifout",
>> +			"amlogic,axg-spdifout";
>> +			reg = <0x0 0x480 0x0 0x50>;
>> +			#sound-dai-cells = <0>;
>> +			sound-name-prefix = "SPDIFOUT";
> 
> Same here
> 
>> +			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
>> +			<&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
>> +			clock-names = "pclk", "mclk";
>> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
>> +			status = "disabled";
>> +		};
>> +
>>  		tdmout_a: audio-controller@500 {
>>  			compatible = "amlogic,sm1-tdmout";
>>  			reg = <0x0 0x500 0x0 0x40>;
> 

All these fixed while applying, no need to send a new version.

Neil
