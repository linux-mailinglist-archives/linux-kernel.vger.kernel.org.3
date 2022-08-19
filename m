Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E37D5998A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347961AbiHSJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347308AbiHSJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:09:10 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB3F0778;
        Fri, 19 Aug 2022 02:09:09 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-33365a01f29so105875337b3.2;
        Fri, 19 Aug 2022 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NFZ1eO+NL0DdpbYe+Shpj3kD0DfJq56KubQKKQcddkU=;
        b=XOBeLUUQRjUvlmYat2FRBDjkZ7Oezy6Y3lYrO+CArd90pB4I6q5QUkoGC5nQcfN14i
         EgsBIHm5yEOhZ2zfFy3oHod0YbGC6jShJnjlJVOpHu+/KdGFbJgMWEQm+/qBKOw03Zdp
         QXwLPIgnLg8j3VgMuYsukvLXSR79D/hs6zVKrsky8FN1Ow8jma60W9wYfEDNm/LeBmNr
         6G55jFueB0gjj2xxLhmZphISxmUONRvkTI/2+tcwiDiTMu7zVUHbKQGabVyY7+Z0PMYG
         ugSa3TRs8k5iHO4Rtf+hORHq1h2KMZRWy2HurjOhUg8xuujOB6ASdlgBXRdmEOlFUYms
         spKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NFZ1eO+NL0DdpbYe+Shpj3kD0DfJq56KubQKKQcddkU=;
        b=vfnD/p4htfXItw7hyHNOXgDglsidC/Hz0AGK887u2hLBcNBrMwH5cfxP2kDgbJobm0
         4dA7wxNKfcbH+F++2cXdpVds+TxIijfT+3+0nkU5+xkPF0UrFNmljs4tiSY3AdHhWpTV
         mDUTj6AK7pi1hWCjRIdvl0DxLyD70QargE4CaUmsNinoB2DpaEqhZjGaMmwOlzUXaxdo
         VISQ4L4JExwWQhemGEtJAjp8tyJLempdnSQSjO0GhSuJXSW6Qdit1d49ZChuVZ6sYXEo
         DKCPmwis2aXtOvBBaW/Nr8S01ZN8UuWcqpwkXd4AulcOxMej+n/boNRptjEWb6iNM6Pc
         zvSA==
X-Gm-Message-State: ACgBeo127v4YOJMEW0DB7T6ZegQnVb0DR1MlJkOH7uJSfm7wds2lc7dc
        mFoeeh7/cR3MIZWdUf1qGkgEWL4kwdRkokinkME=
X-Google-Smtp-Source: AA6agR4crwUZ51R3+LyOXZVR3lotoIYKMWBFupVpI0Go+holeaYaFRtNfkONddeSJ3wwGqH4Mc+IR5M14kyxudtzwnU=
X-Received: by 2002:a81:1d09:0:b0:31d:a40:8332 with SMTP id
 d9-20020a811d09000000b0031d0a408332mr6899061ywd.138.1660900149126; Fri, 19
 Aug 2022 02:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVEVtu2zf0R5+LufxHWLtG0=aEvPkfcF=K9V025_TCTrQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVEVtu2zf0R5+LufxHWLtG0=aEvPkfcF=K9V025_TCTrQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 19 Aug 2022 10:08:42 +0100
Message-ID: <CA+V-a8uz1XKbbrOrGRyOyJUo-PsHUDRn7qc1X+zaakGh2dOdsA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] MAINTAINERS: Add entry for Renesas RISC-V architecture
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Fri, Aug 19, 2022 at 9:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Initial Renesas RISC-V architecture support will be for the
> > RZ/Five SMARC EVK board.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17562,6 +17562,16 @@ F:     drivers/spi/spi-microchip-core.c
> >  F:     drivers/usb/musb/mpfs.c
> >  F:     include/soc/microchip/mpfs.h
> >
> > +RISC-V/Renesas RISC-V ARCHITECTURE
> > +M:     Geert Uytterhoeven <geert+renesas@glider.be>
> > +L:     linux-renesas-soc@vger.kernel.org
> > +S:     Supported
> > +Q:     http://patchwork.kernel.org/project/linux-renesas-soc/list/
> > +C:     irc://irc.libera.chat/renesas-soc
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
> > +F:     Documentation/devicetree/bindings/soc/renesas/
> > +F:     arch/riscv/boot/dts/renesas/
> > +
> >  RNBD BLOCK DRIVERS
> >  M:     Md. Haris Iqbal <haris.iqbal@ionos.com>
> >  M:     Jack Wang <jinpu.wang@ionos.com>
>
> Perhaps we should merge them all into a single section for "Renesas
> ARM/ARM64/RISC-V ARCHITECTURE", to follow up on "[PATCH/RFC]
> MAINTAINERS: Merge ARM/Renesas ARM64 and ARM/SH-Mobile ARM
> architectures" I've just ssent?
> https://lore.kernel.org/r/a869b8afdc47aa637ebeefcc1ca7bc61244f34b9.1660898008.git.geert+renesas@glider.be/
>
Agreed, I'll merge this on top of your changes.

Cheers,
Prabhakar
