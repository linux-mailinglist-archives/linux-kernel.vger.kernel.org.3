Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0C59B258
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiHUGq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHUGqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:46:09 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22F13E25;
        Sat, 20 Aug 2022 23:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661064338; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bYCJqhi+7nttqyXosZqYm05vspgGmksaihPrm5uAGVuFIqeWwjyfqlFNXC6DeV/imHingbli6MlJ24QDPtYvcfYZLevSmeW7Ke0ypSqUuve/qZ/Md6bDMqL2wNWsCYTTRiowt5OTBr0GBBRATIs/gUZmRprjJOq6NZ2PnJVEpHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1661064338; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XOgbmExxvrqPcmSB4T3YYmPjxkSvihylwUhZYEypY/o=; 
        b=Z/lj6UjQdvfPjKHhUYCVNBwwb0tVvvwTvcjYn6Fa8ZTUVF0p90qs88jn2NKSkW9AtMNWZS4q6UbxA4py2y1TvnopB+EzNRTWCmwKAsm+haZMTy4bGrsJdss1kXXIQKvNZHFVI6JUxpFhSdM3uFIsjCJjFJXESTMWyI1uppeGzuM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661064338;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=XOgbmExxvrqPcmSB4T3YYmPjxkSvihylwUhZYEypY/o=;
        b=OzoilHrmKoD5y7+Yp7rUZt1f2jCBCriC5nIpmcz1YvfpV+Bk5QvJ7OKl8j4Kpmg5
        yI38dBZQzD4SXAxAx2iqyGjtLI3X/6PNTgXxfBQ63uKWdSRjgOOHp/i79SxBLdJ4uQA
        SDsj98NFgYcV3f6nQslenrXyTsxObqi8jl/D/lb8=
Received: from edelgard.icenowy.me (112.94.100.154 [112.94.100.154]) by mx.zohomail.com
        with SMTPS id 1661064334957903.0114134560564; Sat, 20 Aug 2022 23:45:34 -0700 (PDT)
Message-ID: <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor.Dooley@microchip.com, samuel@sholland.org,
        andre.przywara@arm.com
Cc:     wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Date:   Sun, 21 Aug 2022 14:45:27 +0800
In-Reply-To: <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
         <20220815050815.22340-7-samuel@sholland.org>
         <20220815141159.10edeba5@donnerap.cambridge.arm.com>
         <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
         <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
         <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-08-20=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 17:29 +0000=EF=BC=
=8CConor.Dooley@microchip.com=E5=86=99=E9=81=93=EF=BC=9A
> On 20/08/2022 18:24, Samuel Holland wrote:
> > On 8/15/22 12:01 PM, Conor.Dooley@microchip.com=C2=A0wrote:
> > > On 15/08/2022 14:11, Andre Przywara wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless
> > > > you know the content is safe
> > > >=20
> > > > On Mon, 15 Aug 2022 00:08:09 -0500
> > > > Samuel Holland <samuel@sholland.org> wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > thanks for all the efforts in getting those SoC peripherals
> > > > supported!
> > > >=20
> > > > > D1 is a SoC containing a single-core T-HEAD Xuantie C906 CPU,
> > > > > as well as
> > > > > one HiFi 4 DSP. The SoC is based on a design that
> > > > > additionally contained
> > > > > a pair of Cortex A7's. For that reason, some peripherals are
> > > > > duplicated.
> > > >=20
> > > > So because of this, the Allwinner R528 and T113 SoCs would
> > > > share almost
> > > > everything in this file. Would it be useful to already split
> > > > this DT up?
> > > > To have a base .dtsi, basically this file without /cpus and
> > > > /soc/plic,
> > > > then have a RISC-V specific file with just those, including the
> > > > base?
> > > > There is precedence for this across-arch(-directories) sharing
> > > > with the
> > > > Raspberry Pi and Allwinner H3/H5 SoCs.
> > >=20
> > > For those playing along at home, one example is the arm64
> > > bananapi m2
> > > dts which looks like:
> > > > /dts-v1/;
> > > > #include "sun50i-h5.dtsi"
> > > > #include "sun50i-h5-cpu-opp.dtsi"
> > > > #include <arm/sunxi-bananapi-m2-plus-v1.2.dtsi>
> > > >=20
> > > > / {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "Banana P=
i BPI-M2-Plus v1.2 H5";
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "ban=
anapi,bpi-m2-plus-v1.2",
> > > > "allwinner,sun50i-h5";
> > > > };
> > >=20
> > > I think this is a pretty good idea, and putting in the modularity
> > > up
> > > front seems logical to me, so when the arm one does eventually
> > > get
> > > added it can be done by only touching a single arch.
> >=20
> > This is not feasible, due to the different #interrupt-cells. See
> > https://lore.kernel.org/linux-riscv/CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisG=
xHMBPUEa8nTMFpzw@mail.gmail.com/
> >=20
> > Even if we share some file across architectures, you still have to
> > update files
> > in both places to get the interrupts properties correct.
> >=20
> > I get the desire to deduplicate things, but we already deal with
> > updating the
> > same/similar nodes across several SoCs, so that is nothing new. I
> > think it would
> > be more confusing/complicated to have all of the interrupts
> > properties
> > overridden in a separate file.
>=20
> Yeah, should maybe have circled back after that conversation, would
> have been
> nice but if the DTC can't do it nicely then w/e.

Well, maybe we can overuse the facility of C preprocessor?

e.g.

```
// For ARM
#define SOC_PERIPHERAL_IRQ(n) GIC_SPI n
// For RISC-V
#define SOC_PERIPHERAL_IRQ(n) n
```

