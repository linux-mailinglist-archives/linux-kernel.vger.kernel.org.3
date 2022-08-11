Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8631658FE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiHKOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiHKOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:50:59 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B5267A;
        Thu, 11 Aug 2022 07:50:58 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id e69so14820375iof.5;
        Thu, 11 Aug 2022 07:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DEhzfhZV/RyIyIO+WhhTCUqriMrgwEDdfEEw2Sy+YWs=;
        b=zJLIJC697NWf5SRYbGYlfdNUm2UpoOb82qrIFXiYG9Frog4Igq+vVx7VIib8gu1xtC
         G4jIZmOgh+YjpsUKtjDVfbgxZwgNgMTwiPb23ZSVhQVvuUJiscfRHkY4wscCrW993nAE
         q3wGfDjYm4TEnNzp0o7h1N3rGRtNAj7xnQk26jAlguOEjDmGLEZPjxQf12vTDpWL5dRu
         ITp8RukWuyOmu0cm5XQcR4i5ctEaVyY00XQROGVEwaH5ryxBoqYOdpT3vZiaQ/rFHjT1
         qK2dQvTHOLoTgt2hAY0J153+LYjIg+T7EDFWSUTR6tydJ1IV1J2IApuQHC/H3Dr95ks8
         2KOQ==
X-Gm-Message-State: ACgBeo1AcV0ZouI7hip0/89H96KKhsMLOS9Hum5wr6YTJT6GNoeqhTDq
        LAh4ktIeYaEm5uqXpgmLOu+Nav8gL9G01l94
X-Google-Smtp-Source: AA6agR5xmI4K/0CWBj7XFC0AWpop6F3H/pMS9hv4CCnvFcA9OZtoG2JpDpjja0SDmgPi0Ua41Mv/bA==
X-Received: by 2002:ac8:5b53:0:b0:340:19e6:38eb with SMTP id n19-20020ac85b53000000b0034019e638ebmr28929814qtw.1.1660229447180;
        Thu, 11 Aug 2022 07:50:47 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a430a00b006b60c965024sm2036016qko.113.2022.08.11.07.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:50:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-32a17d3bba2so52519867b3.9;
        Thu, 11 Aug 2022 07:50:46 -0700 (PDT)
X-Received: by 2002:a81:af42:0:b0:31f:4e9a:74ad with SMTP id
 x2-20020a81af42000000b0031f4e9a74admr33465900ywj.358.1660229446035; Thu, 11
 Aug 2022 07:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220722151155.21100-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <8735eqdbav.wl-maz@kernel.org>
In-Reply-To: <8735eqdbav.wl-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 16:50:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVj7J442iMr0PN5jxMhLv1U22+G9jNXLWFzLYkS0JTf5A@mail.gmail.com>
Message-ID: <CAMuHMdVj7J442iMr0PN5jxMhLv1U22+G9jNXLWFzLYkS0JTf5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update description for '#interrupt-cells' property
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Sun, Jul 24, 2022 at 1:01 PM Marc Zyngier <maz@kernel.org> wrote:
> On Fri, 22 Jul 2022 16:11:54 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Update description for '#interrupt-cells' property to utilize the
> > RZG2L_{NMI,IRQX} for the first cell defined in the
> > include/dt-bindings/interrupt-controller/irqc-rzg2l.h file.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v3:
> > * New patch

> > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > @@ -31,8 +31,9 @@ properties:
> >        - const: renesas,rzg2l-irqc
> >
> >    '#interrupt-cells':
> > -    description: The first cell should contain external interrupt number (IRQ0-7) and the
> > -                 second cell is used to specify the flag.
> > +    description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
> > +                 include/dt-bindings/interrupt-controller/irqc-rzg2l.h and the second
> > +                 cell is used to specify the flag.
>
> I think a binding should be self describing, and not rely on an opaque
> macro. Mentioning that there is a macro that encodes it is fine, but
> the values are what matter, specially when considering that other OSs
> could (and should be able to) write their own DTs from scratch without
> depending on something that is very much Linux-specific.

The macros are not Linux-specific, and are part of the bindings.
But the only hard dependency on <dt-bindings/interrupt-controller/irqc-rzg2l.h>
is the DT source file describing the board.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
