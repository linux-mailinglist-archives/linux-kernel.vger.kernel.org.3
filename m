Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067284DE73F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 10:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiCSJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 05:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiCSJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 05:30:01 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA454243165;
        Sat, 19 Mar 2022 02:28:40 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id c4so8605121qtx.1;
        Sat, 19 Mar 2022 02:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dKseVXgRwQ7SrA5ZJ9WG3Q7S3JwI0cLYbFRdthRYoU=;
        b=Z+vdsJL5FIqYyQ1k6EG5ZX4XupfZALRqOyXyrjGU0tZthm+SC/pzeuZywIk2TAr749
         VuoPrrF0wyXoX6Yjp2yEomrDqwadGls00PbtqA8hYvxJC9qODHTx5F8umQ595TpXBu80
         uN2H8ukNMmgM7oXnntZnMRqbN2WEEE9jogx7u82Luxxk6n/wEqI+Ga+Y281yhOXgPjYP
         EDfD6bpppC51gId6VtQygdMVDqB/Z/9ekSLKEpeW+coaQ1hmZNm5hCB04DnRnDgVeQH1
         Dju6HN0Fr4/tR3yEol3rxC7ERiM7A4el6akGzx2moHS+cYRDBTV8ZHWzMRuCJWxs5LX6
         KHkA==
X-Gm-Message-State: AOAM532Bv99Vxum5bdIyqp3xSGFm/a2H4J4SH0WuTv94NF2i0dK9ugqN
        2QaVni0y+1+LFYnr0h190sZVNuszdwQwcg==
X-Google-Smtp-Source: ABdhPJzh0EIYhi74e0CScdapJf5hupQoVAGshAj/X8NE8llqSgU3xCRElAdGSeSLKIqowL8h9y+E4A==
X-Received: by 2002:ac8:5b8c:0:b0:2e1:e454:7fd1 with SMTP id a12-20020ac85b8c000000b002e1e4547fd1mr10018403qta.687.1647682118946;
        Sat, 19 Mar 2022 02:28:38 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id b82-20020ae9eb55000000b0067b314c0fedsm5248425qkg.42.2022.03.19.02.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 02:28:38 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id v130so19730960ybe.13;
        Sat, 19 Mar 2022 02:28:37 -0700 (PDT)
X-Received: by 2002:a05:6902:101:b0:633:ccde:cfca with SMTP id
 o1-20020a056902010100b00633ccdecfcamr2948672ybh.207.1647682117570; Sat, 19
 Mar 2022 02:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me>
 <20220124121009.108649-3-alistair@alistair23.me> <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
 <CAKmqyKOnezw8_dDY-c69F77KVxmb-C3t=N3H23GurKbrxWDAgg@mail.gmail.com>
In-Reply-To: <CAKmqyKOnezw8_dDY-c69F77KVxmb-C3t=N3H23GurKbrxWDAgg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 19 Mar 2022 10:28:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVy4E1pX+VLLq_05FX4pM+BPZycQgn68ArGh2s8qL24=w@mail.gmail.com>
Message-ID: <CAMuHMdVy4E1pX+VLLq_05FX4pM+BPZycQgn68ArGh2s8qL24=w@mail.gmail.com>
Subject: Re: [PATCH v18 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On Sat, Mar 19, 2022 at 3:36 AM Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Mar 8, 2022 at 8:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Thanks for your patch, which is now commit bae5a4acef67db88
> > ("mfd: simple-mfd-i2c: Add a Kconfig name") in mfd/for-mfd-next.
> >
> > On Mon, Jan 24, 2022 at 1:24 PM Alistair Francis <alistair@alistair23.me> wrote:
> > > Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
> > > device so that it can be enabled via menuconfig.
> >
> > Which still does not explain why this would be needed...
> >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1188,7 +1188,7 @@ config MFD_SI476X_CORE
> > >           module will be called si476x-core.
> > >
> > >  config MFD_SIMPLE_MFD_I2C
> > > -       tristate
> > > +       tristate "Simple Multi-Functional Device support (I2C)"
> > >         depends on I2C
> > >         select MFD_CORE
> > >         select REGMAP_I2C
> >
> > The help text states:
> >
> > | This driver creates a single register map with the intention for it
> > | to be shared by all sub-devices.
> >
> > Yes, that's what MFD does?
> >
> > | Once the register map has been successfully initialised, any
> > | sub-devices represented by child nodes in Device Tree will be
> > | subsequently registered.
> >
> > OK...?
> >
> > Still, no clue about what this driver really does, and why and when
> > it would be needed.
> >
> > There is one driver symbol that selects MFD_SIMPLE_MFD_I2C.
> > There are no driver symbols that depend on this symbol.
> >
> > If you have a driver in the pipeline that can make use of this,
> > can't it just select MFD_SIMPLE_MFD_I2C, so the symbol itself can
> > stay invisible?
>
> My patch "mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a"
> allows using this driver for the silergy,sy7636a MFD. So it's nice to
> be able to enable and disable it as required.

So after that patch, enabling MFD_SIMPLE_MFD_I2C will enable
support for an ever-growing random bunch of devices, none of which
is described in the help text?
To me, ghat doesn't look like the way to go forward...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
