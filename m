Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD954E77D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378576AbiCYPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378880AbiCYP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:26:00 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF3673EE;
        Fri, 25 Mar 2022 08:22:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id r1so6434806qvr.12;
        Fri, 25 Mar 2022 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Nr3DeqonwwMb9/SDbQnlHBzrqz5hNGIQ0bi9+OQD5LE=;
        b=I8ihO790T510KhQJWcw/xy+FXCvvY800WdiGxnAuxv+9UIxYIcbk5qRfa96ASujkqD
         YnLZBrFUJdko3+qJHqcLnJ8YKCVn03Dt9d/vk7FYZbZJjzTmr8cfAe80fjbtx2Ufao3T
         g820Zhc8CIFXmNolov7zEknYK3M08mP4OzHHiE0lBjG7BC+7SM0opObd0cvKjoEXz0O6
         xw68ll2dP6cmRcgZjAA3QlD8qZ7zRsT3iMwzMmmUcEg1U+DEVYbuQtxaqW9Ol/yqDS+s
         roA+gOkfJ8pbbZrGvRTH+Lk4oWUoJW/uGpdSgoCZwV4eulIV/XjaAfPm4rjAk1aFmxhI
         tO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nr3DeqonwwMb9/SDbQnlHBzrqz5hNGIQ0bi9+OQD5LE=;
        b=i3OeIKmIUd/cfGjY0FV1+PjiS5Y1vWtMj0PZmJxZeXq1w8Zrsak7891SuAEtAuiq3H
         sy3qqgM87fUS3lLI1WgqQ33HTbCWhTJ6WS4Xfm1EFDDcCBkTW/vSFFPcKVfSIAabIYAe
         S+UZUzEuiDwBpvCVr3O0qO7kWO6cIRbaPoITeIFPhQk8dRqQQqWmGqgxdKRfwg9m1dPT
         X/kbXgWMgpYoqiJPSgRPbOA/YR2p0n2aa/ERgxb45AK/PJbx2w1ouL7Vh05o1ooIQWWF
         RJUIMu5rQPVZsJj2fZzRl1CQ8zIO3SWd0I+MYMgu03UDSrcm7+oBozWZRGyvHzjLYO99
         6NqQ==
X-Gm-Message-State: AOAM5313k4E5NMLx/+p3TngrfwxE9VGv5ltrSyBzXC6WNdYYxRYWOpfy
        eV6gN/rZczn09fJg/VI7pZ4=
X-Google-Smtp-Source: ABdhPJytk6+Rgin+foiO9o9b3FUr7XdAI6fUfyHnb/q+96PuY8usYRfj3OG1kDe0fWKXu9O0cBZuiw==
X-Received: by 2002:ad4:5a11:0:b0:441:1485:33ff with SMTP id ei17-20020ad45a11000000b00441148533ffmr9233225qvb.127.1648221748311;
        Fri, 25 Mar 2022 08:22:28 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j8-20020a05622a038800b002e236535929sm5327375qtx.32.2022.03.25.08.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:22:27 -0700 (PDT)
Message-ID: <70350446-9e89-3c7b-d515-22cb2ed5a9ca@gmail.com>
Date:   Fri, 25 Mar 2022 16:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 16/22] arm64: dts: mt8192: Add vcodec lat and core
 nodes
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
 <20220318144534.17996-17-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-17-allen-kh.cheng@mediatek.com>
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
> Add vcodec lat and core nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 61 ++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 63893779b193..71ad3adeed51 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1285,6 +1285,67 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
>   		};
>   
> +		vcodec_dec: vcodec-dec@16000000 {
> +			compatible = "mediatek,mt8192-vcodec-dec";
> +			reg = <0 0x16000000 0 0x1000>;	/* VDEC_SYS */
> +			mediatek,scp = <&scp>;
> +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0 0 0 0x16000000 0 0x26000>;
> +
> +			vcodec_lat: vcodec-lat@10000 {
> +				compatible = "mediatek,mtk-vcodec-lat";
> +				reg = <0x0 0x10000 0 0x800>;		/* VDEC_MISC */
> +				interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
> +				iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
> +					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
> +					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
> +					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
> +					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
> +					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
> +					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
> +					 <&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
> +				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +					 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +					 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> +					 <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
> +					 <&topckgen CLK_TOP_MAINPLL_D4>;
> +				clock-names = "vdec-sel", "vdec-soc-vdec", "vdec-soc-lat",
> +					      "vdec-vdec", "vdec-top";

Clock names do not match binding description. We have superfluous "vdec-" 
prefix. Same holds for mtk-vcodec-core. Anway I applied that patch as the driver 
does not care about the clock name. In any case it would be good if you could 
send a follow-up patch to fix the clock name.

Applied, thanks

> +				assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
> +				assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
> +				power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
> +			};
> +
> +			vcodec_core: vcodec-core@25000 {
> +				compatible = "mediatek,mtk-vcodec-core";
> +				reg = <0 0x25000 0 0x1000>;	/* VDEC_CORE_MISC */
> +				interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
> +				iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_UFO_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_PP_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_PRED_RD_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_PRED_WR_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_PPWRAP_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_TILE_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_VLD_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
> +					 <&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
> +				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +					 <&vdecsys CLK_VDEC_VDEC>,
> +					 <&vdecsys CLK_VDEC_LAT>,
> +					 <&vdecsys CLK_VDEC_LARB1>,
> +					 <&topckgen CLK_TOP_MAINPLL_D4>;
> +				clock-names = "vdec-sel", "vdec-soc-vdec", "vdec-soc-lat",
> +					      "vdec-vdec", "vdec-top";
> +				assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
> +				assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
> +				power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
> +			};
> +		};
> +
>   		larb5: larb@1600d000 {
>   			compatible = "mediatek,mt8192-smi-larb";
>   			reg = <0 0x1600d000 0 0x1000>;
