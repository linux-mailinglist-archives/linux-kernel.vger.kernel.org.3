Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF859ADCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346168AbiHTMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbiHTMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:07:43 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F89D8DC;
        Sat, 20 Aug 2022 05:07:42 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id a15so4969230qko.4;
        Sat, 20 Aug 2022 05:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZR3FjkuW5iiRmrC3UtyKJcWdpW3MmZDZj9swwhPKMYc=;
        b=rp6S5kJjVnCfxZ5P9jvbRMsH3JlGSy9gU+JfOWDu3mLvKbRu73WMviujk4xjNfelX/
         E1RFIToF1u2Mnnt/X1ryStwf1mWNwPOrc9NwnbGIFcFlKC5LcgmzcvEAUWXQvKu9DjrE
         JglnmkFJJnsb/qJDuAGAeh+N7KgQqDyZbFLZrDz/DSULUzvhxVQSlkVhKJmjq1Ev9DGg
         +INL6VhOB56O4YJFvWX5C91oSTscTesA/rdCZhtR/1DDpaNyj0IfollTvTBOmBxJCaPi
         +Ke9mmIpI37jdb0rXW8dgcGukyNNJmofoGHqh+8XIWmmMo60jT3S5wv90C3dtx2PWpYS
         I0Jg==
X-Gm-Message-State: ACgBeo0P+Gra8mBAlOKGNtix+YblxEN/Yk/BlvZkvwuA/R2kkJqVm1a+
        9ONo/pC1szYHJ5qtKnkts3GSEgF4+JYgmg==
X-Google-Smtp-Source: AA6agR4McFE7kFk21ae3mwT40DfQrXDhm+/AmmQfbaS42RIIm7LZvKeH/9Qx/wLvvvCjGAq1McqgIQ==
X-Received: by 2002:a05:620a:12bc:b0:6bb:2f73:beab with SMTP id x28-20020a05620a12bc00b006bb2f73beabmr7845941qki.546.1660997260997;
        Sat, 20 Aug 2022 05:07:40 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a295200b006b9593e2f68sm6496432qkp.4.2022.08.20.05.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 05:07:40 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3376851fe13so149793297b3.6;
        Sat, 20 Aug 2022 05:07:39 -0700 (PDT)
X-Received: by 2002:a81:f47:0:b0:31f:434b:5ee with SMTP id 68-20020a810f47000000b0031f434b05eemr12132492ywp.383.1660997259528;
 Sat, 20 Aug 2022 05:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <e9b00bb5-bb78-091f-9c10-96c156690469@microchip.com> <CAMuHMdUGttswcSGeOdrJLeoZLmoeKhm7R82L-3wLJnagmZ4dBA@mail.gmail.com>
 <47cec683-dc17-7aa2-3511-b0244020d571@microchip.com>
In-Reply-To: <47cec683-dc17-7aa2-3511-b0244020d571@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 20 Aug 2022 14:07:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSud4-0ercQe3cyg1RXqg4DKTfgvPh5wc8ibca6dyDKQ@mail.gmail.com>
Message-ID: <CAMuHMdUSud4-0ercQe3cyg1RXqg4DKTfgvPh5wc8ibca6dyDKQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar Lad <prabhakar.csengg@gmail.com>,
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

Hi Conor,

On Sat, Aug 20, 2022 at 10:49 AM <Conor.Dooley@microchip.com> wrote:
> On 20/08/2022 09:45, Geert Uytterhoeven wrote:
> > On Fri, Aug 19, 2022 at 8:40 PM <Conor.Dooley@microchip.com> wrote:
> >> On 15/08/2022 16:14, Lad Prabhakar wrote:
> >>> Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> >>> Single).
> >>>
> >>> Below is the list of IP blocks added in the initial SoC DTSI which can be
> >>> used to boot via initramfs on RZ/Five SMARC EVK:
> >>> - AX45MP CPU
> >>> - CPG
> >>> - PINCTRL
> >>> - PLIC
> >>> - SCIF0
> >>> - SYSC
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> >> That aside, by convention so far we have put things like extals or
> >> reference clocks below the /cpus node. Could you do the same here too
> >> please?
> >
> > Really? We've been putting them at the root node for a long time,
> > since the separate "clocks" grouping subnode was deprecated.
> > The extal-clk is not even part of the SoC, so it should definitely
> > not be under the /cpus node.
>
> Under may have been a confusing choice of words, I meant "physically"
> under it in the file. Maybe after would have been a better choice of
> words? I wasn't suggesting you put it inside the CPUs node.
> Does that make more sense?

Oh right, you mean the order of the nodes. Yes, "extal-clk" should
be after "cpus", following alphabetical sort order, as the nodes have no
unit addresses.

Sorry for missing that in my review.  I also misread "below"
(in Dutch there is only a single word for "below" and "under" ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
