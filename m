Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE9053FAE5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiFGKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiFGKKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:10:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6DEAD2F;
        Tue,  7 Jun 2022 03:10:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v25so22319399eda.6;
        Tue, 07 Jun 2022 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4j1WzrBW7EoZdlkWo244YU3ttsWs7+lWBx1HTzeeKKc=;
        b=k23Law+syP+E6x3K0yUQxVdE/9XIFEPWysOg7j2WDeKtBx729T+2Ihex566ccY1NSW
         /KdeoEC3hiXmTH/xeoPWb+dS/3X3gbA1UG4HPDfxlUBxYQPeDl6mJgPGK6NeyojA6Abf
         ErtQctSEKZJLfNoSMQAqeTgWzsOMPzlcIP0+VYPspkt+S40YTGXlpT4flmrJqBQ7osXJ
         vnd68mBSsP1IvdXNDWY+k7St9j9alQ73vVHhMmGuxcMdVjXRGzdPNASQdMlBvsBlPEA6
         euCRwe1d5v0iFzLTuOvK2OF2P4IGQNI2IANf3P5CAIfr14hElWYUkoOsDp/pUr8axkGo
         H78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4j1WzrBW7EoZdlkWo244YU3ttsWs7+lWBx1HTzeeKKc=;
        b=wERVlqlSlihFN0mRvrWGXNsWdQnbLJ9kUaxtk1590rmG731fJ5GIn/sD8iltHT++gl
         +z0GDdxkqp6kwdagqfA6hZvYZyzsv+Ljrmz1f9rD+5/2XmTVNcP8yrS0SWTWIN8AFGBN
         JMcO7pbJ+FRkDSTGOlEpXsruaTG6Pt46K3AH6dg6lKLDah1r29nrJy+u9GWWAV3zWmbJ
         PTeBGqn4hc1MU3SfxhmjX2q8uIzeqFIaQvJzzXVqzJzYgyb9DqnSMfAxQBn12H5B+iNv
         rg3XgMu9O4O6lprZPd56FunrMl30uh85wQYXyGQ1gm30t5tYnKvc2gKeMtYgIwYPzBhw
         bjpg==
X-Gm-Message-State: AOAM533WB2kHed3O11e9ts3t4kMXxQGRFL+Idp9xDLhavhRvP+WFYdr5
        hZ96yji7R47+Gf06ef0YjLWve9PfUDXyTnvC4caETAt8HG524w==
X-Google-Smtp-Source: ABdhPJxk/YC0FG6cv/TnhxlUpyFDCXO3/z4i+jholBQGddkZmAN56cAZNS/4viDhq29uRNzogOGiMYRPy7QLSNXkEh4=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr32816146edq.178.1654596616279; Tue, 07
 Jun 2022 03:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com> <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
 <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
 <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com> <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
 <20220606194046.gbt4ghz2yvazsfo4@pengutronix.de> <CAHp75VdiJFtLnEJfW6KXwaVFsKWSSTSMgKQLvikSEQj7x3tgLA@mail.gmail.com>
 <20220607055810.szkjoitpr3vboymr@pengutronix.de>
In-Reply-To: <20220607055810.szkjoitpr3vboymr@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Jun 2022 12:09:39 +0200
Message-ID: <CAHp75VcUBOcz_UAx9tVER8cBb8h8NF+NivUH00-B39wwH6ObUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr read
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Jonathan (some documentation clarification might be needed)

On Tue, Jun 7, 2022 at 7:58 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Jun 06, 2022 at 10:38:37PM +0200, Andy Shevchenko wrote:
> > On Mon, Jun 6, 2022 at 9:40 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Mon, Jun 06, 2022 at 07:01:15PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Jun 6, 2022 at 6:54 PM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > On Mon, 6 Jun 2022, Andy Shevchenko wrote:
> > > > > > On Mon, Jun 6, 2022 at 3:55 PM Ilpo J=C3=A4rvinen
> > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > > But more importantly I do not see the reason for the Acked-by t=
ag when
> > > > > > SoB of the same person is present.
> > > > >
> > > > > I just repeated what Uwe gave me. Maybe he didn't notice he was a=
lready
> > > > > there as SoB.
> > > > >
> > > > > This situation is anyway a bit more complex than usual. The line =
I took
> > > > > was part of Uwe's much larger patch initially (which was fully re=
verted)
> > > > > so his SoB was carried over to preserve the authorship. As I made=
 a
> > > > > non-trivial modification to his original patch by removing almost=
 all of
> > > > > it, I added my SoB too. Given this situation, I kind of thought h=
e Acked
> > > > > (approved) the post-modification version of it.
> > > >
> > > > I believe you haven't preserved the authorship that way (since From
> > > > line is different), but since you have done non-trivial changes and
> > > > Uwe is okay with them, the straightforward tag chain would be (with
> > > > your authorship implied):
> > > > Co-developed-by: Uwe
> > > > SoB: Uwe
> > > > SoB: yours
> > >
> > > I don't care much, but IMHO the initial set of tags made sense to me.
> >
> > > It
> > > has my S-o-b because the change is (somewhat) taken from me and it ha=
s
> > > my ack because the modification looked good to me.
> >
> > According to
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
when-to-use-acked-by-cc-and-co-developed-by
> > the SoB already implies that you developed that, but Ack if not. It
> > also clarifies Co-developed-by for cases like this.
>
> That's unintuitive (and wrong) in my opinion.

I have the opposite opinion.

> For me, Acked-by is a
> confirmation of the respective person, that the patch in question is ok.
> If I take a hunk of a random reverted patch and add the S-o-b of the big
> patch's author, can I really assume the original author "acks" the
> result? I would expect that in most cases they don't. (And if they do,
> there is no way to record it, because the usual way of adding an Ack is
> blocked as there is already a S-o-b?)

It's very logical to me. If you allowed (by not NAKing) the other
developer to use your SoB you imply Ack for every change they made.
Otherwise you need explicitly ask for withdrawal of your SoB.

--=20
With Best Regards,
Andy Shevchenko
