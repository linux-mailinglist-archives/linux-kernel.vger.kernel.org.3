Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1346C50B9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448606AbiDVOSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448566AbiDVOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:18:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A85A590;
        Fri, 22 Apr 2022 07:15:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e28so1057799wra.8;
        Fri, 22 Apr 2022 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UYWpWQbW1bcVwNgWTRtNC4aBZe02WCeF/oJCbOk791g=;
        b=DgoD05H175CPG5T7HupqWGMcrRoo/VhsX9QxDoB2eCa8xm2IpZvYw/accHb/yY1knQ
         OdHqLR1npnt8dfnxu4+/FNCQu0TvedwH6T2YxB3X3RanECqRp35evfVNFo62jMoERknh
         HAtJZk0ixt5VmMNAusDJA/U7OJealIERnLzPU3XzqwO44w8jPLiLbytXchQeNFOUDUhG
         0XPwhTGiMU1kRR6XaM8165ItV8hjkxzEK2gvI/lojOX3A5Mpe94oBwCEmsavCPG8Qug+
         WryHaHEFVUjDbBB543zhmZqSaRsSxXelGwiARVcN7+ddNvmcll9X+f2Ddjt3HwD7l6oX
         8RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UYWpWQbW1bcVwNgWTRtNC4aBZe02WCeF/oJCbOk791g=;
        b=M85GbgZGF2ixhxBBgm5H4NuESmv43GC3eP9dpqyCYzGuz0FajNlfyva2wwJjjEu32+
         DhgoA7hWc4nt4YRuiqdRYPyAR73VObRqRRTiY5RpUbyqZfPMrBVTNyYhV/x+VqpvDSYD
         TyWebjUfNsRQptbjysVbYvE7SZpvqq4FXc1yQ41hU19UlzZgBv96d1sOkzYU0h6LDwco
         j0tUfXHh0VFa9TturOVZUftObjCev0ntXR3xKGdT8dMEICkuJqoOcQJ4LEh26yCrkTJw
         2UjMVGpgi18MyjmukChdiXTNuGJrGPSriuXm2RDFXLYIba4+/Faww7qQ6RgaidveDYFw
         Bd6w==
X-Gm-Message-State: AOAM530/XOO8kVsuHhxaHrMadyjAu1vwB8759JtljnpJGTi640a+EcFM
        tzY39DO3TFJi+1oA0EZrAqk=
X-Google-Smtp-Source: ABdhPJxiWo+XuBszVZ0ihkM9EkhcgThKUJXLmHG7rDjT+bQoRLfkSHF4avPHKyvLtQbs3NfJmFIT2w==
X-Received: by 2002:a5d:4882:0:b0:207:97dd:111c with SMTP id g2-20020a5d4882000000b0020797dd111cmr4174686wrq.115.1650636957655;
        Fri, 22 Apr 2022 07:15:57 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i6-20020a0560001ac600b0020a93f75030sm1855803wry.48.2022.04.22.07.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:15:57 -0700 (PDT)
Message-ID: <61073ff6-9af0-aa11-3adf-f4275c185732@gmail.com>
Date:   Fri, 22 Apr 2022 16:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] arm64: dts: mt8192: Add audio-related nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220419025557.22262-1-allen-kh.cheng@mediatek.com>
 <20220419025557.22262-3-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220419025557.22262-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 04:55, Allen-KH Cheng wrote:
