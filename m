Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1156AA04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiGGRvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiGGRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:51:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D2D59244;
        Thu,  7 Jul 2022 10:51:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a9so3997244ejf.6;
        Thu, 07 Jul 2022 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPGmSSkEKuIxkfYPNKaLme5kcpaEx5EEbQVv8NiY+tI=;
        b=U0R7WqvJPyFPmcL4fOV3316P0Hhb34jweRuqTB8ek+Z1bKKURM9xsHivQcxmY5O4tE
         7TBB5IgU03h5hFkXmYrfzStmUfDfB8Ox6sK0GtKZA+iSP6ntBWImA+cDDoi+bRwcpE8N
         3bio6laXZtLrd3/djtuD2ml4CxcggyXgYZa2H85RH4ntOzO3VqtpXGD7cKo6ZwrP0HBE
         hYTmwWicjJ6Bliu3qnZiwnsHSgPfMHWbJWiOgo3gSZ0ZKIOXuck+0dIAoV3+VcYnyZiH
         s/17UFEZrF7iqB+6onW9uJxRXRR+idPmM94vdrIiB9k+Efvn1pvnp2tvu8l3zwdDBmrg
         OX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPGmSSkEKuIxkfYPNKaLme5kcpaEx5EEbQVv8NiY+tI=;
        b=xplZo841qEhxbPyUTzkQBACPYK1H3P7z5N0DmhkG0NZDZkKll8arXY7U5N7rPFnUQE
         6/h5vIquibAAizYnqIOdt5efC/d3jwkUgxMU07liSk+ULYn93dNAlj5EsBz9033NfLCW
         vKOfWsxCtaU3Yic8tV7S87u+JXKF/+hFe0FcXmteP4sfEGhJ2ohAdPV9XCrt0tLdmA/5
         S0jisiMK2QNQBZwz4yja9nF16N3yUMHyAhiefkbIKGECKKmFHxnv6i0LCSgVGXps/h26
         ZYbEmK7s+QOWTW2kxyCl1ovhKdIP75Es+tiQXmENqdksDkzeUTOzJHNzmwodStw4ZumP
         Di0A==
X-Gm-Message-State: AJIora+3LPisHbZjRIme1efNDnzgKd9huyEQy51U/CV6Yj78hdiDxCi9
        OsqKwyOWiCWIwMrTc0q3frPUDv9sEjShihBpYj+8UghE
X-Google-Smtp-Source: AGRyM1ueUAvCxvaIlb/9gHATajCw3Vep06RVIjsU9x8Eq8J5AZqrZORkbSmSBUF0OCdWAabZ2WBo8gXl02QpYjJbQpc=
X-Received: by 2002:a17:907:6eac:b0:72a:fb80:d39 with SMTP id
 sh44-20020a1709076eac00b0072afb800d39mr8623143ejc.536.1657216287772; Thu, 07
 Jul 2022 10:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220703194020.78701-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfFZ146p1sZ2=Ec-F-9zYJZHPWyvgYQeVsG=2TzssaPmA@mail.gmail.com>
 <CA+V-a8vua6t5wDNc2CT_XWhoy6OjmzCXyaJ1FtGaqeG5g-qS-w@mail.gmail.com> <87iloan2rv.wl-maz@kernel.org>
In-Reply-To: <87iloan2rv.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Jul 2022 18:51:01 +0100
Message-ID: <CA+V-a8uQ5ESFNhnBATsm0s0OZooA2-+wxqK2tc7cM3XyGf9eVA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Jul 6, 2022 at 8:01 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 05 Jul 2022 05:53:03 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > On Mon, Jul 4, 2022 at 5:16 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Sun, Jul 3, 2022 at 9:43 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Allow free() callback to be overridden from irq_domain_ops for
> > > > hierarchical chips.
> > > >
> > > > This allows drivers to free up resources which are allocated during
> > > > child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.
> > > >
> > > > On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
> > > > is allocated in child_to_parent_hwirq() callback which is freed up in free
> > > > callback hence this override.
> > >
> > > Hmm... To me this sounds asymmetrical. We alloc something in another
> > > callback, which is not what this free is for. Perhaps it should be an
> > > optional
> > >
> > > free_populated_parent_arg() or alike?
> > >
> > @Marc your thoughts?
>
> I think there are enough optional callbacks, and we don't currently
> have a clear picture of how this may be used in the future, specially
> based on a sample of *one*.
>
> Let's get it in as is, and tweak things as we go, should another user
> require a slightly different behaviour. This also saves us the debate
> around the naming, which is always pretty useless.
>
Thanks, I will repost it as is.

Cheers,
Prabhakar
