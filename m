Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A20516263
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbiEAHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 03:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiEAHKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 03:10:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE51276C;
        Sun,  1 May 2022 00:06:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq17so22623536ejb.4;
        Sun, 01 May 2022 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x8T0l3ePxEo0tPa3nLCaVVv3kLYt0vca+nm1RdbXgmU=;
        b=Yo5O3EgiMQ0ZlebWvAXvbrxwCC3Aa+BZtg6kyYXMeJ8vpyo1yfB95uK5ni+LptP+nl
         gCdl9e5FaqaK7cwYvdbaKvTCl6EAZp8r1G/QDCuJT7S01ZPyJPRchQro1MDWZQ62zydE
         48UIuJs9psLLaaSOeAzgJt8jX45iSesfBrj7jni3Qs+/2ffgtYc7qbSxuIlTV9v0h8Ia
         B/3vjy5tsd0yNy4+rQacs34rkx4UJq/kTLpupA0nTbk3lBWmUl1VQJLeACn6woO9hqkp
         w58IEe6BAcci+MO03p0OTbMFCt+nCh0B75t/CmxfQ/e5gWHNc7ekzL3ZDegn22l9uKw7
         lOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x8T0l3ePxEo0tPa3nLCaVVv3kLYt0vca+nm1RdbXgmU=;
        b=3EzucTTa27h1nN+X2sUA7Bd9AQbjXQscsUc5hBKC8J3Zjwa4S63n2W0Dn3uvfA1m3n
         rPtSO+kVlZ8XveeuPpmDZ+bj9P3sfqVg4fUO6wd2uh6qFcO2ZXgLyf7MSyXTVYX/MJss
         yNmHLlIGLaI64jDRK7+USaom8pt1CyP2vcVkTUv4uc8ZsMmoio1PNemgmi2oxJrRVmve
         Q3BpqnbG8nGWvfxWAHJpIpOoogIIqC2PtYsoYkbAPVYSy1kA1vQ0Wq3RIH9ZQyui5j/D
         evKySKabYjC6tjf1BT/32+ThqaiXPccHXZuilRx6y0xKSCRJAchsegM2Xs8t+AsUQ19X
         /ceA==
X-Gm-Message-State: AOAM532+l93nIJTHjmIRZLL72n5vOj1T47Vr6LtR5NWxyYDlM87l3aWe
        PET/wQMPLvnI6OeJAYTJlsM=
X-Google-Smtp-Source: ABdhPJzTW1au6Hq8+LkxfQRJRfHQIxpwiLzl7XquNFMAD+nZQL7T6Uji+LhedVpwD1C0N9xh0HE4+w==
X-Received: by 2002:a17:907:6da5:b0:6f3:c4b1:378b with SMTP id sb37-20020a1709076da500b006f3c4b1378bmr6515327ejc.307.1651388795791;
        Sun, 01 May 2022 00:06:35 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id hw7-20020a170907a0c700b006f3ef214e18sm2336790ejc.126.2022.05.01.00.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 00:06:35 -0700 (PDT)
Message-ID: <46548c93-4e6d-858c-8b79-03be9326c92a@gmail.com>
Date:   Sun, 1 May 2022 09:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 5/7] arm64: dts: rockchip: add Pine64 Quartz64-B device
 tree
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
 <20220429115252.2360496-6-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220429115252.2360496-6-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 13:52, Peter Geis wrote:
> Add a device tree for the Pine64 Quartz64 Model B single board computer.
> This board ouputs debug on uart2 and supports the following components:
> Gigabit Ethernet
> USB2 x2 (one port otg capable)
> USB3
> PCIe/SATA M2
> HDMI
> DSI (RPi compatible pinout)
> CSI (RPi compatible pinout)
> A/B/G/N WiFi
> Bluetooth
> SDMMC
> eMMC
> SPI Flash
> PI-40 compatible pin header
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 615 ++++++++++++++++++
>  2 files changed, 616 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 4ae9f35434b8..252ee47b8a1d 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -59,5 +59,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> new file mode 100644
> index 000000000000..184ab7e1d178
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -0,0 +1,615 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3566.dtsi"
> +
> +/ {
> +	model = "Pine64 RK3566 Quartz64-B Board";
> +	compatible = "pine64,quartz64-b", "rockchip,rk3566";
> +

[..]

> +
> +&mdio1 {

> +	rgmii_phy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;

Hi,

The reg value doesn't match the node name.
Other 2 boards use "reg = <0>" with label "rgmii_phy1".
Could you check?

Johan

> +	};
> +};
> +
