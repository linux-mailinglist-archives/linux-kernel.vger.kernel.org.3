Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890950D300
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiDXQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDXQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:00:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB281033;
        Sun, 24 Apr 2022 08:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A68CBCE0E64;
        Sun, 24 Apr 2022 15:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F572C385A9;
        Sun, 24 Apr 2022 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650815835;
        bh=hyDA78tEIPX5Y/hSMkh9Pr/zb0L53zVXz4DTZ/vS+Es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TcDSb4NQWuTTsbFSpRmWI+bsu+Erdbl1CfG0MMIweUG2AKM6r6g6Ju7bmDO/mooy/
         ccSaHS9h3t1UZSzqZFDOD19URxNCQky09Ebqhqmy635Xj6eXFwBAbe8BOQneHd9gma
         l2mLubk0rEUv3A7kK0Jv6xJki1A0ZLbtNO9pBn7A4AQhFN+EK4VgtDT0KpTRReOcuM
         0MVNrWPjd9UDHfnC5EPlsr5hB68CRyUJEKFFKDoPuwxpn0G9tivpyAG5V4qtxxJrA1
         47p/Juz+xP7P5HJQ9oOfFXBfhty+/oleKWWnuHbL6X4CF7KgDliY2iSKkaPJs1cVlc
         PR5ErByIg3uJw==
Date:   Sun, 24 Apr 2022 17:05:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: add AD4130
Message-ID: <20220424170522.1879c29b@jic23-huawei>
In-Reply-To: <f0f90430-fa90-129e-77bc-f5594206b76d@gmail.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
        <20220416160040.7e0d6015@jic23-huawei>
        <f0f90430-fa90-129e-77bc-f5594206b76d@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> >>
> >> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> ---
> >>   .../bindings/iio/adc/adi,ad4130.yaml          | 255 ++++++++++++++++=
++
> >>   1 file changed, 255 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4=
130.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> >> new file mode 100644
> >> index 000000000000..e9dce54e9802
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> >> @@ -0,0 +1,255 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +# Copyright 2022 Analog Devices Inc.
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Analog Devices AD4130 ADC device driver
> >> +
> >> +maintainers:
> >> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> +
> >> +description: |
> >> +  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found =
here:
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4130-8.pdf
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - adi,ad4130-8-16-lfcsp
> >> +      - adi,ad4130-8-16-wlcsp
> >> +      - adi,ad4130-8-24-lfcsp
> >> +      - adi,ad4130-8-24-wlcsp =20
> >=20
> > What are the variants?   They look to possibly be package differences?
> > + resolution differences.
> > They definitely need some description here.
> > It may make more sense to have one compatible and then some extra
> > booleans to say what it supported.
> > =20
>=20
> Packaging + available interrupt pins + resolution. Is having extra
> booleans to describe what is supported really the best approach?
> It's not really about how the hardware is configured anymore, is it?
> They're different chips.

It's unusual to have compatibles for packaging alone and I couldn't find
any clear references to the variants.  Maybe best we can do here is
add a bunch of documentation.

>=20
> > Long shot, but do the different packages have different model IDs?
> > The datasheet says
> > Model ID: 24-bit WLCSP Model ID. These bits are set by default for each=
 model and
> > are read only.  If there is one for each of these models then it would =
be
> > better to have a single compatible and do the detection of variant in
> > the driver.
> >=20
> > I'm not immediately spotting the resolution information in the data she=
et.
> > It is marked Preliminary but if there are details missing, please menti=
on
> > in cover letter so we don't go looking for information that doesn't exi=
st.
> > =20
>=20
> I don't have enough information about the other models to know what
> Model IDs they will have. That's why I took this approach.

My inclination is to probably not add the compatibles for those until we
do have that information.

>=20
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +    description: phandle to the master clock (mclk)
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: mclk
> >> +
> >> +  interrupts:
> >> +    minItems: 1
> >> +    maxItems: 1
> >> +
> >> +  interrupt-names:
> >> +    minItems: 1
> >> +    maxItems: 1
> >> +    description:
> >> +      Default if not supplied is dout-int.
> >> +    items:
> >> +      enum:
> >> +        - dout-int
> >> +        - clk
> >> +        - p1 =20
> >=20
> > This is unusual.  It is probably helpful to add more description to
> > explain that the data ready/ fifo interrupt can be routed to any of the=
se
> > pins. =20
>=20
> Is it unusual? ADIS16480 follows a similar approach.

I think I got thrown by the large number of choices for a single interrupt.
Flexibility of interrupt routing is common but I've never seen 4 choices for
a single interrupt before :)

>=20
> description: |
>    Specify which interrupt pin should be configured as Data Ready / FIFO
>    interrupt.
>    Default if not supplied is dout-int.
>=20
> How does this sound?

Sounds good to me.

>=20
> >  =20
> >> +        - dout
> >> +
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 0
> >> +
> >> +  refin1-supply:
> >> +    description: refin1 supply. Can be used as reference for conversi=
on.
> >> +
> >> +  refin2-supply:
> >> +    description: refin2 supply. Can be used as reference for conversi=
on.
> >> +
> >> +  avdd-supply:
> >> +    description: AVDD voltage supply. Can be used as reference for co=
nversion. =20
> >=20
> > Whilst these are optional in theory, you should call out that they must=
 be
> > provided if any of the channels use them as a reference.
> >  =20
>=20
> I thought that "Can be used as reference for conversion." + it being an
> option in adi,reference-select property would make it obvious, no?