> Add audio-related nodes in audsys for mt8192 SoC.
>   - Move audsys node in ascending order.
>   - Increase the address range's length from 0x1000 to 0x2000.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 135 ++++++++++++++++++++++-
>   1 file changed, 129 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a6da7b04b9d4..13c87d2a391a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -716,6 +716,135 @@
>   			status = "disabled";
>   		};
>   
> +		audsys: syscon@11210000 {
> +			compatible = "mediatek,mt8192-audsys", "syscon";
> +			reg = <0 0x11210000 0 0x2000>;
> +			#clock-cells = <1>;
> +
> +			afe: mt8192-afe-pcm {
> +				compatible = "mediatek,mt8192-audio";
> +				interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH 0>;
> +				resets = <&watchdog 17>;
> +				reset-names = "audiosys";
> +				mediatek,apmixedsys = <&apmixedsys>;
> +				mediatek,infracfg = <&infracfg>;
> +				mediatek,topckgen = <&topckgen>;
> +				power-domains = <&spm MT8192_POWER_DOMAIN_AUDIO>;
> +				clocks = <&audsys CLK_AUD_AFE>,
> +					 <&audsys CLK_AUD_DAC>,
> +					 <&audsys CLK_AUD_DAC_PREDIS>,
> +					 <&audsys CLK_AUD_ADC>,
> +					 <&audsys CLK_AUD_ADDA6_ADC>,
> +					 <&audsys CLK_AUD_22M>,
> +					 <&audsys CLK_AUD_24M>,
> +					 <&audsys CLK_AUD_APLL_TUNER>,
> +					 <&audsys CLK_AUD_APLL2_TUNER>,
> +					 <&audsys CLK_AUD_TDM>,
> +					 <&audsys CLK_AUD_TML>,
> +					 <&audsys CLK_AUD_NLE>,
> +					 <&audsys CLK_AUD_DAC_HIRES>,
> +					 <&audsys CLK_AUD_ADC_HIRES>,
> +					 <&audsys CLK_AUD_ADC_HIRES_TML>,
> +					 <&audsys CLK_AUD_ADDA6_ADC_HIRES>,
> +					 <&audsys CLK_AUD_3RD_DAC>,
> +					 <&audsys CLK_AUD_3RD_DAC_PREDIS>,
> +					 <&audsys CLK_AUD_3RD_DAC_TML>,
> +					 <&audsys CLK_AUD_3RD_DAC_HIRES>,
> +					 <&infracfg CLK_INFRA_AUDIO>,
> +					 <&infracfg CLK_INFRA_AUDIO_26M_B>,
> +					 <&topckgen CLK_TOP_AUDIO_SEL>,
> +					 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> +					 <&topckgen CLK_TOP_MAINPLL_D4_D4>,
> +					 <&topckgen CLK_TOP_AUD_1_SEL>,
> +					 <&topckgen CLK_TOP_APLL1>,
> +					 <&topckgen CLK_TOP_AUD_2_SEL>,
> +					 <&topckgen CLK_TOP_APLL2>,
> +					 <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
> +					 <&topckgen CLK_TOP_APLL1_D4>,
> +					 <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
> +					 <&topckgen CLK_TOP_APLL2_D4>,
> +					 <&topckgen CLK_TOP_APLL_I2S0_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S1_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S2_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S3_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S4_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S5_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S6_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S7_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S8_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL_I2S9_M_SEL>,
> +					 <&topckgen CLK_TOP_APLL12_DIV0>,
> +					 <&topckgen CLK_TOP_APLL12_DIV1>,
> +					 <&topckgen CLK_TOP_APLL12_DIV2>,
> +					 <&topckgen CLK_TOP_APLL12_DIV3>,
> +					 <&topckgen CLK_TOP_APLL12_DIV4>,
> +					 <&topckgen CLK_TOP_APLL12_DIVB>,
> +					 <&topckgen CLK_TOP_APLL12_DIV5>,
> +					 <&topckgen CLK_TOP_APLL12_DIV6>,
> +					 <&topckgen CLK_TOP_APLL12_DIV7>,
> +					 <&topckgen CLK_TOP_APLL12_DIV8>,
> +					 <&topckgen CLK_TOP_APLL12_DIV9>,
> +					 <&topckgen CLK_TOP_AUDIO_H_SEL>,
> +					 <&clk26m>;
> +				clock-names = "aud_afe_clk",
> +					      "aud_dac_clk",
> +					      "aud_dac_predis_clk",
> +					      "aud_adc_clk",
> +					      "aud_adda6_adc_clk",
> +					      "aud_apll22m_clk",
> +					      "aud_apll24m_clk",
> +					      "aud_apll1_tuner_clk",
> +					      "aud_apll2_tuner_clk",
> +					      "aud_tdm_clk",
> +					      "aud_tml_clk",
> +					      "aud_nle",
> +					      "aud_dac_hires_clk",
> +					      "aud_adc_hires_clk",
> +					      "aud_adc_hires_tml",
> +					      "aud_adda6_adc_hires_clk",
> +					      "aud_3rd_dac_clk",
> +					      "aud_3rd_dac_predis_clk",
> +					      "aud_3rd_dac_tml",
> +					      "aud_3rd_dac_hires_clk",
> +					      "aud_infra_clk",
> +					      "aud_infra_26m_clk",
> +					      "top_mux_audio",
> +					      "top_mux_audio_int",
> +					      "top_mainpll_d4_d4",
> +					      "top_mux_aud_1",
> +					      "top_apll1_ck",
> +					      "top_mux_aud_2",
> +					      "top_apll2_ck",
> +					      "top_mux_aud_eng1",
> +					      "top_apll1_d4",
> +					      "top_mux_aud_eng2",
> +					      "top_apll2_d4",
> +					      "top_i2s0_m_sel",
> +					      "top_i2s1_m_sel",
> +					      "top_i2s2_m_sel",
> +					      "top_i2s3_m_sel",
> +					      "top_i2s4_m_sel",
> +					      "top_i2s5_m_sel",
> +					      "top_i2s6_m_sel",
> +					      "top_i2s7_m_sel",
> +					      "top_i2s8_m_sel",
> +					      "top_i2s9_m_sel",
> +					      "top_apll12_div0",
> +					      "top_apll12_div1",
> +					      "top_apll12_div2",
> +					      "top_apll12_div3",
> +					      "top_apll12_div4",
> +					      "top_apll12_divb",
> +					      "top_apll12_div5",
> +					      "top_apll12_div6",
> +					      "top_apll12_div7",
> +					      "top_apll12_div8",
> +					      "top_apll12_div9",
> +					      "top_mux_audio_h",
> +					      "top_clk26m_clk";
> +			};
> +		};
> +
>   		pcie: pcie@11230000 {
>   			compatible = "mediatek,mt8192-pcie";
>   			device_type = "pci";
> @@ -766,12 +895,6 @@
>   			status = "disabled";
>   		};
>   
> -		audsys: clock-controller@11210000 {
> -			compatible = "mediatek,mt8192-audsys", "syscon";
> -			reg = <0 0x11210000 0 0x1000>;
> -			#clock-cells = <1>;
> -		};
> -
>   		efuse: efuse@11c10000 {
>   			compatible = "mediatek,efuse";
>   			reg = <0 0x11c10000 0 0x1000>;
