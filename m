Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF415474EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiFKNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiFKNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:50:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DD5EBF0;
        Sat, 11 Jun 2022 06:50:20 -0700 (PDT)
Received: from p508fd9f0.dip0.t-ipconnect.de ([80.143.217.240] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o01VC-0004TJ-AU; Sat, 11 Jun 2022 15:50:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SoQuartz CM4IO usb
Date:   Sat, 11 Jun 2022 15:50:08 +0200
Message-ID: <4178848.3VsfAaAtOV@phil>
In-Reply-To: <CAMdYzYqJ2S8K2NCH1uQ2xDjTfLmePPv5TzgeXZa0EG6XdGQzBQ@mail.gmail.com>
References: <20220610132601.160088-1-pgwipeout@gmail.com> <CAMdYzYqJ2S8K2NCH1uQ2xDjTfLmePPv5TzgeXZa0EG6XdGQzBQ@mail.gmail.com>
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

Am Freitag, 10. Juni 2022, 16:44:23 CEST schrieb Peter Geis:
> On Fri, Jun 10, 2022 at 9:26 AM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > The SoQuartz CM4-IO should support otg mode, however it currently
> > defaults to device mode when otg is enabled. Force it to host mode to
> > retain the previous behavior.
> 
> It would seem the role-switch issue is more widespread than originally
> thought, affecting other boards where automatic control should work.
> Please hold this patch while I investigate further.

ok!

I guess this also applies to
	"arm64: dts: rockchip: Fix Quartz64-A dwc3 otg port behavior"?


Heiko


> >
> > Fixes: bc405bb3eeee ("arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x")
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > index e00568a6be5c..56764fae9f9d 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > @@ -169,6 +169,7 @@ &usb2phy0_otg {
> >  };
> >
> >  &usb_host0_xhci {
> > +       dr_mode = "host";
> >         status = "okay";
> >  };
> >
> > --
> > 2.25.1
> >
> 




