Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D6598AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiHRSTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHRSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:19:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FD5B69EF;
        Thu, 18 Aug 2022 11:19:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3378303138bso23306237b3.9;
        Thu, 18 Aug 2022 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hsfwWpmgExzWlmbZDKLSyuPDLh/uObZ0VNKfsXtXMuw=;
        b=dvhZE5h4dCmIqJy4VGVxeGkNi4ssy0JxthqBuXfA+I1ljmRwFgAB00+bdKrl1CN1u6
         UovJbjpmOUSsZtvFusj6eRbJWHXHWj7M4ihDY22ZSATSHYwapy4A4g35tlnfGuuz/6Ak
         Lx7oS4ourgghCf7qYsg6ob7CpALUl2mXllPL7gcD5Rh3xsyoWd6JCUm0R4Ycf5QaSAPD
         HPxPvu8LtSyBfGBP53gryTRw0nQ3UVuZW5ro9BHs8iJq1xz3V7JOu+9uFSXhJNsX6gsk
         W8f6rDt7Pdrj8f+26pd/G0sOnOhHrbxvGc93tfOE1/xl2U2RG/j1ljzyxEgCzNueSVnu
         3NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hsfwWpmgExzWlmbZDKLSyuPDLh/uObZ0VNKfsXtXMuw=;
        b=fq/diKEf/aZmfvRypK0/oIHmsKn0gtPIYg0ZnDP2AuZ0474cBjXSxcDiL3jrAior3c
         wFdybtM0gTBUtvRJtPPF36JtBjj/iIKiz5tWZVzCVM4RRW3Z/5JLyFlmWfWHspXytcGi
         o1riWL3NDxbdfTB5X3U6ZvH2ynF+VFK9zn7CoS/cvIpddaae/9YzgZQHbIGeT+Lalr0v
         f9la8uUwUyc1I6PWVHGdkNGtb0JEYBRS+ZGt9t9lcyIiVAjW/SsE6Li/YOq5dKW0U63U
         oKF8ZGT2SPQev+iPkchT0a4+u97G4dwWpDr3jVZkdYZTQ6DJs3sNX/ftsY+obt+y7hsD
         B1CA==
X-Gm-Message-State: ACgBeo3/ETbRIZkqIIPAMRfgvAHp1bIgYBZ6klmSduaCxuGgMcn3vhLi
        LChyaIc5R+oJS+LLHsvLr1i7rosIMgHpVyv5WrM=
X-Google-Smtp-Source: AA6agR7U/oVpzPHvchwsE54U6r7OKVjyYC6QkwgfBzrzIUX5YaKC8KGeQyILJ2Z8F/pH21bfHWi7erMANy19NPP7t9c=
X-Received: by 2002:a81:6c0f:0:b0:334:c01f:fa10 with SMTP id
 h15-20020a816c0f000000b00334c01ffa10mr4117792ywc.382.1660846785474; Thu, 18
 Aug 2022 11:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW29Q40hypWZ05KRj5cc=DY8XjnDwOPVw3kJPNUrnL0fA@mail.gmail.com>
In-Reply-To: <CAMuHMdW29Q40hypWZ05KRj5cc=DY8XjnDwOPVw3kJPNUrnL0fA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 18 Aug 2022 19:19:18 +0100
Message-ID: <CA+V-a8sVpEx==R6QXF8qxhVSsv2mVnZ_R3N2wTt+JPcQWNqCWQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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

On Thu, Aug 18, 2022 at 4:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
> > (R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
> > of the Renesas drivers depend on this config option.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> The technical part LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif # SOC_CANAAN
> >
> > +config ARCH_RENESAS
>
> We definitely want ARCH_RENESAS, as it serves as a gatekeeper for
> Kconfig options for IP cores found on Renesas ARM and RISC-V SoCs.
>
Agreed, or else we will end up touching too many Kconfig files.

> > +       bool
> > +       select GPIOLIB
> > +       select PINCTRL
> > +       select SOC_BUS
> > +
> > +config SOC_RENESAS_RZFIVE
>
> Do we need this symbol? You could as well make ARCH_RENESAS above
> visible, and defer the actual SoC selection to ARCH_R9A07G043 in
> drivers/soc/renesas/Kconfig[1].
>
I think we could drop it and just defer the actual SoC selection to
ARCH_R9A07G043 as you said.

> I don't know what is the policy on RISC-V. ARM64 has a "single-symbol
> in arch/arm64/Kconfig.platforms"-policy, so we handle SoC selection
> in drivers/soc/renesas/Kconfig, and that is fine, as it avoids merge
> conflicts.
>
Agreed.

@Conor - Does the above sound OK?

Cheers,
Prabhakar
