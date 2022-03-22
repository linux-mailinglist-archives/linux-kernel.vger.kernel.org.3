Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9319F4E4780
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiCVUaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiCVUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:30:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950166632;
        Tue, 22 Mar 2022 13:28:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 89B281F431E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647980911;
        bh=1CkcBWcFLWap6uKtAh1dSlwHTFBzBqGJJwNqC1b53nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHjlpq/kg6OUyZsGSXY47+FiRpjGpYfOtwTS/cXDajteWi2DMGrrBKg6pE/7K3lit
         s9yP6YOd5Z4JxBuQVUJz+kAgLusobcFRv9lDwH28EGDMoA+7RN16Ix6MUdm58yNVHf
         Kp4mrq/U/GI837iIIhkn9SmYVZxWeYqFq5fKAn2FAU53c7oH1QMIBFK94w8MDS4MIN
         s80J5IKqlHe0us25z6HONWFDRaFRuc89AK082yO3eQY4EUGOObsSjOL4jGXZdFa1py
         aA7ig2syp6EBtOxAz1HJEdiv8M8P+S/6LSv4WOe+/3YrtpSHUfNU0j3vVPW2ksnoJi
         lq6cazoWPVLTQ==
Date:   Tue, 22 Mar 2022 16:28:26 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 04/22] arm64: dts: mt8192: Add SCP node
Message-ID: <20220322202826.64kwisnka5xq64vc@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-5-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-5-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:16PM +0800, Allen-KH Cheng wrote:
> Add SCP node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 9e1b563bebab..195d50894df4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -706,6 +706,18 @@
>  			status = "disabled";
>  		};
>  
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8192-scp";
> +			reg = <0 0x10500000 0 0x100000>,
> +			      <0 0x10700000 0 0x8000>,
> +			      <0 0x10720000 0 0xe0000>;
> +			reg-names = "sram", "l1tcm", "cfg";
> +			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_SCPSYS>;
> +			clock-names = "main";
> +			status = "disabled";
> +		};
> +
>  		nor_flash: spi@11234000 {
>  			compatible = "mediatek,mt8192-nor";
>  			reg = <0 0x11234000 0 0xe0>;
> -- 
> 2.18.0
> 
> 
