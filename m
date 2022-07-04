Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA16565593
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiGDMiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiGDMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:38:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5BC49
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:38:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z13so15512497lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BAn7H856GfFRIZFIPVXMWyj53npckuCFDy0OCv3VUpA=;
        b=ttufPLcTzCznFU5yCsxwU6S2KKVGSbhhl1fAH1EC/QzUhgf5uu757WjgKjCILW6C8G
         ahnSm/UjhZWTglFPNpkRIqigLPNAdTTxYrUW/kvlcHzSP9lHm6LODb7RYRLLrwMvXMyb
         E6MhPv2VXM2CbgjD9ayU4di+itAGXAmQcI0Ubus9FL/o8zGyP3+QXSernOCsmyDXhWSw
         RXv+RR5rzdHAHxxYuJb/VIDS0BB5RwP9qBeV4XqjYZ363eVcqgw3pf42j/Ao0HpPHA7L
         mlpp4lPV6WC9Fmybv7sumvnEDbDhQI16EubQ0mhf+MX+n7+r0ovazuyjaoVNMYIfgZiM
         tDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BAn7H856GfFRIZFIPVXMWyj53npckuCFDy0OCv3VUpA=;
        b=DGteqy7aIATBpYef3xjOxIAK9afn6i4NHkpIKpjToXD+z8F1eIVkAzLMGw388b7FTY
         Llnz9srFMve5vDdt+xxQkN/5gNfPCPtbu/Bw49J5VHx5QAriosyDUJnaFz/mfwzrimjy
         FwtCgZ1LJUniVG3F6b/K57qLJIRzjkwthZufECy888zlvsdtM8UcAe1r//qjTOdNK23m
         mkbg7bb5n3UyPnZiC1DG99beE7eAxvVk56/y6MJf9nxD3rr73f7igBhuz5HZU0CaY/Gu
         mS382a+vkWsHNrxtw3VZjPj1ksOSjsOHSgNr47lu5obYNDj9nlcfxUChk1A3iE7gzG/7
         iUdA==
X-Gm-Message-State: AJIora8hu+NTv9UiTfKZ/aC8u91ZQWKudS8G7TAU3KNasBIJCqs+D4ud
        xiBwb65/G5ej5uEZH//QfkfGpA==
X-Google-Smtp-Source: AGRyM1tVufJHyD7qAM2njRRF0qbXtYAbqkVJD/3FnkNNHjFwWDejKXalAn22BDebBg99Lz1Y+vUkXw==
X-Received: by 2002:a05:6512:4006:b0:47f:912d:1400 with SMTP id br6-20020a056512400600b0047f912d1400mr18533386lfb.466.1656938298236;
        Mon, 04 Jul 2022 05:38:18 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512214b00b0047fbc399ad2sm5008363lfr.245.2022.07.04.05.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:38:17 -0700 (PDT)
Message-ID: <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
Date:   Mon, 4 Jul 2022 14:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704100028.19932-9-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 12:00, Tinghan Shen wrote:
> Add power domains controller node for mt8195.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>  1 file changed, 327 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 8d59a7da3271..d52e140d9271 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/power/mt8195-power.h>
>  
>  / {
>  	compatible = "mediatek,mt8195";
> @@ -338,6 +339,332 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		scpsys: syscon@10006000 {
> +			compatible = "syscon", "simple-mfd";

These compatibles cannot be alone.

> +			reg = <0 0x10006000 0 0x1000>;
> +			#power-domain-cells = <1>;

If it is simple MFD, then probably it is not a power domain provider.
Decide.

Best regards,
Krzysztof
