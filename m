Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63857DD0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiGVJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiGVJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:01:58 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FCA183B7;
        Fri, 22 Jul 2022 02:01:57 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id o1so3141668qkg.9;
        Fri, 22 Jul 2022 02:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DaHwUZ1RE1PYQHo6ho0JHLd5AyS1nGZAw53JopZtuc=;
        b=gHA/DliFBweURmf9WxF/3yy3xRmX+qMxuXci9T2veXS6XL0DUMI9tWE1mnhX4/hXXJ
         Hb1Clt6iam/PfK1M8VW9fllklNXOHmxycIUwcXBnnfq1wnC5FCWLuUNgm9UgS4mu7CPf
         7FPs6icf5y7XJoqGS7iWvZ1mM135NJHjy6lNBQRNbv+Zu9pZkUFby69O3y3MfKvu6Rwt
         6Zl0pJnnd7+3eKpaYxMGcyc0oUi0rWM8MtOA9GSy2is/m1yW1SE4EPp5DrwVipGb45qu
         HLcxCigPBQYss48dNiwJ40TmLRgZIA6gmm9IHSD9waQ3F+n/slae1OK0XIT5q9VB9N7u
         071g==
X-Gm-Message-State: AJIora+0cnkVKxpMVFowjaSBlbtpI/ErVNYzZWOdkZgGLpLqJ9AZbGhG
        LeGsxfbetuy6w4fPrLOQPNKVCMxZ7dEeQw==
X-Google-Smtp-Source: AGRyM1vIPmi34jnrTC5KHNV4WLLQN9Y5oIVAthkOvkY0eQWfeys9E0ccahs5qzsO+RtZ+Dg3cMxhtA==
X-Received: by 2002:a05:620a:bd4:b0:6ab:8874:4cdc with SMTP id s20-20020a05620a0bd400b006ab88744cdcmr1742339qki.415.1658480516738;
        Fri, 22 Jul 2022 02:01:56 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id bs16-20020a05620a471000b006b618e006ffsm2989239qkb.2.2022.07.22.02.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:01:56 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31e560aa854so41036027b3.6;
        Fri, 22 Jul 2022 02:01:56 -0700 (PDT)
X-Received: by 2002:a81:4f87:0:b0:31e:7122:16fb with SMTP id
 d129-20020a814f87000000b0031e712216fbmr2224273ywb.358.1658480516055; Fri, 22
 Jul 2022 02:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220721165701.17888-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922D6EC478AE231A06E94B586909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922D6EC478AE231A06E94B586909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jul 2022 11:01:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrmseZEBpsh22U52vivA=wXYo2C8Ke6CvgWSKjwgYByQ@mail.gmail.com>
Message-ID: <CAMuHMdUrmseZEBpsh22U52vivA=wXYo2C8Ke6CvgWSKjwgYByQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
 for IRQ0-7
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC maz

On Fri, Jul 22, 2022 at 6:34 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
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

No definition for NMI?

> > +
>
> Not sure, may be these macros to be moved to [1]?? as it is nothing to do
> with rzg2l-pinctrl.
>
> [1]
> include/dt-bindings/interrupt-controller/irqc-rzg2l.h
>
> and binding update to use these macros.

Indeed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
