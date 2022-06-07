Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA52A53FCAF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiFGLBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbiFGK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A0106356;
        Tue,  7 Jun 2022 03:55:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x62so22444562ede.10;
        Tue, 07 Jun 2022 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7fF39XPrOPkdo7E4VUZFz+N8yQJoyk99Z+L7CTMpFsY=;
        b=IixdAUWuJi5O0TbpxcVeYckiybPdqgjmSigmuqzY63WhnbOUAvcUTqI24oBubbwv0f
         5BKQZv3MZa56JsrpApAI5ZUSER2RbH/gQta/vq3r3GwdxG+vIvMwGBume2Pu6R0SuGJK
         CifmDoxa7yMfXa8zgMwvOixEAi4ca13g4ZPdI6UGenYOUV9Ob0Y7zYFl7i33qCA6ELOZ
         9GMm/O4Mltmgo7fuCRWW+MIearciOKT3sEZUp12ugdI6DS0OmooCxrfEIEFBnEBzQYY7
         RCeYOwCL55pc7ivtvaPzEvKJIlpRAWxNQBlHN0nwIE6d5+BpGH/TRi4TtsZ19eOEO1de
         RhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7fF39XPrOPkdo7E4VUZFz+N8yQJoyk99Z+L7CTMpFsY=;
        b=bWAfoNlZJzr5XOgeICYMvcZ9AovOM21/7PWECb3EHEpdnyOVWrUmf/28O3yg/zA7t8
         Z4x9CJ7MZuHT7xM6dZ9udJD4Iljcqt/rrmf3KYuhPnDG6KNUo6Wp+5vh3Nfn/kz5dA/v
         U/ALOv9pnNCiA8WBXLUT0aYqZhCyZO5Qa33kZ54z9M3Krw5wFPdxqJuhzbqWzePLnZGh
         79sj/cmUbE0rPNCFISlcMvv3p96yMsZGBp29Jm1CQOMKI4gxK2Mx/LtIpOVZ3eixn44x
         dmxqkTr2Ou+Gc0HpNoQUDpwexXWAgsHSp8mFUDrqNafy+pcUn04HMtb6r4P9RRrAO7/x
         Mf0A==
X-Gm-Message-State: AOAM5316dAaE6mjQu6o+DGyN/ehNvfEchJRGKj6g5z7zphvoT9mlXw8b
        z7rx5tXlkuALPJCVrFoBAyGVlb1+hk0ejrHoRAc=
X-Google-Smtp-Source: ABdhPJxaodRyQVAdYi7NPUb9wvGS8f2HZMK6tjh9GGGfFdsu8ubG2WHhmlPo3nW2vW5nF3vrgmG7/vTV5EAywYzhvCY=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr32673780edr.209.1654599308595; Tue, 07
 Jun 2022 03:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com> <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
 <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
 <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com> <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
 <20220606194046.gbt4ghz2yvazsfo4@pengutronix.de> <CAHp75VdiJFtLnEJfW6KXwaVFsKWSSTSMgKQLvikSEQj7x3tgLA@mail.gmail.com>
 <20220607055810.szkjoitpr3vboymr@pengutronix.de> <CAHp75VcUBOcz_UAx9tVER8cBb8h8NF+NivUH00-B39wwH6ObUQ@mail.gmail.com>
 <20220607103229.f4hniwkcyfwlgem2@pengutronix.de>
In-Reply-To: <20220607103229.f4hniwkcyfwlgem2@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Jun 2022 12:54:32 +0200
Message-ID: <CAHp75VeoKxaEWB7F=d6ocZ563Oq+6yZGSPumUZJJ_V7rveXBGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr read
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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

On Tue, Jun 7, 2022 at 12:32 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Jun 07, 2022 at 12:09:39PM +0200, Andy Shevchenko wrote:

...

> > > > > > I believe you haven't preserved the authorship that way (since =
From
> > > > > > line is different), but since you have done non-trivial changes=
 and
> > > > > > Uwe is okay with them, the straightforward tag chain would be (=
with
> > > > > > your authorship implied):
> > > > > > Co-developed-by: Uwe
> > > > > > SoB: Uwe
> > > > > > SoB: yours
> > > > >
> > > > > I don't care much, but IMHO the initial set of tags made sense to=
 me.
> > > >
> > > > > It
> > > > > has my S-o-b because the change is (somewhat) taken from me and i=
t has
> > > > > my ack because the modification looked good to me.
> > > >
> > > > According to
> > > > https://www.kernel.org/doc/html/latest/process/submitting-patches.h=
tml#when-to-use-acked-by-cc-and-co-developed-by
> > > > the SoB already implies that you developed that, but Ack if not. It
> > > > also clarifies Co-developed-by for cases like this.
>
> Reading that by the letter, it doesn't say you must not use Ack if there
> is a S-o-b.
>
>         If a person was not directly involved in the preparation or
>         handling of a patch but wishes to signify and record their
>         approval of it then they can ask to have an Acked-by: line added
>         to the patch=E2=80=99s changelog.
>
> It's "If" and not "Iff". Not sure if that is intended?!

Yes, it's a bit ambiguous, but I use common sense. Acking yourself
code seems awkward to me.

...

> > > That's unintuitive (and wrong) in my opinion.
> >
> > I have the opposite opinion.
> >
> > > For me, Acked-by is a
> > > confirmation of the respective person, that the patch in question is =
ok.
> > > If I take a hunk of a random reverted patch and add the S-o-b of the =
big
> > > patch's author, can I really assume the original author "acks" the
> > > result? I would expect that in most cases they don't. (And if they do=
,
> > > there is no way to record it, because the usual way of adding an Ack =
is
> > > blocked as there is already a S-o-b?)
> >
> > It's very logical to me. If you allowed (by not NAKing) the other
> > developer to use your SoB you imply Ack for every change they made.
>
> So you assume that you notice each patch with your S-o-b in time to send
> a NAK. I don't claim that for me and I would be surprised if a major
> part of the kernel contributors did.

Yes. That's why `git send-email` is always Cc'ing people whose SoB
tags in the patch.

The flaw that you may notice here is that anybody can potentially add
anybody's SoB to any garbage and send it to a mailing list. It has
non-zero chances to pass review (a person whose SoB has been abused on
a sick leave, for example). But this is more process and QA related.

--=20
With Best Regards,
Andy Shevchenko
