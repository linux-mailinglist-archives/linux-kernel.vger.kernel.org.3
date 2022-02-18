Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0B14BB9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiBRM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:56:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiBRM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:01 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F82B4D82;
        Fri, 18 Feb 2022 04:55:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3E1791F46724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188934;
        bh=BRoYVwJM/U76dTqPgt7FwoL/dGJH6kPyI+rQnHeI2Ns=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=YOD1Epml7xZRQSFKg1pgdV4lJIvl9jIZNmlx1Um3pl/rpbvY/JeAxvQsENpDcEhSu
         i0Z1aNX/aC317AcMeghwQ13uaP4H4vqXkFLK1DxDfFxZuOk+CJaUNrZURcea2sAFiT
         n+JVC8kmynuuXjK8LJFGoYQX+h6dH4yL3g50e4X5hdGIL/3KZxsMxqqFX7FCNB4rVY
         ZyQ6EI3zKnfrXoyj8qo1XmSGXMvvULy55hqpuqOvqfGjRVcM54Hsqku9Hxlwnl8bi9
         ngvC0pki1a9jFUfht/DbnS69N/tIvvY5XIViFAYorIR2YTvSs9KvvfXqPPMHueq95x
         HjgubwT7DvmkQ==
Message-ID: <7ce0bf47-b0c9-b6e6-92f3-b7a11b3adfd5@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 06/23] arm64: dts: mt8192: Add usb-phy node
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
 <20220218091633.9368-7-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-7-allen-kh.cheng@mediatek.com>
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
> Add xhci node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 25 ++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 61aadd7bd397..ce18d692175f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -875,6 +875,31 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		u3phy0: usb-phy@11e40000 {
> +			compatible = "mediatek,mt8192-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;

This can be better:
			#address-cells = <1>;

			#size-cells = <1>;
			ranges = <0 0 0x11e40000 0x1000>


> +			status = "okay";
> +
> +			u2port0: usb-phy@11e40000 {

			u2port0: usb-phy@0 {

> +				reg = <0 0x11e40000 0 0x700>;

				reg = <0x0 0x700>;

> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +				status = "okay";
> +			};
> +
> +			u3port0: usb-phy@11e40700 {
> +				reg = <0 0x11e40700 0 0x900>;

			u3port0: usb-phy@700 {
				reg = <0x700 0x900>;

> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +				status = "okay";
> +			};
> +		};
> +
>   		i2c0: i2c@11f00000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11f00000 0 0x1000>,

Thanks,
Angelo
