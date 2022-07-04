Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694105652B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiGDKoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiGDKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:44:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55152647;
        Mon,  4 Jul 2022 03:44:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62B6766015A6;
        Mon,  4 Jul 2022 11:44:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656931450;
        bh=gjNEsUi0SsF/6vtg4n8Tc6Jg9gWEjEsUA2sD8bp3x9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CioOKrpDBDzPBsG3sOxB6gSfHCwZY7y8rfYurcXucgtbNanLuZyEK65ugGX2LLs4V
         dFKRiesAMYgxiR47wQvDPJBuBmt3S/nD8IeQWXNnLvdnnYIFDESGu0b5o+6DQDSx22
         lc0gNcxYvD+zaz+qQS4DA6vBz/s6u+i6BKT5KnWjHv8FTNh5sIDZffjdxdZqZV3j0d
         OddSGfq5JlDhU6UWuMb75zhx69WQbzMPSCSmLu8ArrCKdV0wU9SpI4aEjTSPTyxFkB
         soyVnShjmhFu8A+ArMUl7Akqabr6UYyPG2qQqN9FTNJkDlual7BTuzAmndoUYsWB7R
         IRmJE2yXMbbwA==
Message-ID: <84ce9b03-9edd-9ef1-aec1-127b34c23021@collabora.com>
Date:   Mon, 4 Jul 2022 12:44:06 +0200
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
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-17-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220704100028.19932-17-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/07/22 12:00, Tinghan Shen ha scritto:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Add display node for vdosys0 of mt8195.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 109 +++++++++++++++++++++++
>   1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 724c6ca837b6..faea8ef33e5a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1961,6 +1961,7 @@
>   		vdosys0: syscon@1c01a000 {
>   			compatible = "mediatek,mt8195-mmsys", "syscon";
>   			reg = <0 0x1c01a000 0 0x1000>;
> +			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
>   			#clock-cells = <1>;
>   		};
>   
> @@ -1976,6 +1977,114 @@
>   			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
>   		};
>   
> +		ovl0: ovl@1c000000 {
> +			compatible = "mediatek,mt8195-disp-ovl",
> +				     "mediatek,mt8183-disp-ovl";

This fits in one line, please fix, here and all of the other instances of that.

> +			reg = <0 0x1c000000 0 0x1000>;
> +			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
> +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;

Same for gce-client-reg.

Regards,
Angelo
