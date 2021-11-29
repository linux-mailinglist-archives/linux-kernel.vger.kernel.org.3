Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2638B461F92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380052AbhK2Suo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:50:44 -0500
Received: from vps5.brixit.nl ([192.81.221.234]:53226 "EHLO vps5.brixit.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380792AbhK2Ssm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:48:42 -0500
X-Greylist: delayed 697 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 13:48:42 EST
Received: from [192.168.20.102] (unknown [77.239.252.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps5.brixit.nl (Postfix) with ESMTPSA id 702A6618B4;
        Mon, 29 Nov 2021 18:33:44 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: qcom: sdm660-xiaomi-lavender: Add volume up
 button
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Caleb Connolly <caleb@connolly.tech>
References: <20211121170449.1124048-1-danct12@riseup.net>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
Message-ID: <ce775ef5-2e88-af2b-264b-da77a2e23007@postmarketos.org>
Date:   Mon, 29 Nov 2021 21:35:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211121170449.1124048-1-danct12@riseup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/21 8:04 PM, Dang Huynh wrote:
> This enables the volume up key.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
> This patch is a continuation of this series [1]. The other patches in
> the series have been applied and remains this.
> 
> Changes in v5:
> - Remove deprecated input-name property.
> 
> [1]: https://patchwork.kernel.org/cover/12630601/
> 
>   arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> index 9a6684922804..6586b8e47483 100644
> --- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> @@ -9,6 +9,8 @@
>   #include "sdm660.dtsi"
>   #include "pm660.dtsi"
>   #include "pm660l.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
>   
>   / {
>   	model = "Xiaomi Redmi Note 7";
> @@ -33,6 +35,17 @@ vph_pwr: vph-pwr-regulator {
>   		regulator-boot-on;
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		volup {
> +			label = "Volume Up";
> +			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
>   	reserved-memory {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> 

Nice, works on my Redmi Note 7.

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
