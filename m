Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79C4717AA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhLLBgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhLLBgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:36:18 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C6C061714;
        Sat, 11 Dec 2021 17:36:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5C1D742598;
        Sun, 12 Dec 2021 01:36:14 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: apple: t8103: Add watchdog node
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211211124044.4697-1-sven@svenpeter.dev>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <1c094fdc-be38-8c54-8334-23dc4270fe0b@marcan.st>
Date:   Sun, 12 Dec 2021 10:36:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211211124044.4697-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2021 21.40, Sven Peter wrote:
> Add the watchdog node which also enables reboot support on the t8103.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   arch/arm64/boot/dts/apple/t8103.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index fc8b2bb06ffe..6ef28d833e4f 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -199,6 +199,14 @@ pinctrl_nub: pinctrl@23d1f0000 {
>   				     <AIC_IRQ 336 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		wdt: watchdog@23d2b0000 {
> +			compatible = "apple,t8103-wdt", "apple,wdt";
> +			reg = <0x2 0x3d2b0000 0x0 0x4000>;
> +			clocks = <&clk24>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 338 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>   		pinctrl_smc: pinctrl@23e820000 {
>   			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
>   			reg = <0x2 0x3e820000 0x0 0x4000>;
> 

Acked-by: Hector Martin <marcan@marcan.st>

Thanks! Applied to asahi-soc/dt :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
