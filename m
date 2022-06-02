Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65753BD69
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiFBRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiFBRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:40:24 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118415A3E7;
        Thu,  2 Jun 2022 10:40:21 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id A16455FD02;
        Thu,  2 Jun 2022 20:40:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654191618;
        bh=Ns/jWLoocsXbGN/wByVw7QlxyQs2qa8peqP9XJPmR/w=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=o7YvEeHGOnknvDRHGo/oFgS+Mfv5ONp+m2rmOb1QGjeWtQpbsYwxmxkKmPxdmmGHe
         6fpDwzhAIkBF1fPeTRlv2LR6rtyxZsbB1up5gwNYvxpYnDcCUrL9+Tx2Id6fJqmIKt
         6Ss6ELPlfB9vRzdZOLN9z9/DHOWFoK4xfgWDi8V7D75S/gPXJi+5KOalOSEhcbvajk
         GxUdkSuR5FnzeyWtElvUW9O/7NvYlrbGWNyyjOl/hWqEDSSVwjbjMo2WhPk+2vHlyv
         esa0rq9GJBTo7uy/eW2JjZOAU6nRorDAHFZvdCmHdALj1u72p01uD/hL26hO9hwkrG
         ESiSH0IBSSWzw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu,  2 Jun 2022 20:40:18 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: add dt-binding schema for
 msa311 accel driver
Thread-Topic: [PATCH v2 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Thread-Index: AQHYcGNsHieJqKs6FU67Uad334M2Aq0vuKGAgASpOICAB9q1gA==
Date:   Thu, 2 Jun 2022 17:39:55 +0000
Message-ID: <20220602174013.x4ygdpbivr2xv5iq@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-4-ddrokosov@sberdevices.ru>
 <20220525183255.lc7hmmcfj47yrxc3@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220528184337.0855c8cc@jic23-huawei>
In-Reply-To: <20220528184337.0855c8cc@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <719AE3C7FD7B814D986963EEA545FF29@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/02 12:19:00 #19650230
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On Sat, May 28, 2022 at 06:43:37PM +0100, Jonathan Cameron wrote:
> On Wed, 25 May 2022 18:32:45 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
> > > +  interrupt-names:
> > > +    const: irq =20
> > I stay interrupt-names node here, because otherwise dt_binding_check
> > command shows such a warning:
> >=20
> > =3D=3D=3D=3D
> >   CHECK   Documentation/devicetree/bindings/iio/accel/memsensing,msa311=
.example.dt.yaml
> > Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.d=
t.yaml: accelerometer@62: 'interrupt-names' does not match any of the regex=
es: 'pinctrl-[0-9]+'
> > =3D=3D=3D=3D
> >=20
> > I can't delete this node from the example as well, because it's require=
d for
> > msa311 dts i2c irq declaration.
>=20
> Sorry, you've lost me - what breaks if you drop it from the example?
> I'd expect to see no interrupt-names being documented or in the example.
>=20
> >=20
> > Please help me to resolve this problem properly if possible. If we can
> > ignore such warning I'll delete interrupt-names in the next patchset's
> > version.
>=20
> We can't ignore the warning, so this comes down to what am I missing with
> the need for it in the example...
>=20

You are totally right. I thought during i2c device probe we should
provide interrupt-names dts property because i2c irq parsing requires
it, but I was wrong. i2c_device_probe() function tries to parse irq
value using interrupt-names property and fallbacks to simple
of_irq_get() if interrupt-names property is missing. In other words,
interrupt-names property is not required for device node declaration, so
it can be removed from documentation. Thank you for pointing this out.

> >=20
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    i2c {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > + =20
> > Properties #address-cells and #size-cells are still located in the
> > schema example, because otherwise dt_binding_check raises the below=20
> > warnings if we delete these properties:
>=20
> They should be there for the i2c node, (as they are required for an i2c b=
us master
> node) but you had them documented as being in the msa311 node.  If it's
> not in the
> accelerometer@62 {
>=20
> }
>=20
> section of the example documetnation doesn't belong on this file (it will=
 be
> elsewhere).=20
>=20
> The request is to drop the documentation of them (as we are documenting
> the msa311 part of the binding only).  They should indeed still be there
> in the example.
>=20
> Jonathan
>=20

I've removed #address-cells and #size-cells properties from
doc section as well as interrupt-names. All dtbs checkings have passed
successfully. Thank you!

--=20
Thank you,
Dmitry=
