Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DB75986B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbiHRPAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbiHRPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:00:36 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3105326D8;
        Thu, 18 Aug 2022 08:00:34 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id f14so1312440qkm.0;
        Thu, 18 Aug 2022 08:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C69f4QDvaAb9KHdDEuFrDGdZguxo1xk19InMWxRMIz0=;
        b=SnPs7tHjwmilKKq/1xVr4hC88b7djKcN7QOc68uiEkARQj//KF0UDAAYSOCxD6BTXS
         xn1sDIij0+y9tX475IzI0Q/X2GIfUuAEF8VGfnui/1xLlm17O9oYSaZ+V3H/poASezJ4
         rt9CUoSBh4RONn0PJZJt4vIw6mTcdG+Yg5wHajTKsctCVbFvdVdURHMFLkBhbWII8LYw
         nkRNM0OdwDKqV5qc6Nsxnrtgc97IFvM3Vyl1zOSlmBMIkSraqxa8xVJcDbcNAyGxf9Sp
         N2i0N0Xc7BG9Mv+AA0eLqcQ7zZSI42O0FmlgUe+/O684dHx+iaWfLYkGu95HcQt2Mzg3
         9msQ==
X-Gm-Message-State: ACgBeo0zSM+TpnC2Ud/LyOmInrih/Aa2+mvQY3mNzNPks6XmiUvJzEsV
        Yf/x+DmkW5/xkBIuU26sH/apXA48EWfZbw==
X-Google-Smtp-Source: AA6agR4wjx1QvGtwMNEukY/38l2yQhJk/JV6dw6kHuFsrbXUjD1ITzTh1NfSY3uGnUlKE62LijZyfg==
X-Received: by 2002:a05:620a:2409:b0:6ba:e98f:d2ab with SMTP id d9-20020a05620a240900b006bae98fd2abmr2275036qkn.343.1660834833857;
        Thu, 18 Aug 2022 08:00:33 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id q13-20020a37f70d000000b006b629f86244sm1483984qkj.50.2022.08.18.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 08:00:32 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-324ec5a9e97so48130407b3.7;
        Thu, 18 Aug 2022 08:00:32 -0700 (PDT)
X-Received: by 2002:a81:f47:0:b0:31f:434b:5ee with SMTP id 68-20020a810f47000000b0031f434b05eemr3267925ywp.383.1660834831754;
 Thu, 18 Aug 2022 08:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 17:00:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUaketBpEfoSKeSJ4SuYwOTLoqJ_FCp=G8HmVudhv3zWw@mail.gmail.com>
Message-ID: <CAMuHMdUaketBpEfoSKeSJ4SuYwOTLoqJ_FCp=G8HmVudhv3zWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: soc: renesas: renesas.yaml: Document
 Renesas RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document Renesas RZ/Five (R9A07G043) SoC.
>
> More info about RZ/Five SoC:
> https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> @@ -415,11 +415,12 @@ properties:
>                - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
>            - const: renesas,r9a06g032
>
> -      - description: RZ/G2UL (R9A07G043)
> +      - description: RZ/Five and RZ/G2UL (R9A07G043)
>          items:
>            - enum:
>                - renesas,smarc-evk # SMARC EVK
>            - enum:
> +              - renesas,r9a07g043f01 # RZ/Five (RISC-V core)

Should we be consistent, and leave out the "(RISC-V core)" comment,
or add it everywhere?

Note that several of the SoCs listed in this file have SuperH or
RealTime ARM cores, so going for the former means a lot of work.

>                - renesas,r9a07g043u11 # RZ/G2UL Type-1
>                - renesas,r9a07g043u12 # RZ/G2UL Type-2
>            - const: renesas,r9a07g043

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
