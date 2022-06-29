Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B755FB39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiF2I7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiF2I7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:59:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EE924956;
        Wed, 29 Jun 2022 01:59:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g26so31171455ejb.5;
        Wed, 29 Jun 2022 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ey+1hPLWMzu03pOiFsT4/+TTM+sA5fHRsZxt3a18l5I=;
        b=ITFrgF4tOWPEhvarmRB5prRer9hEUz+UyNGFHcwfTGVb8Iu9ut4cyieJU0oum2eSvM
         Z7BNbjCLM32ciGEqgOGAt7TvZQjazxOM+YygBbgwnjhjYYYJ2Wx9VoLysU1iJ94izIR6
         Bxw0IUWp6KLy/n7RGqg926kFq6jj29j3PJaXlUIotrrJ61Xf5csNYpp03WfWmkS0xDco
         G9WP5jKLZnsQRv3rm4KWk2n9Hu+SwCfuT700IElUw1emp0EzBS9CIQIZm++CAZOvUm+f
         CJWFt8Y0z0e5g5Jv90vt0p3lNiwAnXhlj5S9VWNfWOVvsoIO4LRu6jEhJxjB2suMC1Vh
         9Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ey+1hPLWMzu03pOiFsT4/+TTM+sA5fHRsZxt3a18l5I=;
        b=RgxoT/J5sEJb500PAC9PnD7wGOeECmuR0QB+uN80CALXWxDGSJRaY7i+w7KPl/UuE2
         XDj5fk0F7RPaPiTNq0/szGD/CBU2dMDP8v/RfYOI4bmrS0IEwllxv8dVNiJHHOXkmF+/
         dpHdWMZql5KGSR7MypGhNCdr1q/2weh+X2l9mAP9AzFUYnFul5afgPT9TLM4XBbu4hAk
         rvpZfBmVZT5s2atBimiM8a6YSHkPuHCXTukews7lq+88vCMkkeTqdZC1wvlNADiT4i0w
         BUDCC9u2b8x2MeFw6+3Zf1BZgHYpZafd/C6iCq4XHbTXUjQYvmQM7ZuwIkUOc18nTHKs
         HEoQ==
X-Gm-Message-State: AJIora/G6GuOY8cekN6tMJbHOEHqxwy+yI8UURBvFgToH2Pjp+/ZoY+I
        HAvj9tmwsgdc8mTfzJiVnNoTwle1I5ftsPccOM4=
X-Google-Smtp-Source: AGRyM1tS17F0rorf47vhU8c0TPDYGRUlrVAu3BBSUv1DO0tbWiOYhXEPu0at2UeRXUwCcE+w/UrNYs+A6K2xfqP0bo4=
X-Received: by 2002:a17:907:72d0:b0:726:ec43:9bb with SMTP id
 du16-20020a17090772d000b00726ec4309bbmr2032289ejc.533.1656493181431; Wed, 29
 Jun 2022 01:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-2-git-send-email-u0084500@gmail.com> <bc6f42d9-f821-ad0c-85c8-b4a4d2146485@linaro.org>
In-Reply-To: <bc6f42d9-f821-ad0c-85c8-b4a4d2146485@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 29 Jun 2022 16:59:30 +0800
Message-ID: <CADiBU39TPVhDgZkv27mzWNMD5EVOg_jFq=_mFLa6tPZ6EwjT3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B46=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:25=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 29/06/2022 04:20, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add the documentation for Richtek rtq6056.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Since v2
> > - Change the resistor property name to be generic 'shunt-resistor-micro=
-ohms'.
> >
> > ---
> >  .../bindings/iio/adc/richtek,rtq6056.yaml          | 56 ++++++++++++++=
++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,r=
tq6056.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.=
yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> > new file mode 100644
> > index 00000000..fe45d8b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit AD=
C
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  The RTQ6056 is a high accuracy current-sense monitor with I2C and SM=
Bus
> > +  interface, and the device provides full information for system by re=
ading
> > +  out the loading current and power.
> > +
> > +  The device monitors both of the drops across sense resistor and the =
BUS
> > +  voltage, converts into the current in amperes, and power in watts th=
rough
> > +  internal analog-to-digital converter ADC. The programmable calibrati=
on,
> > +  adjustable conversion time, and averaging function are also built in=
 for
> > +  more design flexibility.
> > +
> > +  Datasheet is available at
> > +  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: richtek,rtq6056
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +  shunt-resistor-micro-ohms:
> > +    description: Shunt IN+/IN- sensing node resistor
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#io-channel-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      rtq6056@40 {
>
> This was not fixed.
>
Sorry, too many changes to check. I really forgot it.
>
> Best regards,
> Krzysztof
