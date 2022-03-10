Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36F94D4523
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiCJKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241458AbiCJKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:54:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9902D7087F;
        Thu, 10 Mar 2022 02:53:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 70CF21F454C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646909587;
        bh=/gNWVadDfDGHqNyl7lJyNQZh6ChwEINYUFyIGatCL1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AGV3VigDWxu0PfehGZ2acLaX+HM0VeKT3xlJoPRA6pxisHTKZUbrEmzSW9Jrzwfqk
         cVncWHKPaXKR/u9m9paG+QZxjyyCe67geLsp3EgoZ0dd06LCTfzKJC4d7yviicTnzE
         JthQlmrJNZBZjaXDV486nsWQeXnt20hA+EgwmbPEq2INHfNox7yS5uBDSR7XrfI028
         eWCBlBdYnyFZANqf8VzT+xBDf7lVW3TpUscXIDxEWSr/UI1CwFp5EjvPjxr/DWPizN
         VCLLsM4JmYf8XCMQucjmDVQbpHTpU6/N8wlClJEy33dotHvE10bnC2H9OwQ8EYjNL7
         ZXbABZYumsrxQ==
Message-ID: <b9404776-b5c7-7321-f352-1995dafa1565@collabora.com>
Date:   Thu, 10 Mar 2022 11:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v14 22/22] arm64: dts: mt8195: add display node for
 vdosys1
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220310035515.16881-1-nancy.lin@mediatek.com>
 <20220310035515.16881-23-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220310035515.16881-23-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/03/22 04:55, Nancy.Lin ha scritto:
> Add display node for vdosys1.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 223 +++++++++++++++++++++++
>   1 file changed, 223 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index dbca699bba05..e650ec759235 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi


..snip..

> +
> +		ethdr0: ethdr@1c114000 {
> +			compatible = "mediatek,mt8195-disp-ethdr";
> +			reg = <0 0x1c114000 0 0x1000>,
> +			      <0 0x1c115000 0 0x1000>,
> +			      <0 0x1c117000 0 0x1000>,
> +			      <0 0x1c119000 0 0x1000>,
> +			      <0 0x1c11A000 0 0x1000>,
> +			      <0 0x1c11B000 0 0x1000>,
> +			      <0 0x1c11C000 0 0x1000>;

Hello Nancy,
looks like you partially forgot to use lower-case hex here...

0x1c11a000 0x1c11b000 0x1c11c000

> +			reg-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
> +				    "vdo_be", "adl_ds";
> +			mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0x4000 0x1000>,
> +						  <&gce0 SUBSYS_1c11XXXX 0x5000 0x1000>,
> +						  <&gce0 SUBSYS_1c11XXXX 0x7000 0x1000>,
> +						  <&gce0 SUBSYS_1c11XXXX 0x9000 0x1000>,
> +						  <&gce0 SUBSYS_1c11XXXX 0xA000 0x1000>,
> +						  <&gce0 SUBSYS_1c11XXXX 0xB000 0x1000>,
> +						  <&gce0 SUBSYS_1c11XXXX 0xC000 0x1000>;

...and here too: 0xa000 0xb000 0xc000

Please fix that, after which, you can add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +			clocks = <&vdosys1 CLK_VDO1_DISP_MIXER>,
> +				 <&vdosys1 CLK_VDO1_HDR_VDO_FE0>,
> +				 <&vdosys1 CLK_VDO1_HDR_VDO_FE1>,
> +				 <&vdosys1 CLK_VDO1_HDR_GFX_FE0>,
> +				 <&vdosys1 CLK_VDO1_HDR_GFX_FE1>,
> +				 <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
> +				 <&vdosys1 CLK_VDO1_26M_SLOW>,
> +				 <&vdosys1 CLK_VDO1_HDR_VDO_FE0_DL_ASYNC>,
> +				 <&vdosys1 CLK_VDO1_HDR_VDO_FE1_DL_ASYNC>,
> +				 <&vdosys1 CLK_VDO1_HDR_GFX_FE0_DL_ASYNC>,
> +				 <&vdosys1 CLK_VDO1_HDR_GFX_FE1_DL_ASYNC>,
> +				 <&vdosys1 CLK_VDO1_HDR_VDO_BE_DL_ASYNC>,
> +				 <&topckgen CLK_TOP_ETHDR>;
> +			clock-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
> +				      "vdo_be", "adl_ds", "vdo_fe0_async", "vdo_fe1_async",
> +				      "gfx_fe0_async", "gfx_fe1_async","vdo_be_async",
> +				      "ethdr_top";
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +			iommus = <&iommu_vpp M4U_PORT_L3_HDR_DS>,
> +				 <&iommu_vpp M4U_PORT_L3_HDR_ADL>;
> +			interrupts = <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH 0>; /* disp mixer */
> +			resets = <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE0_DL_ASYNC>,
> +				 <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE1_DL_ASYNC>,
> +				 <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE0_DL_ASYNC>,
> +				 <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE1_DL_ASYNC>,
> +				 <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_BE_DL_ASYNC>;
> +		};
> +
>   	};
>   };

