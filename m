Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7EF565D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiGDSmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiGDSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:42:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D611A1E;
        Mon,  4 Jul 2022 11:42:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb34so17992035ejc.11;
        Mon, 04 Jul 2022 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVJSQrTkQwe5Z79nmWayDFvWmq1VAQ9HxitkgUgMq7I=;
        b=nNwxh1be9FXpXETndamwxF8+aKZO5VyLdF+ZKCK/kHSIaHqMYO+HT4wuM8FJsaSVyQ
         uEaxS6vxcf83Ai90ONWLn7FiyMNS/KjlXSohBN5GCdH1s+IDfFP36sXlWWu+DRWFQKnw
         4ooyMo+wi8vr0Lqivl75cK+xT7q2rR+qiGoLCArODj1s83Ynd7AXmTAwOtylUwqjWlM6
         BcjD5Emg/qZP2BoBKSDBUNR9q79a9OhalapR0LxOg1jknW4JY/cH1tx5WDuxgoLem+jS
         kXhn4BuThlzNDNwYkFQdrpdjxqHbEbl1XfKwM9kTpYno08q5gmAVY7L+Jfnw8jFPZCe3
         6jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVJSQrTkQwe5Z79nmWayDFvWmq1VAQ9HxitkgUgMq7I=;
        b=3YgBnIcqLSl0Ax9VjWzNXxZQAmNarjV727KXi/3LJixIG7qGepvlU5l0xotlruQL4Q
         89gMEKlP0UWW7mN2SFkhNdkGX2gPkMhkwWks/m2Ke10Vz0slesM84HcMb5S/zH2RuLet
         OSPGd1S6CggnXggGW/LUepPxQRm5Qj18egUQWZyjX11AsSdaBXPgygpux7k4+KsYmWoS
         pnLscagVrM06rizEoIDltKzAc6lwokdGhCZMeKJK7GWGOrdiTa/pEFtCvt5CarQPdWhw
         j2dXK3O+juVQ37zutoC/EG+ljBJC5MU9SK9EgSgvT7HpXOs2gZ85xvrU7cxP72MiAYIB
         YnEA==
X-Gm-Message-State: AJIora8evxM1A+ixCpRvecUX+lm3jyBxyOhAs5ZuidBr64/kzkm4Eyw1
        byfGYDtzzb83CoqnkiYUGBI=
X-Google-Smtp-Source: AGRyM1v1ECUUyG9a10cJpPtqQtqmjS6SBNVFEIfhdSeE5cA+Z6q0MwW0/iujbPi9QkKpY+t1MedfGw==
X-Received: by 2002:a17:907:2cf4:b0:72a:47b1:32ee with SMTP id hz20-20020a1709072cf400b0072a47b132eemr27235391ejc.293.1656960168878;
        Mon, 04 Jul 2022 11:42:48 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906301500b00728f6d4d0d7sm7818732ejz.67.2022.07.04.11.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:42:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
Date:   Mon, 04 Jul 2022 20:42:47 +0200
Message-ID: <22699277.6Emhk5qWAg@kista>
In-Reply-To: <20220704143057.76163208@donnerap.cambridge.arm.com>
References: <20220428230933.15262-1-andre.przywara@arm.com> <2985997.CbtlEUcBR6@jernej-laptop> <20220704143057.76163208@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 04. julij 2022 ob 15:30:57 CEST je Andre Przywara napisal(a=
):
> On Sat, 02 Jul 2022 23:16:53 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> > Dne =C4=8Detrtek, 30. junij 2022 ob 02:04:10 CEST je Andre Przywara nap=
isal(a):
> > > On Tue, 03 May 2022 21:05:11 +0200
> > > Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
> > >=20
> > > Hi Jernej,
> > >=20
> > > many thanks for taking the time to wade through this file!
> > >  =20
> > > > Dne petek, 29. april 2022 ob 01:09:30 CEST je Andre Przywara=20
napisal(a): =20
> > > > > This (relatively) new SoC is similar to the H6, but drops the=20
(broken)
> > > > > PCIe support and the USB 3.0 controller. It also gets the managem=
ent
> > > > > controller removed, which in turn removes *some*, but not all of =
the
> > > > > devices formerly dedicated to the ARISC (CPUS).
> > > > > And while there is still the extra sunxi interrupt controller, the
> > > > > package lacks the corresponding NMI pin, so no interrupts for the=
=20
PMIC.
> > > > >=20
> > > > > The reserved memory node is actually handled by Trusted Firmware=
=20
now,
> > > > > but U-Boot fails to propagate this to a separately loaded DTB, so=
 we
