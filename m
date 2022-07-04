Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72A565599
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiGDMjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiGDMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:39:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2311115B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:39:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v9so10906519ljk.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x880kuS6PNUF918Mktd1de/5BgyubBGYBWa3z9pZQa8=;
        b=Q1X8I1wKoipJvnCB/pUw1wiyXOfTGXV/Nce3Mgckmw5ubtkVsRjwxbMsqpkJm3xiEv
         +CvpKh3gKUq0c8sZYrc06FqHc7ANjERfslK4wf8ysBEN+unfPS0eA773kfKt4Af2FpaW
         R7LjUDuBKj8FRN4n+KdITPsrCdWA25m+GGLpGzelaTKyLPFTxD08NdWl7/+f1g0Zn+kO
         kRzfaeEbMcE8Ut6YeIYVUR0tSWxf6wzAR9qzveYFBRykOGJxwesuJsx/xyPMybmhfvj5
         efN3SuCztUGrs4cxI/7g9tbEBiQo1p4AfDn2w7oOuFhtYOkf5n9LhBsdoPhlr9n+yTN6
         XGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x880kuS6PNUF918Mktd1de/5BgyubBGYBWa3z9pZQa8=;
        b=rgr4zbst6Fx+Sx60IB9dha7JtojIhVwWSZmCe9kBXR+umD3FW5QGkzWcKqSKkFmXbQ
         WXrn0Ly3iZaXL4kCR1plCBQ347yOCUA1Fjk7fvXFOZMgNL0Ef8//q1iRZ4EAnFhXDLU0
         vp9+xbccOv1YVpXH9t5gATE5GsTKxoK+qUlE8YHu6zfMGWjMPOK35t09OEOBz3X951nW
         7ltVAqLiUoQnONcKeqDNlrWNKM4v0OTDkAm8CScDtY2uU9SurBO+9e2xa4wqgtXvsyJe
         npSO4ABJnL7eL7mijGN3fCdS/Pc+1DdicnqEfY/fuMEm3M/I4NwPj4/rCsYzWP3nn2GV
         nV3Q==
X-Gm-Message-State: AJIora+6XxgGtCGTB3oYHS7/YAaVU4hSD4XTqucUsvHx7lt6IPbEZLFg
        YlOxyWFCcP9mRYYZZBFpuzipWw==
X-Google-Smtp-Source: AGRyM1vqUXvSAsn7AogRlPoSUu3j3CYCJPTYiSe4MRhkAljhqJZmpSrBqVZa8ahYb+Kd5xySXteurQ==
X-Received: by 2002:a2e:730b:0:b0:25c:63cf:1ffd with SMTP id o11-20020a2e730b000000b0025c63cf1ffdmr8410032ljc.208.1656938388417;
        Mon, 04 Jul 2022 05:39:48 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id p11-20020a056512234b00b0047f6b4a53cdsm5104577lfu.172.2022.07.04.05.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:39:47 -0700 (PDT)
Message-ID: <27c8f7b1-c308-89c2-54be-2d6c1a5527b8@linaro.org>
Date:   Mon, 4 Jul 2022 14:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 16/16] arm64: dts: mt8195: Add display node for vdosys0
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
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-17-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704100028.19932-17-tinghan.shen@mediatek.com>
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

On 04/07/2022 12:00, Tinghan Shen wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Add display node for vdosys0 of mt8195.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 109 +++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 724c6ca837b6..faea8ef33e5a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1961,6 +1961,7 @@
>  		vdosys0: syscon@1c01a000 {
>  			compatible = "mediatek,mt8195-mmsys", "syscon";
>  			reg = <0 0x1c01a000 0 0x1000>;
> +			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
>  			#clock-cells = <1>;
>  		};
>  
> @@ -1976,6 +1977,114 @@
>  			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
>  		};
>  
> +		ovl0: ovl@1c000000 {
> +			compatible = "mediatek,mt8195-disp-ovl",
> +				     "mediatek,mt8183-disp-ovl";
> +			reg = <0 0x1c000000 0 0x1000>;
> +			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
> +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;
> +		};
> +
> +		rdma0: rdma@1c002000 {
> +			compatible = "mediatek,mt8195-disp-rdma";
> +			reg = <0 0x1c002000 0 0x1000>;
> +			interrupts = <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_RDMA0>;
> +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x2000 0x1000>;
> +		};
> +
> +		color0: color@1c003000 {
> +			compatible = "mediatek,mt8195-disp-color",
> +				     "mediatek,mt8173-disp-color";
> +			reg = <0 0x1c003000 0 0x1000>;
> +			interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_COLOR0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x3000 0x1000>;
> +		};
> +
> +		ccorr0: ccorr@1c004000 {
> +			compatible = "mediatek,mt8195-disp-ccorr",
> +				     "mediatek,mt8192-disp-ccorr";
> +			reg = <0 0x1c004000 0 0x1000>;
> +			interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_CCORR0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x4000 0x1000>;
> +		};
> +
> +		aal0: aal@1c005000 {
> +			compatible = "mediatek,mt8195-disp-aal",
> +				     "mediatek,mt8183-disp-aal";
> +			reg = <0 0x1c005000 0 0x1000>;
> +			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_AAL0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
> +		};
> +
> +		gamma0: gamma@1c006000 {
> +			compatible = "mediatek,mt8195-disp-gamma",
> +				     "mediatek,mt8183-disp-gamma";
> +			reg = <0 0x1c006000 0 0x1000>;
> +			interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_GAMMA0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x6000 0x1000>;
> +		};
> +
> +		dither0: dither@1c007000 {
> +			compatible = "mediatek,mt8195-disp-dither",
> +				     "mediatek,mt8183-disp-dither";
> +			reg = <0 0x1c007000 0 0x1000>;
> +			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_DITHER0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x7000 0x1000>;
> +		};
> +
> +		dsc0: dsc@1c009000 {
> +			compatible = "mediatek,mt8195-disp-dsc";
> +			reg = <0 0x1c009000 0 0x1000>;
> +			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DSC_WRAP0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x9000 0x1000>;
> +		};
> +
> +		merge0: merge0@1c014000 {

Generic node name.

> +			compatible = "mediatek,mt8195-disp-merge";
> +			reg = <0 0x1c014000 0 0x1000>;
> +			interrupts = <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_VPP_MERGE0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c01XXXX 0x4000 0x1000>;
> +		};
> +
> +		mutex: mutex0@1c016000 {

Generic node name.

> +			compatible = "mediatek,mt8195-disp-mutex";
> +			reg = <0 0x1c016000 0 0x1000>;
> +			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
> +			mediatek,gce-events =
> +				 <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
> +		};
> +
>  		larb0: larb@1c018000 {
>  			compatible = "mediatek,mt8195-smi-larb";
>  			reg = <0 0x1c018000 0 0x1000>;


Best regards,
Krzysztof
