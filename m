Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1C497291
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbiAWPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:30:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46812 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237637AbiAWPad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:30:33 -0500
Received: from p508fcdea.dip0.t-ipconnect.de ([80.143.205.234] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nBep2-0005KV-40; Sun, 23 Jan 2022 16:30:28 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: enable the pine64 touch screen on rockpro64
Date:   Sun, 23 Jan 2022 16:30:29 +0100
Message-ID: <5747938.922zgog0jt@phil>
In-Reply-To: <20220107051335.3812535-5-pgwipeout@gmail.com>
References: <20220107051335.3812535-1-pgwipeout@gmail.com> <20220107051335.3812535-5-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Am Freitag, 7. Januar 2022, 06:13:35 CET schrieb Peter Geis:
> Enable the touch screen, backlight, and dsi nodes for the Pine64 touch panel
> attached to the rockpro64.

can you please also include me in the other patches of the series?
I.e. they introduce a new property for the display, so it's nice to know
when they get applied.

While I do agree with patch 3/4, I'm hesistant about this one.
The display/touchscreen will probably not be connected on every rockpro64
so what happens if it doesn't?

I.e are there alternative uses for the affected pins, that may get fried
when this is always enabled?

So part of me would think that an dt-overlay enabling this might be the
nicer way to go?


Heiko


> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 158befb9a48c..f6c36fcd6db3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -26,7 +26,7 @@ backlight: backlight {
>  		pwms = <&pwm0 0 1000000 0>;
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
>  		default-brightness-level = <5>;
> -		status = "disabled";
> +		status = "okay";
>  	};
>  
>  	clkin_gmac: external-gmac-clock {
> @@ -594,7 +594,7 @@ touch: touchscreen@5d {
>  		interrupts = <RK_PD5 IRQ_TYPE_EDGE_FALLING>;
>  		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
>  		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> -		status = "disabled";
> +		status = "okay";
>  	};
>  };
>  
> @@ -633,7 +633,7 @@ &io_domains {
>  
>  /* enable for pine64 panel display support */
>  &mipi_dsi {
> -	status = "disabled";
> +	status = "okay";
>  	clock-master;
>  
>  	ports {
> 




