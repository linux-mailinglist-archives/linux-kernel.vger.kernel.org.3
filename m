Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532FE52543A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357368AbiELR4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357411AbiELR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:56:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8088C1FCEF;
        Thu, 12 May 2022 10:56:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i38so11123254ybj.13;
        Thu, 12 May 2022 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDf56ztQPBCcZZJ7QUrd+Gca39+mdnDOAe1uKcepMDQ=;
        b=pegICUYUytx85orAdIVv5XS7x83nbZWGrPKozBcGu7LZ2N31Zlzr2ABeWgeo9ZesfS
         Q46RwOAW6yxxghjbVmkXVxsEg/BryIOfQ3mfkdzsG8xzoLv8Yilx09aPJnBldN7Z/7b7
         iWbBrfZzxJ5KURGwvm+G0EXuSnjYDntNzjI4Y8N6XeAbE2n6NPky7JIYWCzPTXm7tEjO
         RsQJG3xgvgfKSCGD5z9I4Wa01etuxs70zkPy+/6p9ciwhp/rka2A4cY3LzTHsA7VUbua
         gcHS/yDdnG5Blol+61ocBmo3OujeKdGWgOWV9TuPkxDYgchtGYmz8quKf2sqmrERJHar
         NlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDf56ztQPBCcZZJ7QUrd+Gca39+mdnDOAe1uKcepMDQ=;
        b=HiIiN6zAIOZyX+k166tTg0/1qu5zpcM55F3EvKgGy31+zwb/kWi0nkDiJh8CNNB5pS
         337hwwTvuuE1ZbieZWn6bAxCddDC9ESB8BRDpdqE2Uagx/E3pRR020kh0/A6tfBAOeJp
         RuOds7RBNpDPmLc7Pr2ZR/DU5Yw3V9gncaXGjM5J3tBUhBLE0/x6Nsa9pgqcJLtyres1
         SbXBTgd0lQo3F5+p26bRp/cFx0fbCYAgazxxBhrKO7XGmq9/CLMLwkrlm9ZlQy8Z9bta
         xcbLIlHOu9a5jdboMaKDodOKjBjHjyUKXbh5IWhizfzXj7MtAhW8mCpe0ZE8Rf9/ytLR
         uH2w==
X-Gm-Message-State: AOAM5329dxDl45P9i7/FoDcOtUcsDKrmF3+XPzsEpPCx/TEBSTGY46pj
        65keujk+5AIkdnNn6wApyK1CEFsHLGA7JltFF2w=
X-Google-Smtp-Source: ABdhPJzRigrzfrx530jGCbcMBGmMrZu0k8SbHFBXZASDGaDsogoQOvX4dBSvDcRlR4lzsuShPUKGDXwO2ueGPNrihJw=
X-Received: by 2002:a5b:246:0:b0:619:5651:3907 with SMTP id
 g6-20020a5b0246000000b0061956513907mr1061247ybp.190.1652378164781; Thu, 12
 May 2022 10:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87y1z75770.wl-maz@kernel.org> <CA+V-a8tf1RmT-cX5y807rTAPES2NXLJHp=u1WUG11fLrtt-5Mg@mail.gmail.com>
 <87wneq6fz3.wl-maz@kernel.org> <CA+V-a8v9WodNNK7AL4XemDnSrrWc9wG+qDKZb7SmbWixs5Q3Nw@mail.gmail.com>
 <87v8ua67kt.wl-maz@kernel.org>
In-Reply-To: <87v8ua67kt.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 18:55:38 +0100
Message-ID: <CA+V-a8sMvjYK5NfkqpD3ertfUOy1zbauXW9gLzG+GLzZtvUygg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
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

Hi Marc,

On Thu, May 12, 2022 at 5:26 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 12 May 2022 14:50:05 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Marc,
> >
> > On Thu, May 12, 2022 at 2:24 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 12 May 2022 13:48:53 +0100,
> > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Hi Marc,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Thu, May 12, 2022 at 12:19 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Wed, 11 May 2022 19:32:08 +0100,
> > > > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > >
> > > > > > Allow free() callback to be overridden from irq_domain_ops for
> > > > > > hierarchical chips.
> > > > > >
> > > > > > This allows drivers to free any resources which are allocated during
> > > > > > populate_parent_alloc_arg().
> > > > >
> > > > > Do you mean more than the fwspec? I don't see this being used.
> > > > >
> > > > The free callback is used in patch 5/5 where free is overridden by
> > > > rzg2l_gpio_irq_domain_free. I just gave an example there as an
> > > > populate_parent_alloc_arg()  In actual in the child_to_parent_hwirq
> > > > callback I am using a bitmap [0] to get a free tint slot, this bitmap
> > > > needs freeing up when the GPIO interrupt is released from the driver
> > > > that as when overridden free callback frees the allocated tint slot so
> > > > that its available for re-use.
> > >
> > > Right, so that's actually a different life-cycle, and the whole
> > > populate_parent_alloc_arg() is a red herring. What you want is to free
> > > resources that have been allocated via some other paths. It'd be good
> > Is there any other path which I have missed where I can free up resources?
>
> No, that's the only one. It is just that usually, the alloc()
> callback is where you are supposed to perform... allocations.
>
OK.

> It'd be good if you could move your allocation there, as I would
> expect calls to child_to_parent_hwirq() to be idempotent.
>
For now I'll go with the current implementation, as currently a an
array is maintained which is tied with the tint slot and child (which
is obtained from child_to_parent_hwirq)

> >
> > > if your commit message actually reflected this instead of using an
> > > example that doesn't actually exist.
> > >
> > My bad, I will update the commit message.
> >
> > > >
> > > > > There is also the question of why we need to have dynamic allocation
> > > > > for the fwspec itself. Why isn't that a simple stack allocation in the
> > > > > context of gpiochip_hierarchy_irq_domain_alloc()?
> > > > >
> > > > you mean gpio core itself should handle the fwspec
> > > > allocation/freeing?
> > >
> > > Yes. The only reason we resort to dynamic allocation is because
> > > ThunderX is using MSI-based GPIOs, and thus doesn't use a fwspec (no
> > > firmware is involved here).
> > >
> > I see..
> >
> > > If we had a union of the two types, we could just have a stack
> > > variable, and pass that along, completely sidestepping the whole
> > > dynamic allocation/freeing business.
> > >
> > Right agreed.
>
> FWIW, I've just posted a PoC patch[1].
>
I guess I'll have to rebase my changes on top of it now ;)

Cheers,
Prabhakar
