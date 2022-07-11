Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9A570305
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiGKMnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiGKMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:43:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520D1169;
        Mon, 11 Jul 2022 05:43:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sz17so8593527ejc.9;
        Mon, 11 Jul 2022 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFIWdw+oH2e7ggqN762X73Uvj4NmyoOD6YcZjg1c9UE=;
        b=Y0ay2MOCK5HvKYZEU/KH0y+by57+m6lDt3X9vbaUWzTUupLzLgNsBzuxtNNWYiVmwL
         +3c2sJ2W9nvK+fWuldPx7ig1Mq9gmF2wqfO/1VioA5g0SuggM/VDsimHz8WUneyv1afP
         ImN0cB8MOqzG49ddkDoH1AOGuRHvpXs4H2v9tH+u++JoSsGWnEZwFGDzOkcD5Y+xVWif
         j6L3jgd5gTMpl7QpCmk4Lef50fXgM2ad7dBlQzVsm9HWNYTHj58+bbw9VziaS7dY9oEu
         52NkdqX7Q6V8vpyoe+Xn884MIvtcqidhh9SfgJBjrXv8+3RorU/o1Qpnde6YyBzxP+bn
         J1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFIWdw+oH2e7ggqN762X73Uvj4NmyoOD6YcZjg1c9UE=;
        b=aJvmEkPYpZVfFG2/FLH9l0X7vElfO5sBcUj00KtLBVMESFTOYGl57IKBNmReC43f5F
         Jlh/wLm1gO/i6VGq0CTkmM0tMj4kPCDPP5r3vkVoCECcBfzf0grsWIwp/GWnqPenO7Q4
         0pbyVKNATlCjgMXeaWQXrdPueRlftejgYNyGjUspk8WsXTsQEpOPRaoZ2T/ao75NHabX
         VmNFtCLNoaypj2RSGHaok0IKVXz+uHbe5Mmq8q+12+hKcTwG6oSiajcW2k5+/e/DgHhv
         P6JIjBRmZ+NZGSs58EHMlWoUfw1W9gNtNJodT4xIFFuWMDglx0hMA0t8ld9Nu1panfZA
         O6mQ==
X-Gm-Message-State: AJIora/ltptnUUsl+lG/G5e/P0xLzxjPB96q2pjjkToOdFojj8x/eIcc
        4FeEhZK3yzGPN424laC07IE6JJmMqDLYHjZqWUk=
X-Google-Smtp-Source: AGRyM1tRZv+S21P2yqAIdHMiGuopXuLzlIjQD0sqQyr34rlVtpnGhej3WMjCMcZ3IOICdyo3IrAtOCYIKQR+x2RreIs=
X-Received: by 2002:a17:907:6d86:b0:72b:5ad6:6df1 with SMTP id
 sb6-20020a1709076d8600b0072b5ad66df1mr3957100ejc.264.1657543411346; Mon, 11
 Jul 2022 05:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220707182314.66610-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CACRpkdbhDJq9bJKHM=1pq5+HrVasrT_WuqtAxGWFfnAXMWSr8g@mail.gmail.com> <CAMuHMdXqK7Snk6=+VNhq59SLgv-zRCgwrkABMtC5JOpX02fuVg@mail.gmail.com>
In-Reply-To: <CAMuHMdXqK7Snk6=+VNhq59SLgv-zRCgwrkABMtC5JOpX02fuVg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 11 Jul 2022 13:43:04 +0100
Message-ID: <CA+V-a8uBk9iB08v65CbDQKyKr1jmd1jgvCTP69raxntoNUoU2w@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] dt-bindings: pinctrl: renesas,rzg2l-pinctrl:
 Document the properties to handle GPIO IRQ
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
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

Hi Geert, Linus,

On Mon, Jul 11, 2022 at 12:51 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Linus,
>
> On Mon, Jul 11, 2022 at 1:36 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Jul 7, 2022 at 8:25 PM <prabhakar.csengg@gmail.com> wrote:
> >
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document the required properties to handle GPIO IRQ.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Is this already queued in Marc's branch targeted for next
> > so I don't need to do anything with the pinctrl patches?
>
> I don't know; I was wondering the same thing ;-)
>
> The gitweb link in the bot email does not work:
>
>     Commit-ID:     35c37efd12733d8ddbdc11ab9c8dbcee472a487f
>     Gitweb:
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/35c37efd12733d8ddbdc11ab9c8dbcee472a487f
>
> The actual commit seems to exist in that repo, but using the web
> interface, it is difficult to find out to which branch it belongs.
>
This patch (and all the patches of this series) is part of
irqchip-next branch [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/irqchip-next

Cheers,
Prabhakar

> It is also not part of next-20220711.
>
> Anyway, it's too late for me to take the pinctrl parts for v5.20 (saw
> no ack from Marc before the bot emails), so if it finds a different
> path upstream, I'm happy ;-)
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
