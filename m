Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372E84B7CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbiBPBvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:51:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbiBPBvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:51:17 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF11FA235;
        Tue, 15 Feb 2022 17:51:06 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id bt13so1637777ybb.2;
        Tue, 15 Feb 2022 17:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zgZsN7oUvazPcA59OzEiJ3ZRYuzqTaOIlq6Gf9AbiHs=;
        b=CerpXZ9trzLcnSio8lebrkpKr0iKgIeBUHWagYx6AmkV2p0fH2XUk90jJR1aJ7qenD
         SLNi8VpVHHW8NTMu4LbSfL5BkQo+aeDwPEyagD5r0sazNmThl1XUm7amKO+e3wFkzjtR
         Eq7djuNwjREq8C2TOf4Bcz1ACWH7dCJAoSLf5Tq9wJzpIozYhZdBw9kEZ7CnHernaWBl
         gBWUsXJCL85OAkWBwSM5pl7q0VrXADeoHku13l9TFlwMxSNBPAQV3p27g3YNGbQItnXm
         /vJSCsb3HbI7gIej6J9F6j1TTfktepD7i1sY6Zz5psSBD9wrbEa9FQ/TvK5TyVAukb0B
         YWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zgZsN7oUvazPcA59OzEiJ3ZRYuzqTaOIlq6Gf9AbiHs=;
        b=3uw36DvFwejZQEEEnhk3VIwNvyuJA5+ehSs8EHfshU5UORHORTAbnv7vuRZJWUQCyQ
         6hnEAJSjpjklNtuv7pES1W77UnmdV46Z77LC/s81R/4S6jXs4LhBXa656awZ0DZb7H27
         T7Muja2+UKYqFkCdwZHgC/Stj9xBkiQ6q3k1pd3qO7kDuD5YKMmYdvWCI5MNaNJeJuJU
         LN5CRXRW2ZgjD4llOf33QcMwSmNeLjn3ggy8BKJeitqK8nNbdbaEUvaW07a5Vw8wzYua
         rMktJhVZ8othuZLZ9aydEZU3XK+MuIHpKxatuTPuHXzsrMWb9DFAY4cRk1lZlFlmNxqp
         k2Vg==
X-Gm-Message-State: AOAM532K2W1COvFnhT+Ff2gcEmoqmeqLsSH6PBF84AYk4zx41PlT6LPp
        EUwo0MtEafkW7/BiGGxZs4MYB2BR+U+NW9gvRrLqTeJ2
X-Google-Smtp-Source: ABdhPJzlFDa6naeVKOpgrMFYKIzN8aBeFhAICkRmdRT7vQxr/k+FFv+b7g3Ocm7b+8ED/BTEGcsf88ctDDcBVClw6yg=
X-Received: by 2002:a25:6d87:0:b0:60f:fa38:fbd8 with SMTP id
 i129-20020a256d87000000b0060ffa38fbd8mr363321ybc.560.1644976266023; Tue, 15
 Feb 2022 17:51:06 -0800 (PST)
MIME-Version: 1.0
References: <1644917065-23168-1-git-send-email-hammerh0314@gmail.com>
 <1644917065-23168-2-git-send-email-hammerh0314@gmail.com> <b50bf9ef-eb38-8e86-70f9-7a9a959be67b@canonical.com>
In-Reply-To: <b50bf9ef-eb38-8e86-70f9-7a9a959be67b@canonical.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Wed, 16 Feb 2022 09:51:21 +0800
Message-ID: <CAOX-t55+_AE9eKf3OwRb1pos7gZZBa1xVV7EXAEMDQ2mm5VS0Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings:serial:Add bindings doc for Sunplus
 SoC UART Driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        p.zabel@pengutronix.de, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>
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

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=E5=
=B9=B42=E6=9C=8815=E6=97=A5
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 15/02/2022 10:24, Hammer Hsieh wrote:
> > Add bindings doc for Sunplus SoC UART Driver
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> > ---
> > Changes in v8:
> >  - no change.
> >
> >  .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  5 ++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp=
7021-uart.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-ua=
rt.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> > new file mode 100644
> > index 0000000..894324c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) Sunplus Co., Ltd. 2021
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Hammer Hsieh <hammerh0314@gmail.com>
> > +
> > +allOf:
> > +  - $ref: serial.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sunplus,sp7021-uart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    aliases {
> > +            serial0 =3D &uart0;
>
> Incorrect indentation. With this fixed:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
>
> Best regards,
> Krzysztof

OK, will modify it. Thanks.

Regards,
Hammer
