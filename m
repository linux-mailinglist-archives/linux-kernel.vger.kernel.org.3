Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3174E573B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiCWRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiCWRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:17:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8367484B;
        Wed, 23 Mar 2022 10:15:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so254013wms.1;
        Wed, 23 Mar 2022 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oJQgROgJhAs1zSxE1mRh4y4eh7NMgOw/yWHgMuFN26I=;
        b=mIn5e6gAwLR5fDT8jPEigoygRWKOZzU/RGVaiTkiHDSNcImPNYdagX20DR3b1BPQnz
         A5OyFHQNmCzjzZGWJcEd2UE5HJnJdPz4px9EqJdrNmxmR4YVsjsoIEzWe8bVLchlWjEV
         KX0LTmh5mEJTBVR3OPe1PFpsH9mZu1TerF3m260/0Yz0j/jEesCTTaahD8KbDHQPrpek
         I21mlCuEE0L9YtlsscXN3rFaIxL5G8pobQaGC+ibhZDOPo3IrJdPnV2Awrmv8d5ZYSC+
         wvQ2hedNDq0VJjAFOMtFxvt3uiYwdNKymoLDN7afSMr4Y8r6XevbfxMDAkgWQ8uNNUIb
         uQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oJQgROgJhAs1zSxE1mRh4y4eh7NMgOw/yWHgMuFN26I=;
        b=TnFrWYyUoB2ES1ZrjC8QFTToO8D4DNt02wJLzLpfogn8GQyRUm36npPtv35nqCcW0k
         VcPtDs+gcLWGXWzqSOKX8mR9ruWz5EqHhHF6R8QrM/lz8QDHOtTsZGV0hNCRmoCgEOpG
         G1lG9z89Lasv0fEsq110p6I7lgld599nYv4gsYgrkapAaxZFU0fAIWlYhR4V3FyC5G4k
         NL8Cd3fQs6EmU+tjc378W7kxAvLFgRCGbMYTTWcgcBM6WSzA3i5BaSgC6G9k5fNycL+z
         cY09nskvDn9SO7zM90GDu7pjhr3bODXY9aDOZ47kB34gYkwyPcFpWrHk9GMZB4Lh7eMp
         8cmQ==
X-Gm-Message-State: AOAM532Dr7/BGeTVJ5YJdNGXZ7np81sTgdB7pEOGaTvvFQfmgzqXzX4I
        YXJvffUzZF9TCSURBBTAORs=
X-Google-Smtp-Source: ABdhPJygYOPyQCoOA2LIJK6393T7O0XcTeprcQYnp4XDZQbgdlmkYUc4J0aKPLXB2HNYh3cMi0w2Qw==
X-Received: by 2002:a05:600c:190c:b0:38c:ca19:1bb7 with SMTP id j12-20020a05600c190c00b0038cca191bb7mr2502374wmq.152.1648055737123;
        Wed, 23 Mar 2022 10:15:37 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d64cc000000b00203d45bfbc7sm408022wri.7.2022.03.23.10.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:15:36 -0700 (PDT)
Message-ID: <3bddd48b-95c2-de20-3aa2-0f6f3ebffd3e@gmail.com>
Date:   Wed, 23 Mar 2022 18:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 01/22] arm64: dts: mt8192: Add pwrap node
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
 <20220318144534.17996-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Add pwrap node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied

Thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 411feb294613..76428599444e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -523,6 +523,18 @@
>   			clock-names = "clk13m";
>   		};
>   
> +		pwrap: pwrap@10026000 {
> +			compatible = "mediatek,mt6873-pwrap";
> +			reg = <0 0x10026000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_PMIC_AP>,
> +				 <&infracfg CLK_INFRA_PMIC_TMR>;
> +			clock-names = "spi", "wrap";
> +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
> +		};
> +
>   		scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
