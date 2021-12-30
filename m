Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13E481BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhL3LQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhL3LQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:16:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95801C061574;
        Thu, 30 Dec 2021 03:16:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j18so49796181wrd.2;
        Thu, 30 Dec 2021 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QJiEW3Than3rNAQomxhEQoj2KzhEMy6qK6t7gwsr+2M=;
        b=HvHh4ijHNsHDvId2hGgky/aPU3nNWF8es4944u4HzdAlAe03sTNPZeaac+m5be6+3O
         LtejdCYXCu587yewIk+PeFKRAZyLyXmkFSJoOe9yjKzZ4gVkYSPxPM9fJc4ihnIWZHir
         oTHXSwxHLeyD4HtU5EPsieyaW+h0F+ZSTj0rZm+nyYK7nQHGt9iWziw7Le2YQ32hkjeE
         0HX/F/zOxxQ5WrqNUHGkZwzOO7/4/HaJMfbWO/EFWTLB4mzTwNj0qMXHNb7PmWKF/lA7
         jfoEw+Zv2dTApwaijFc1ExIlAXHg4UFVm+u44nkptRc5S5vLnCRYiy/A8xm8vnYpbmbC
         Db1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QJiEW3Than3rNAQomxhEQoj2KzhEMy6qK6t7gwsr+2M=;
        b=YZjjYleuuucMyh1/Pezsgh3Jqu1ibtj+k2jdAqDwBjJ+XwfiPM028v2fOsLHm7bt9F
         XLRHettHbBdkAN0vwWw0raAl9RbLPTJxXsJknaQ+vj5pmrfNUorP13FFmRasMenh1Wn7
         Bo854lOzqM5YHNO3YQOOikRnI92yvKYHDk8g/wop8SwJPcq3+HqZnaDhaZDAFATwC4tH
         x7tHna/Gmz2GdOe4GysU9p6Nb34CP0B38ruIyWk0oSIbMx4H/kjhepjk9g4tRyDXXFza
         HQj6Zq353KMnrIxikBeP58q3bs7d4wU83NVcDkIvQAoISIvV0X2RHRA4nBResLQZp7X4
         uxCg==
X-Gm-Message-State: AOAM5302g/E0JZKyp0SJ2lnl3XewXaKbe6TKbo4aOC22IL5m/THIZ1V9
        F+wPC/TvdOpCN5XEyaB8h4zCxtnzyw9Sfg==
X-Google-Smtp-Source: ABdhPJzAMl+79ZfKoM1ZNLCqQyUAb6N3yNKY7N29NsxfWK7w9PU8HOTmyKvUHqLoLn1KDOLK/JOqqQ==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr25032781wry.495.1640862963935;
        Thu, 30 Dec 2021 03:16:03 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id c9sm22553801wml.12.2021.12.30.03.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 03:16:03 -0800 (PST)
Message-ID: <2698260b-43c1-6fbd-b3af-fac01ee48c82@gmail.com>
Date:   Thu, 30 Dec 2021 12:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/4] arm64: dts: mt8183: Add katsu board
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211213162856.235130-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211213162856.235130-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2021 17:28, Hsin-Yi Wang wrote:
> Katsu is known as ASUS Chromebook Detachable CZ1.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> This patch depends on [1] to add Himax8279d MIPI-DSI LCD panel driver.
> 
> [1] https://patchwork.freedesktop.org/patch/462468/
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>   .../dts/mediatek/mt8183-kukui-katsu-sku32.dts | 38 +++++++++++++++++
>   .../dts/mediatek/mt8183-kukui-katsu-sku38.dts | 42 +++++++++++++++++++
>   3 files changed, 82 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 1613259b686576..c130518c3293d5 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -28,6 +28,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu-sku22.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku32.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku38.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
> new file mode 100644
> index 00000000000000..f923b8c3c49c36
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-kakadu.dtsi"
> +#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
> +
> +/ {
> +	model = "MediaTek katsu board";
> +	compatible = "google,katsu-sku32", "google,katsu", "mediatek,mt8183";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	/delete-node/touchscreen@10;
> +	touchscreen1: touchscreen@5d {
> +		compatible = "goodix,gt7375p";
> +		reg = <0x5d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&open_touch>;
> +
> +		interrupt-parent = <&pio>;
> +		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&panel {
> +	compatible = "starry,2081101qfh032011-53g";

Compatible not present in DT-Bindings.

> +};
> +
> +&qca_wifi {
> +	qcom,ath10k-calibration-variant = "GO_KATSU";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
> new file mode 100644
> index 00000000000000..1ab14096a279c6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-kakadu.dtsi"
> +#include "mt8183-kukui-audio-rt1015p.dtsi"
> +
> +/ {
> +	model = "MediaTek katsu sku38 board";
> +	compatible = "google,katsu-sku38", "google,katsu", "mediatek,mt8183";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	/delete-node/touchscreen@10;
> +	touchscreen1: touchscreen@5d {
> +		compatible = "goodix,gt7375p";
> +		reg = <0x5d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&open_touch>;
> +
> +		interrupt-parent = <&pio>;
> +		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&panel {
> +	compatible = "starry,2081101qfh032011-53g";


Same here.

Regards,
Matthias

> +};
> +
> +&qca_wifi {
> +        qcom,ath10k-calibration-variant = "GO_KATSU";
> +};
> +
> +&sound {
> +	compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015p";
> +};
> 
