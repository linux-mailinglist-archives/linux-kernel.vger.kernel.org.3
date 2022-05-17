Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D252AB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352377AbiEQSsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352351AbiEQSrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:47:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C103983F;
        Tue, 17 May 2022 11:47:54 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nr2EX-0003vD-T1; Tue, 17 May 2022 20:47:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: set display regulators to always-on on BPI-R2-Pro
Date:   Tue, 17 May 2022 20:47:49 +0200
Message-ID: <11363549.CDJkKcVGEf@phil>
In-Reply-To: <20220415104951.27104-2-linux@fw-web.de>
References: <20220415104951.27104-1-linux@fw-web.de> <20220415104951.27104-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. April 2022, 12:49:49 CEST schrieb Frank Wunderlich:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Set display related regulators to always-on on Banana PI R2 Pro
> board.

Hmm, I'd expect some sort of explanation for the "why" here.
It looks like both the gpu patch as well as the vop patch do
reference the relevant regulators for the gpu+hdmi nodes,
so in theory this shouldn't be necessary anymore?

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> index 2700fb18a3bc..0950f9659bb4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> @@ -225,6 +225,7 @@ regulator-state-mem {
>  
>  			vdd_gpu: DCDC_REG2 {
>  				regulator-name = "vdd_gpu";
> +				regulator-always-on;
>  				regulator-init-microvolt = <900000>;
>  				regulator-initial-mode = <0x2>;
>  				regulator-min-microvolt = <500000>;
> @@ -274,6 +275,7 @@ regulator-state-mem {
>  
>  			vdda0v9_image: LDO_REG1 {
>  				regulator-name = "vdda0v9_image";
> +				regulator-always-on;
>  				regulator-min-microvolt = <900000>;
>  				regulator-max-microvolt = <900000>;
>  
> @@ -369,6 +371,7 @@ regulator-state-mem {
>  
>  			vcca1v8_image: LDO_REG9 {
>  				regulator-name = "vcca1v8_image";
> +				regulator-always-on;
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <1800000>;
>  
> 