More obvious is always good, but you are probably right and I was just
not terribly awake when I wrote that :)

>=20
> >> +
> >> +  iovdd-supply:
> >> +    description: IOVDD voltage supply. Used for the chip interface.
> >> +
> >> +  spi-max-frequency:
> >> +    maximum: 5000000
> >> +
> >> +  adi,mclk-sel:
> >> +    description: |
> >> +      Select the clock.
> >> +      0: Internal 76.8kHz clock.
> >> +      1: Internal 76.8kHz clock, output to the CLK pin.
> >> +      2: External 76.8kHz clock.
> >> +      3. External 153.6kHz clock. =20
> >=20
> > For the external clocks, can we use the fact that one is supplied
> > as enough to tell us we should be using them?  Then query the
> > frequency directly from that clock?
> >  =20
>=20
> Aren't we supposed to set the frequency of that clock ourselves,
> in the driver?

True, I got that backwards.

>=20
> > If no clock provided then clearly internal.  All that is
> > necessary after that is a boolean to control if the CLK output
> > is enabled or not (and ideally constrain that to only be possible
> > if in internal clock mode).
> >  =20
>=20
> Well...
>=20
> So, mclk present =3D> external, not present =3D> internal.
> adi,int-clk-out-enable to specify if the internal clock should be
> exposed? adi,ext-clk-freq to specify the desired clock speed of the
> external clk?

Yes that sounds good to me.  I just don't like magic numbers
in bindings if we can avoid them.   With the above a reader should
be able to figure out what is going on without reading this doc.

>=20
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [0, 1, 2, 3]
> >> +    default: 0
> >> +
> >> +  adi,int-ref-en: =20
> >=20
> > Mentioned below...
> >  =20
> >> +    description: |
> >> +      Specify if internal reference should be enabled.
> >> +    type: boolean
> >> +    default: true
> >> +
> >> +  adi,bipolar:
> >> +    description: Specify if the device should be used in bipolar mode.
> >> +    type: boolean
> >> +    default: false
> >> +
> >> +  adi,vbias-pins:
> >> +    description: Analog inputs to apply a voltage bias of (AVDD =E2=
=88=92 AVSS) / 2 to.
> >> +    items:
> >> +      minimum: 0
> >> +      maximum: 15 =20
> >=20
> > If I read things correctly VBIAS_CONTROL is a bitmap across the 16 inpu=
t lines.
> > So why use a single value rather than either a list of pins, or a bitma=
p?
> >  =20
>=20
> Umm. Isn't this a list of pins? That's why everything is plural here.
> I guess I should add `maxItems: 16`?
> I already added `$ref: /schemas/types.yaml#/definitions/uint32-array`.

Ah. Yes, with an array and maxItems this will be fine I think.

>=20
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts
> >> +
> >> +patternProperties:
> >> +  "^channel@([0-9]|1[0-5])$":
> >> +    type: object
> >> +    $ref: adc.yaml
> >> +
> >> +    properties:
> >> +      reg:
> >> +        description: |
> >> +          The channel number.
> >> +        items:
> >> +          minimum: 0
> >> +          maximum: 15
> >> +
> >> +      diff-channels:
> >> +        description: |
> >> +          Besides the analog inputs available, internal inputs can be=
 used.
> >> +          16: Internal temperature sensor.
> >> +          17: AVss
> >> +          18: Internal reference.
> >> +          19: DGND.
> >> +          20: (AVDD =E2=88=92 AVSS)/6+
> >> +          21: (AVDD =E2=88=92 AVSS)/6-
> >> +          22: (IOVDD =E2=88=92 DGND)/6+
> >> +          23: (IOVDD =E2=88=92 DGND)/6-
> >> +          24: (ALDO =E2=88=92 AVSS)/6+
> >> +          25: (ALDO =E2=88=92 AVSS)/6-
> >> +          26: (DLDO =E2=88=92 DGND)/6+
> >> +          27: (DLDO =E2=88=92 DGND)/6-
> >> +          28: V_MV_P
> >> +          29: V_MV_M
> >> +        $ref: adc.yaml
> >> +        items:
> >> +          minimum: 0
> >> +          maximum: 29 =20
> >=20
> > Interesting. So we have a part that has a 16 channel sequencer, but
> > can you have more channels as long as you don't want them all at once?
> > For example, I doubt anyone wants to permanently configure a device to =
monitor
> > the various supplies, but they will want to occasionally.
> >=20
> > As such, perhaps we need to treat this device more flexibly?
> > There are obviously contraints on what channels + references make sense
> > but maybe we should allow more than 16 to be specified?
> >  =20
>=20
> Ehhhhh. Look at the driver. It's already pushing 2k+ lines with
> the 8 setups for 16 channels situation + all the extra options the
> chip provides. If we also make it so that channels are rewritten at
> runtime, it will turn into a mess. Or at least I don't see a clean
> way of adding that. Besides, then I'd have to do all these extra
> allocations depending on the number of channels in the device tree...
> It gets complicated. If a customer expresses his interest in this,
> I guess I'll have to add it.
> Also, presumably the extra inputs are marketed as diagnostics.

Another approach would be to 'always' provide those diagnostic channels
but not via buffered interface (if that's sensible to do).  Then potentially
drop them from this binding?

Maybe waiting for customer demand is the best way to go.  Even if you
added a path to read them without them being in DT later it should be
easy enough to maintain backwards compatibility.

Jonathan
