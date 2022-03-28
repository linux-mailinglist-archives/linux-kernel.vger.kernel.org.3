Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24B4E92FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiC1LI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiC1LIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:08:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065955224;
        Mon, 28 Mar 2022 04:06:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a1so19805486wrh.10;
        Mon, 28 Mar 2022 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5zRnuOddM/pnWASo81ZkoEvRnzsP8QPd1DZ1UKdPT4s=;
        b=TvR0RF4TSiqYGppaBCf3IX0Ss0m3JX0VcGIFPCXzP3QMvO6MmzrY6msrSb0inupxxS
         ecyJfWtZUcxFWt3sQsvtuHHccIPyaGdqtcvOuWJx3w4tgn49DyGAxEegJB4xF4gfo/xb
         F85fJG/tPjNn7mMNSrPaBItoYbIbs2XCNPgP+svEYUttrmrN1J+Px7lsmKO59WOB+XAd
         5eOtnGF5GY4yMTAXsYOyP5RsPo2YkD1IqWw5x0do+FlZj8icNXksB4NtcLPhlk+9XkFp
         7bzfYW2FYnSoFvU42nMltjFqnbCzqvIcjU6/o/X7QQjLZ+oJhhaP2/JokNTumxlmHnh/
         wKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5zRnuOddM/pnWASo81ZkoEvRnzsP8QPd1DZ1UKdPT4s=;
        b=cIK+EswJnWtH69hv2PScXp8AjU/y8V+bsopDKhJ93Cz5HFps5W4gwLiIh27tYbW+qu
         ijqnoDebj+zvhbZVeTdxYAtv+aRCPSCjLypXpjNZedFvnrQ9I4F22v1WvCBrQr0CMy2m
         On/qlaM6Z+tqvAHwvip/fKiR7QRuB8X5BKvXmLVjzfuhhEnIRzPtUphxuFofONVIMGlh
         jQmi47Nkdy1VX65WYQLGBruxfQMeWevEKoPeerL4+j4i9OO+ZzswkaXV2GmCxQDUq7Xz
         KGwsNI3OLz+31uD4T+bN26yy7IPBWkPERLsd5zqK3GcTMlvZr6YzdBOx7rckcZ0Dug47
         yo7A==
X-Gm-Message-State: AOAM533JDBbAl1TKNis/YpQtCZrDzaNESGhgFrwrNG7ehyPG1KQaGw0f
        6DpAQpvZVnXNP2P0hzVn1cc=
X-Google-Smtp-Source: ABdhPJx7rpc/toOY4+iILxDNjbBaHiG5lJc9/4OUSNSkreGSfS2g+0AIDa2rLFDWRYiR8xh8/HtdcQ==
X-Received: by 2002:adf:e744:0:b0:204:213:ae40 with SMTP id c4-20020adfe744000000b002040213ae40mr23462516wrn.344.1648465598948;
        Mon, 28 Mar 2022 04:06:38 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0038cbcbcf994sm11873706wmq.36.2022.03.28.04.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 04:06:38 -0700 (PDT)
Message-ID: <c62c29d1-e373-a0f2-482b-98c70cf22b4b@gmail.com>
Date:   Mon, 28 Mar 2022 13:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 21/22] arm64: dts: mt8192: Add gce info for display
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
 <20220318144534.17996-22-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-22-allen-kh.cheng@mediatek.com>
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
> Add gce info for display nodes
> - It's required to get drivers' CMDQ support
> 

What keeps us from adding that in the display nodes in patch 18/22 of this 
series? When doing so, please mention in the commit message that we then need to 
add the GCE to the mmsys node.

Regards,
Matthias

> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 08e0dd2483d1..f0f0f067c023 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1203,6 +1203,9 @@
>   		mmsys: syscon@14000000 {
>   			compatible = "mediatek,mt8192-mmsys", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
> +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
>   		};
> @@ -1212,6 +1215,8 @@
>   			reg = <0 0x14001000 0 0x1000>;
>   			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
>   			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
> +					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
>   		};
>   
>   		smi_common: smi@14002000 {
> @@ -1253,6 +1258,7 @@
>   			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
>   				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
>   		};
>   
>   		ovl_2l0: ovl@14006000 {
> @@ -1263,6 +1269,7 @@
>   			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
>   			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
>   				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
>   		};
>   
>   		rdma0: rdma@14007000 {
> @@ -1274,6 +1281,7 @@
>   			mediatek,larb = <&larb0>;
>   			mediatek,rdma-fifo-size = <5120>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
>   		};
>   
>   		color0: color@14009000 {
> @@ -1283,6 +1291,7 @@
>   			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
>   		};
>   
>   		ccorr0: ccorr@1400a000 {
> @@ -1291,6 +1300,7 @@
>   			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
>   		};
>   
>   		aal0: aal@1400b000 {
> @@ -1300,6 +1310,7 @@
>   			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
>   		};
>   
>   		gamma0: gamma@1400c000 {
> @@ -1309,6 +1320,7 @@
>   			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>   		};
>   
>   		postmask0: postmask@1400d000 {
> @@ -1318,6 +1330,7 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
>   			iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
>   		};
>   
>   		dither0: dither@1400e000 {
> @@ -1327,6 +1340,7 @@
>   			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
>   		};
>   
>   		dsi0: dsi@14010000 {
> @@ -1351,6 +1365,7 @@
>   			clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
>   			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
>   				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
>   		};
>   
>   		rdma4: rdma@14015000 {
> @@ -1361,6 +1376,7 @@
>   			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
>   			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
>   			mediatek,rdma-fifo-size = <2048>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
>   		};
>   
>   		dpi0: dpi@14016000 {
