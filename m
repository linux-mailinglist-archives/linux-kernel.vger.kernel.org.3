Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB984641EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbhK3XEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:04:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51156 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbhK3XEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:04:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 593E1CE1D17;
        Tue, 30 Nov 2021 23:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FDC53FD5;
        Tue, 30 Nov 2021 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638313280;
        bh=/XtvKBKIAZgBZpHU5l7FFP9bobAXH0K3MiMhbZFKhcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NCEJwq1PwtA2WtEEXgXy7oE5yCR4XLm7KyNx9pdJSkaA98LBgnAteKPHhmwFa9nmv
         cyrskbRaNNTZWwwYZ3Q8dQ/V+5AwGCU8/vq3OeFNB9Xxa1MrqYdEpPR7krzwt6bPNk
         /7v1wtzVQNkB6axchbw/auOcQAq1fiqIUfxg1Z3JHc71VFN4b36QXS/CZSmx+xmLJl
         4u7gDAm8yFXEzZYgoT10Xltlnl5AeHxChLM+XE5JZRnKSLsL4c+zXX8vG82KO8xixC
         jiAcWEFc7gWX3LeZefMuQoTOT/Tyf6O02kul3zbFVaeTFbPqHtBmZXgO/O9p9DJsY6
         zpUMRQSg2bmlw==
Received: by mail-ed1-f50.google.com with SMTP id y12so93419373eda.12;
        Tue, 30 Nov 2021 15:01:20 -0800 (PST)
X-Gm-Message-State: AOAM530M0+zlaa28oQrMu44NFRrjk4a1b89R0NrDf7VVCnOZA4LSvnXd
        4+u+MkI4aE1C1nv5EPUY/35o9Z1ohHMYqOvgYg==
X-Google-Smtp-Source: ABdhPJwGYPJE956LksSZBLju/I83pfHQ4ZXNie2up3wXJY0kmFL+GyQypPQQpG6PQ2wQLmlwFlJGQwnP8sUWSYsJU9s=
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr3055651eda.22.1638313278675;
 Tue, 30 Nov 2021 15:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20211125152233.162868-1-geert@linux-m68k.org> <161F972E-7972-4001-BE19-C88F81EF8047@jrtc27.com>
 <CAMuHMdXpmnmAy7cvA4b9LZe1skzjyOmYgUMgY7KiLRPznSj+2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXpmnmAy7cvA4b9LZe1skzjyOmYgUMgY7KiLRPznSj+2Q@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Nov 2021 17:01:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLr53hm2ai6EwxGg=nMoYqJnOkPGHXmjA1Yh31ReE_hUA@mail.gmail.com>
Message-ID: <CAL_JsqLr53hm2ai6EwxGg=nMoYqJnOkPGHXmjA1Yh31ReE_hUA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive, plic: Fix
 number of interrupts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Zhu <michael.zhu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:58 AM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> Hi Jessica,
>
> On Thu, Nov 25, 2021 at 5:08 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > On 25 Nov 2021, at 15:22, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> > > To improve human readability and enable automatic validation, the tup=
les
> > > in "interrupts-extended" properties should be grouped using angle
> > > brackets.  As the DT bindings lack an upper bound on the number of
> > > interrupts, thus assuming one, proper grouping is currently flagged a=
s
> > > an error.
>
> Rob: Is this a bug in the tooling that should be fixed?

The grouping or upper bound? The tools default to minItems =3D=3D
maxItems, so you be getting 'maxItems: 1' here.

For grouping, I plan to make this not matter for validation. I'm
working on making the validation operate on dtbs and we lose any
source grouping with that. I'll probably switch the kernel to use dtbs
as well because I don't want to maintain both. Still, I think the
grouping is good from a source consistency POV.

> Regardless, specifying a real upper limit is always a good idea.

Yes. A 'should be enough for now' limit is better than none IMO, too.

>
> > > Fix this by adding the missing "maxItems", limiting it to 9 interrupt=
s
> > > (one interrupt for a system management core, and two interrupts per c=
ore
> > > for other cores), which should be sufficient for now.
> >
> > This is SiFive=E2=80=99s IP, so is this actually true? I would imagine =
it=E2=80=99s
> > just parameterised and could be generated with as many targets as fit
> > in the MMIO space, and that this is thus inaccurate. Besides, such a
>
> Yes, this is implementation-defined.  I just used the maximum value
> currently in use.
>
> drivers/irqchip/irq-sifive-plic.c has #define MAX_CONTEXTS 15872,
> which matches the value of CONTEXT_PER_HART and the available address
> space in the driver and in [1].
> Would you be more comfortable with "maxItems: 15872"?

Always good to have a real value rather than an unknown implementation limi=
t.

Rob
