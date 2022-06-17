Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7054F6AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381530AbiFQL1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381290AbiFQL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:27:09 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABD6BFD1;
        Fri, 17 Jun 2022 04:27:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y12so4219890ior.7;
        Fri, 17 Jun 2022 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cIita4Mx/OZl+X+VeaS6ACjFa0zy1JtZ/wxGcvDjX4M=;
        b=cBnghZ9dK8jQypp2zWcU1IJmfJ9ib0azbSO3a6CUrQ6p7k8MqcOEu38UcGE/ELnbTj
         H8ijRkJPVfwZkD66BARfJX9oqGp5ge7C/Qw3DlQbZsvEEWj/J9mBU7bCEKxQwlnlHY9M
         SBloAA7m7tmnhDjWeMSIY/T7PARhocjfJGPxhzOeODLK3cPap+SSyb4kH1Z//ZuD4l8v
         x9YVQQnDeCAKKsgUNQMFXKyMOFvhFCJyKXsnWZg4h4AFQs9m8271FmL3Oc4bhBIDrys2
         AKhbEKwxmxTk/45W3UpXfGJzK42rRBHh7djKKQ7LrLGqFCSjNEcYTb/10k6Q8kliAaAJ
         T0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cIita4Mx/OZl+X+VeaS6ACjFa0zy1JtZ/wxGcvDjX4M=;
        b=OW06Ppzody8xhgFYSzr1WtIbLRoJ+Jj1vA6a1Fw9sNPPpKxDF0CtTsx7IUVFGEfgVD
         4iSdJGRBbsWE8EOFoYPhFK6t1pQ8t+fZ5s+DKCMJcukEnxFkOe/5dXqfciaWEQAHitu2
         fY5VV9C3iNqY/jUbSwkACv6bKPP4xnU05/dG40bJnMZIbXVLuT3FnGbbCGNmPk9JJu5X
         HBd+lmB0zIEb/xOjtrTQ9SEndgu6HbpcWRC86jyDtce9BZWbK3Wpp5bkSeW6p1Dt5FLs
         UtBMQ1znIfmdE17SG0/lHV6mqwI29ZVp337uf1oM2mVJEEKUWVMUbbTh0Zf2GUYSQTmZ
         s1Qg==
X-Gm-Message-State: AJIora9twcC8lcid0wmNWgWpIkb7ju6Vm3srqdGyk0cXyz0QW+lzbpg2
        GbWI9ul1BcJ1WgPOa5lmzAMXur3ZdiXnudfylRwwNuBzDa4=
X-Google-Smtp-Source: AGRyM1v+uOPPKXH5BGj0nN0XZL/uXw8K7soKzPUvo/hXYcZRuyA8S1WlggM3NtZdIqlhGxZxIj4Std5tTPlwSTv8/pI=
X-Received: by 2002:a05:6638:d01:b0:331:d29a:8e60 with SMTP id
 q1-20020a0566380d0100b00331d29a8e60mr5201134jaj.254.1655465225916; Fri, 17
 Jun 2022 04:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-7-peterwu.pub@gmail.com>
 <28b73da7-d97c-5ea5-0b22-724fa971aeb0@linaro.org>
In-Reply-To: <28b73da7-d97c-5ea5-0b22-724fa971aeb0@linaro.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 17 Jun 2022 19:26:55 +0800
Message-ID: <CABtFH5LTpHyaJvwr6WHWx89gdGmsD-inWJa_LidyJzSL5bxowg@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: mfd: Add Mediatek MT6370
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B46=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94 =E6=B8=85=E6=99=A85:15=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 13/06/2022 04:11, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Mediatek MT6370 binding documentation.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/mfd/mediatek,mt6370.yaml         | 279 ++++++++++++++++++
> >  .../dt-bindings/iio/adc/mediatek,mt6370_adc.h |  18 ++
> >  2 files changed, 297 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt63=
70.yaml
> >  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml=
 b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > new file mode 100644
> > index 000000000000..6c2639e81e50
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> > @@ -0,0 +1,279 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/mediatek,mt6370.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek MT6370 SubPMIC
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  MT6370 is a highly-integrated smart power management IC, which inclu=
des a
> > +  single cell Li-Ion/Li-Polymer switching battery charger, a USB Type-=
C &
> > +  Power Delivery (PD) controller, dual flash LED current sources, a RG=
B LED
> > +  driver, a backlight WLED driver, a display bias driver and a general=
 LDO for
> > +  portable devices.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6370
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  wakeup-source: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +
> > +  adc:
> > +    type: object
> > +    description: |
> > +      Provides 9 channels for system monitoring, including vbusdiv5, v=
busdiv2,
> > +      vbat, vsys, chg_vddp, ts_bat, ibus, ibat, and temp_jc.
> > +
> > +    properties:
> > +      compatible:
> > +        const: mediatek,mt6370-adc
> > +
> > +      "#io-channel-cells":
> > +        const: 1
> > +
> > +    required:
> > +      - compatible
> > +      - '#io-channel-cells'
>
> Decide in your entire patchset whether you use ' or ". Don't mix.

Thanks for your comments.
We apologize for doing these mistakes...
We will use the same symbol in the entire patchset and check again
before the next submission.

>
> Since you did not test your bindings, I am not reviewing it. First, test
> them. No need for me to do the job of a automated tool, right?
>
> Best regards,
> Krzysztof

Best regards,
ChiaEn Wu
