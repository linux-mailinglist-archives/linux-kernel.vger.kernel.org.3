Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615DC5314BB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiEWPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbiEWPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:31:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735626AFE;
        Mon, 23 May 2022 08:31:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 215921F438C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653319889;
        bh=V2ecxk+Ic8I9lhk6UyREKjNhm0bjbq7zRjgV1eRfoPQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iA8dbTtZduTsJ1u+r0/w4AwH+apYH0sXiICKHMKpnhE+3/4xtilH1NdmwrxZiQXIE
         K05jpZSpUgvekYEMWKgjFPYRS1UV4NWoSjE4hJ9Ex77REtbwpW/sI4K0OJ+66yDTiI
         Xnvn3rLjz+haR22S6jXsyCIYkTKjF+K7ufr8tiXuYKRw+ayvnKxpyOa/Nvz7ClOTeP
         ChS2IYBg/a3avNT+QvsPG51xxy3dkyHz3cFIBPDb0WbZhhe9/Gs7NMkejsDITQGs0S
         DYEoAfUx5EPIWLodJWvqoJ5jQc3ZxzBbZUBE5uFpqnznRwUe83WcDO0JAQbiaj//ub
         LLjG85NOS00cw==
Message-ID: <8a0f7ab0-e814-0908-d4b3-99540994db3e@collabora.com>
Date:   Mon, 23 May 2022 17:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v16 3/4] dts: arm64: mt8183: add Mediatek MDP3 nodes
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com
References: <20220520083006.27789-1-moudy.ho@mediatek.com>
 <20220520083006.27789-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220520083006.27789-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 10:30, Moudy Ho ha scritto:
> Add device nodes for Media Data Path 3 (MDP3) modules.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 79 +++++++++++++++++++++++-
>   1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index fc6ac2a46324..5b6c18f51787 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1389,6 +1389,50 @@
>   			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>   		};
>   
> +		mdp3_rdma0: mdp3-rdma0@14001000 {

Are these phandles necessary?
I don't think that any machine will ever override these... and in case this will be
needed in the future, we can always add them later.

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
> +		mdp3_rsz0: mdp3-rsz0@14003000 {
> +			compatible = "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14003000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_RSZ0>;
> +		};
> +
> +		mdp3_rsz1: mdp3-rsz1@14004000 {
> +			compatible = "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14004000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
> +		};
> +
> +		mdp3_wrot0: mdp3-wrot0@14005000 {
> +			compatible = "mediatek,mt8183-mdp3-wrot";
> +			reg = <0 0x14005000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_WROT0>;
> +			iommus = <&iommu M4U_PORT_MDP_WROT0>;
> +		};
> +
> +		mdp3_wdma: mdp3-wdma@14006000 {
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
> @@ -1513,7 +1557,33 @@
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
> @@ -1538,6 +1608,13 @@
>   			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>   		};
>   
> +		mdp3_ccorr: mdp3-ccorr@1401c000 {

Same comment applies here too.

Cheers,
Angelo

> +			compatible = "mediatek,mt8183-mdp3-ccorr";
> +			reg = <0 0x1401c000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xc000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_CCORR>;
> +		};
> +
>   		imgsys: syscon@15020000 {
>   			compatible = "mediatek,mt8183-imgsys", "syscon";
>   			reg = <0 0x15020000 0 0x1000>;

