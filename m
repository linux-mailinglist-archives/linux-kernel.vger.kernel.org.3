Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289BE58ABC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiHENng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiHENna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:43:30 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB57A26AD3;
        Fri,  5 Aug 2022 06:43:25 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id A46E05FD06;
        Fri,  5 Aug 2022 16:43:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659707002;
        bh=ZNxsBXeMZ0NBVx7yd+OxgeV/4yUg2rQxV6ljhZklxjo=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=hAaDeTfEOLQ8MEKeZMWODqu4FTygeU6ul4xPt3OVwFKHVKDtSYQqB728rj8lhsC46
         ArWGTPDwhl/TUju6lcLJz7WLWd+y8slu14yTJ3zfkFc6ZQm/G8504oD7frJTWh16ba
         W7PzbqHMFutLRlESnfpK9jf79iiYiDp2FnP95yjGyIhnXR7wjJb35xBbfBrBRv+Ajx
         +X/sd2Mju00WGlvYiFc7ibe5hP+XMVOqVPM3pPjHa9ffmitSs9W93wIcKtPD2cgs4z
         c4i7bQY5nGMn0Il6VktplNr0x+gUrnjcQbsgGqVVmI1mnDpn78i2qV6jdSavcgAOMy
         4DiXFxUb0t1aw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  5 Aug 2022 16:43:22 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: meson-axg: reserve memory region for
 Amlogic TrustOS
Thread-Topic: [PATCH v1] arm64: dts: meson-axg: reserve memory region for
 Amlogic TrustOS
Thread-Index: AQHYqCKmlgn31IcXkUK0U/+U7ZMA562fwScAgABe64A=
Date:   Fri, 5 Aug 2022 13:42:53 +0000
Message-ID: <20220805134317.y6lnpgefolfq4iim@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220804165317.29086-1-ddrokosov@sberdevices.ru>
 <1jfsibqfez.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jfsibqfez.fsf@starbuckisacylon.baylibre.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C39E89F7937BD45A6D243AD02E27093@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/05 06:43:00 #20054623
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jerome,

Thank you for the feedback.

On Fri, Aug 05, 2022 at 10:03:34AM +0200, Jerome Brunet wrote:
>=20
> On Thu 04 Aug 2022 at 16:52, Dmitry Rokosov <DDRokosov@sberdevices.ru> wr=
ote:
>=20
> > For the all AXG SoC based boards, which run Amlogic vendor ATF and
> > TrustOS this memory region 0x5300000-0x6300000 is reserved by BL32,
> > so tag it as no-map in the kernel iomem.
>=20
> This may be true for the boards you have seen so far but not all ship
> with this specific AML TEE. Some don't have TEE at all, other may have
> different TEE regions.
>=20
> 16 MB may be a significant part of the available memory on some AXG
> devices. Reserving that memory on all AXG devices, regardless of what is
> actually running does not seem appropriate.
>=20
> I know the same has been done for other devices but I don't think we shou=
ld
> continue to do so. This should be set either
> * per device if it is fixed
> * dynamically by the bootloader depending on the ATF (which is probably b=
etter)
>=20

I agree with you, *.dtsi is a common device tree base file which is
included in the all board trees. But looks like I don't understand meson
dtsi policy about TEE reserved memory regions. I mean g12 and gx dtsi
have statically defined TrustOS regions inside, and all meson dtsi have
hardcoded ATF regions. All of these regions are aligned with Amlogic ATF
and Amlogic Trust OS reserved memory addresses. And if I want to use
upstream ATF or optee build for Amlogic board, I need to patch dtsi file,
which is not right way as you mentioned.

If we want to use per-board TEE memory regions definitions I suppose we
need to move secos reserved ranges from gx and g12 dtsi files and move
all secmon definitions from all meson dtsi files to appropriate board
dtses (or mark them with status =3D "disable").

What do you think?

> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/bo=
ot/dts/amlogic/meson-axg.dtsi
> > index 3f5254eeb47b..1fa0d3805969 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > @@ -142,6 +142,12 @@ secmon_reserved: secmon@5000000 {
> >  			reg =3D <0x0 0x05000000 0x0 0x300000>;
> >  			no-map;
> >  		};
> > +
> > +		/* 16 MiB reserved for Amlogic Trust OS (BL32) */
> > +		secos_reserved: secos@5300000 {
> > +			reg =3D <0x0 0x05300000 0x0 0x1000000>;
> > +			no-map;
> > +		};
> >  	};
> > =20
> >  	scpi {
>=20

--=20
Thank you,
Dmitry=
