Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3D5113F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiD0JDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiD0JC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:02:58 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864AF1EE1FB;
        Wed, 27 Apr 2022 01:59:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 2080B5FD13;
        Wed, 27 Apr 2022 11:59:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1651049977;
        bh=2mztbYGe3irG8fxZ5rjxop8bDyyrOgSYnSdRSoEfjfw=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=N8/GFe9oGWqVXdZpcAqhkQTzEuWKGpGs9jS0MJW3KHEnbucix+eZCoP0rBS4fWiDT
         9xOKwOFRQ5AHi2ogzhFWnMcA0Fw8YWco2F6LxiRc5CoWXebLrIMsYU5vttsnleITUE
         2r/wSk6s4obIP8Rlb4tx7XsxjRJP9n67aW3OXBnYQYRK9IaN+gDqA8mNMjviAQxXUI
         Ubp1M6xN+abkInQi3e7kBk+QeId/uPq+F8bXwFjxdm6jNOzKxtU7VlxHwuvg8ZZ+G6
         1pA/YHY/2EjqCQkskrSz0K77NUz60L9FtC7BfF5BB6hnCLamTYXiy2peGKwUk8Pa6B
         Wk46sDUbHePEw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 27 Apr 2022 11:59:36 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>
CC:     "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
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
Thread-Index: AQHYVASQQZC393Ji1keuDd+e+35bUq0CfseAgADRHQA=
Date:   Wed, 27 Apr 2022 08:58:45 +0000
Message-ID: <20220427085932.z3l7h2vash4km4r2@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-4-ddrokosov@sberdevices.ru>
 <YmhWic3rG8ERtCYY@robh.at.kernel.org>
In-Reply-To: <YmhWic3rG8ERtCYY@robh.at.kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78FB6C8D15AE644680148FCB8B984191@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/27 03:59:00 #19365489
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for review! I agree with all things you mentioned. It will be
fixed in the next v2 patchset.

On Tue, Apr 26, 2022 at 03:31:05PM -0500, Rob Herring wrote:
> On Tue, Apr 19, 2022 at 03:45:58PM +0000, Rokosov Dmitry Dmitrievich wrot=
e:
> > Introduce devicetree binding json-schema for MSA311 tri-axial,
> > low-g accelerometer driver.
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
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
>=20
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>=20
> These apply to 'reg' in a child node, but you don't have child nodes so=20
> drop them.
>=20

Ack

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
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c0 {
>=20
> i2c {
>=20

Ack

> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        msa311: msa311@62 {
>=20
> accelerometer@62 {
>=20

Ack

> > +            compatible =3D "memsensing,msa311";
> > +            reg =3D <0x62>;
> > +            interrupt-parent =3D <&gpio_intc>;
> > +            interrupts =3D <29 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "irq";
> > +            status =3D "okay";
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
> > --=20
> > 2.9.5
> >=20

--=20
Thank you,
Dmitry=