> > > > > keep it in here for now, until U-Boot learns to do this properly.
> > > > >=20
> > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > > ---
> > > > >=20
> > > > >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574 ++++++++++++=
+++
+++
> > > > >  1 file changed, 574 insertions(+)
> > > > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > >=20
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > b/arch/arm64/ =20
> > > >=20
> > > > boot/dts/allwinner/sun50i-h616.dtsi
> > > >  =20
> > > > > new file mode 100644
> > > > > index 000000000000..cc06cdd15ba5
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > @@ -0,0 +1,574 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > +// Copyright (C) 2020 Arm Ltd.
> > > > > +// based on the H6 dtsi, which is:
> > > > > +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > > > > +
> > > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > > > > +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> > > > > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > > > > +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > > > > +
> > > > > +/ {
> > > > > +	interrupt-parent =3D <&gic>;
> > > > > +	#address-cells =3D <2>;
> > > > > +	#size-cells =3D <2>;
> > > > > +
> > > > > +	cpus {
> > > > > +		#address-cells =3D <1>;
> > > > > +		#size-cells =3D <0>;
> > > > > +
> > > > > +		cpu0: cpu@0 {
> > > > > +			compatible =3D "arm,cortex-a53";
> > > > > +			device_type =3D "cpu";
> > > > > +			reg =3D <0>;
> > > > > +			enable-method =3D "psci";
> > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > +		};
> > > > > +
> > > > > +		cpu1: cpu@1 {
> > > > > +			compatible =3D "arm,cortex-a53";
> > > > > +			device_type =3D "cpu";
> > > > > +			reg =3D <1>;
> > > > > +			enable-method =3D "psci";
> > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > +		};
> > > > > +
> > > > > +		cpu2: cpu@2 {
> > > > > +			compatible =3D "arm,cortex-a53";
> > > > > +			device_type =3D "cpu";
> > > > > +			reg =3D <2>;
> > > > > +			enable-method =3D "psci";
> > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > +		};
> > > > > +
> > > > > +		cpu3: cpu@3 {
> > > > > +			compatible =3D "arm,cortex-a53";
> > > > > +			device_type =3D "cpu";
> > > > > +			reg =3D <3>;
> > > > > +			enable-method =3D "psci";
> > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > +		};
> > > > > +	};
> > > > > +
> > > > > +	reserved-memory {
> > > > > +		#address-cells =3D <2>;
> > > > > +		#size-cells =3D <2>;
> > > > > +		ranges;
> > > > > +
> > > > > +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> > > > > +		secmon_reserved: secmon@40000000 {
> > > > > +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> > > > > +			no-map;
> > > > > +		};
> > > > > +	}; =20
> > > >=20
> > > > I'm not a fan of above. If anything changes in future in BL31, U-Bo=
ot
> > > > would
> > > > need to reconfigure it anyway. Can we just skip it? =20
> > >=20
> > > I am not a fan neither, but last time I checked this is needed to boo=
t.
> > > Indeed TF-A inserts this node, with the right values, into U-Boot's D=
T.
> > > And that's nicely preserved if you use that DT ($fdtcontroladdr) for
> > > the kernel as well.
> > > But if someone *loads* a DTB into U-Boot (to $fdt_addr_r), then
> > > U-Boot fails to propagate the /reserved-memory node into that copy.
> > > There does not seem to be a global notion of reserved memory in U-Boo=
t.
> > > Some commands (like tftp) explicitly parse the control DT to find and
> > > respect reserved memory regions. bootm does that also, but only to
> > > avoid placing the ramdisk or DTB into reserved memory. The information
> > > ends up in images->lmb, but is not used to generate or amend nodes in
> > > the target DT.
> > > So the bits and pieces are there, but it will require some code to be
> > > added to the generic U-Boot code.
> > >=20
> > > So what do you think? Leaving this out will prevent loading DTBs into
> > > U-Boot, at the moment, which sounds bad. I suggest we keep it in, for
> > > now, it should not really hurt. U-Boot will hopefully start to do the
> > > right thing soon, then we can either phase it out here (maybe when we
> > > actually change something in TF-A), or let U-Boot fix it. =20
> >=20
> > TBH, if "soon" is really soon, I would rather wait with H616 DT until U-
Boot=20
> > supports carrying over reserved memory nodes.
>=20
> But this also carries compatibility issues. U-Boot support the H616 for
> more than a year now, and the earliest possible U-Boot release having that
> propagation code would be the one released in October.=20

I was hoping you would say July (next U-Boot release) :).

