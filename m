Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74753EA96
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiFFOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbiFFOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:32:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2208913F61;
        Mon,  6 Jun 2022 07:32:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38D496601E94;
        Mon,  6 Jun 2022 15:32:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654525938;
        bh=YMYIIOjdr7X3xgwUiFiBZS3Co4/RxQgCOo0x434ptFE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T8KWPtQKbM+lkmGY0j+8VgnQys9vQH8Fyd2an0W04VCW9bsCAddlaI0zF/fqgHQzQ
         mBXQdV0nNgS4PZhqX+Uiks0E46zyNJytUkQ7hKmBQi2I5C6l+oyE61SU/xJcRf46yx
         OxTv7DUL3Ci3D9jlc21E+dyqt7MpnOM9vI0xC6SfTXB9ZRiq0QrUONZJHRbydTcuXk
         1GLkxJL2oHvX/p3UQYQH4pE6JFuK2k/boWb+u7pmNrj9CVxcmn74K2LWlIwPVynuXr
         vqzWnw6Y0HFpziWY82HxloJ+2SLipB86z+lqfr71BdBUXdJ4xDIATSHmLGTvOM+piQ
         3Ol27qkGt6uIw==
Message-ID: <287b7d3a-a412-0ec9-7be0-c17f3da782b6@collabora.com>
Date:   Mon, 6 Jun 2022 16:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8195: add pwm node
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220531114544.144785-1-fparent@baylibre.com>
 <20220531114544.144785-2-fparent@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220531114544.144785-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/05/22 13:45, Fabien Parent ha scritto:
> MT8195's PWM IP has 4 PWM blocks.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

I've verified that the binding is actually right - and it is, the MT8183
data is a perfect match with MT8195.

In any case, there are at least a few MT8195 boards on which the PWM controller
is not used (only the disp-pwm one is used), so please set this node as disabled
by default, after which, you get my:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index d076a376bdcc..366543f27a99 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -367,6 +367,21 @@ pwrap: pwrap@10024000 {
>   			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
>   		};
>   
> +		pwm0: pwm@10048000 {
> +			compatible = "mediatek,mt8195-pwm",
> +				     "mediatek,mt8183-pwm";
> +			reg = <0 0x10048000 0 0x1000>;
> +			#pwm-cells = <2>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PWM_H>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM1>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM2>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM3>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM4>;
> +			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
> +				      "pwm4";
> +		};
> +
>   		scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8195-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
> 


