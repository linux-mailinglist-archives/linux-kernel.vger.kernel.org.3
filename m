Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA949E1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbiA0MGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:06:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52058 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiA0MGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:06:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EB6AA1F45144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643285165;
        bh=KrGpftmLi1FF1CiPpBG1DBzyj0E2RJBuG57h3VcIVqE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E2EHxsny6nKNscCTsPSC5fsxEOPE620ib7WYwNE4Vix+tQkVtmdUmMQHD600jJib8
         FtqLI0jR4fvm7zEg4p50Vk3tUrAPizqWzj0LtrDdRc2X2lrx8o2dmzdydM7W+N1cfQ
         BGGqtm08mIe2R1YYMH81em8GJmEjGwyC2cziiBwH6I25e8Ku+bgm+zcW8Qa5otEZnx
         XRgVSrEejNi+DOngQD6W6a6tZlFI5j0UPYhdRKD8R1s8Te8QCCcEhXLGdFTk+F9FJt
         h0gJ6v3Evae6zgqrOfKE2clXE1zRAIl2bdQJCL9+l7PV3+nyL96YxEkWZ1oYo6q78O
         02mAOEcxbMo3g==
Subject: Re: [PATCH] arm64: dts: mt8195: add display node for vdosys0
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        maciej.szmigiero@oracle.com, David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org,
        chunfeng.yun@mediatek.com, Seiya Wang <seiya.wang@mediatek.com>,
        moudy.ho@mediatek.com, roy-cw.yeh@mediatek.com,
        nancy.lin@mediatek.com, singo.chang@mediatek.com,
        Macpaul.Lin@mediatek.com
References: <20220126093340.18792-1-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <3d5e8c74-958f-0d43-0579-ee07dff9ee58@collabora.com>
Date:   Thu, 27 Jan 2022 13:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220126093340.18792-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/01/22 10:33, jason-jh.lin ha scritto:
> Add display node for vdosys0.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> This patch depends on series [1]
> [1] Add Mediatek Soc DRM (vdosys0) support for mt8195
> - https://patchwork.kernel.org/project/linux-mediatek/list/?series=608548
> 
> This patch is based on [2][3][4]
> [2] arm64: dts: Add mediatek SoC mt8195 and evaluation board
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20220112114724.1953-4-tinghan.shen@mediatek.com/
> [3] arm64: dts: mt8195: add IOMMU and smi nodes
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20210615173233.26682-15-tinghan.shen@mediatek.com/
> [4] arm64: dts: mt8195: add gce node
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20220126090109.32143-1-jason-jh.lin@mediatek.com/
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 123 +++++++++++++++++++++++
>   1 file changed, 123 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index d778ca598d18..cc3a9e898c77 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1067,5 +1067,128 @@
>   			reg = <0 0x1b000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
> +
> +		ovl0: disp_ovl@1c000000 {

Please be consistent with the other SoC DTs: call this ovl@1c000000

> +			compatible = "mediatek,mt8195-disp-ovl",
> +				     "mediatek,mt8192-disp-ovl";
> +			reg = <0 0x1c000000 0 0x1000>;
> +			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
> +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;
> +		};
> +
> +		rdma0: disp_rdma@1c002000 {

...this is just rdma

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
> +		color0: disp_color@1c003000 {

color@...

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
> +		ccorr0: disp_ccorr@1c004000 {

ccorr@...

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
> +		aal0: disp_aal@1c005000 {

aal@...

> +			compatible = "mediatek,mt8195-disp-aal",
> +				     "mediatek,mt8173-disp-aal";
> +			reg = <0 0x1c005000 0 0x1000>;
> +			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_AAL0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
> +		};
> +
> +		gamma0: disp_gamma@1c006000 {

gamma@...

> +			compatible = "mediatek,mt8195-disp-gamma",
> +				     "mediatek,mt8173-disp-gamma";
> +			reg = <0 0x1c006000 0 0x1000>;
> +			interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_GAMMA0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x6000 0x1000>;
> +		};
> +
> +		dither0: disp_dither@1c007000 {

dither@....

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
> +		dsc0: disp_dsc_wrap@1c009000 {

dsc@...

> +			compatible = "mediatek,mt8195-disp-dsc";
> +			reg = <0 0x1c009000 0 0x1000>;
> +			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DSC_WRAP0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x9000 0x1000>;
> +		};
> +
> +		merge0: disp_vpp_merge0@1c014000 {

merge@...

> +			compatible = "mediatek,mt8195-disp-merge";
> +			reg = <0 0x1c014000 0 0x1000>;
> +			interrupts = <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_VPP_MERGE0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c01XXXX 0x4000 0x1000>;
> +		};
> +
> +		mutex: disp_mutex0@1c016000 {

mutex@....

> +			compatible = "mediatek,mt8195-disp-mutex";
> +			reg = <0 0x1c016000 0 0x1000>;
> +			reg-names = "vdo0_mutex";
> +			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
> +			clock-names = "vdo0_mutex";
> +			mediatek,gce-events =
> +				 <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
> +		};
> +
> +		vdosys0: syscon@1c01a000 {
> +			compatible = "mediatek,mt8195-vdosys0", "syscon";
> +			reg = <0 0x1c01a000 0 0x1000>;
> +			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdosys1: syscon@1c100000 {
> +			compatible = "mediatek,mt8195-vdosys1", "syscon";
> +			reg = <0 0x1c100000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
>   	};
>   };
> 

Regards,
Angelo
