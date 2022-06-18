Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27CD5505E4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiFRPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiFRPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:50:45 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C6413D0A;
        Sat, 18 Jun 2022 08:50:43 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id b81so3289500vkf.1;
        Sat, 18 Jun 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T3SgY9Ix2aQ1fUpUhaxNDx5u2J5tcKzRVXLg7gEU6qc=;
        b=DAwZ8Ft7Sba01Z8evn6uoWQoH9rK99FXpEvjXBnA5t7tR3tZLlgrp6fUNJv9smBdlj
         w2ry2c8bJtmivQXeLqhPT2XSBwsFoWYms32x2AaQxszi3YExASCUQR0PkaTxQV3cFlrR
         H0zI0OIOrxec4FoQbqX8kAUShOTUk2SnVSM+qgS85KMl1SWMTpWYfrRin8vQP1lljFwP
         I5N+LN+QzHKmXYl1N8qFwNU6ukkXn604ClWenfzZhuYkvrQ78LPX9mz2JVzzk3vy812F
         lqiWIiDFkmRXuzz+9HK7tMIqicYzR0YRcelW3rE6DWb3aPsVT73OSAfla5enZiLhj5LJ
         DlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T3SgY9Ix2aQ1fUpUhaxNDx5u2J5tcKzRVXLg7gEU6qc=;
        b=mUGPuyucpWNesAnQ5p8V654b/dSXU4xC1At8frqmiTqJ/B2+JXI43Dbmrz22wgVMyW
         r7YIr7jzNsnMaU8pXq09AQTXF96m3anEHKzVSQprrT4HldaDqRkh1M6+r5w7y1H1fIjo
         GrjK4ZJovU7wtQRS21UNJMpu2ZCF7L3sPkQm4M49Cwim7RG2u9iuJX2JtBkWXQWXnTL4
         5vlIgPVF+3GPMS6PNXRRAINXkgm+4HXQ6ClQCt7GTYQKFIs0BHeoEE8JYSDTgwpsryOO
         E16rnpHK3MWuOj5LlRVEt2H66Hfqbkkw1ZfO9Swc01anMTSwCCn0EGAAG4ddop4BFtvr
         5V9g==
X-Gm-Message-State: AJIora8kvN2Nnr/wax/o9o//qSmfcf1k/1Zlso+uB9GBPb7/OdUqLYnO
        f8jucz5Yyu6G90QUVZ4htIV0aihphkW9m8/XDDmVAtqk
X-Google-Smtp-Source: AGRyM1ubde/CEtYH/tGSzFgCo0k54FpcDOVXmIF4a2Tu5TcjzQIXDvB+7E3C4YBEkNvrSXZwPSqpnL4auCvuFJ6z9zY=
X-Received: by 2002:a1f:18c4:0:b0:35c:d0f9:c547 with SMTP id
 187-20020a1f18c4000000b0035cd0f9c547mr6544075vky.29.1655567442932; Sat, 18
 Jun 2022 08:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-2-git-send-email-u0084500@gmail.com> <7a9d3354-164b-e5e5-936b-95de4c4338f9@linaro.org>
In-Reply-To: <7a9d3354-164b-e5e5-936b-95de4c4338f9@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 18 Jun 2022 23:50:32 +0800
Message-ID: <CADiBU3_wyFLpoy3PU0a-EbGAKoQ9LZMprH5DWnzwo05-Gwa2=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
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
=B46=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:45=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 17/06/2022 02:32, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add the documentation for Richtek RTQ6056.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/iio/adc/richtek,rtq6056-adc.yaml      | 57 ++++++++++++++=
++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,r=
tq6056-adc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-=
adc.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.ya=
ml
> > new file mode 100644
> > index 00000000..6b4e0e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yam=
l
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056-adc.yaml#
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
> > +  richtek,shunt-resistor-uohm:
>
> Use standard properties, so "-micro-ohms". Drop the unit from
> description and drop the ref.
>
Use richtek.shunt-resistor-micro-ohms?
Or the prefix 'richtek,' can be removed?
> > +    description: Shunt IN+/IN- sensing node resistor in microohm.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
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
> Generic node name, so probably "adc" (or something else appropriate).
>
Ack in next.
> > +        compatible =3D "richtek,rtq6056";
> > +        reg =3D <0x40>;
> > +        #io-channel-cells =3D <1>;
> > +      };
> > +    };
>
>
> Best regards,
> Krzysztof
