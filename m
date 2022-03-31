Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5914ED955
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiCaMJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiCaMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:09:50 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD31F2DDF;
        Thu, 31 Mar 2022 05:08:03 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r8so25020627oib.5;
        Thu, 31 Mar 2022 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GzekprHvhU9HqCe2Q2SnOEP07QMEYok2g4o+xh2TZn4=;
        b=XWnMOZa96XHZi26Qv90uHAyVOPG1F9C3ajBPJi/wzZD0+zyoc2Pj0h8l5HjrUoaBJt
         lrLglpe9ZQ/WLQtJoJ/stUfGSkjHc7u4eJUD7JigH97q2Pp2krOHghCpdL08qVdXsdYF
         7cZMd7pVTVxeBFBpDp3RHSH8y5qIVEG50Hr2I6dQNlAo8aflehlBUZ5yQrseQBgnCBNJ
         ouR+PjilooHqXhbDwxJCdupK+7fCGVvEe5vnZguMucBjlQoVF0/8ZG5sFD1dehI5Lr0t
         P1btM+6KIKaXYx53LYtTU7nMbVIkgeI/YufNTt/a+AMjhpuEkqmHVfic9Y5pFE/gPvlu
         q71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GzekprHvhU9HqCe2Q2SnOEP07QMEYok2g4o+xh2TZn4=;
        b=Bmutt6ugbu4o65YL9nvoUYAPRsQvtxwKUZrVj91lP77mxT5uophz+hSsfwLQEXFvPB
         Pfom0aE4Iod9TVJrc60i5esLIi+qAJnV6/ONvNecHHGY1+R7ljg95wId21KAnZjGd/22
         uOHuAHr3/pBLTkjQqASsnyh8cB1MZanllSzSWUjJtcW9bWAE+wO4zf+EbPeI7DLlfnkM
         +35SEY1PsH3dsRj7+fb/XVC4yC2GO/lKJiAMoN7ptVHBxFcfABV0OXxiE/Gz5LUb9EI7
         678K+DHsw4IQcqCppsPCBmAY90g8xj26UZBb0ne4sOqFKo5lX2JLXEpcaWM7iwuvcbSz
         hA+g==
X-Gm-Message-State: AOAM532QEcHYZKmgR/O/o89wX0CsAsrE5BRkD2mYxDHz8vB2Zwp6Su6x
        +khRfTDRp0icoUfaj/lLGk0=
X-Google-Smtp-Source: ABdhPJwqbyLW/OnZh9P63G9u0hNBlNmj4xyBFk34d0it8CaipwI8ohODOz//5NdFBPTZgUaZH3JvaQ==
X-Received: by 2002:a05:6808:13c9:b0:2f9:2cf0:932a with SMTP id d9-20020a05680813c900b002f92cf0932amr2436272oiw.39.1648728481068;
        Thu, 31 Mar 2022 05:08:01 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c19-20020a9d7853000000b005cdbc0f02ccsm10578954otm.68.2022.03.31.05.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 05:08:00 -0700 (PDT)
Message-ID: <1483ffb9-ef39-0974-10f8-37b7a7a40225@gmail.com>
Date:   Thu, 31 Mar 2022 14:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 3/4] arm64: dts: mt8192: Add H264 venc device node
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
References: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
 <20220330133816.30806-4-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220330133816.30806-4-allen-kh.cheng@mediatek.com>
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



On 30/03/2022 15:38, Allen-KH Cheng wrote:
> Adds H264 venc node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I told you in v4 that I'll apply it, but it's not in the repo. It seemed I 
accidentely dropped that one, so I apply it again now. If you realize something 
like this in the future don't hesitate to tell me :)

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index c1057878e2c6..3d61238fb102 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1166,6 +1166,29 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
>   		};
>   
> +		vcodec_enc: vcodec@17020000 {
> +			compatible = "mediatek,mt8192-vcodec-enc";
> +			reg = <0 0x17020000 0 0x2000>;
> +			iommus = <&iommu0 M4U_PORT_L7_VENC_RCPU>,
> +				 <&iommu0 M4U_PORT_L7_VENC_REC>,
> +				 <&iommu0 M4U_PORT_L7_VENC_BSDMA>,
> +				 <&iommu0 M4U_PORT_L7_VENC_SV_COMV>,
> +				 <&iommu0 M4U_PORT_L7_VENC_RD_COMV>,
> +				 <&iommu0 M4U_PORT_L7_VENC_CUR_LUMA>,
> +				 <&iommu0 M4U_PORT_L7_VENC_CUR_CHROMA>,
> +				 <&iommu0 M4U_PORT_L7_VENC_REF_LUMA>,
> +				 <&iommu0 M4U_PORT_L7_VENC_REF_CHROMA>,
> +				 <&iommu0 M4U_PORT_L7_VENC_SUB_R_LUMA>,
> +				 <&iommu0 M4U_PORT_L7_VENC_SUB_W_LUMA>;
> +			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,scp = <&scp>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
> +			clocks = <&vencsys CLK_VENC_SET1_VENC>;
> +			clock-names = "venc-set1";
> +			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +		};
> +
>   		camsys: clock-controller@1a000000 {
>   			compatible = "mediatek,mt8192-camsys";
>   			reg = <0 0x1a000000 0 0x1000>;
