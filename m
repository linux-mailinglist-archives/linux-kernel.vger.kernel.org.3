Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E4E57DF88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiGVKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:11:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216806D9EC;
        Fri, 22 Jul 2022 03:11:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31e1ecea074so42462567b3.8;
        Fri, 22 Jul 2022 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u2TXpjolCYNP6lYHJAWLqzsC0mS5f8cQgkMxHryEDw=;
        b=gQCk9v6DDgA5OgMn10kyVKBJ5yITDxr9DrdhflUG4FAX42EkCK9tXNN4WnTk3mKK5c
         KktauhjtzWG7a1UGtt4VuBQc4TYDrF6bh1gIGlJBsfKOuXzWdJE+bsisNS8Dqo8Lz9DU
         lPnfT5rC8SzadG02wOtPGSD5G7OsI9X0gwR4GqxH5XtRIqskf7sJeQl0qCnjv7e+PDkX
         s73cMv4yDGHRzJ0NFy+hqDeexBG8JdIIwTQ9tzaErT0U8iUNYV1L/GxPYGRNJN1Cww45
         dA4InCzXPFCM21gRPcb+aZqc6WuLbBduffnBEPN0Afw42zSJW+PUaG/YUxEZIUt8XwK/
         d4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u2TXpjolCYNP6lYHJAWLqzsC0mS5f8cQgkMxHryEDw=;
        b=NmbK8RWObzYQm/V2smTvhjQpsy0plgW8U0McFWwAorQvA/OZ9NZV/y8ADtCu4zZQAs
         a1aotlRHmEMoCkARU46LaZw1+JpvNTrIbMJpx3Ijn0oGGNCjqC5t57fl8i5dPkycf065
         FjoJJboBQbQNOYTr3juMYqGu8RgS9UmF6SO+RfBrVxHYBB+FQOxKH5II24hF0Q9dOrqd
         k6fhMBb+WoYdwwtSS2Hmd2v4Nr2PMoed4pPBR9Pi/cklvVi8yrv5GpnmQetQRZ2+3xrX
         A9/oCIFAl4xlQPMrr5GcSX2QmW/QO/tLbdFltex8t2n/U2k7+Aa4HZIxQ2q4u8mJdPKW
         mRzA==
X-Gm-Message-State: AJIora/YeQOdBJrHSPg4YhZB24meaK2nfuVz+4n189pslfYQktzqfmwx
        f1IuXSHpfbTqISEzXP0nOl2lkTWAyYhQcsO2L8Cm3xt7MQVbUA==
X-Google-Smtp-Source: AGRyM1unitKCxp6cqX4AfkgMtXKzwd/Y5NAO8e5jfma66MMn7fNUCV9KtMq9/rVBHr/LzAECMuPt43umwzLrZNV2j/E=
X-Received: by 2002:a0d:d909:0:b0:31e:6adb:95f4 with SMTP id
 b9-20020a0dd909000000b0031e6adb95f4mr2412674ywe.355.1658484714321; Fri, 22
 Jul 2022 03:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220721165701.17888-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922D6EC478AE231A06E94B586909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922D6EC478AE231A06E94B586909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 22 Jul 2022 11:11:27 +0100
Message-ID: <CA+V-a8tsAVa_h_KFz55hDZjg-S=kqm+ngRrwQiPyrmAA-W_6XQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
 for IRQ0-7
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

Thanks for the review.

On Fri, Jul 22, 2022 at 5:34 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > Subject: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
> > for IRQ0-7
> >
> > Add macros for IRQ0-7 which map to SPI1-8 so that it can be used in
> > dts/i.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * New patch
> > ---
> >  include/dt-bindings/pinctrl/rzg2l-pinctrl.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h b/include/dt-
> > bindings/pinctrl/rzg2l-pinctrl.h
> > index c78ed5e5efb7..6aae2ac206d6 100644
> > --- a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
> > +++ b/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
> > @@ -20,4 +20,14 @@
> >  /* Convert a port and pin label to its global pin index */
> >  #define RZG2L_GPIO(port, pin)        ((port) * RZG2L_PINS_PER_PORT +
> > (pin))
> >
> > +/* IRQ0-7 map to SPI1-8 */
> > +#define RZG2L_IRQ0   1
> > +#define RZG2L_IRQ1   2
> > +#define RZG2L_IRQ2   3
> > +#define RZG2L_IRQ3   4
> > +#define RZG2L_IRQ4   5
> > +#define RZG2L_IRQ5   6
> > +#define RZG2L_IRQ6   7
> > +#define RZG2L_IRQ7   8
> > +
>
> Not sure, may be these macros to be moved to [1]?? as it is nothing to do
> with rzg2l-pinctrl.
>
> [1]
> include/dt-bindings/interrupt-controller/irqc-rzg2l.h
>
Agreed, I will move this to irqc-rzg2l.h.

> and binding update to use these macros.
>
Ok.

Cheers,
Prabhakar
