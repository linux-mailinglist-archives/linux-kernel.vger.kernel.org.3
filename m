Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE55055CA43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiF0NG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiF0NGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:06:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A20165C1;
        Mon, 27 Jun 2022 06:06:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id cw10so19067785ejb.3;
        Mon, 27 Jun 2022 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOSI8zp0jjxL5+CxolovAvYdFi+BiCcWlLjESh/UX/A=;
        b=pHkkuP5Q6EifbGayLDb0Ez91DuQx5xkhc7QCQ0k+IT34Ns9HcJSehFYOEZX129kJLq
         4S8r1tOQeEiTjNdu51RsxAD6S6J1ciPSuWHY5hRT53ATbCu2St/zspi0Le62FvgBlAt5
         vXrLIbtl+2fyvBRWIGQ84HxG/Z9KcA9yZjs6fyux7BQBLgl6jvhd0vPxkOsf/Ox0IXcg
         fpbJTgBhgmq5AAm8s70wmFHoi7K5JHltfXni+FekAFAlsWfRLN1tkYdB7sAqM4LpTJ85
         wQD5KtqGMknCMQ1o0xKPb5MecVivc6TvIxNjLtdeiACpQN/JNVyIF75+3tqmAK8u3x6e
         wxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOSI8zp0jjxL5+CxolovAvYdFi+BiCcWlLjESh/UX/A=;
        b=Cpujh2e8zMrpMhEdEdDjK8NWUPt96+W++RdW4EvPKlM57dchaWhvf2Qj3nR/pKg+OM
         o7DCbFaDtUBt79TPG9Vwz7gGLUsCvmEcqVjiFyzp25vs5pj0+Q2OiDN5NqaLRUrLq6Am
         TEsLyDE/wbhDS7bS9UOnvIxxSK89EHwnpYW769HunInyDdxu4Qd5Zwg40qbymH6nKMV8
         XBaInrwzjeOqzkMD/OypRZyq1e2BxVWTwUZg/BKwGsjXteh2Gpajxb2VXJUEBMkfcaFw
         hqKP7FLD/xSakdVhwF+TfmS4fQpsnEDNNDtZRuDyR1Z/4HLnl5ZYeDKbsuEDAEkJ0WdY
         7/5Q==
X-Gm-Message-State: AJIora97VDSjl+2i6ctGsjzJle3Yp69swZsyzbD+BkGZ51XAdIBNfVRI
        Ukvl2OWqp1bd2QcoWotMcUa9q86hTQUCx4ETlZw=
X-Google-Smtp-Source: AGRyM1tV0uy7m2UWEmiBYpZBnFXopW6CovXzIp6Y2TekBETDYCrK00QI5NAWVA4dyfjvMhVMk4gGj/y7W5BvEzGeHsY=
X-Received: by 2002:a17:906:b05a:b0:718:cc6b:61e0 with SMTP id
 bj26-20020a170906b05a00b00718cc6b61e0mr12731068ejb.501.1656335190863; Mon, 27
 Jun 2022 06:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87wnd3erab.wl-maz@kernel.org> <CA+V-a8tcxj_N0sBHhgAZAN8WSJ12JnDzAvUUnCXto3wHLqNVwg@mail.gmail.com>
 <87v8snehwi.wl-maz@kernel.org> <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 27 Jun 2022 14:06:04 +0100
Message-ID: <CA+V-a8uLzLJ=wB6oUu0b2oZO=FPSCTSrqb=3m9=BJxATFKmjMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Jun 27, 2022 at 9:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Marc,
>
> On Sun, Jun 26, 2022 at 2:19 PM Marc Zyngier <maz@kernel.org> wrote:
> > On Sun, 26 Jun 2022 10:38:18 +0100,
> > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > On Sun, Jun 26, 2022 at 9:56 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > On Sun, 26 Jun 2022 01:43:26 +0100,
> > > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> > > > > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> > > > > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> > > > > edge until the previous completion message has been received and
> > > > > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> > > > > interrupts if not acknowledged in time.
> > > > >
> > > > > So the workaround for edge-triggered interrupts to be handled correctly
> > > > > and without losing is that it needs to be acknowledged first and then
> > > > > handler must be run so that we don't miss on the next edge-triggered
> > > > > interrupt.
> > > > >
> > > > > This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> > > > > support to change interrupt flow based on the interrupt type. It also
> > > > > implements irq_ack and irq_set_type callbacks.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > > +     if (of_device_is_compatible(node, "renesas,r9a07g043-plic")) {
> > > > > +             priv->of_data = RENESAS_R9A07G043_PLIC;
> > > > > +             plic_chip.name = "Renesas RZ/Five PLIC";
> > > >
> > > > NAK. The irq_chip structure isn't the place for platform marketing.
> > > > This is way too long anyway (and same for the edge version), and you
> > > > even sent me a patch to make that structure const...
> > > >
> > > My bad will drop this.
> >
> > And why you're at it, please turn this rather random 'of_data' into
> > something like:
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index bb87e4c3b88e..cd1683b77caf 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -64,6 +64,10 @@ struct plic_priv {
> >         struct cpumask lmask;
> >         struct irq_domain *irqdomain;
> >         void __iomem *regs;
> > +       enum {
> > +               VANILLA_PLIC,
> > +               RENESAS_R9A07G043_PLIC,
> > +       } flavour;
> >  };
> >
> >  struct plic_handler {
> >
> > to give some structure to the whole thing, because I'm pretty sure
> > we'll see more braindead implementations as time goes by.
>
> What about using a feature flag (e.g. had_edge_irqs) instead?
>

diff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c
index 9f16833dcb41..247c3c98b655 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -60,13 +60,13 @@
 #define        PLIC_DISABLE_THRESHOLD          0x7
 #define        PLIC_ENABLE_THRESHOLD           0

+#define PLIC_QUIRK_EDGE_INTERRUPT      BIT(0)

 struct plic_priv {
        struct cpumask lmask;
        struct irq_domain *irqdomain;
        void __iomem *regs;
+       u32 plic_quirks;
 };

What about something like above?

Cheers,
Prabhakar
