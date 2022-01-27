Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9895A49DF49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiA0KYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:24:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50156 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiA0KYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:24:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1788A1F44FF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643279084;
        bh=gjQ9eUgUEeaQAmTYpCOWfZW2UjC1PUR8v4+9IjLVhOI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FkRivsz71o7K1peXx1QazJy6vo2p/1GUA8JJi6DoHiZ7Ppp9OfV5i+GCR0bJ82l5X
         5rRB2ecrJbLsbGZtvWF7jL5sK4W4rhtfZmuqJxbbWW0JfgoeFceq3YvHXwPCR6SDCL
         ezUwB/ESZkqlCk/+4ela5+KvRtewn4n9pZnJgD6d1HomD8qRoNTw2F5ja2vAdwLu0H
         dG3exMi67BDESxpmeZ55SlC/dbnig6A/tmijR6hOCU9Od/N0chNkO/+Vd6AvxjW8q+
         uHhchAwz4ia1Q7+bjc/vDS3CMxX4oxvgEgcp0ugKNugcUp2yTSqyqKabHZ6CnPMd94
         GeZPnvDx0Dm3g==
Subject: Re: [PATCH] arm64: dts: mt8195: add gce node
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
References: <20220126090109.32143-1-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <15d12a78-b8e2-f2f6-9bb0-9e501f245b94@collabora.com>
Date:   Thu, 27 Jan 2022 11:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220126090109.32143-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/01/22 10:01, jason-jh.lin ha scritto:
> Add gce node and gce alias on mt8195 dts file.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> This patch is based on [1]
> 
> [1] arm64: dts: Add mediatek SoC mt8195 and evaluation board
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20220112114724.1953-4-tinghan.shen@mediatek.com/
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index a363e82f6988..d778ca598d18 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -6,6 +6,7 @@
>   
>   /dts-v1/;
>   #include <dt-bindings/clock/mt8195-clk.h>
> +#include <dt-bindings/gce/mt8195-gce.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/phy/phy.h>
> @@ -18,6 +19,11 @@
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	aliases {
> +		gce0 = &gce0;
> +		gce1 = &gce1;
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -367,6 +373,22 @@
>   			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
>   		};
>   
> +		gce0: mdp_mailbox@10320000 {

Just "mailbox" is fine.
		gce0: mailbox@10320000 {

> +			compatible = "mediatek,mt8195-gce";
> +			reg = <0 0x10320000 0 0x4000>;
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#mbox-cells = <2>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_GCE>;
> +		};
> +
> +		gce1: disp_mailbox@10330000 {

Same here, please.

After that,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +			compatible = "mediatek,mt8195-gce";
> +			reg = <0 0x10330000 0 0x4000>;
> +			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#mbox-cells = <2>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
> +		};
> +
>   		scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8195-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
> 
