Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB964E32AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiCUWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCUWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:37:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D1B39F01F;
        Mon, 21 Mar 2022 15:25:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 20AC01F43C7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647901122;
        bh=1sqTrDjOkqq6nhvO+rMH2CwIada0wuStpXssjUi/8w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7gu6PM9fr515U684oxy99kT87ovDMMDzVviJOUWGtZQ/ekA5Ws0NebYVdCQmfR6y
         m1zvhh0mFqIgxa+hNYdeC0c4WfUo9YjmuTDDeO+QbxaAU5vqw7bFvkX7BVOG/uMT5m
         0HdaDl0bjsGj1kqtI8VbpfKFpaCMztjA+ydGI1mkkPnUfSY3YN0cT0XhT1Sd59wC15
         +MPledpN5JtzEFXCB4s+IKzwJbDqqo5PWm1bbPlON4yrmsF66q8b57fswO5JHokRQY
         3Hw/PfNHhgw+Ktgpbie2FAyL8zlCVfkt/VAseHPsMpfSrFBfq3L83otOidVALn5erT
         kiHwnCgJHEoBg==
Date:   Mon, 21 Mar 2022 18:18:36 -0400
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
Subject: Re: [PATCH v4 22/22] arm64: dts: mt8192: Add pwm node
Message-ID: <20220321221836.li7ylxe2w3pbopk3@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-23-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-23-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:34PM +0800, Allen-KH Cheng wrote:
> Add pwm node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index f0f0f067c023..ea98b2230f18 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -625,6 +625,17 @@
>  			status = "disabled";
>  		};
>  
> +		pwm0: pwm@1100e000 {
> +			compatible = "mediatek,mt8183-disp-pwm";
> +			reg = <0 0x1100e000 0 0x1000>;
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#pwm-cells = <2>;
> +			clocks = <&topckgen CLK_TOP_DISP_PWM_SEL>,
> +				 <&infracfg CLK_INFRA_DISP_PWM>;
> +			clock-names = "main", "mm";
> +			status = "disabled";
> +		};
> +
>  		spi1: spi@11010000 {
>  			compatible = "mediatek,mt8192-spi",
>  				     "mediatek,mt6765-spi";
> -- 
> 2.18.0
> 
> 
