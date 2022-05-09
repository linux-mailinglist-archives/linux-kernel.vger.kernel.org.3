Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22E51F82D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiEIJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiEIJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:01:10 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEBE15A3CE;
        Mon,  9 May 2022 01:57:14 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id h3so10488247qtn.4;
        Mon, 09 May 2022 01:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkNL9UF9gn3bo4ZBmPpkTUdSu1SkuvIXS7tPfz0O7Z4=;
        b=WxLPzbiNEEJgF+73W19C4piyoT9Rk94USD83uAZjnJuYs2nUh07S0InPXZUHLyiCpd
         MausihgTOysVgKkhtHJET9/0U6bPQ8cVvL9niJr+fSWDIXrsVHUQpiQlnxyK4X8eznYa
         Ane25Xviw+lG+sGXOAA1PTeTvDwFh8dxma8mkqkzeuqoUop0+qxFrxQaOUFreiKdxLBs
         WNVDk3pcJ95iJREWMvUXQhV5X+np8k6SbeAyVS/LnBsvG2Zt+aT5j0Kk+kbQObubeWZf
         /QE/AJWhTwVfJhqOL5TkW+qTM5D46ua9uNQ0yfg0aMRYPRGbVPpUws7yRmoV98ihQXVo
         HcDA==
X-Gm-Message-State: AOAM530QIC5fvJhPjQw17nu8dxVJFC899efiRFKFKFh1KpzqggW5K68T
        zGPOqArHts7WWXmtLVolm2zqJaGqvKqq6g==
X-Google-Smtp-Source: ABdhPJziinEhRR9kq9fTEUIXGw1u6VGoI1Xd9iZX4Sdh99qd6a/LWRQP5UPyaQ3eIMyGte0Gtr4rAQ==
X-Received: by 2002:ac8:578a:0:b0:2e1:a0d2:c3a with SMTP id v10-20020ac8578a000000b002e1a0d20c3amr14075087qta.261.1652086633446;
        Mon, 09 May 2022 01:57:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id cm11-20020a05622a250b00b002f39b99f66fsm7505297qtb.9.2022.05.09.01.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 01:57:13 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id m128so23647360ybm.5;
        Mon, 09 May 2022 01:57:12 -0700 (PDT)
X-Received: by 2002:a25:4506:0:b0:648:cfc2:301d with SMTP id
 s6-20020a254506000000b00648cfc2301dmr12216717yba.380.1652086632606; Mon, 09
 May 2022 01:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220509050953.11005-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220509050953.11005-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 May 2022 10:57:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0RF=ESX+WmLTrMYyhQ_M18FVn_g3A83WOe6gBzn19mg@mail.gmail.com>
Message-ID: <CAMuHMdW0RF=ESX+WmLTrMYyhQ_M18FVn_g3A83WOe6gBzn19mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, May 9, 2022 at 7:10 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

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

Please document the meaning of the cells.

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
