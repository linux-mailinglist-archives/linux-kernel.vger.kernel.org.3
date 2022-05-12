Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F952460E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350079AbiELGn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiELGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:43:23 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729251B7939;
        Wed, 11 May 2022 23:43:21 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id x9so3659174qts.6;
        Wed, 11 May 2022 23:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFP7hJ6KzfffhBpGLIJzVwzD4tIyuujgKC17ziO4XoU=;
        b=avCH17pglDxmMCfl7OkvHBzImsz656JoTuS/IJLq9lWbGYQaHojSjiPcQiG+FX2VnF
         RZv6kqjrOf645WExuTWKoUnHH/IzxekgDxFBHl4tOg69Lf5Fbeq+ZWW+JDdyGrcfMfpt
         AEcaAqDAiak1yxHoJhgvaHdgGAR0U/h3uFTGFl3WXd6dCO6OxhIJIA9OnPXY3wrnLDvO
         RQ+yOuk12CH+1NoMtmKiyyXyFad5glzXDaHJS71C+QFoDM1JTdgQ+b+uY8/Ey9nrm54h
         4az3xiCxfX+yqKfVq4xbx49xa34GoSuf2DOJq8Ezjht9k1lmAexH8NJ0Xfrf7AxfyzWK
         NLlg==
X-Gm-Message-State: AOAM5316ajdwnoLi80+7K1LxaEiAzKj1yDenlI3xOuB2GpBJlbXvql7H
        WIimQXNIAWK/YCPGfQ5a+aLJF3qNjex+Ng==
X-Google-Smtp-Source: ABdhPJw2bcXzPmoifc4THsehp38cXvXYfniJ7FLd6SN3l45Ep7p7ZWAAPjnwgIaj1qo0zSiJHyCIIQ==
X-Received: by 2002:a05:622a:591:b0:2f3:d8fc:1967 with SMTP id c17-20020a05622a059100b002f3d8fc1967mr17660497qtb.353.1652337800334;
        Wed, 11 May 2022 23:43:20 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id y30-20020a05620a0e1e00b0069fd9de088esm2345779qkm.93.2022.05.11.23.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 23:43:19 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2f16645872fso45269287b3.4;
        Wed, 11 May 2022 23:43:18 -0700 (PDT)
X-Received: by 2002:a81:6588:0:b0:2f8:b75e:1e1a with SMTP id
 z130-20020a816588000000b002f8b75e1e1amr29899309ywb.358.1652337798506; Wed, 11
 May 2022 23:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220511183210.5248-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 May 2022 08:43:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU6-cfgYE0DLyWSxzDmQ3Z67qTJAKzi75qNt8p=PMuEnA@mail.gmail.com>
Message-ID: <CAMuHMdU6-cfgYE0DLyWSxzDmQ3Z67qTJAKzi75qNt8p=PMuEnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> @@ -0,0 +1,134 @@
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
> +    description: The first cell should contain interrupt number and the second cell
> +                 is used to specify the flag.

The important part is still missing: which interrupt number (the general
description mentions 3 types)?
I believe the answer is "external interrupt number".

> +    const: 2
> +
> +

Double blank line.

> +  '#address-cells':
> +    const: 0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
