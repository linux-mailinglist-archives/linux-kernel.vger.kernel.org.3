Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12DD4815CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhL2RcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:32:13 -0500
Received: from gloria.sntech.de ([185.11.138.130]:42186 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237519AbhL2RcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:32:11 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1n2cnp-0001Az-5Q; Wed, 29 Dec 2021 18:31:53 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, lee.jones@linaro.org,
        yifeng.zhao@rock-chips.com, kever.yang@rock-chips.com,
        cl@rock-chips.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 1/4] dt-bindings: mfd: syscon: add naneng multi phy register compatible
Date:   Wed, 29 Dec 2021 18:31:52 +0100
Message-ID: <6181139.AAzF1lipOG@diego>
In-Reply-To: <50f49afa-6042-03f2-a8ed-cfffd317aa15@gmail.com>
References: <20211222213032.7678-1-jbx6244@gmail.com> <20211222213032.7678-2-jbx6244@gmail.com> <50f49afa-6042-03f2-a8ed-cfffd317aa15@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan, Yifeng,

Am Dienstag, 28. Dezember 2021, 13:08:00 CET schrieb Johan Jonker:
> The file grf.yaml is already pretty full with legacy stuff.

I wouldn't call that legacy stuff ;-) .
The grf as "dumping ground" for more or less unsorted parts will probably
stay around in future socs as well.

> Now rockchip,rk3568-usb2phy-grf is added, would you like these two
> compatible strings also there?

I guess that makes sense. The grf.yaml is a better match
for grf compatible strings I guess.


Heiko


> Could you give advice to Yifeng?
> 
> Kind regards,
> 
> Johan Jonker
> 
> 
> On 12/22/21 10:30 PM, Johan Jonker wrote:
> > Add Naneng multi phy register compatible.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > index 5de16388a..9f0c8aa81 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -52,6 +52,8 @@ properties:
> >                - rockchip,rk3288-qos
> >                - rockchip,rk3368-qos
> >                - rockchip,rk3399-qos
> > +              - rockchip,rk3568-pipe-grf
> > +              - rockchip,rk3568-pipe-phy-grf
> >                - rockchip,rk3568-qos
> >                - samsung,exynos3-sysreg
> >                - samsung,exynos4-sysreg
> > 
> 




