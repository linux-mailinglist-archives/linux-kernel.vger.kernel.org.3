Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B54BB9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiBRM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:56:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiBRMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:55:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E402B4051;
        Fri, 18 Feb 2022 04:55:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F028E1F469B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188928;
        bh=2LUQyDpX5Lw4Zk25AFu90opTOzaF34SfiATTLW/rmuI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=i+9I4aawRx/vP28TM/rNeFSVFTJ4DqTkaf+7x6MGIbkjO1piJm2Y/BV1ShNZ9a5Tf
         JBpH5svDCtbzAXhndl8l3+/Hm4yh5pGBQ0mQOm8NWfzb8g91qHetjDdnIgIoC6OvHe
         ez1EEh14/pNBWJRGt7wJ10unSrqwb6UoSQ26kJuJzn770HKVXLQ/LkRjv3KE38jz9x
         u1/LK6EHpcKto7qxdAxETnHQ19JmeZMNkV3wZvtqBqPBf9Zq/jQrbcIU8QGAnakAMy
         x/26Zgy/Ylr8FnX5PqGMuwuRhCuhtjnkRWUGUm1UKkXf6vOveJX7nWyaym9/rNrmFX
         T/quI1nZTc3YA==
Message-ID: <3158f868-7ee2-660d-9952-174d33265060@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 02/23] arm64: dts: mt8192: Add pwrap node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-3-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-3-allen-kh.cheng@mediatek.com>
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

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Add pwrap node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index f10a9c75b20c..f58a13b10916 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -523,6 +523,18 @@
>   			clock-names = "clk13m";
>   		};
>   
> +		pwrap: pwrap@10026000 {
> +			compatible = "mediatek,mt6873-pwrap";
> +			reg = <0 0x10026000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_PMIC_AP>,
> +				 <&infracfg CLK_INFRA_PMIC_TMR>;
> +			clock-names = "spi", "wrap";
> +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
> +		};
> +
>   		scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
