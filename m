Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208E347A27B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhLSV5P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Dec 2021 16:57:15 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53796 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233601AbhLSV5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:57:14 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mz4As-00068I-JM; Sun, 19 Dec 2021 22:56:58 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     plr.vincent@gmail.com, linux-riscv@lists.infradead.org
Cc:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        qiuwenbo@kylinos.com.cn, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        david.abdurachmanov@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v3 4/6] riscv: dts: sifive unmatched: Expose the FU740 core supply regulator
Date:   Sun, 19 Dec 2021 22:56:57 +0100
Message-ID: <5471232.RFuYXYORHR@diego>
In-Reply-To: <mhng-854afd5f-800b-4b58-af68-cdc6afdc0a4a@palmer-ri-x1c9>
References: <mhng-854afd5f-800b-4b58-af68-cdc6afdc0a4a@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 17. Dezember 2021, 06:35:00 CET schrieb Palmer Dabbelt:
> On Fri, 19 Nov 2021 14:55:40 PST (-0800), plr.vincent@gmail.com wrote:
> > Provides monitoring of core voltage and current:
> > tps544b20-i2c-0-1e
> > Adapter: i2c-ocores
> > vout1:       906.00 mV
> > temp1:        -40.0°C  (high = +125.0°C, crit = +150.0°C)
> > iout1:         5.06 A  (max = +20.00 A, crit max = +26.00 A)
> >
> > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> >
> > ---
> > Note: checkpatch.pl complains about undocumented devicetree binding,
> > which is fixed by:
> >   https://lore.kernel.org/linux-devicetree/20211116110207.68494-1-krzysztof.kozlowski@canonical.com/T/#u
> >
> > Changes since v2:
> > - Fix end-of-commit-message separator so change lists do not end up in them.
> > Changes since v1:
> > - Added missing "ti," prefix in compatible string.
> > - Remove trailing "." on subject line.
> > - Rename tree node.
> 
> I see this in Rob's for-next as 761de79adc2c ("dt-bindings: hwmon: add
> TI DC-DC converters"), so I'm going to hold off on this one until the
> bindings land.

Can't this patch then simply go into your for-next branch then?

The split is most times binding goes through the driver-tree
(or Rob's dt tree) and the dts patch through an arch or soc tree.

But in general once a maintainer accepts the binding it is ok
to also apply the dts patch for the same cycle (aka merge window)
the binding will be in.


Heiko


> 
> I've put the others on fixes.
> 
> Thanks!
> 
> > ---
> >  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > index 270360b258b7..6e7775fdae32 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > @@ -51,6 +51,11 @@ &uart1 {
> >  &i2c0 {
> >  	status = "okay";
> >
> > +	regulator@1e {
> > +		compatible = "ti,tps544b20";
> > +		reg = <0x1e>;
> > +	};
> > +
> >  	temperature-sensor@4c {
> >  		compatible = "ti,tmp451";
> >  		reg = <0x4c>;
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 




