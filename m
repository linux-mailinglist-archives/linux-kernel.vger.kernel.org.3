Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C459979C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347562AbiHSInF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347014AbiHSIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:42:58 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E167146;
        Fri, 19 Aug 2022 01:42:57 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id g21so2846180qka.5;
        Fri, 19 Aug 2022 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+Cq03o2awZ2CNavLumSobGfio3EFTtGHTSm82q82K2A=;
        b=RLA5gBURjwXrKBW418Tb13lNHH6WfLKhnihlwtoipQvzpkCIHgYLCKPMUW2sCK+Mdh
         cLTPh861GFI0AvmgmglY2Y3b6cKmG4C4xHxkH885oagwkZFpg7GM8o3bo8Mu+/MUn+03
         d1euMZBX/3C7fTJT2x+HozcMD9kNKUnAJKtCmYPyKWUdxNJo65JRUyCu+ngLELHYFZaX
         2nnUmwRO8w+kx71Ec8B4gevfx4ukYoOE8/gYW6OVq5nA2QcF3R3rmuG5dZ38L3OIYzg6
         3laZ/JFqZKj+IKzJTcUuxqWeHTB37JkXM9xrtM2zQh6DqB0gGwWTzOjg5KZ6ZYKZCrvF
         T8ug==
X-Gm-Message-State: ACgBeo0f+LYskdR/A4iDi9dv7LpLO7HczobND3Omi1NqbIl/xg/XaFup
        fsVKaoi7xiQK+16wLqvUE/Q/lu5dLmX9+w==
X-Google-Smtp-Source: AA6agR5a6EDIO/adlC9pO9cqiTlx4Pa5cQBDvBpvDKPOyZ69H9MiZ2KhQG0zr5TKRgWPIbcmYaHUXQ==
X-Received: by 2002:a37:4049:0:b0:6b8:e75f:6920 with SMTP id n70-20020a374049000000b006b8e75f6920mr4491334qka.448.1660898576144;
        Fri, 19 Aug 2022 01:42:56 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id i12-20020ac85c0c000000b0031eb393aa45sm2721239qti.40.2022.08.19.01.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:42:54 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso104260417b3.5;
        Fri, 19 Aug 2022 01:42:54 -0700 (PDT)
X-Received: by 2002:a5b:bcd:0:b0:68f:b4c0:7eca with SMTP id
 c13-20020a5b0bcd000000b0068fb4c07ecamr6714080ybr.202.1660898573940; Fri, 19
 Aug 2022 01:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Aug 2022 10:42:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEVtu2zf0R5+LufxHWLtG0=aEvPkfcF=K9V025_TCTrQ@mail.gmail.com>
Message-ID: <CAMuHMdVEVtu2zf0R5+LufxHWLtG0=aEvPkfcF=K9V025_TCTrQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] MAINTAINERS: Add entry for Renesas RISC-V architecture
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Initial Renesas RISC-V architecture support will be for the
> RZ/Five SMARC EVK board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17562,6 +17562,16 @@ F:     drivers/spi/spi-microchip-core.c
>  F:     drivers/usb/musb/mpfs.c
>  F:     include/soc/microchip/mpfs.h
>
> +RISC-V/Renesas RISC-V ARCHITECTURE
> +M:     Geert Uytterhoeven <geert+renesas@glider.be>
> +L:     linux-renesas-soc@vger.kernel.org
> +S:     Supported
> +Q:     http://patchwork.kernel.org/project/linux-renesas-soc/list/
> +C:     irc://irc.libera.chat/renesas-soc
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
> +F:     Documentation/devicetree/bindings/soc/renesas/
> +F:     arch/riscv/boot/dts/renesas/
> +
>  RNBD BLOCK DRIVERS
>  M:     Md. Haris Iqbal <haris.iqbal@ionos.com>
>  M:     Jack Wang <jinpu.wang@ionos.com>

Perhaps we should merge them all into a single section for "Renesas
ARM/ARM64/RISC-V ARCHITECTURE", to follow up on "[PATCH/RFC]
MAINTAINERS: Merge ARM/Renesas ARM64 and ARM/SH-Mobile ARM
architectures" I've just ssent?
https://lore.kernel.org/r/a869b8afdc47aa637ebeefcc1ca7bc61244f34b9.1660898008.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
