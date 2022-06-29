Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D5955FD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiF2Kez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiF2Kex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:34:53 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70CB3E0C8;
        Wed, 29 Jun 2022 03:34:52 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p7so25725636ybm.7;
        Wed, 29 Jun 2022 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Esm5fzBQwgLjWErX7JniKLOwrXIy0Zs+0PNTxASNg3c=;
        b=dKp8Z/sbDfOyGVipwI8EqlAg8kU2VBO24xV3svroRisNc4HjMJfy+C2BqZ9L80a6AI
         VymRjoL15k6RZDKv4rrtfl3B+joD0YRVLYNuqO4wwOLyVS9zPGYqYHfTfr3R/SlahmXv
         stBX7L1T/cRWT8qEykk8KjNfP1/EmPmQ92fuykmr+QJcZgbaYlVPJfttkNopDfSPINrw
         JEbIlqvtLfu5B5c65zVDNgsA9i1oIlZJvdUN1lxfK+y/pLhwBpjxaQaVCO4f+Py3tVQ/
         8E6xFAekCkgSUojTwYOBqNN70mynTvW0qtCNpn/viJvFttnJhxA+AXMgZs+shTldGN7V
         ac1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Esm5fzBQwgLjWErX7JniKLOwrXIy0Zs+0PNTxASNg3c=;
        b=mrJo3Nk+8BCfp0C1/lnrvm/yNE7ED6BodeeoaS2gj6NWAUudQTySefsWE5rOvZvt4N
         GbhkQxghWMyQ3QrSo2VDqwPfoUns/oEALWN8jLneq3uSzMNG8CUkAagoUi4sSAEImh5n
         ENqj0V96aKHWqbZs8m4BAimsI9qOp/oH4lcUDCo93nDDC+Y2wxTNH5+CgxHyGkncd8Hq
         8VwYKhkpwXTx9ROI4gPg6X4Vu4ZivfvchzukOaGcE9Mnn6IWODHWWX/BmebUhZexQuvH
         Q56PYyhdTlARkpbvVxNNSy/pFJRjm3PdkDiF+CiHiRjO+Gz9bTZsveUwJErxCpj6fuCj
         2yDA==
X-Gm-Message-State: AJIora+Y5nQRCovPbaa+q7Da5m9Gs/5DGIelMLAQQl4FJMSX1xozJpFf
        B3rCZSC/xY+NHRoUYA7iMOLJxQdgMxPE6Oqgo6uImvn/JoFzEw==
X-Google-Smtp-Source: AGRyM1tyF2+rCpjXHLhkT67Iu+Bejxh/ov4ERZECi1AQGydRTJ9BRKmVpc6ZmM+pOe/fzEEULNvHDlvvCdxGGfbAgqg=
X-Received: by 2002:a05:6902:1549:b0:66d:5f76:27ba with SMTP id
 r9-20020a056902154900b0066d5f7627bamr2392119ybu.385.1656498891813; Wed, 29
 Jun 2022 03:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
 <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
 <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com>
 <PH0PR03MB67861277E1AE456A316DFFEB99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <CAHp75VfeZ9jbWvFwL+Sae0h8DG36GeV4PKtskVQe10hpWGf28w@mail.gmail.com>
In-Reply-To: <CAHp75VfeZ9jbWvFwL+Sae0h8DG36GeV4PKtskVQe10hpWGf28w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 12:34:13 +0200
Message-ID: <CAHp75VdPz_S6HO8G6Qr=xQMRBetjZBmLQm2y1Ss43PbUzpUHvA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: adp5588: sort header inclusion alphabetically
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Jun 29, 2022 at 12:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jun 29, 2022 at 12:10 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Wednesday, June 29, 2022 12:00 PM
> > > On Wed, Jun 29, 2022 at 10:50 AM Hennerich, Michael
> > > <Michael.Hennerich@analog.com> wrote:
> > > > > -----Original Message-----
> > > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Sent: Dienstag, 28. Juni 2022 21:39
>
> ...
>
> > > > > Sort header inclusion alphabetically.
> > > >
> > > > Thanks for the patches, they look good.
> > > > However, Nuno is currently working on getting the irqchip support
> > > into the
> > > > adp5588 input driver. In his patch series this driver is going away.
> > > >
> > > > https://urldefense.com/v3/__https://lore.kernel.org/linux-
> > > input/YpMCh1Xje*jsny8j@google.com/__;Kw!!A3Ni8CS0y2Y!_Cb1uAs
> > > D-
> > > Z6iz_zSDfrd5Va6zLmdoxjv1vLYWQGHDOqYniaXVVHl3Ou2lOUQIjwhSN
> > > Ku2aZkYrOb8xMi2cZtfmsv$
> > >
> > > While that work is ongoing, and most likely won't make v5.20-rc1, for
> > > the v5.20-rc1 I think my patches are good to go to avoid a bad (or
> > > rather very old) example on how to do GPIO drivers. What do you
> > > think?
> >
> > Just as note, If nothing unexpected happens, I'm planning in sending this
> > out today. If you still think this makes sense, fine by me. It's a very minimal
> > change that won't give much pain to deal with...
>
> Ah, Okay, I was thinking about a week or two from now. Let's see how
> it will go and let Linus decide how to proceed.

With all respect to Linus, I had to put Bart :-)

-- 
With Best Regards,
Andy Shevchenko
