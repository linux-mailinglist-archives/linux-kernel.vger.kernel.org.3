Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76054B435
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiFNPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbiFNPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:09:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA63EEE35;
        Tue, 14 Jun 2022 08:09:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so172686wma.1;
        Tue, 14 Jun 2022 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Nl9p8XiHK5AtOeQObHfkqzSF21Df3dWTIZeLDSP3Cys=;
        b=dHlU4MVJUMyBYrekjMq6Vhyud157on1z+2yR09M4IAhjQ9PvH+Oyazf1HRmDFwP9Px
         qx793ASDm4UaOMFcmoziBQ2g7bDIt3xm61ZAVAB0QeGlURjEg9vEA4/3585aWLgXgCXi
         xBotswPEPmHsxDHkZhf1mamS6sSxFBvUXuBF60MBtLdKs5KFiyg08RUI7snMi08keLfp
         nZLi2TkdvSO2DgkN0yRrnuZGECpZC2dITErT/lxeliM6wjqOEZ2BWErkrBMLkWv9ikFB
         GFiX1aRcXXwXc73EUpaRGiOAV7BIzD3NzTk5lB+ygJGXDN6l0hVkXpKe2JmRdhP2psXN
         tOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nl9p8XiHK5AtOeQObHfkqzSF21Df3dWTIZeLDSP3Cys=;
        b=lggMpqjISov9E942KMvWhVKVTJvhQ2h+Q06ccWTPITRLlY5QPRYIvjQNEIJIESb+rI
         FKlXe6bb1IMb6K3CV4AyUVEI9GuqtK2CDnTKk/9LIxLpcsc1ja+YjSR4Mu2WyxL/Cgre
         771FBcaykU98Jux8hKWCkOpkmohR+vQOCUGIfKjxv2029gAzT27WNVywCTvxuqGJjcpC
         z/67dlhL06nHZ7wtLqNp6tXgIQGqpbsnGMVltE0zxO8uzbxdZ42qm3CDY4KfbfeTvlx9
         bZ1qCwQQL/xYzsjgFA+BNsoK+zNwIyl81H+GWyQEerDv48gTwOOHdKAgBwsCOeRCa+GF
         YbNA==
X-Gm-Message-State: AOAM53387XNsNiO5UOncRVHb9dJv5zqOgJCWkTZPlQ0GWODY8s+2pEqB
        iBzejiJF3kTj20vI0lLC97E=
X-Google-Smtp-Source: ABdhPJyv0qrF9fYVnHKL6koDutsHT/45fh4dzAhBy8tf9jKdyeD9b1maXdCi+EYvCB28F6WOc6tOTw==
X-Received: by 2002:a05:600c:1c88:b0:39d:7299:e295 with SMTP id k8-20020a05600c1c8800b0039d7299e295mr4182748wms.155.1655219353085;
        Tue, 14 Jun 2022 08:09:13 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0039c4d022a44sm14763956wmq.1.2022.06.14.08.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:09:11 -0700 (PDT)
Message-ID: <86c40dc9-c48a-4f42-88ea-7a91b5bb425a@gmail.com>
Date:   Tue, 14 Jun 2022 17:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v18 3/4] dts: arm64: mt8183: add Mediatek MDP3 nodes
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com
References: <20220610064504.8302-1-moudy.ho@mediatek.com>
 <20220610064504.8302-4-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220610064504.8302-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2022 08:45, Moudy Ho wrote:
> Add device nodes for Media Data Path 3 (MDP3) modules.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Looks good to me. I'm ready to take this as soon as 1,2 and 4 got merged.

Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 79 +++++++++++++++++++++++-
>   1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index e74fd253478b..ade5997a9656 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1389,6 +1389,50 @@
>   			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>   		};
>   
> +		mdp3-rdma0@14001000 {
> +			compatible = "mediatek,mt8183-mdp3-rdma";
> +			reg = <0 0x14001000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> +				 <&mmsys CLK_MM_MDP_RSZ1>;
> +			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
> +			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
> +				 <&gce 21 CMDQ_THR_PRIO_LOWEST 0>;
> +		};
> +
> +		mdp3-rsz0@14003000 {
> +			compatible = "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14003000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_RSZ0>;
> +		};
> +
> +		mdp3-rsz1@14004000 {
> +			compatible = "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14004000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
> +		};
> +
> +		mdp3-wrot0@14005000 {
> +			compatible = "mediatek,mt8183-mdp3-wrot";
> +			reg = <0 0x14005000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_WROT0>;
> +			iommus = <&iommu M4U_PORT_MDP_WROT0>;
> +		};
> +
> +		mdp3-wdma@14006000 {
> +			compatible = "mediatek,mt8183-mdp3-wdma";
> +			reg = <0 0x14006000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_WDMA0>;
> +			iommus = <&iommu M4U_PORT_MDP_WDMA0>;
> +		};
> +
>   		ovl0: ovl@14008000 {
>   			compatible = "mediatek,mt8183-disp-ovl";
>   			reg = <0 0x14008000 0 0x1000>;
> @@ -1507,7 +1551,33 @@
>   			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
>   			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>   			mediatek,gce-events = <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
> -					      <CMDQ_EVENT_MUTEX_STREAM_DONE1>;
> +					      <CMDQ_EVENT_MUTEX_STREAM_DONE1>,
> +					      <CMDQ_EVENT_MDP_RDMA0_SOF>,
> +					      <CMDQ_EVENT_MDP_RDMA0_EOF>,
> +					      <CMDQ_EVENT_MDP_RSZ0_SOF>,
> +					      <CMDQ_EVENT_MDP_RSZ1_SOF>,
> +					      <CMDQ_EVENT_MDP_TDSHP_SOF>,
> +					      <CMDQ_EVENT_MDP_WROT0_SOF>,
> +					      <CMDQ_EVENT_MDP_WROT0_EOF>,
> +					      <CMDQ_EVENT_MDP_WDMA0_SOF>,
> +					      <CMDQ_EVENT_MDP_WDMA0_EOF>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_0>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_1>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_2>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_3>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_4>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_5>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_6>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_7>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_8>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_9>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_10>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_11>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_12>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_13>,
> +					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_14>,
> +					      <CMDQ_EVENT_WPE_A_DONE>,
> +					      <CMDQ_EVENT_SPE_B_DONE>;
>   			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x6000 0x1000>;
>   		};
>   
> @@ -1532,6 +1602,13 @@
>   			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>   		};
>   
> +		mdp3-ccorr@1401c000 {
> +			compatible = "mediatek,mt8183-mdp3-ccorr";
> +			reg = <0 0x1401c000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xc000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_CCORR>;
> +		};
> +
>   		imgsys: syscon@15020000 {
>   			compatible = "mediatek,mt8183-imgsys", "syscon";
>   			reg = <0 0x15020000 0 0x1000>;
