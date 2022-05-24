Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27B53260C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiEXJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiEXJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:02:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600BF18E00;
        Tue, 24 May 2022 02:01:48 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ff90e0937aso99917177b3.4;
        Tue, 24 May 2022 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtvK9iUedFKaQuVeKfSVKXEgU+fF9GB3g36XeQK32vg=;
        b=k61kCTAMKBbDrt2b8GUuLmoYekYFPTl76dJl6FDv13wmY/Etj2JdsCuqbc6m2HkjJv
         3/xO0xusDYiRyNENeeH/SDLtZH96U3U1CYs7m8nczmdFgEXbnuplde3IQ+7HheSEwZg3
         +wvrIQ+jteJn7ZKT4FIbuH6VzLBgOsRn5qGe+kuPhc+AeY5rVqPfwhw1Tdwy7UENk2L3
         vaHsrvxk6tGGwMXG0XfDhC3w1FIYp86l9Xl8UKgED3/pBqYZadtxVRrIBebdIgqq0SsP
         bj3NKLUCqbwrQxcTOHcmmFvyOpZq1rO1wOStdSsFXhRfAeMnd5yPaKb/cEZjHAUF+Aik
         ZDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtvK9iUedFKaQuVeKfSVKXEgU+fF9GB3g36XeQK32vg=;
        b=IbnfLNWJNA85b7lrquggv+pyteXdK6if8jfJlOU9HKbomGKNbSPEHKRYtHel1Zoj0D
         hmEAtPQ9edMtRAqX5lMsyitxLzHAmFNJngBjBkJp6mIdwchpu6cDwv45Wvt2kVXzbQq9
         iWoifdME/FXS+rXm4+eb1TE4W6rKexrb6rOZR0JvtxqU3JpTiLEtRxSHrPxC22o7cUze
         izkjxbaXsCDjG0iMUQ7F0+th4822mJSHqomsTPIxE+DtQnenaDjECxlHabAEnVBOaT7A
         +Rj8GG9cBllNudKXRjvsW/JqzLIxXIbxmUiklSKl+zJMTd3FSWL0VSHw42aTh72/gI4J
         0Xeg==
X-Gm-Message-State: AOAM5304Pv/NpqijBPfXg0FJSl0SAtKWquAo+P9SHQUwsnzaTTxIICA9
        CDg9rhSoswc0O/klk6wA+qSSeiavne9vfnzbhEc=
X-Google-Smtp-Source: ABdhPJz0uRDeCSlt0dkZYTlEHJ7WpwgL0ZivGhIUKrgaeioonqD9mram/aDYrTfYEHer2L465ERIiWclM7bV7iFXyiE=
X-Received: by 2002:a81:6789:0:b0:2ff:c3d1:6cc4 with SMTP id
 b131-20020a816789000000b002ffc3d16cc4mr9505123ywc.265.1653382907286; Tue, 24
 May 2022 02:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220523174238.28942-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CACRpkda5x-O+RT-=4AU0MYgeR2j7ToH5maYGCUH5NDyx6T7CFw@mail.gmail.com>
In-Reply-To: <CACRpkda5x-O+RT-=4AU0MYgeR2j7ToH5maYGCUH5NDyx6T7CFw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 24 May 2022 10:01:20 +0100
Message-ID: <CA+V-a8s8K0VaNunrFnW_BzPCHmi9RK887bb1tBfodbxBmGOvPg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
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

Thank you for the review.

On Tue, May 24, 2022 at 9:57 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, May 23, 2022 at 7:43 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > Add IRQ domain to RZ/G2L pinctrl driver to handle GPIO interrupt.
> >
> > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > used as IRQ lines at a given time. Selection of pins as IRQ lines
> > is handled by IA55 (which is the IRQC block) which sits in between the
> > GPIO and GIC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> I don't know if I'm too tired or reading it wrong, but it seems you
> went through the trouble of making it possible to override .free() in
> the irqdomain in patch 3/5 and yet not using it in this patch 5/5?
>
I think you missed it, free callback is overridden with
rzg2l_gpio_irq_domain_free().

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220523174238.28942-6-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
