Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587EA5822DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiG0JNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiG0JMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:12:40 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE74548C80;
        Wed, 27 Jul 2022 02:09:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31f64093c21so9665317b3.6;
        Wed, 27 Jul 2022 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhOsBRxXhz/t+ynGnqroYsLAyuJRf45b+7ao/a2EGuY=;
        b=c7FL5tPiXWhbsDJZV/iYKyhXsFCX/uy+ALzeJHW7nG4yf+fPeB2Sq979Z7EjnlXwso
         Ks8EK0Dzk7FOkIfmbGdQQAGDXGKnSBTf8Tkic46zYcWQxKnrQb+EH9ci65YEO/4/awYf
         6gEu7zPxqln4XZJ2n8h4h04dV3TbIlSJaeNioctaJJ22eczAJzT88aRLvSWDaqjtoRhP
         Vwep7v+cxLjnEQC4hxv+F4/AGjEFzdPD8kxPTArdpjOpgWJjFqPc+EAp8ZkHQqYvMqAI
         3I/EZaxwwgyhSsJbHOQN51jrwtmwTccx0Zb7wVwzZcHPadMoKjqqY6pbGuL5bprxyDMI
         YMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhOsBRxXhz/t+ynGnqroYsLAyuJRf45b+7ao/a2EGuY=;
        b=0Qsc7sIYp3M5y0xKopU7wIUAHiPcrlpbijrjkD2ea/J0gIG0nhh4CTfowufUYvTw6/
         dS178UcXKze3MCSql1V0kO1b9qm8bNgccQlYPAq/V36II7YhKe1oZ65w1k2Rcy2fI0QT
         jeBMTitAASeo+vr1UXkWFlnn7Xol/1S6CzPgbnlN5BuewfMFtyL/biUa/QFvSi5e87yH
         mUG9N5E+nlQZKkF0393Rdou+DWlgGT1Jb9jSZZ28C28UUzC9VLKiZcXEurYFlI9jG5Q4
         BWolofMozFQzSQTA7d0ApZOzsRzZRYKFi8Cm3ryD1VGMes4d5BaLasgfwnJtuh5KbJvc
         JcUQ==
X-Gm-Message-State: AJIora9ykKucFvosTpdaBGqpQ9mfaB/eBCI08Qb5Ni6TMp0FXuII5QX/
        +JPcHEpicqiIgBhw6oAOPi57hn4BtKfamkjp/5M=
X-Google-Smtp-Source: AGRyM1scO33sgcG8wgcvvA8weDtTskLR++MoDbmJLJDGl2d+NtRAl68cuEVh+81ylmZbjQ7jLFt7jVoQ2Veb6yn9hXw=
X-Received: by 2002:a81:1d09:0:b0:31d:a40:8332 with SMTP id
 d9-20020a811d09000000b0031d0a408332mr19291445ywd.138.1658912959232; Wed, 27
 Jul 2022 02:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <6a87ee9b-f944-ab8c-cc00-fd8bbb22cad8@linaro.org>
In-Reply-To: <6a87ee9b-f944-ab8c-cc00-fd8bbb22cad8@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 10:08:52 +0100
Message-ID: <CA+V-a8uAcqGt6SP3jdJ9dPrV+rQdconfft41U+VdGXC8yFMByQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 27, 2022 at 9:55 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/07/2022 20:06, Lad Prabhakar wrote:
> > Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> > Single).
> >
> > Below is the list of IP blocks added in the initial SoC DTSI which can be
> > used to boot via initramfs on RZ/Five SMARC EVK:
> > - AX45MP CPU
> > - CPG
> > - PINCTRL
> > - PLIC
> > - SCIF0
> > - SYSC
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/riscv/boot/dts/Makefile               |   1 +
> >  arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 121 +++++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> > index ff174996cdfd..b0ff5fbabb0c 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -3,5 +3,6 @@ subdir-y += sifive
> >  subdir-y += starfive
> >  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> >  subdir-y += microchip
> > +subdir-y += renesas
>
> What are you building there? There is no DTS.
>
My plan was to get the initial minimal SoC DTSi and then gradually add
the board DTS, but it looks like I'll have to include it along with
this series.

Cheers,
Prabhakar
