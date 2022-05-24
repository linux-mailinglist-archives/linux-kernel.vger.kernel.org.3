Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDF5326D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiEXJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiEXJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:50:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1706F491
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:50:22 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 1so6886121ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G5WlWLi6CTURLGag3t+5CNRf4lZCgCTJvDTMTbTzQ5s=;
        b=M5ncORw3o6tH0W6GJp/VpORJZBt9q4377NZcTfDcKeo1/AQf38SDgEJiTum+C02xgc
         r4QaJJ+obzajUh+DovgWFW42ZkroAxdOoffR7GZhttn1jnPQp3TV5ZWcpJfqYQrCFV6L
         57BRFW0TbWj5Oc5tZNBBqfpwr7W6AAgPIBI2pS8LZnAtnE+MEpd4xGPt6NXBEIR9McxM
         maGD+k8hr8IO056uwFRRKdMrsrk7dXrwIrpZQ0bokeNSqP+M3uMIsPiHmJ+FsyPUOiBL
         NibYJZfMinCiQEXphf+a1ecq+yd7bfS4GmXu5raI7xcXYVJliT7pFVK5U9jyEgqkBtOZ
         e7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G5WlWLi6CTURLGag3t+5CNRf4lZCgCTJvDTMTbTzQ5s=;
        b=2h/yNNuTqf6lD946Nt/zEeMT+StI8yy2sKeKQFsua2XOK7fGdzvRVUD9y33SHlX+z4
         SL0P6sxNks6cqHkaca87BXQBT5JKPGV7KE+bi7h0/7XaUNczrD//bm27sFWHfkDM0WXK
         6gD0r3SHWVMfUofXtu6Tkt6WCJN7fYw8c3RTtJOSpolQVgzO9I3cmQz0Yhno7b46c9vL
         o6bdHCicBnoRKryZGh9sIIl6NnJjfXEbJbsvJWTtwfWKiqY17TaFabzPNWKkIyMrrgpM
         YEGQIBHw9Yg0qfp9JwMUsQsdmwZfMDy3lDkQGvHgV1/H9uhzfuxySH/9jsUSt9XKSnot
         bujA==
X-Gm-Message-State: AOAM530tDH9VPAEgKWzkn59IB0sYXcx0bljURjyxfPOI687o5txOjXjJ
        Nkn0X8Zt1oo0azWGv9nrzdDcQA==
X-Google-Smtp-Source: ABdhPJzADTR5ZRgZ2CtrdOGOpAvEuXwgcWWGhbFMTvfVxCiP3KAzV1YJN8j3H75tLbWtQ/a5Bfw4zg==
X-Received: by 2002:a2e:91d9:0:b0:253:d761:130 with SMTP id u25-20020a2e91d9000000b00253d7610130mr14134812ljg.7.1653385820828;
        Tue, 24 May 2022 02:50:20 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id m10-20020a056512358a00b0047255d21152sm2441897lfr.129.2022.05.24.02.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:50:20 -0700 (PDT)
Message-ID: <a59707ea-0b58-0f3a-b39c-bc33d0625c8e@linaro.org>
Date:   Tue, 24 May 2022 11:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] arm64: dts: mt7986: add built-in Wi-Fi device nodes
Content-Language: en-US
To:     Peter Chiu <chui-hao.chiu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220524032430.6261-1-chui-hao.chiu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220524032430.6261-1-chui-hao.chiu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 05:24, Peter Chiu wrote:
> This enables built-in 802.11ax Wi-Fi support.
> 
> Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
> v2: add clocks and clock-names
> ---
>  arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 41 +++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 22 ++++++++++
>  arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 43 ++++++++++++++++++++
>  3 files changed, 106 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index 24c155c71f0d..359e14f8e9f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -57,6 +57,13 @@
>  	status = "okay";
>  };
>  
> +&wmac {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>;
> +};
> +
>  &pio {
>  	pcie_pins: pcie-pins {
>  		mux {
> @@ -99,6 +106,40 @@
>  			groups = "jtag";
>  		};
>  	};
> +
> +	wf_2g_5g_pins: wf_2g_5g-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_2g", "wf_5g";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_dbdc_pins: wf_dbdc-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_dbdc";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
>  };
>  
>  &spi0 {
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 9663a0779416..47d719fb66fb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/mt7986-clk.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/reset/mt7986-resets.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -80,6 +81,11 @@
>  			reg = <0 0x43000000 0 0x30000>;
>  			no-map;
>  		};
> +
> +		wmcpu_emi: wmcpu-reserved@4fc00000 {
> +			no-map;
> +			reg = <0 0x4fc00000 0 0x00100000>;
> +		};
>  	};
>  
>  	timer {
> @@ -381,6 +387,22 @@
>  			 #reset-cells = <1>;
>  		};
>  
> +		wmac: wmac@18000000 {

This is wifi, right? If so, then generic node name - wifi.

> +			compatible = "mediatek,mt7986-wmac";
> +			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
> +			reset-names = "consys";
> +			clocks = <&topckgen CLK_TOP_CONN_MCUSYS_SEL>,
> +				 <&topckgen CLK_TOP_AP2CNN_HOST_SEL>;
> +			clock-names = "mcu", "ap2conn";
> +			reg = <0 0x18000000 0 0x1000000>,
> +			      <0 0x10003000 0 0x1000>,
> +			      <0 0x11d10000 0 0x1000>;
> +			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
> +			memory-region = <&wmcpu_emi>;
> +		};
>  	};
>  
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index d4078feb4aad..f25312c9a289 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -97,3 +97,46 @@
>  &usb_phy {
>  	status = "okay";
>  };
> +
> +&wmac {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>;
> +};
> +
> +&pio {
> +	wf_2g_5g_pins: wf_2g_5g-pins {

No underscores in node names, unless binding requires them... but it
should not as this is not allowed character.


Best regards,
Krzysztof
