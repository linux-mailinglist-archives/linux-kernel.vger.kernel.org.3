Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1059E65C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbiHWPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244030AbiHWPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:50:30 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DB21FA3D;
        Tue, 23 Aug 2022 04:55:19 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQSTe-0004TT-EA; Tue, 23 Aug 2022 13:53:50 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Jensen Huang <jensenhuang@friendlyarm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to emmc phy on rk3399
Date:   Tue, 23 Aug 2022 13:53:49 +0200
Message-ID: <23552842.6Emhk5qWAg@diego>
In-Reply-To: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huang:
> Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was disabled
> by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> 
> Tested on NanoPC-T4.
> 
> Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in dts")
> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>

ok, so this looks like it restores previous functionality.

I'm just wondering as the "offending" patch is from 2020, why this
only turns up now. Any ideas?

> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 9d5b0e8c9cca..9491cafbbaa3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1561,6 +1561,7 @@ emmc_phy: phy@f780 {
>  			clock-names = "emmcclk";
>  			drive-impedance-ohm = <50>;
>  			#phy-cells = <0>;
> +			rockchip,enable-strobe-pulldown;
>  			status = "disabled";
>  		};
>  
> 




