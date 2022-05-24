Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAC53261C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiEXJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiEXJHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:07:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7767D05;
        Tue, 24 May 2022 02:07:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p190so2851945ybg.4;
        Tue, 24 May 2022 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Tx1BWROKP0/4lNYHpybGvkaMQyge6iiz9PNPvD4+qY=;
        b=aQwUz6+ffoqY1v3jszLqvLwqJB7nzfjWfj+InzeqhN8GQDyYS/b88yLLRogzI3NS01
         lH6OUz7zukDBCM5O4GlPa2gpHESJc2pU7dJExaOE0VxauQQtzCXHrHxvRzn71j/Y/qR4
         tdv19sKBPmX5AJPpFh2A7SWjZkiUcWBHd0iEIB0iVZcGEfWXVyp0di3fmvAKZubV8ToU
         KU6XTCXHpxLEubIapRDOEhbO0/ShqLms1N/zrNDomIRyvjy3iBfOqofJFqmn+KPH2Bde
         utKp4yORLjuLScNdH0OPOWxD1uJSynt0kElv3Z3NyYpfxu7kjYgtf4Toih2xyLKk6b1n
         F1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Tx1BWROKP0/4lNYHpybGvkaMQyge6iiz9PNPvD4+qY=;
        b=nKlrVyy0IXzVkaOjJFt1fHxLIULxhm4ZDdsxqKWYqMInTCgyC4/F8f+yVVCYlX28f3
         7o7qdRDbOlF3UHNZ4rO5XgJfIyRRaYpnAGUaJXkB378W8GUb1xWJvIl4DtuA+3aV+mJI
         GYsWt+oZwhtfXmBDsJ+UQRPPbu7sW3oPztCEHUHq6uPMdhYh31J85jN/57KKYzQjOrXP
         F+1qLSY7WD3140CVNDFhCPmBpnkFw/kVaValpJox8YC8zuhV4X3mr83nqKxWXCm4LjN1
         j9BuA0QQ76MMN7Sm2vyOCzPDLaXVhcj3qT6Kwd1w0IEdOkvcUWLB6MQI4P8PlgkjkS6P
         3CMw==
X-Gm-Message-State: AOAM530b9EUunIHdMb7T5aYabFFJKdtrOYQybUZINECzt8sQwdhDRgSV
        fHFbaDFC/3VH3mfumJZCk6dr8vmpjtSDY3dgWIM=
X-Google-Smtp-Source: ABdhPJzM4ZpMtr20WZp/sxrmVJUSKAmBdig4nKMcgZaRdipxdlpEOiglvaxJZe+JMhHfONlZuQBKYRWKkWTKFJNLv9E=
X-Received: by 2002:a5b:888:0:b0:651:ac74:d084 with SMTP id
 e8-20020a5b0888000000b00651ac74d084mr2445569ybq.218.1653383231923; Tue, 24
 May 2022 02:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220523174238.28942-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CACRpkdYaWmD9PTcGgeP5MTe9bXMgmf=tUSDBQ-4VxSfL4qkoeQ@mail.gmail.com>
In-Reply-To: <CACRpkdYaWmD9PTcGgeP5MTe9bXMgmf=tUSDBQ-4VxSfL4qkoeQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 24 May 2022 10:06:46 +0100
Message-ID: <CA+V-a8s+dWMwL6zQnWwFAa15sMgPGYrW+GZ=WhSW1tPxgpLOqA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Linus,

Thank you for the feedback.

On Tue, May 24, 2022 at 9:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, May 23, 2022 at 7:43 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > Allow free() callback to be overridden from irq_domain_ops for
> > hierarchical chips.
> >
> > This allows drivers to free up resources which are allocated during
> > child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.
> >
> > On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
> > is allocated in child_to_parent_hwirq() callback which is freed up in free
> > callback hence this override.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> So that function today looks like this:
>
> static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
> {
>         ops->activate = gpiochip_irq_domain_activate;
>         ops->deactivate = gpiochip_irq_domain_deactivate;
>         ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
>         ops->free = irq_domain_free_irqs_common;
>
>         /*
>          * We only allow overriding the translate() function for
>          * hierarchical chips, and this should only be done if the user
>          * really need something other than 1:1 translation.
>          */
>         if (!ops->translate)
>                 ops->translate = gpiochip_hierarchy_irq_domain_translate;
> }
>
> (...)
> -       ops->free = irq_domain_free_irqs_common;
> (...)
> > +       if (!ops->free)
> > +               ops->free = irq_domain_free_irqs_common;
>
> Marc Z is working on cleaning up the way that gpiolib is (ab)using
> irqchips. We definitely need his ACK if we do things like this.
> This doesn't look like one of the big offenders to me, but I want
> to make sure we don't create new problems while Marc is trying
> to solve the old ones.
>
Agreed, I had a discussion with Marc on v3 series [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220511183210.5248-4-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
