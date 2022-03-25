Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886D4E71C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353248AbiCYLCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbiCYLCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:02:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52CCC527;
        Fri, 25 Mar 2022 04:01:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a1so10345253wrh.10;
        Fri, 25 Mar 2022 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bOEKS9NzaNyigA185P4is7UM4t5gP2JIN17BW0RY5+s=;
        b=n8rS3kO8VR+Ix6NtEe5TdIXE91acMYCD3GXOqhjgWrR8mXLaWXqmXBAe1bb+H1Sf0S
         ISnTEpWb6e+0GQRr+j5o6Q3Hy0YggpZCUG/b8pY1DV8ltR6iGU0Q1nT5dbZ8pdqBNUgd
         MzUdatrPkqoi7qeUj637BqqU3zlghVeaaZF2UkBMjFpZiFOg2Y9Jd7BBgwMRoXHPyPZY
         rHEHC8gkgbsNo1LaRSqVa4BEHx2S5jx0yqJwkwILxCgHHQxKGfjVvAMxvj8TCBYM5fUj
         0wYNeAjqBITMUFoICpbHI4e0+WqH4E+j29+f+OJ4decUT88Du2y6rGrGnFP+PXt7UK44
         PNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bOEKS9NzaNyigA185P4is7UM4t5gP2JIN17BW0RY5+s=;
        b=cj3mGjHJvSTwmBbVFSFURy0xbrBHX/f3QeD4AhFWbBVHPTN36MT2dZQmMWDakXbJJ8
         1ZN42/NKak7lV4aCwsRiVsc4mfW0rTDNyQgLmxyGjgZJnw7CRoFefsMLr5TtWTxuUyBs
         jClE+ApL2m+WbtbutGctB3+qvQtVeCguR7BC/D+OmFb1W/uk476ppWIATqb3p8qik2gU
         4FjZ9ZCBO+KEd362PKymAy+vLa5yodgfctmHFgCghjYFoqQ/mQ2TVPR4k/Z3puDyI8EE
         J/L83JhZk+3sqGSfO2TROCEkfOMwPvQaQk3YGb5vG3tVNWnGTzjOz/WotQG5yKiT6HLS
         MDQg==
X-Gm-Message-State: AOAM532AZL8B+zKQI0lFILTjxSH8zDse+yaFuKQx2b3lBHeMOj7LfCwJ
        qwQP/Lrn477j/8jDuiXdMr0=
X-Google-Smtp-Source: ABdhPJzTS0dVAANN0EU58IyzAWEKrax/ymEZPW+QqQX8M5RfJXL9GrTasCi1E0w+5zu0fIfozf9gLQ==
X-Received: by 2002:a5d:64cc:0:b0:205:a724:9d1a with SMTP id f12-20020a5d64cc000000b00205a7249d1amr1999689wri.177.1648206072586;
        Fri, 25 Mar 2022 04:01:12 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm4914906wri.4.2022.03.25.04.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 04:01:11 -0700 (PDT)
Message-ID: <6117f51e-d43a-40da-f5a0-7b59c09ac29e@gmail.com>
Date:   Fri, 25 Mar 2022 12:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 15/22] arm64: dts: mt8192: Add H264 venc device node
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
 <20220318144534.17996-16-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-16-allen-kh.cheng@mediatek.com>
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
> Adds H264 venc node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Applied thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 4addf6ddd86d..63893779b193 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1336,6 +1336,29 @@
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
