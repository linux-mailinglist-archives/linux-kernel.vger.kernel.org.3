Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55004512FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiD1JtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347895AbiD1Jfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:35:34 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15BF95486;
        Thu, 28 Apr 2022 02:32:20 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id s4so3195791qkh.0;
        Thu, 28 Apr 2022 02:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxrucvC/NAbMhAGxWgmP+P246fNaW3Hi7ZrfYXkN5TU=;
        b=JUOn690e8hRPPVUa5vhEFKjj719h6ekxjI8U1Z3FWaiCTeTTRNgJaJUSXRSfjd801W
         ZqUv3kzdBFk0Bpw0DWYz5XGfDSr5LaL3UqYNyU0qfp7F2FAG5M75OqWV/nnV1INIbCQ+
         S1rdpqOhPbn7LwUejCGhKOhDAVyLyIWIx5eO6fKTEsnffubW6rXvkjP7R7+WgHWXeFxS
         9unMT/kSvhSDccsPHudCWzoAtqI1fvkftoViIJrRqlUGEHi97+wMSfvMmYMkVNPALJyH
         tQEXKX43khIrYspHEFXTSu30OdgeV/EYyuCJgH52v6+AN1Z8R+JKcjJvQm+3YbwEnGIa
         Nv7Q==
X-Gm-Message-State: AOAM5320tCIZu9PcPtp7VnIKaCuJIRgDAPoLnqRGNZq0XKaNcnJCwuRu
        d1TkKKJLF3PuPkQgUp+aU0Gn3NFG8wklcg==
X-Google-Smtp-Source: ABdhPJx4S8vUCcoVz/XiyfC23GM4Dmtj+/2Xg4SoVTsz2XZbbLg1QFb+OXVM2p5ZXg9xRJBla5oynQ==
X-Received: by 2002:a05:620a:404e:b0:69e:a5db:22cb with SMTP id i14-20020a05620a404e00b0069ea5db22cbmr18894611qko.735.1651138339897;
        Thu, 28 Apr 2022 02:32:19 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id i198-20020a379fcf000000b0069f869bcd49sm3039513qke.75.2022.04.28.02.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:32:18 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id w17so7923266ybh.9;
        Thu, 28 Apr 2022 02:32:18 -0700 (PDT)
X-Received: by 2002:a25:d393:0:b0:648:4871:3b91 with SMTP id
 e141-20020a25d393000000b0064848713b91mr20880320ybf.506.1651138338366; Thu, 28
 Apr 2022 02:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220421221159.31729-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220421221159.31729-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 11:32:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrcT5iHUZUiCYmD12sS4F66BETBih36G7BzLTLuoQ9eQ@mail.gmail.com>
Message-ID: <CAMuHMdVrcT5iHUZUiCYmD12sS4F66BETBih36G7BzLTLuoQ9eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: Add Renesas RZ/G2L
 Interrupt Controller
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Prabhakar,

On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description: |
> +  IA55 performs various interrupt controls including synchronization for the external
> +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
> +  interrupts output by each IP. And it notifies the interrupt to the GIC
> +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
> +    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> +      stand-up edge detection interrupts)
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-irqc    # RZ/G2L
> +      - const: renesas,rzg2l-irqc
> +
> +  '#interrupt-cells':
> +    const: 2

What is the meaning of the cells? IRQ number + flags, I assume?
How are the numbers mapped, do you need a DT bindings header?
Perhaps it would make sense to increase to 3 cells, so you can use
one cell for the type (cfr. e.g. GIC_SPI), and the second for the
plain index within the type?

The rest LGTM, but I'm not an interrupt expert, so I'm curious in
hearing Marc's opinion.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
