Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430254E6593
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbiCXOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiCXOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:46:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73CA8EE5;
        Thu, 24 Mar 2022 07:45:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q20so2872283wmq.1;
        Thu, 24 Mar 2022 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=M/f8y/26l32WvTxIaHNU9NsW+ax20B3YgWzAaAZO6Mo=;
        b=UE4m2c67FnKibQK1QU98/UtSQNv3yQUQD3OZ4iuZTaCkDrnaL8cBSt4nB9yB/3YFet
         6LpI3mZBnPV/OBZrP3wleWoJLQbHlir64S7QeIjLF71/DtDLwDkNZgeRrVWTp9L89WJf
         kMViLRyhKx4+1AYaqwLDHEPislGseQm/ZzqJA4MIdCA+ChCp2+gOnL7EQx4kXNsgubrd
         z3AJWf+jaE+cqBOBSYb+ilBwqk3CHfRvoNDEeS+mTjENDFsjc6MMJEpkhjCTDl+CJn+x
         diIue72mp0ZbSBNN4JNyEJa9pge17td2txR9bz6+Nhxoz4Yhc2RZvZ8GsjQjjEYdWIIP
         GsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=M/f8y/26l32WvTxIaHNU9NsW+ax20B3YgWzAaAZO6Mo=;
        b=j1nEgXxfBZd7l0nPsjJhL+CFZOomG5gVdBBph78ueRmVt5ZNScT3v+s0XQTepeExEN
         eceXw9qlYRjKH1z5Tc+Kz29YyAtNn9baED8nIhs+n8jrTnJ0A4HdKBIk59EEfSzxjOqv
         i+HIN/HqmH7gq2EtiacYj308IoSBGypImi7rSJBSiDfd3Y8LzsX9oK96q22Sskac5l24
         JOggwtSI78+iKTYTGgZR4V7htWCy5BGH6JthCZymYSkzbXu5hI2dPLwoILHT2g7NXYis
         gZmK6gHRirQHd1lBt4+VZP/OjxkQXG5fhMuyGGFyhfIYsLEIiGwHCisQYNSRfp3VgldE
         tfzw==
X-Gm-Message-State: AOAM5331lPyQE6UqpXQpJfe2IE+GIWFWUEmyV4B/+yc0cZnA9Le4BUO1
        2xVFtzfGWonxl383IX8CeWg=
X-Google-Smtp-Source: ABdhPJwtm+jCnY1o081n9jxBevzG/xtKrtYGckQi6oRARJ8rLE7tnoVwr7G3c/GIJj01lcGz5pqfHA==
X-Received: by 2002:a7b:cd01:0:b0:38c:9142:2006 with SMTP id f1-20020a7bcd01000000b0038c91422006mr14718045wmj.4.1648133117227;
        Thu, 24 Mar 2022 07:45:17 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm2298003wmh.31.2022.03.24.07.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 07:45:16 -0700 (PDT)
Message-ID: <e4f414a6-2a18-1f46-d8c0-c070d63e5326@gmail.com>
Date:   Thu, 24 Mar 2022 15:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-8-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 07/22] arm64: dts: mt8192: Add audio-related nodes
In-Reply-To: <20220318144534.17996-8-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Add audio-related nodes in audsys for mt8192 SoC.
>   - Move audsys node in ascending order.
>   - Increase the address range's length from 0x1000 to 0x2000.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 134 ++++++++++++++++++++++-
>   1 file changed, 128 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6bc36a4076f4..40cf6dacca3e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -742,6 +742,134 @@
>   			status = "disabled";
>   		};
>   
> +		audsys: syscon@11210000 {
> +			compatible = "mediatek,mt8192-audsys", "syscon";
> +			reg = <0 0x11210000 0 0x2000>;
> +			#clock-cells = <1>;

New line here please.

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

There are many more clocks then in the bindings, can please fix that.

Regards,
Matthias

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
>   		nor_flash: spi@11234000 {
>   			compatible = "mediatek,mt8192-nor";
>   			reg = <0 0x11234000 0 0xe0>;
> @@ -757,12 +885,6 @@
>   			status = "disable";
>   		};
>   
> -		audsys: clock-controller@11210000 {
> -			compatible = "mediatek,mt8192-audsys", "syscon";
> -			reg = <0 0x11210000 0 0x1000>;
> -			#clock-cells = <1>;
> -		};
> -
>   		i2c3: i2c@11cb0000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11cb0000 0 0x1000>,
