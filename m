Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDED550EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiFTDHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiFTDHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:07:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1865B2;
        Sun, 19 Jun 2022 20:07:40 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id m16so5055740ilf.6;
        Sun, 19 Jun 2022 20:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ClA6mV7hozr21kuBkeCxjd9fGNxXJpc68c5A8HEJUUI=;
        b=gOpv1108ut5ySpAPndiTka0cdAPZs7Flmw6QF/XASUursDWrwbsAx9Vt+ZXF5kcdEw
         TCakBrMFGrsxiKWEOhenPFzr9LBdXhjmxW5370IMQcOOlgaFHdTNkBB+FXGyNxJcg61e
         E1CcWHlUQ+QDQ0SBGzNysb+dxHy8expVECKExkABctkP/dtbwAAACdK2L7UDO9Gbz48K
         ji3tgBrL0udfA8TkFrC8hp8qz2em39uxnCPqC9QkBkCfnnMqz+vlX4RNa8QIDVPQFIsS
         Tfem3Y9ER0V16TcCeQoXqA7MiKjEXoKy5//qqMQChDe5hPDjkyy9/RyTBkvqD/PR7kp3
         aZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ClA6mV7hozr21kuBkeCxjd9fGNxXJpc68c5A8HEJUUI=;
        b=GEfgbHzpmH0uUZ6uMTT+DbKYhbPVmaJQTSCZAFx1ZAdCCTzdFDIiDQr+wyqLTgzCDQ
         EfmgI6/LZEzcpopXMiOC795S5yI89SucZRRMjX38yKGBQ3m/puF7EWKfUoeP/A4twnbm
         xW/krzXvaoy1GJd1E9Fpd3AoW+o72yMqFtIkzTBUZJLn4eDL46ymkiPuSmtxrxyv57r1
         0dKNHtKLi/YesODLsilCKAoRvrW64rjIhQAPystd8ztbtc3OZy1MrHuGDDdqDcj1ujD2
         ei6ngSJe9/DBAXyAEAd9ALSdNgPh3fi8+6hSfBYbGzgN9sdNawzeRj6ud8aw9UyYmnfN
         HQ6A==
X-Gm-Message-State: AJIora9OBmOY1Vekl6KDag8YTpQ0KCLzT41BZtBZFykqGL/dMCUCj+5v
        YgxbCS6jSXStBKCbx1uoSmzMZ9dkSXLVUYmt8zo=
X-Google-Smtp-Source: AGRyM1uWx3Xja5gAlxQTsI9Gy8E4mbdwpO+4QcNSHclRnN4Pr80zjlE1E8X1wNostXJGk9TU7gkWHZtEAVASNa5cJX8=
X-Received: by 2002:a05:6e02:1bc1:b0:2d1:96b3:b961 with SMTP id
 x1-20020a056e021bc100b002d196b3b961mr12302759ilv.213.1655694460188; Sun, 19
 Jun 2022 20:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-4-peterwu.pub@gmail.com>
 <91e9e3af-8208-7535-1864-08744f934593@linaro.org>
In-Reply-To: <91e9e3af-8208-7535-1864-08744f934593@linaro.org>
From:   szuni chen <szunichen@gmail.com>
Date:   Mon, 20 Jun 2022 11:07:29 +0800
Message-ID: <CA+hk2fZbh0=8gurGS95XpXrYyF3NbwFbFMcygcrW_q10m0zinA@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: leds: mt6370: Add Mediatek mt6370
 current sink type LED indicator
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
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

Dear Krzysztof,

Thank you for the valuable command.

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B46=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94 =E6=B8=85=E6=99=A85:09=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 13/06/2022 04:11, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Mediatek mt6370 current sink type LED indicator binding documentati=
on.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../leds/mediatek,mt6370-indicator.yaml       | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6=
370-indicator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-ind=
icator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indica=
tor.yaml
> > new file mode 100644
> > index 000000000000..42b96c8047a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.=
yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LED driver for MT6370 PMIC from MediaTek Integrated.
> > +
> > +maintainers:
> > +  - Alice Chen <alice_chen@richtek.com>
> > +
> > +description: |
> > +  This module is part of the MT6370 MFD device.
> > +  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM=
/Breath Mode
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6370-indicator
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^(multi-)?led@[0-3]$":
>
> If this is multi-led, then you should reference
> /schemas/leds/leds-pwm-multicolor.yaml
>
> See other examples using it.

In my opinion, leds-pwm-multicolor.yaml is used for external pwm
signals, and needs to assign an external pwm property.
But our pwm leds use an internal clock to generate the pwm signal. Is
leds-class-multicolor.yaml more appropriate?

Sincerely,
Alice
>
>
>
> Best regards,
> Krzysztof
