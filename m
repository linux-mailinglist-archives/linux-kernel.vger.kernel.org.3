Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFC4BB9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiBRM4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:56:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiBRM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91562B4D9F;
        Fri, 18 Feb 2022 04:55:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0D75B1F46724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188954;
        bh=YkLMpSsBe1IVOGgotAXLOXcJ0eSyRqXWWqGIQixSJMY=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=YYKTTPieNptOxsVy76k7+v+tLGltKW1zVx8nyjUug3jxcQiAFxkhGASfRFnmnlM30
         kgjiRsbtOKx1ntIORUi+xgWAvSYGFZmRVnwk1rYKcrhWUAWRI7Th8cBc/eu448PdGx
         D1ue8x5x4NzrL9qfrDzC/eU9DeZyj9nlC2osZjrkozP6flYzuAymzUIYCEuKc2+Py6
         JnHRlx4fnx0LTeHwpqENewz0ioeefXAkNeOboNzzi+LWkkLEogr7UmF7a5wTDt+eTI
         Mv65+quAi5q0GfmNpmmxNwS0HuYbPGLnCMZ0k7Mr67HLbtOFngbISnrMI7VxkHzyz5
         +YFqCDdEpBxvg==
Message-ID: <719c23ae-a8b4-5f0d-6be2-483bb82dbce9@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 12/23] arm64: dts: mt8192: Add efuse node
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
 <20220218091633.9368-13-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-13-allen-kh.cheng@mediatek.com>
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
> Add efuse node for mt8192 SoC
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index f51fd0f6c356..094805db395b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -939,6 +939,20 @@
>   			status = "disabled";
>   		};
>   
> +		efuse: efuse@11c10000 {
> +			compatible = "mediatek,efuse";
> +			reg = <0 0x11c10000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			lvts_e_data1: data1 {

			lvts_e_data1: lvts_data1@1c0 {
				reg = <0x1c0 0x58>;

Please write hex with lower case characters.

> +				reg = <0x1C0 0x58>;
> +			};
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x68>;
> +			};
> +		};
> +
>   		i2c3: i2c@11cb0000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11cb0000 0 0x1000>,


