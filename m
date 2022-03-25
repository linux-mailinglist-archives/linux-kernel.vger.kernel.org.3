Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58634E785D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359329AbiCYPtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiCYPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:49:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD983879E;
        Fri, 25 Mar 2022 08:47:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r13so11408763wrr.9;
        Fri, 25 Mar 2022 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=I0UNyg7SfBu7IB1Z/cqaLgfxg/zRvB23e6ickTd/N9Y=;
        b=JTtWFtj/0KLA/PTK/TZYRCNDaXJche2t4L3ZOXbW/ASrtI0gMPSIgluwBd7+xGt+2x
         uwYq4/keJ3jHhn3eS7NiBtlNNmcj0KTEl/7+GCRHRKYMCqEK/9lfLNbXhjGyxRtlnPGD
         Pv3eHAoIUewOFQHVYlo/P79AqwCh4rZwFQu7C6x5PyuwAqtluq6sVq0HJpOkJqtzR7l+
         sqbuHjfxnEa/6RlVWvfqUPq1reL0T+2MyGNcH7BEmixjJFpkZ3ts6prhiJvoDOWa+st9
         7rJ3/zxFXTS9XGET1yRuZrIwH1u8nNghL9KkJYaAEaSotDo/qYfhVunHhnURGQRw2c7p
         qNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=I0UNyg7SfBu7IB1Z/cqaLgfxg/zRvB23e6ickTd/N9Y=;
        b=8RRGOBURSpqcWTNgo5+zQzwEuNt67zDnQaWEv06OJQCTuWglFFRzca41sRb0oUQ02h
         +986fNwW0nrluF1XUDw1Yhb4pl6jQ7Mc5mHgVLAaOQ2pWTGa+NuWKf04K7NnjrZfUDtt
         T+XCVSHws/LYdbvYa9OI8Ws3gRDlRf0B1eoVVKpcfZzmAEOG1tRh5sPkVhwZ1IvkISx+
         Dm5y1ybragxyuLjBCk47If8WXrl8skHsjhYvsaPTDxN56ekW02rx8e5Xi/x+E4BqyOYw
         A21tMauDu5lroyiI7MIhdIon3jH/MOApIijPT/7wP2V3PFMdE6+M9hWOOIc443gtKQSU
         RSeA==
X-Gm-Message-State: AOAM532meZD6elWqBGfkQ8vVZyqd48RNVVZw7A+mQ9wg4d+XCOjIyTrt
        +DHTHATf6XoUSUZy9Lq/DOs=
X-Google-Smtp-Source: ABdhPJwlWs6hYo1HdTyCT7cOb+sHkPRysj8SXKISJJLWLFm5ARhQ9NWiMthV08TCaO5RdTX5ZL7tKg==
X-Received: by 2002:adf:f28d:0:b0:203:f161:55ac with SMTP id k13-20020adff28d000000b00203f16155acmr9718468wro.209.1648223258190;
        Fri, 25 Mar 2022 08:47:38 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0038cbd8c41e9sm7504769wmq.12.2022.03.25.08.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:47:37 -0700 (PDT)
Message-ID: <09b8c4d2-6cdd-b41b-4913-f9f2f7f4d7c7@gmail.com>
Date:   Fri, 25 Mar 2022 16:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-19-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 18/22] arm64: dts: mt8192: Add display nodes
In-Reply-To: <20220318144534.17996-19-allen-kh.cheng@mediatek.com>
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
> Add display nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 111 +++++++++++++++++++++++
>   1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a77d405dd508..59183fb6c80b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1205,6 +1205,13 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		mutex: mutex@14001000 {
> +			compatible = "mediatek,mt8192-disp-mutex";
> +			reg = <0 0x14001000 0 0x1000>;
> +			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;

We are missing power-domains property.

> +		};
> +
>   		smi_common: smi@14002000 {
>   			compatible = "mediatek,mt8192-smi-common";
>   			reg = <0 0x14002000 0 0x1000>;
> @@ -1236,6 +1243,110 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   		};
>   
> +		ovl0: ovl@14005000 {
> +			compatible = "mediatek,mt8192-disp-ovl";
> +			reg = <0 0x14005000 0 0x1000>;
> +			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
> +				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +		};
> +
> +		ovl_2l0: ovl@14006000 {
> +			compatible = "mediatek,mt8192-disp-ovl-2l";
> +			reg = <0 0x14006000 0 0x1000>;
> +			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> +			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
> +				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;

olv and ovl-2l binding mention that the node should be a sibling of mmsys, but 
this does not hold anymore, correct? Chun-Kuang can you help to fix the binding 
description?

> +		};
> +
> +		rdma0: rdma@14007000 {
> +			compatible = "mediatek,mt8192-disp-rdma";
> +			reg = <0 0x14007000 0 0x1000>;
> +			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +			iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
> +			mediatek,larb = <&larb0>;
> +			mediatek,rdma-fifo-size = <5120>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;

Same here, bindings says it should be a sibling of mmsys. Apart from that the 
maximal rdma-fifo-size isn't specified for all SoCs including mt1892.

> +		};
> +
> +		color0: color@14009000 {
> +			compatible = "mediatek,mt8192-disp-color",
> +				     "mediatek,mt8173-disp-color";
> +			reg = <0 0x14009000 0 0x1000>;
> +			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +		};

Same here, binding description needs fixed, please check for other bindings as 
well. The node here looks good.

> +
> +		ccorr0: ccorr@1400a000 {
> +			compatible = "mediatek,mt8192-disp-ccorr";
> +			reg = <0 0x1400a000 0 0x1000>;
> +			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +		};
> +
> +		aal0: aal@1400b000 {
> +			compatible = "mediatek,mt8192-disp-aal",
> +				     "mediatek,mt8193-disp-aal";
> +			reg = <0 0x1400b000 0 0x1000>;
> +			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +		};
> +
> +		gamma0: gamma@1400c000 {
> +			compatible = "mediatek,mt8192-disp-gamma",
> +				     "mediatek,mt8183-disp-gamma";
> +			reg = <0 0x1400c000 0 0x1000>;
> +			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +		};
> +
> +		postmask0: postmask@1400d000 {
> +			compatible = "mediatek,mt8192-disp-postmask";
> +			reg = <0 0x1400d000 0 0x1000>;
> +			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
> +			iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;

No iommus mentioned in binding description.

Regards,
Matthias

> +		};
> +
> +		dither0: dither@1400e000 {
> +			compatible = "mediatek,mt8192-disp-dither",
> +				     "mediatek,mt8183-disp-dither";
> +			reg = <0 0x1400e000 0 0x1000>;
> +			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +		};
> +
> +		ovl_2l2: ovl@14014000 {
> +			compatible = "mediatek,mt8192-disp-ovl-2l";
> +			reg = <0 0x14014000 0 0x1000>;
> +			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
> +			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
> +				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +		};
> +
> +		rdma4: rdma@14015000 {
> +			compatible = "mediatek,mt8192-disp-rdma";
> +			reg = <0 0x14015000 0 0x1000>;
> +			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
> +			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
> +			mediatek,rdma-fifo-size = <2048>;
> +		};
> +
>   		dpi0: dpi@14016000 {
>   			compatible = "mediatek,mt8192-dpi";
>   			reg = <0 0x14016000 0 0x1000>;
