Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E7454CC89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349036AbiFOPTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347617AbiFOPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:19:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8A2E09B;
        Wed, 15 Jun 2022 08:19:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 20so19420013lfz.8;
        Wed, 15 Jun 2022 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxmL7VaieafuZ6quU52kIVB4lyDd5PT6tuLwul05VPc=;
        b=eDd+GB9xWpKXivIdy2gmo9fuwqLcBWKPc8BfczR/uUamhxb1rVI7w7DM1KAjO1OxXy
         2++nHjCfTMjc2X/HhvDRlwlcJMI/0yk6t8S6slTGw8b+0Sj2RS/DH9Nc4A+pty4DbnX0
         jzMOJtkxKns89wT26VSA7npXXthASfWZd0i9YloAKxRP7D3KSfvLMjwVyUSxSdMNGX5P
         EdC1fkW7uY+Kv22aJMXe/QGYFZSp5rPJ93KFxGanGx5tW/XRO2bAINFaPXaguLgFYCsU
         cXf7PSdkt9D5xk6PJ8bMCaRKHoZhsPrfAjzrGq6X7mYMdQV1eq4azoqIKiiwZMiDVJWY
         y9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxmL7VaieafuZ6quU52kIVB4lyDd5PT6tuLwul05VPc=;
        b=USK80m7g4WB0rTUtelhRcAh7XbDdi5gRQIjBHxImFB7cJ8gaz4OxRBsiJK6evFu6CM
         M2nOiKdguBkzmUgwll8NXwL0VeMgDvnZtyoDtuiX2x2eGnRvGUhZrGkUWrP03ESIPPBE
         +EgZJ30TAvt1Gw/PCr/QvZlvz53fy+JF6Bh1k+l31l7cE1ehpRIWRTMR/l6qchNO4Dms
         lqpy1wXOtUEF782oEcLW0PU87cM7okcQIDKE6n87EYjh5u31Hl1V9FNAx8hzJNWMFdJR
         dUbBG2msDj4MoK8bViecNTEb+34V+OK5e+9OMDae4WTt4kcUINx4tRuA1s3pjbEWdRln
         vDog==
X-Gm-Message-State: AJIora+/CZCDwWEJK/WRAtnH8M9anyrhjm/FlwT/lzzs+1AwtOaMBkdv
        XGk8lw9MIyHX66RKsF17w316YSFudyw9M5xWrg8=
X-Google-Smtp-Source: AGRyM1tIVRm/39MptkbLVKBy49NSklljQ82n+xmsnIJa7nbocpR7rEVrKlPaIUmUunQHP0jLv+bO+LOC4SWPpVeUIns=
X-Received: by 2002:a05:6512:234e:b0:479:3bb1:8d3c with SMTP id
 p14-20020a056512234e00b004793bb18d3cmr19378lfu.478.1655306345755; Wed, 15 Jun
 2022 08:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220609150851.23084-2-max.oss.09@gmail.com>
 <CAMuHMdWm5WV7L=HJnysw76ObG_QPWicSH1kGg4k-GL8nNHd_SQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWm5WV7L=HJnysw76ObG_QPWicSH1kGg4k-GL8nNHd_SQ@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 15 Jun 2022 17:18:54 +0200
Message-ID: <CAEHkU3Vw-Yt6COpJ=K-98CA5dH-iD6AnSHwuBFmQg8yfNsgb-w@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: power: Add bindings for a power
 domain controlled by a regulator
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jun 14, 2022 at 9:24 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Max,
>
> On Thu, Jun 9, 2022 at 5:16 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > Adds binding for a power domain provider which uses a regulator to control
> > the power domain.
> >
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/regulator-power-domain.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/regulator-power-domain.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Power domain controlled by a regulator
> > +
> > +maintainers:
> > +  - Max Krummenacher <max.krummenacher@toradex.com>
> > +
> > +description: |+
> > +  Power domain provider which uses a regulator to control
> > +  the power domain.
> > +
> > +allOf:
> > +  - $ref: "power-domain.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - regulator-pm-pd
> > +
> > +  power-supply:
> > +    description: The regulator used to control the power domain.
>
> I guess there can be more than one?

The proposed implementation currently only uses one.

When I did it I considered more than one regulator a rare use case and
I was under the impression that the generic power domain code
can handle multiple power domains. With that in mind I assumed that
one would create multiple regulator-pm-pd instances each controlling
one regulator and add all of them to the power-domains property of
the power domain consumer.

But it seems the implementation requires the power domain consumer
to handle that case in its code rather than relying on the generic code. [1]

Do you see a real world use case to handle multiple regulators?

Max

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/domain.c?id=8cb1cbd644d5bba5b72eedd632f249c1c677b792#n2290


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