> And then people
> would still need to update first, so that's quite some months out.
> And I was actually hoping to get at least the H616 DT patches off my
> plate, and get them into the tree to have a stable and agreed upon base
> (before this series turns into a teenager ;-)

Yeah, I would like that too.

> Then we could for instance update the U-Boot H616 support.
>=20
> > Whatever we do now, it will have=20
> > compatibility issues. If we introduce reserved memory node now, we can'=
t=20
> > easily drop it later. Bootloaders are not very often updated, but kerne=
ls=20
and=20
> > DTB files are, at least in my experience. So when we decide to drop the=
=20
node?
>=20
> I think of the three possibilities:
> - Drop the node now, and ask people to not load DTBs explicitly
> - Drop the node when U-Boot learned to propagate the reservation
> - Keep the node
> the last one is the least painful: having this node in does not really
> hurt, so we can be very relaxed with this removal decision:
> - If U-Boot does not add the reserved node, we are covered.
> - If U-Boot adds the node, it will do so in a way where it deals with
> existing reservations. So either it doesn't actually change anything, or
> it extends the reservation.
> - Should the TF-A location actually move (and we have no plans or needs to
> do that), people would only get this by updating the firmware, at which
> point the U-Boot part would surely be in place already. We don't really
> support updating just BL31 in an existing binary firmware image, so you
> would get an updated U-Boot as well.
>=20
> I think the worst case scenario is that users end up with an unneeded 512K
> reservation. If they care, a firmware update should solve this problem.
>=20
> As for the time to remove that node: we could do that at the time when
> (or rather: if) we actually change the TF-A reservation. At the moment
> there are no plans to do this, and the size reservation is more than
> generous (the current debug build is actually 77 KB or so only). If there
> is no change, and the node stays in the .dtsi, it doesn't really hurt, see
> above.

I see your point, but I would like to get some input from Samuel first.

Samuel, what do you think?

>=20
> > After 10 years? Alternatively, reserved memory node can be just dropped=
=20
and=20
> > anyone loading DTB file from outside would need to make sure it's patch=
ed.=20
But=20
> > that's unexpected from user perspective, although patching DT files is =
done=20
by=20
> > some distros.
>=20
> Yeah, let's not go there. As you know, I already dislike the idea of
> explicitly loading DTBs at all, but I understand this is what people, and
> distributions, do, so I'd rather have them covered. Hence the node to
> work with existing firmware.

Reusing DTB from U-Boot is only useful when you're happy with completeness =
of=20
DT and with the lack of bugs in it. Then you can save troubles with skippin=
g=20
external DTB load step and life is easier. But as you know, features and th=
us=20
nodes are added in steps and sometimes some bugs are fixed, which means it'=
s=20
extremely handy to have easily updatable DTB file. Yes, U-Boot can be=20
automated, but it's tedious for distro to maintain one bootloader package p=
er=20
board. Ideally, distro shouldn't care at all about that, but many boards do=
n't=20
have designated bootloader storage (SPI NOR flash in AW case), so they have=
 to=20
be combined on same storage, partition even, as distro. On the other hand,=
=20
when building kernel, you automatically build all relevant DTB files, which=
 you=20
can then just copy to common place. No device specific handling needed. Als=
o,=20
U-Boot doesn't sync DT files every release, so latest U-Boot doesn't necess=
arly=20
mean latest DT.

Above is a bit off topic, but I hope you understand why distros opt to use=
=20
external DTB files (speaking from my own experiences).

Best regards,
Jernej

>=20
> Does that make sense?
>=20
> Cheers,
> Andre
>=20


