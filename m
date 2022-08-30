Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53C5A5EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiH3JNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiH3JN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:13:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C18CE330
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:13:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m7so5723082lfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=85ddw98iKNFdMuScvqYcAwOPIMZilnqs6BhTFJ5fmQo=;
        b=RxXyqq8+0Sxkf95IUpCyHZevRPKgc/uV5kRhgHRSayzKqoncb1jP95k6uoqpB+Q7Ih
         XbDvlK7PdYc4wBljUVJm4e7bC6hgCSPMsCRiqAQT5lD/IYU2O6yQR6uF29h0OwYG5Jft
         lW+dJJNbBhSClZ4dtreIM5qESkCbodSoEsmYEC0Jt0OghwP+Au7FMDroyDf9vY38R105
         jANwEVyNnrniE9bcocSlxFMaPHqTTp+j+S5uXy9c/c7zsy9JKWQK2j1uet5Td2os0RoZ
         hWLBySci78bEdowzZO29kvGhhxBSGFoGJHHxxIFzHWfj9GK78HFt/hsI9rADW/JLcgVD
         Iilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=85ddw98iKNFdMuScvqYcAwOPIMZilnqs6BhTFJ5fmQo=;
        b=gn3l/ZlOFDjxc8DV/B45gNukV6giwMOddmUcIFny1u8orLvZv5NbarT3hBg6znQSVF
         KARXSB88TBMhOYqFGPsHX21QnkJny/JmQwWy0ykj+jdHVTH3PHRhOqNz1t/hOvMRl+4B
         9XONnzEJVLVfouDyb3+BrTQ9fwC1mB5bFTEkXgKiMBX1pybZrYgt0hJ00RWSQTeTET+S
         5JJFrrUg9vzd2t1FJh6Ae8beI9jMF765wWxcBCuTE+TIi5fLgYQiEjflf8uWkD7W0MM/
         Yw9ABlX9JgB/kCeziqkG4UYu3dnEFnrIW/4UvEv4a2T28pyocbaanEISAjQKvjOvWrR1
         mMYA==
X-Gm-Message-State: ACgBeo15M36iUwaprGg3B+v1A0LDTMHFefFOnqQNPdNYp74KCqMjntHX
        5FNCkhqgkxSSnIaZXQ2ANNMBdw==
X-Google-Smtp-Source: AA6agR6Epke9TZidjS+t7TVXu/nI8IDXuv2Zcj4qF33M58gVrL9aocLEX9bOQfB3mw2k5CxN4EZ2zg==
X-Received: by 2002:a05:6512:4012:b0:492:c667:c899 with SMTP id br18-20020a056512401200b00492c667c899mr7177797lfb.48.1661850799778;
        Tue, 30 Aug 2022 02:13:19 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id v1-20020a05651203a100b0049482adb3basm11931lfp.63.2022.08.30.02.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:13:19 -0700 (PDT)
Message-ID: <e668a86b-f47b-bc42-440a-a74591827ccb@linaro.org>
Date:   Tue, 30 Aug 2022 12:13:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/3] arm64: dts: Modify gamma compatible for mt8195
Content-Language: en-US
To:     "zheng-yan.chen" <zheng-yan.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220830063929.13390-1-zheng-yan.chen@mediatek.com>
 <20220830063929.13390-4-zheng-yan.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830063929.13390-4-zheng-yan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 09:39, zheng-yan.chen wrote:
> Modify gamma compatible for mt8195.

Commit should explain why. "What" we all can easily see.
> 
> Fixes: 16590e634f1d ("arm64: dts: mt8195: Add display node for vdosys0")

Your patchset is not bisectable and might cause ABI break. I doubt that
it matches the criteria of backports, especially that you did not
describe here bug being fixed.

Drop the tag and explain reasons for ABI break.

> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index a50ebb5d145f..d4110f6fac62 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2022,7 +2022,7 @@
>  		};
>  
>  		gamma0: gamma@1c006000 {
> -			compatible = "mediatek,mt8195-disp-gamma", "mediatek,mt8183-disp-gamma";
> +			compatible = "mediatek,mt8195-disp-gamma";
>  			reg = <0 0x1c006000 0 0x1000>;
>  			interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;


Best regards,
Krzysztof
