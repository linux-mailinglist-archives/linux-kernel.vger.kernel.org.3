Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB74CF09E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 05:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiCGETh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 23:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiCGETd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 23:19:33 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E120F40;
        Sun,  6 Mar 2022 20:18:39 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id u61so28479574ybi.11;
        Sun, 06 Mar 2022 20:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=70QANHuilS/DlNxXzeIJU0v7aYUQYFYcd/4PORiu+uY=;
        b=Rfkg5uXdxfhsC2SowUbgLkhAxsUQJPxW6TxbLfbGeQzbEpaduiyaXYCxHPSUp1dSzS
         mKEcqEgK8DiBhNJgIicaA4WqVJaEtYukMYaeFwwigVKKg2m9a9OpEmseSmFwUIxRmeks
         2zFUwxlditEuf4BdMXjLC//Hi2AOcbq2fny4YuTvYjpxhzMuje7B/g3uskDkGP0b9az2
         L5eUyzf6DursWQcam2ME8qfQbt2kaUAMlAEkv7A2RKkgEgIQ4b4G0gveGHV0M8Kp52R4
         6xMcgaT5iweciEUVvk2F2JjGFyVwR58gtOQk6vwnbeINGjlmFGho8k3r/87to+B/pJaO
         +y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=70QANHuilS/DlNxXzeIJU0v7aYUQYFYcd/4PORiu+uY=;
        b=rMjVjimQbKPqB4RdNsq4sbwXLshMv73cmKUxUdmJYbkTJOiNi5rbPXOlBOzsDWJkfm
         CFLs4fr2MIUgd3tS5EThS9qZ4eJu/LgVWragP0Jf+lSxUbtP9yYFefNm66fOM/v4xqbH
         wBMc8HtbZl7snKUyEbEjLR2YIeX92b5HI+hVIoENdhIhE8IrRSjDDMS6cjIXt7T86G/z
         Ru0/j43LIiYv/RpGel4n8jQAek62tI5IWSXZdReQZil6SbNRjqSIhbaVkQC8WzxnRYpT
         Iod8f/oFLHAFExdlEXdeXBDRmqm4H4biQmP8kmUFkCDjkyVWDoVGy7EAlmCBWMLpuW5T
         UD4Q==
X-Gm-Message-State: AOAM533sEdwpKsIlXtfCPgRWyHPbm74y4FRwnEn0n7U+QUhyEjdIFZKs
        XyDBJ4BglFrpEH7jNUDp231MUrF5ftxU3FzStgY=
X-Google-Smtp-Source: ABdhPJw7BijN/ynaHoEV5vwHawxOUNKoamH/zSoxJcsIt541xlSgaj1LP3N2cCntuQmBAgX0TLkhqF2P7dEoq/TmXnw=
X-Received: by 2002:a25:e697:0:b0:629:1f4a:5a3c with SMTP id
 d145-20020a25e697000000b006291f4a5a3cmr4998993ybh.228.1646626718685; Sun, 06
 Mar 2022 20:18:38 -0800 (PST)
MIME-Version: 1.0
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-2-git-send-email-hammerh0314@gmail.com> <9113e319-58a2-fd90-6887-fb32eb21fd18@canonical.com>
In-Reply-To: <9113e319-58a2-fd90-6887-fb32eb21fd18@canonical.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Mon, 7 Mar 2022 12:18:56 +0800
Message-ID: <CAOX-t55sXVg8Fj_G_xzxWTStxZXOwKo46=_R0LkfHnMS051KaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings:pwm:Add bindings doc for Sunplus SoC
 PWM Driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     thierry.reding@gmail.com,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, lee.jones@linaro.org,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
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
=B9=B43=E6=9C=884=E6=97=A5 =E9=80=B1=E4=BA=94
=E4=B8=8B=E5=8D=8811:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 04/03/2022 07:20, Hammer Hsieh wrote:
> > Add bindings doc for Sunplus SoC PWM Driver
>
> You miss spaces in the subject.
>

ok, will modify it.

> >
> > Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> > ---
> > Changes in v2:
> >  - Addressed all comments from Rob Herring.
> >    modify author's mail match Signed-off-by.
> >  - rebase kernel to 5.17 rc5
> >
> >  .../devicetree/bindings/pwm/pwm-sunplus.yaml       | 40 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  5 +++
> >  2 files changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.y=
aml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml b/D=
ocumentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > new file mode 100644
> > index 0000000..19fe5d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) Sunplus Co., Ltd. 2021
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-sunplus.yaml#
>
> Is it going to be one binding for all Sunplus SoCs? Existing and future?
>

yes, that was my first plan.
but not all sunplus SoCs use the same IP-based,
so I will change file name form 'pwm-sunplus.yaml' to
'sunplus,sp7021-pwm.yaml' in  next patch.

> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sunplus SoC PWM Controller
> > +
> > +maintainers:
> > +  - Hammer Hsieh <hammerh0314@gmail.com>
> > +
>
> allOf with pwm.yaml
> Then unevaluatedProperties instead of additionalProperties.
>

ok , will add it.

>
> > +properties:
> > +  '#pwm-cells':
> > +    const: 2
> > +
> > +  compatible:
>
> Commpatible goes first. Rest of properties you could order
> alphabetically. Similar approach in required.
>
>

ok, will modify it.

> > +    items:
> > +      - const: sunplus,sp7021-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
>
> compatible
>
> > +  - reg
> > +  - clocks
>
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm: pwm@9c007a00 {
> > +      #pwm-cells =3D <2>;
> > +      compatible =3D "sunplus,sp7021-pwm";
>
> compatible goes first, then reg.
>

ok, will modify it.

>
> Best regards,
> Krzysztof
