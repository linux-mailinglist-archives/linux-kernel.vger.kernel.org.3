Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8905317D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbiEWSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiEWRiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:38:09 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01685ED9;
        Mon, 23 May 2022 10:32:14 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id f16so26678650ybk.2;
        Mon, 23 May 2022 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+WLDyB1KyiUyJgUsSoOS0+avgPWWtIIyr0okynq40k=;
        b=OwTZPyphMH0ShclRWHmvVvmKKYRI8KRPtGaQ2imCrcIW8cAsyR98AxruB7fsfc+jAV
         Bl8WBKI8LeKB+4GdKcfq5wePNKXKgbYipxtjW/MCLMznKjxm6PyzzeO5v3PYuYSwUTSD
         KcHd7taZrbyq/eIn7XALueE8aGjU4zffJaz0GrMQC7LXa3kQ6FA0eGW4WNnBr43uYMwu
         mvIV+hlDTYQxujYMkjGlSDRovcsJ8JYYBxgE4YDu8VXL9Dd9jtg/7uleR4ZIusqZ0Wao
         BPtC6lfJfnp4Hy8Sfm1eclUTxaYFinWAYYHXnmTp13GMgFzy9ikeC2nSygT9MEJPsZn+
         S/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+WLDyB1KyiUyJgUsSoOS0+avgPWWtIIyr0okynq40k=;
        b=HiFodHF+EQzcAWpVCi/r7iU+0MKAGS+qsYRU6n1sX1acKx1sPGXI+0G4YHkmRke1UJ
         x/2D08lXpkZ813cY2UCByEvEeraq/ASEdetsPtIsUOXsgDgYhPjkhARGKgcZMB2ipff9
         K5QmbS9zgc2VeYKvQJcjnr5NyZSnQ3QkC7UzpxzjsGzzrOGGEmHiXJiVaxVS+w2v92yg
         pzEFR87Atgw2z+ZN/yhFCyrz49CbJyopeFSINQkJ7paxne8X99weHJg//OZFpBqonADb
         Y2wzlo1Ir2bkA3PedO4Ka/zC8Ot59Kdv5m7VxH8RrIafbz4t6nP7l0KzAHcITcsdq/GI
         Pobg==
X-Gm-Message-State: AOAM533540tXeMdpHM0A/kmaZ8PO3tKaBi8uPlMapUy+kDOahFoTt3El
        tqo2gU6VjF2nh650raArvzbxdbgcCc9yInQ11Qg=
X-Google-Smtp-Source: ABdhPJyHekt3JIocbDUxFMK4GkF5t4CZsAZMk/LL+K9cKxPoQhDfyLRj9hy42RLDgOzDKMCGnmU0RH12f4UOjKh1fbk=
X-Received: by 2002:a25:ab84:0:b0:64e:3d2:8a6f with SMTP id
 v4-20020a25ab84000000b0064e03d28a6fmr21704797ybi.431.1653327001589; Mon, 23
 May 2022 10:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220518192924.20948-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXz7ZtC_63hUckrEeB3uocNG0iKbA4i3xDsuyL48m_7qQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXz7ZtC_63hUckrEeB3uocNG0iKbA4i3xDsuyL48m_7qQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 23 May 2022 18:29:35 +0100
Message-ID: <CA+V-a8tU9tEdJSa+BJfAiWtCE5VAeD5EA-zMOdf8GjQaG8oc+w@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: pinctrl: renesas,rzg2l-pinctrl:
 Document the properties to handle GPIO IRQ
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, May 19, 2022 at 1:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, May 18, 2022 at 9:30 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document the required properties to handle GPIO IRQ.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > @@ -126,6 +139,9 @@ examples:
> >              gpio-controller;
> >              #gpio-cells = <2>;
> >              gpio-ranges = <&pinctrl 0 0 392>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +            interrupt-parent = <&irqc>;
>
> I think the "interrupt-parent" property can be dropped from the example.
>
Sure will drop it in the next version.

Cheers,
Prabhakar

> >              clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
> >              resets = <&cpg R9A07G044_GPIO_RSTN>,
> >                       <&cpg R9A07G044_GPIO_PORT_RESETN>,
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
