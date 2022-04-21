Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E505650A159
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388397AbiDUN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388321AbiDUN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:58:12 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C22BB1B;
        Thu, 21 Apr 2022 06:55:20 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id A07805FD06;
        Thu, 21 Apr 2022 16:55:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1650549317;
        bh=Vx0fQIL15yRo1tQ1B3ku9JZaBjnreUllysZQgmgiL3Q=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=Q0rv00JCvcd+EQczEOKRA9bRPlKgNKE7Y1QjVasvOVqwcM20f11lnPZtgBzKGYUKw
         XRZT2hEcgLxEqmJNay40LOOvvGJis8d3a7eIccZc70NtSaQsmud2HnJxL7DR4cTQsA
         5PtemGvEjCdN1U9FYdz4I1L3GIAykjayuMPmBvsRXlLFBIRCpW1ZVA1yaPwBpsFclp
         temG3CF9lCjfb5C8zBUU7EJJSvFWFMnX15lZKQ91nDVJfXri5dNFaovsvtX1HCf55C
         /bvljLoHkLpjIqVcekG9oQq5I4mOE6EB63WlBnWlvg04zmVQDqRk7kkDR+Yw1FOvmd
         RowmP1v2/KFfA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 21 Apr 2022 16:55:14 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: accel: add dt-binding schema for
 msa311 accel driver
Thread-Topic: [PATCH v1 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Thread-Index: AQHYVASQQZC393Ji1keuDd+e+35bUqz4TVCAgAHnLgA=
Date:   Thu, 21 Apr 2022 13:55:07 +0000
Message-ID: <20220421135457.ldtsff6ii4nhjkh5@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-4-ddrokosov@sberdevices.ru>
 <20220420095127.000059d4@Huawei.com>
In-Reply-To: <20220420095127.000059d4@Huawei.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F4944C50A2B3F4CB31F52FCB5B5F289@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/21 06:36:00 #19322218
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

Thank you for the quick feedback.
I completely agree with all of your comments. Please find my notes below.

On Wed, Apr 20, 2022 at 09:51:27AM +0100, Jonathan Cameron wrote:
> On Tue, 19 Apr 2022 15:45:58 +0000
> Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru> wrote:
>=20
> > Introduce devicetree binding json-schema for MSA311 tri-axial,
> > low-g accelerometer driver.
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Hi Dmitry and welcome to IIO.
>=20
> Sign off generally matches the From: of the email.
> Makes it easier for scripts to check than having different name forms.
>=20

Yes, looks like this problem is located on the corporative Exchange server =
side.
I use DavMail local proxy to send emails, so server changes From: statement=
.
I have already discussed it with our IT guys, it should be fixed starting f=
rom current email.

> > ---
> >  .../bindings/iio/accel/memsensing,msa311.yaml      | 64 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/memsens=
ing,msa311.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/accel/memsensing,msa=
311.yaml b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.ya=
ml
> > new file mode 100644
> > index 00000000..3e4660f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yam=
l
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: MEMSensing digital 3-Axis accelerometer
> > +
> > +maintainers:
> > +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > +
> > +description: |
> > +  MSA311 is a tri-axial, low-g accelerometer with I2C digital output f=
or
> > +  sensitivity consumer applications. It has dynamical user selectable =
full
> > +  scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measure=
ments
> > +  with output data rates from 1Hz to 1000Hz.
> > +  Datasheet can be found at following URL
> > +  https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: memsensing,msa311
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: I2C registers address
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: optional I2C int pin can be freely mapped to specific=
 func
> > +
> > +  interrupt-names:
> > +    const: irq
>=20
> For a single IRQ giving it a name isn't that useful so I would drop this.
>=20
>=20

Based on Documentation/devicetree/bindings/example-schema.yaml I thought
interrupt-names must contain irq name regardless of interrupt count,
because it helps to understand right property name.
I'll delete it for v2.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
>=20
> Why have this?
>=20

I agree, this header is needed for GPIO constant values, which is not used =
here.
I'll remove it for the v2 then.

> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        msa311: msa311@62 {
> Generic naming required.
>            accelerometer@62 {
>=20

Okay, I will change it in the next version.

> > +            compatible =3D "memsensing,msa311";
> > +            reg =3D <0x62>;
> > +            interrupt-parent =3D <&gpio_intc>;
> > +            interrupts =3D <29 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "irq";
> > +            status =3D "okay";
>=20
> We don't often have status in the examples.=20
>=20

Sure, status is useful for real dts declarations.
It's there because I copied this declaration from by tested real board dts =
:-)

>=20
> Otherwise looks good to me.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c75be17..4227914 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12482,6 +12482,7 @@ MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DR=
IVER
> >  M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> >  F:	drivers/iio/accel/msa311.c
> > =20
> >  MEN A21 WATCHDOG DRIVER
>=20

--=20
Thank you,
Dmitry=
