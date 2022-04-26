Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED23510A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354821AbiDZUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354340AbiDZUSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:18:47 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA061DA74;
        Tue, 26 Apr 2022 13:15:17 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id s131so2653314oie.1;
        Tue, 26 Apr 2022 13:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4D4FA3jMbNSOVGYIrOuVGyIIySWxqxWkkBOU3AjQRE=;
        b=2ob1sdxGG8/vFwKNOwHXA5NALuYf6BUnia0sry/qx1N4CPoXZHt+RZHaZgDSx+aSPf
         qg3XLbQ/m4Qdt93jMGc50hJEFHLgeOQ6qq4LVs6mS/qLz/sU+ISHRcdpoDnb097klAIU
         zq2WYxOa7HA4mIscnLX5Jwzx1Qy7lDiFd9bQWnJjqYixtkJCbbM9xy9z+MHR9MSGXtyv
         H09nuUUn+Cn/646qdxqxg3V0+8puS5mNetM0xigKmO0B+xuKHuDi5yUanNpYEbO5KvTL
         asjbBzKSx4WwlOPq5/MQASwtu+Vh20DqTNub98WBxjJB/DVd6B5bQvyPkBfnRZPvjf7T
         +dPg==
X-Gm-Message-State: AOAM531Reh0JxKUAycNHU0J4W9f8sUFZY7Pfh6A1AuIELgypbzIOeHrv
        odp/fAsuAxHG55u2GXfUTA==
X-Google-Smtp-Source: ABdhPJxQsiU7TXwKBypyr1tR6ffaX0ownpf1Ny/g7n3+2m1MyWGud+Y/0ExcJTEv9n8w1aDgraAX0w==
X-Received: by 2002:aca:1117:0:b0:322:4189:8959 with SMTP id 23-20020aca1117000000b0032241898959mr15357841oir.254.1651004116888;
        Tue, 26 Apr 2022 13:15:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v22-20020a056870e49600b000d6c86ea98dsm1184568oag.1.2022.04.26.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:15:16 -0700 (PDT)
Received: (nullmailer pid 2463555 invoked by uid 1000);
        Tue, 26 Apr 2022 20:15:15 -0000
Date:   Tue, 26 Apr 2022 15:15:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: mediatek: mt8192: complete clocks
 and clock-names
Message-ID: <YmhS0yh/KqYqKshj@robh.at.kernel.org>
References: <20220419025557.22262-1-allen-kh.cheng@mediatek.com>
 <20220419025557.22262-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419025557.22262-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:55:56AM +0800, Allen-KH Cheng wrote:
> From: Jiaxin Yu <jiaxin.yu@mediatek.com>
> 
> Complete all clocks and clock-names be used for mt8192 SoC into dt-bindings.

Not a compatible change breaking the ABI. Please explain why if that's 
intentional.

> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../bindings/sound/mt8192-afe-pcm.yaml        | 165 +++++++++++++++++-
>  1 file changed, 157 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> index 7a25bc9b8060..1b6b22a5732e 100644
> --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> @@ -39,20 +39,67 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    items:
> -      - description: AFE clock
> -      - description: ADDA DAC clock
> -      - description: ADDA DAC pre-distortion clock
> -      - description: audio infra sys clock
> -      - description: audio infra 26M clock
> +    minItems: 56
> +    maxItems: 56
>  
>    clock-names:
>      items:
>        - const: aud_afe_clk
>        - const: aud_dac_clk
>        - const: aud_dac_predis_clk
> +      - const: aud_adc_clk
> +      - const: aud_adda6_adc_clk
> +      - const: aud_apll22m_clk
> +      - const: aud_apll24m_clk
> +      - const: aud_apll1_tuner_clk
> +      - const: aud_apll2_tuner_clk
> +      - const: aud_tdm_clk
> +      - const: aud_tml_clk
> +      - const: aud_nle
> +      - const: aud_dac_hires_clk
> +      - const: aud_adc_hires_clk
> +      - const: aud_adc_hires_tml
> +      - const: aud_adda6_adc_hires_clk
> +      - const: aud_3rd_dac_clk
> +      - const: aud_3rd_dac_predis_clk
> +      - const: aud_3rd_dac_tml
> +      - const: aud_3rd_dac_hires_clk
>        - const: aud_infra_clk
>        - const: aud_infra_26m_clk
> +      - const: top_mux_audio
> +      - const: top_mux_audio_int
> +      - const: top_mainpll_d4_d4
> +      - const: top_mux_aud_1
> +      - const: top_apll1_ck
> +      - const: top_mux_aud_2
> +      - const: top_apll2_ck
> +      - const: top_mux_aud_eng1
> +      - const: top_apll1_d4
> +      - const: top_mux_aud_eng2
> +      - const: top_apll2_d4
> +      - const: top_i2s0_m_sel
> +      - const: top_i2s1_m_sel
> +      - const: top_i2s2_m_sel
> +      - const: top_i2s3_m_sel
> +      - const: top_i2s4_m_sel
> +      - const: top_i2s5_m_sel
> +      - const: top_i2s6_m_sel
> +      - const: top_i2s7_m_sel
> +      - const: top_i2s8_m_sel
> +      - const: top_i2s9_m_sel
> +      - const: top_apll12_div0
> +      - const: top_apll12_div1
> +      - const: top_apll12_div2
> +      - const: top_apll12_div3
> +      - const: top_apll12_div4
> +      - const: top_apll12_divb
> +      - const: top_apll12_div5
> +      - const: top_apll12_div6
> +      - const: top_apll12_div7
> +      - const: top_apll12_div8
> +      - const: top_apll12_div9
> +      - const: top_mux_audio_h
> +      - const: top_clk26m_clk
>  
>  required:
>    - compatible
> @@ -88,13 +135,115 @@ examples:
>          clocks = <&audsys CLK_AUD_AFE>,
>                   <&audsys CLK_AUD_DAC>,
>                   <&audsys CLK_AUD_DAC_PREDIS>,
> +                 <&audsys CLK_AUD_ADC>,
> +                 <&audsys CLK_AUD_ADDA6_ADC>,
> +                 <&audsys CLK_AUD_22M>,
> +                 <&audsys CLK_AUD_24M>,
> +                 <&audsys CLK_AUD_APLL_TUNER>,
> +                 <&audsys CLK_AUD_APLL2_TUNER>,
> +                 <&audsys CLK_AUD_TDM>,
> +                 <&audsys CLK_AUD_TML>,
> +                 <&audsys CLK_AUD_NLE>,
> +                 <&audsys CLK_AUD_DAC_HIRES>,
> +                 <&audsys CLK_AUD_ADC_HIRES>,
> +                 <&audsys CLK_AUD_ADC_HIRES_TML>,
> +                 <&audsys CLK_AUD_ADDA6_ADC_HIRES>,
> +                 <&audsys CLK_AUD_3RD_DAC>,
> +                 <&audsys CLK_AUD_3RD_DAC_PREDIS>,
> +                 <&audsys CLK_AUD_3RD_DAC_TML>,
> +                 <&audsys CLK_AUD_3RD_DAC_HIRES>,
>                   <&infracfg CLK_INFRA_AUDIO>,
> -                 <&infracfg CLK_INFRA_AUDIO_26M_B>;
> +                 <&infracfg CLK_INFRA_AUDIO_26M_B>,
> +                 <&topckgen CLK_TOP_AUDIO_SEL>,
> +                 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> +                 <&topckgen CLK_TOP_MAINPLL_D4_D4>,
> +                 <&topckgen CLK_TOP_AUD_1_SEL>,
> +                 <&topckgen CLK_TOP_APLL1>,
> +                 <&topckgen CLK_TOP_AUD_2_SEL>,
> +                 <&topckgen CLK_TOP_APLL2>,
> +                 <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
> +                 <&topckgen CLK_TOP_APLL1_D4>,
> +                 <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
> +                 <&topckgen CLK_TOP_APLL2_D4>,
> +                 <&topckgen CLK_TOP_APLL_I2S0_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S1_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S2_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S3_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S4_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S5_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S6_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S7_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S8_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL_I2S9_M_SEL>,
> +                 <&topckgen CLK_TOP_APLL12_DIV0>,
> +                 <&topckgen CLK_TOP_APLL12_DIV1>,
> +                 <&topckgen CLK_TOP_APLL12_DIV2>,
> +                 <&topckgen CLK_TOP_APLL12_DIV3>,
> +                 <&topckgen CLK_TOP_APLL12_DIV4>,
> +                 <&topckgen CLK_TOP_APLL12_DIVB>,
> +                 <&topckgen CLK_TOP_APLL12_DIV5>,
> +                 <&topckgen CLK_TOP_APLL12_DIV6>,
> +                 <&topckgen CLK_TOP_APLL12_DIV7>,
> +                 <&topckgen CLK_TOP_APLL12_DIV8>,
> +                 <&topckgen CLK_TOP_APLL12_DIV9>,
> +                 <&topckgen CLK_TOP_AUDIO_H_SEL>,
> +                 <&clk26m>;
>          clock-names = "aud_afe_clk",
>                        "aud_dac_clk",
>                        "aud_dac_predis_clk",
> +                      "aud_adc_clk",
> +                      "aud_adda6_adc_clk",
> +                      "aud_apll22m_clk",
> +                      "aud_apll24m_clk",
> +                      "aud_apll1_tuner_clk",
> +                      "aud_apll2_tuner_clk",
> +                      "aud_tdm_clk",
> +                      "aud_tml_clk",
> +                      "aud_nle",
> +                      "aud_dac_hires_clk",
> +                      "aud_adc_hires_clk",
> +                      "aud_adc_hires_tml",
> +                      "aud_adda6_adc_hires_clk",
> +                      "aud_3rd_dac_clk",
> +                      "aud_3rd_dac_predis_clk",
> +                      "aud_3rd_dac_tml",
> +                      "aud_3rd_dac_hires_clk",
>                        "aud_infra_clk",
> -                      "aud_infra_26m_clk";
> +                      "aud_infra_26m_clk",
> +                      "top_mux_audio",
> +                      "top_mux_audio_int",
> +                      "top_mainpll_d4_d4",
> +                      "top_mux_aud_1",
> +                      "top_apll1_ck",
> +                      "top_mux_aud_2",
> +                      "top_apll2_ck",
> +                      "top_mux_aud_eng1",
> +                      "top_apll1_d4",
> +                      "top_mux_aud_eng2",
> +                      "top_apll2_d4",
> +                      "top_i2s0_m_sel",
> +                      "top_i2s1_m_sel",
> +                      "top_i2s2_m_sel",
> +                      "top_i2s3_m_sel",
> +                      "top_i2s4_m_sel",
> +                      "top_i2s5_m_sel",
> +                      "top_i2s6_m_sel",
> +                      "top_i2s7_m_sel",
> +                      "top_i2s8_m_sel",
> +                      "top_i2s9_m_sel",
> +                      "top_apll12_div0",
> +                      "top_apll12_div1",
> +                      "top_apll12_div2",
> +                      "top_apll12_div3",
> +                      "top_apll12_div4",
> +                      "top_apll12_divb",
> +                      "top_apll12_div5",
> +                      "top_apll12_div6",
> +                      "top_apll12_div7",
> +                      "top_apll12_div8",
> +                      "top_apll12_div9",
> +                      "top_mux_audio_h",
> +                      "top_clk26m_clk";
>      };
>  
>  ...
> -- 
> 2.18.0
> 
> 
