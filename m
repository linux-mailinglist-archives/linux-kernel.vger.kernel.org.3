Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707E24E9248
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiC1KGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiC1KGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:06:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37644831A;
        Mon, 28 Mar 2022 03:04:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i4so745972wrb.5;
        Mon, 28 Mar 2022 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=w0gi+Frmfwv6pI0qBdERwm+Cbi6QM6IQXSRFjrbcfug=;
        b=kQHITV+JGbKQJy9TuxCR5sZAJ9kCNLLHKbW0o55RlD1u43C9sSCaJntZKJte8RWUha
         DCGoo4fUQAZbt2OFEd4Tqkl4CC9VufWgLNEW8NGkwyxTrLMg7sY7x9aEm60SX2QXzFhN
         DZe6GpOnQ//uO6/jL6JGj2IHZnSCkHxke+t5oVqKz/roMbaaSJXFKxWZS42hiiABlhy0
         uLTWmTaeRpH1B1YxEkqROXVXOElRtnvPtCWvG0k98FZagw6HC65sdFeQHPqxaQk2c9Fi
         2/H92vCMhvQKlNUzbx1JhDP25Vt0xP6QU/2mJYdErxep4MJg1ZjzJs9ov1oFBHroAbl2
         hBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=w0gi+Frmfwv6pI0qBdERwm+Cbi6QM6IQXSRFjrbcfug=;
        b=29Z2XOipavUhftiaPlhFtwK5DXLgGRQLS0jIpToD65jF7i2ptfFQwLWln9BHeaXvwq
         oh9Xl5e3AizlBRJ+gakDpwoOV/4TyMJyEWlMZSCCdJBBPirPdCyS90kzLtO4Tk+u4lNS
         Gh/D80nCN2E0Su12wxUGw0xFOmylTGrEcuXr879NUTWJoGsn2hPhRZOru/yxgzK71dCu
         4/b62KKflWn93IVVONg0zyShysqKx/mPqzsTloq2NG3St5oMMAhiGfeXz+zjme7f/NVb
         9gHRs8rA4uh4YlZunz1KWJTkc43Zp7xToXdcK52G/7g9T7bcaixfdlv38m0Y3NF25u4O
         9iZQ==
X-Gm-Message-State: AOAM531FulM6W56Rz0hKV5ll2oBBJiisGXMf54qOQLZqospMogrq4J8l
        XBfWBQ8Pv3GkbYGLUw1Z/M8=
X-Google-Smtp-Source: ABdhPJx9WTNFXW7pS4zRjh6gtGJUlmrRn6gqGy4PASWBkOYvHvIe9hXkX7nloYIM6i5L971wl9PiQQ==
X-Received: by 2002:adf:ec41:0:b0:1ed:beee:6f8f with SMTP id w1-20020adfec41000000b001edbeee6f8fmr21852065wrn.110.1648461874336;
        Mon, 28 Mar 2022 03:04:34 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d63c5000000b002040822b680sm17338776wrw.81.2022.03.28.03.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 03:04:33 -0700 (PDT)
Message-ID: <982b4085-6bc2-54bf-d417-65e5fbeba4c2@gmail.com>
Date:   Mon, 28 Mar 2022 12:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 18/22] arm64: dts: mt8192: Add display nodes
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
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
 <09b8c4d2-6cdd-b41b-4913-f9f2f7f4d7c7@gmail.com>
In-Reply-To: <09b8c4d2-6cdd-b41b-4913-f9f2f7f4d7c7@gmail.com>
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



