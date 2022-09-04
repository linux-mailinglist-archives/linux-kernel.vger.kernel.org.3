Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC45AC4FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiIDP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiIDP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:28:34 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D112DABA;
        Sun,  4 Sep 2022 08:28:32 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oUrXm-0000U5-3l; Sun, 04 Sep 2022 17:28:18 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Aw: Re:  Re: [PATCH v5 5/5] arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro
Date:   Sun, 04 Sep 2022 17:28:14 +0200
Message-ID: <3349380.9Mp67QZiUf@diego>
In-Reply-To: <trinity-9006aaf2-5bc2-467c-a86e-ba43efc692e6-1661591668494@3c-app-gmx-bs16>
References: <20220825193836.54262-1-linux@fw-web.de> <ee6dc940-8b90-1f57-28b7-6de8e3483027@linaro.org> <trinity-9006aaf2-5bc2-467c-a86e-ba43efc692e6-1661591668494@3c-app-gmx-bs16>
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

Hi,

Am Samstag, 27. August 2022, 11:14:28 CEST schrieb Frank Wunderlich:
> > Gesendet: Samstag, 27. August 2022 um 10:56 Uhr
> > Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> 
> > On 27/08/2022 11:50, Frank Wunderlich wrote:
> > > Hi
> > >
> > >> Gesendet: Freitag, 26. August 2022 um 08:50 Uhr
> > >> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> > >> On 25/08/2022 22:38, Frank Wunderlich wrote:
> > >>> From: Frank Wunderlich <frank-w@public-files.de>
> > >
> > >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > >>> index 93d383b8be87..40b90c052634 100644
> > >>> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > >>> @@ -86,6 +86,66 @@ vcc5v0_sys: vcc5v0-sys {
> > >>>  		vin-supply = <&dc_12v>;
> > >>>  	};
> > >>>
> > >>> +	pcie30_avdd0v9: pcie30-avdd0v9 {
> > >>
> > >> Use consistent naming, so if other nodes have "regulator" suffix, use it
> > >> here as well.
> > >
> > > only these 3 new have the suffix:
> > >
> > > vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator
> > > vcc3v3_minipcie: vcc3v3-minipcie-regulator
> > > vcc3v3_ngff: vcc3v3-ngff-regulator
> > >
> > > so i would drop it there...
> > >
> > > so i end up with (including existing ones to compare):
> > >
> > > vcc3v3_sys: vcc3v3-sys
> > > vcc5v0_sys: vcc5v0-sys
> > > pcie30_avdd0v9: pcie30-avdd0v9
> > > pcie30_avdd1v8: pcie30-avdd1v8
> > > vcc3v3_pi6c_05: vcc3v3-pi6c-05
> > > vcc3v3_minipcie: vcc3v3-minipcie
> > > vcc3v3_ngff: vcc3v3-ngff
> > > vcc5v0_usb: vcc5v0_usb
> > > vcc5v0_usb_host: vcc5v0-usb-host
> > > vcc5v0_usb_otg: vcc5v0-usb-otg
> > >
> > > is this ok?
> > >
> > > maybe swap avdd* and pcie30 part to have voltage in front of function.
> > >
> >
> > I prefer all of them have regulator suffix. I think reasonable is also
> > to rename the old ones and then add new ones with suffix.
> 
> ok, will change these to add -regulator in name (not label). and then rename the others in separate Patch outside of the series.
> 
> so basicly here
> -       pcie30_avdd0v9: pcie30-avdd0v9 {
> +       pcie30_avdd0v9: pcie30-avdd0v9-regulator {
> -       pcie30_avdd1v8: pcie30-avdd1v8 {
> +       pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> 
> how about the swapping of pcie30 and the avddXvY? In Schematic they are named PCIE30_AVDD_0V9 / PCIE30_AVDD_1V8, so better leave this?
> 
> avdd0v9-pcie30 will be more similar to the other regulators, but inconsistent with Schematic.

now that the phy-driver changes got applied I'll just pick up the remaining
patches and do the node-name conversion while applying, so no need
to send another revision for it.

But of course feel free so send patches for converting the other regulator
names.

And I'm definitly preferring keeping close to schematic names :-)


Heiko


