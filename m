Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649184DC557
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiCQMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiCQMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:35 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BAB170DA8;
        Thu, 17 Mar 2022 05:00:18 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o5so9796159ybe.2;
        Thu, 17 Mar 2022 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7umAd0HdQF/0Y/dcMA5O7GL9fe1/Zuc2dVyyldUlgw=;
        b=gfZ92XehhNSgAL1i916bWJTKe1a1eeZ0rlq0AUvo23EAZz9KwhhgS3njKZeyzpk/Ey
         vTOdsvqySgrQd5J7nGndrNwNTMBUFcDBdFy95ZNtJtmbvCqyIP3eCgp71S4WMHHHlKla
         PslTZh1Zwt9t6sxKrVidMy/kfisuV8rOpMCOMDYR2H63sr1PebYkdvyvYEIJpbnQMFJO
         SPm3dzu23FG1oGpcQbO+1RXRins5MimoZHVlIiGYnapBq2drmDJNN3xojvP/IoYMJYaX
         rm+ekHq39HFlWjNztSMKB/g0q6VJjEpG6Ay5DLhe/94K4yGtlGTCX/Y7NmM8JP9ui7mj
         IK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7umAd0HdQF/0Y/dcMA5O7GL9fe1/Zuc2dVyyldUlgw=;
        b=QqM0Vxe7js/qI0kerPxlPNEFJmN67u1pSCN5ZGopQ6BsgA4deYmKLRPzQGWMYlWo3Z
         BqWWNg3i4nru4v4/V8CAIZwG8Z5rnhIw78s05pCZ4F2N609hplAsbjo9mXtjY7OP9Fus
         gNRJRJ6jvicMVHwwqjApRsVvNRqHa6YH//o473xLbU94a8vkB3Kj3I8dZPa2UDjASBj1
         Lom0r42FgAXNzlnpqYHXEnzfU83qNNj381TkWmuZcnRhCpClhkpWeDv1iQLnywPENqAE
         GBBSMbmv791D3SL4O4bzOrvfz0oQDZveD2Ik5HwprGMRqAxsrhlJWQPWT2o7kxIjvPma
         I6kw==
X-Gm-Message-State: AOAM533lxqVcF7MV0XjA+6KUuccwClyAvPmfsEtlvBdtPLfyp0Dd/ZtS
        WqYiJxzm5YgSHgxHh3ehdwmdyBE6iiqwm9FPVrg=
X-Google-Smtp-Source: ABdhPJwYmzfiLbLPvbajfh4qpduHNmcl11o8Nfezb4d7zLMfNtasZCOtvIKOiNO97c1p13rWPLnTSu6EhzR8seFgAYs=
X-Received: by 2002:a25:8812:0:b0:633:7bd8:16ff with SMTP id
 c18-20020a258812000000b006337bd816ffmr4357088ybl.645.1647518418131; Thu, 17
 Mar 2022 05:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75Vc+uSNF4L0WCfCyadOqJ6szXS3Ct5BmEUbeQ_aKg1zjWg@mail.gmail.com> <87wngtx79f.wl-maz@kernel.org>
In-Reply-To: <87wngtx79f.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Mar 2022 11:59:52 +0000
Message-ID: <CA+V-a8uBrau7-0x95O750nPeckz=vdhK2RJtFZ2rfiQhEtrdwA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/5] Renesas RZ/G2L IRQC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Thu, Mar 17, 2022 at 9:23 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 17 Mar 2022 08:46:14 +0000,
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Mar 17, 2022 at 5:43 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > Hi All,
> > >
> > > The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> > > Renesas RZ/G2L SoC's with below pins:
> > > - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> > > - GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
> > >   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> > > - NMI edge select.
> > >
> > What I want to know now is whether it is going to collide with Marc's
> > series about GPIO IRQ chip constification?
>
> Probably, but the current scheme will still be alive for some time
> (you'll need a couple of cycles to sort out all the drivers).
>
Ouch, thanks for letting me know. BTW there are a couple of changes to
GPIO core which you have to review (this was missed in the previous
version).

Cheers,
Prabhakar

> Worse case, this can be fixed at merge time.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