On 25/03/2022 16:47, Matthias Brugger wrote:
> 
> 
> On 18/03/2022 15:45, Allen-KH Cheng wrote:
>> Add display nodes for mt8192 SoC.
>>
>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 111 +++++++++++++++++++++++
>>   1 file changed, 111 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> index a77d405dd508..59183fb6c80b 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> @@ -1205,6 +1205,13 @@
>>               #clock-cells = <1>;
>>           };
>> +        mutex: mutex@14001000 {
>> +            compatible = "mediatek,mt8192-disp-mutex";
>> +            reg = <0 0x14001000 0 0x1000>;
>> +            interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> 
> We are missing power-domains property.
> 
>> +        };
>> +
>>           smi_common: smi@14002000 {
>>               compatible = "mediatek,mt8192-smi-common";
>>               reg = <0 0x14002000 0 0x1000>;
>> @@ -1236,6 +1243,110 @@
>>               power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>>           };
>> +        ovl0: ovl@14005000 {
>> +            compatible = "mediatek,mt8192-disp-ovl";
>> +            reg = <0 0x14005000 0 0x1000>;
>> +            interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&mmsys CLK_MM_DISP_OVL0>;
>> +            iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
>> +                 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +        };
>> +
>> +        ovl_2l0: ovl@14006000 {
>> +            compatible = "mediatek,mt8192-disp-ovl-2l";
>> +            reg = <0 0x14006000 0 0x1000>;
>> +            interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
>> +            iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
>> +                 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> 
> olv and ovl-2l binding mention that the node should be a sibling of mmsys, but 
> this does not hold anymore, correct? Chun-Kuang can you help to fix the binding 
> description?
> 

Forget about the sibling problem I mentioned, the problem is my poor English not 
the binding description.

Regards,
Matthias

>> +        };
>> +
>> +        rdma0: rdma@14007000 {
>> +            compatible = "mediatek,mt8192-disp-rdma";
>> +            reg = <0 0x14007000 0 0x1000>;
>> +            interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&mmsys CLK_MM_DISP_RDMA0>;
>> +            iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
>> +            mediatek,larb = <&larb0>;
>> +            mediatek,rdma-fifo-size = <5120>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> 
> Same here, bindings says it should be a sibling of mmsys. Apart from that the 
> maximal rdma-fifo-size isn't specified for all SoCs including mt1892.
> 
>> +        };
>> +
>> +        color0: color@14009000 {
>> +            compatible = "mediatek,mt8192-disp-color",
>> +                     "mediatek,mt8173-disp-color";
>> +            reg = <0 0x14009000 0 0x1000>;
>> +            interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_COLOR0>;
>> +        };
> 
> Same here, binding description needs fixed, please check for other bindings as 
> well. The node here looks good.
> 
>> +
>> +        ccorr0: ccorr@1400a000 {
>> +            compatible = "mediatek,mt8192-disp-ccorr";
>> +            reg = <0 0x1400a000 0 0x1000>;
>> +            interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_CCORR0>;
>> +        };
>> +
>> +        aal0: aal@1400b000 {
>> +            compatible = "mediatek,mt8192-disp-aal",
>> +                     "mediatek,mt8193-disp-aal";
>> +            reg = <0 0x1400b000 0 0x1000>;
>> +            interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_AAL0>;
>> +        };
>> +
>> +        gamma0: gamma@1400c000 {
>> +            compatible = "mediatek,mt8192-disp-gamma",
>> +                     "mediatek,mt8183-disp-gamma";
>> +            reg = <0 0x1400c000 0 0x1000>;
>> +            interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
>> +        };
>> +
>> +        postmask0: postmask@1400d000 {
>> +            compatible = "mediatek,mt8192-disp-postmask";
>> +            reg = <0 0x1400d000 0 0x1000>;
>> +            interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
>> +            iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
> 
> No iommus mentioned in binding description.
> 
> Regards,
> Matthias
> 
>> +        };
>> +
>> +        dither0: dither@1400e000 {
>> +            compatible = "mediatek,mt8192-disp-dither",
>> +                     "mediatek,mt8183-disp-dither";
>> +            reg = <0 0x1400e000 0 0x1000>;
>> +            interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_DITHER0>;
>> +        };
>> +
>> +        ovl_2l2: ovl@14014000 {
>> +            compatible = "mediatek,mt8192-disp-ovl-2l";
>> +            reg = <0 0x14014000 0 0x1000>;
>> +            interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
>> +            iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
>> +                 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
>> +        };
>> +
>> +        rdma4: rdma@14015000 {
>> +            compatible = "mediatek,mt8192-disp-rdma";
>> +            reg = <0 0x14015000 0 0x1000>;
>> +            interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>> +            clocks = <&mmsys CLK_MM_DISP_RDMA4>;
>> +            iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
>> +            mediatek,rdma-fifo-size = <2048>;
>> +        };
>> +
>>           dpi0: dpi@14016000 {
>>               compatible = "mediatek,mt8192-dpi";
>>               reg = <0 0x14016000 0 0x1000>;
