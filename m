Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1D515E08
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382786AbiD3OKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiD3OKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:10:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A866F83;
        Sat, 30 Apr 2022 07:07:28 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknks-0001ZV-O8; Sat, 30 Apr 2022 16:07:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
Date:   Sat, 30 Apr 2022 16:07:25 +0200
Message-ID: <3229434.5fSG56mABF@phil>
In-Reply-To: <ca670161-7133-631e-f4b6-b48c8fde669b@wolfvision.net>
References: <20220425133502.405512-1-michael.riesch@wolfvision.net> <2087500.ItEYzMA54p@archbook> <ca670161-7133-631e-f4b6-b48c8fde669b@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 28. April 2022, 15:24:09 CEST schrieb Michael Riesch:
> Hi Nicolas,
> 
> On 4/28/22 13:15, Nicolas Frattaroli wrote:
> > On Montag, 25. April 2022 15:35:00 CEST Michael Riesch wrote:
> >> This USB 3.0 controller is capable of OTG/DRD operation. Enable it in the
> >> device tree.
> >>
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> index 55e6dcb948cc..f611aaf2d238 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> @@ -266,7 +266,7 @@ usb_host0_xhci: usb@fcc00000 {
> >>  			 <&cru ACLK_USB3OTG0>;
> >>  		clock-names = "ref_clk", "suspend_clk",
> >>  			      "bus_clk";
> >> -		dr_mode = "host";
> >> +		dr_mode = "otg";
> >>  		phy_type = "utmi_wide";
> >>  		power-domains = <&power RK3568_PD_PIPE>;
> >>  		resets = <&cru SRST_USB3OTG0>;
> >>
> > 
> > Hi Michael,
> > 
> > according to official specs[1], only the RK3568 is capable of using the
> > USB 3.0 controller in OTG mode. For the RK3566, OTG is USB 2.0, if I
> > understand this correctly.
> > 
> > So I think this should be an override in rk3568.dtsi.
> 
> Thanks for pointing that out -- will change in v2 (I'll wait a bit,
> though, as I hope that patches 2 and 3 will be applied as they are ;-)

that can be arranged ;-)

Heiko


