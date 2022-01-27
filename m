Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CAD49DEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiA0KP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:15:29 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57640 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbiA0KP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:15:29 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nD1oC-0007hK-D1; Thu, 27 Jan 2022 11:15:16 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add Quartz64-A sdmmc1 node
Date:   Thu, 27 Jan 2022 11:15:13 +0100
Message-ID: <3859424.JUeRptVaKW@diego>
In-Reply-To: <CAMdYzYrKq==Bs0aonrJBC+W2c4nQ8cUn2dn_Se4WDaRCkT6SYg@mail.gmail.com>
References: <20220127010023.3169415-1-pgwipeout@gmail.com> <07281029-0efd-0a74-0d96-92e3dcf5bbb7@gmail.com> <CAMdYzYrKq==Bs0aonrJBC+W2c4nQ8cUn2dn_Se4WDaRCkT6SYg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 27. Januar 2022, 10:55:13 CET schrieb Peter Geis:
> On Thu, Jan 27, 2022 at 1:18 AM Johan Jonker <jbx6244@gmail.com> wrote:
> >
> >
> >
> > On 1/27/22 02:00, Peter Geis wrote:
> > > The sdmmc1 node on Quartz64-A supports the optional wifi module from
> > > Pine64.
> > > Add the sdmmc1 node and requisite sdio_pwrseq to enable wifi support on
> > > the Quartz64-A.
> > >
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > ---
> > >  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 45 +++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > > index 33c2c18caaa9..1d73ac6557c5 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > > @@ -91,6 +91,18 @@ simple-audio-card,codec {
> > >               };
> > >       };
> > >
> > > +     sdio_pwrseq: sdio-pwrseq {
> >
> > > +             status = "okay";
> >
> > When a node is not previously disabled, then there's no need for "okay".
> 
> Thanks, this is here in case an end user wants to easily hack the
> board to use this for other purposes.

but please drop it here as well.

A user "hacking" a devicetree should be able to also just _add_
a status "disabled" :-) .


