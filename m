Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C05598382
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiHRM4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiHRMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:55:56 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2048321838;
        Thu, 18 Aug 2022 05:55:55 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id j11so715262vkk.11;
        Thu, 18 Aug 2022 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=hdLIdfFHv3QXdsm7syIIcLHy/dA4pzmBakkxNtwnQ88=;
        b=o4AQJs4EQBaaxaXP2SBezP608FaT/gCyKwh720xEW0SYsAhVydbNQ+ULcm3QbmaDWq
         qGlstBouChh9bl8Wdu9MAfLXofhrblPQLZI8lnnMFCTJOERS/2tPGk7gjWdADDqdU0rl
         dGIKKEU4G5D/69S0+9GVWzTe8dJKEiAX4iQsHLp4WpzGXT8pmTbnD7QllvxZ+6XBKw6u
         OYS+2GVEsB5qDOwEVEGKypcfap13E1QWghJdayKM4k2EoJyqE8i46hCe5KlqMmfoxecP
         RnqsZRVdalrunv3Nzo8vUcMaZKeE+EnsKBHn1fP8gW6Ji9PprHdWYAbpPvrSDyK/fZO7
         etIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=hdLIdfFHv3QXdsm7syIIcLHy/dA4pzmBakkxNtwnQ88=;
        b=RQJHat+onoXbgkiqclwrU8jG5YGR8N2bRDO+MJ0JRhHUhtfB6ScJ0nubcYmP6E6Tsu
         zUWfM6lHnJ5uqxbT9QIXSgeeE9D11C7cXyNVBSdHP5s0mZog1MOcnppK9K1SqQ1K+CsR
         3GZyx4btzHe8gLxe9WKRse2YgwFGTG3egEOCRCXCc07tStAXsZjzIhNDa84NOQ9CRfYP
         8viF630jwBruZVV22lKK3Fsg61zT/6fdcwNebp3Wb7/JVbAQc1+JpcTixnCDVlIazU7g
         neof+KeeQ0E/1dyb2ALpg8+d3xtp9Zh20g9HK15npxwZcUsPxTSfiiflgEQFULBCyZmp
         zZYw==
X-Gm-Message-State: ACgBeo1ZcPqchMzbmdQ4kT9UHRlTLPBQRiXt9K/SAJ8Dzdi0nn3G/vLd
        PA1YEBDpm19SExAhdZSCKft3SpvMWtsOV984CqK2GnXV
X-Google-Smtp-Source: AA6agR515wlLrzNdYxk5EBy6qTgyBURqAAfnHWw4Yfs+cfqheuhvLpxfV7SJ4xHBR9yfkOPjA13VjUYxqn9wF8x/tpY=
X-Received: by 2002:a1f:2b47:0:b0:380:59c5:8b8f with SMTP id
 r68-20020a1f2b47000000b0038059c58b8fmr1095475vkr.20.1660827354101; Thu, 18
 Aug 2022 05:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus> <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
 <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com> <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com>
In-Reply-To: <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Thu, 18 Aug 2022 21:55:43 +0900
Message-ID: <CANXPkT5=ryAFvb1cO+Wb0CQYmytwedS2dqVTYqt2Km1fkK4w9Q@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Cc:     0215yys@hanmail.net,
        =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Can you pay your attention to this patch ?
This is a very simple modification.
But, too much time has already passed since I sent the first E-mail.

2022=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:04, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Dear All.
> Too much time has already passed since I first sent this Email.
> Can you share how this patch is going ?
>
> 2022=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:11,=
 =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >
> > Dear Kieran Bingham
> >
> > I sent E-mail again by Linux terminal by using the command " ... git
> > send-email .."
> > I believe that you will surely get the diff file.
> >
> > Thank you
> >
> > 2022=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:=
12, Hans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > Hi Kieran,
> > >
> > > The consumed variable should not be negative. This bug has been there
> > > since the beginning of the GIT at Linux from what I can see.
> > >
> > > +1
> > >
> > > --HPS
> > >
> > >  From 108c6acb2cc4bc4314b96f6f254a04b2873a096c Mon Sep 17 00:00:00 20=
01
> > > From: YongSu Yoo <yongsuyoo0215@gmail.com>
> > > Date: Sun, 22 May 2022 04:53:12 +0000
> > > Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.=
c
> > >
> > > Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> > >
> > > The function dvb_ringbuffer_pkt_next in
> > > /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
> > > which searches the idx of the next valid packet in the ring
> > > buffer of the ca->slot_info[slot].rx_buffer at
> > > /linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
> > > has the following problem.
> > > In calculating the amounts of the consumed address of the ring
> > > buffer, if the read address(rbuf->pread) of the ring buffer is
> > > smaller than the idx, the amounts of the searched address
> > > should be (idx - rbuf->pread),
> > > whereas if the read address(rbuf->pread) of the ring buffer is
> > > larger than the idx, the amounts of the consumed address should
> > > be (idx - rbuf->pread + rbug->size). But there exists an
> > > incorrect logic that the rbug-size was not properly added on
> > > (idx - rbug->pread) in the later case. With this commit, we
> > > fixed this bug.
> > > ---
> > >   drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c
> > > b/drivers/media/dvb-core/dvb_ringbuffer.c
> > > index d1d471af0636..7d4558de8e83 100644
> > > --- a/drivers/media/dvb-core/dvb_ringbuffer.c
> > > +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
> > > @@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct
> > > dvb_ringbuffer *rbuf, size_t idx, size_t*
> > >                 idx =3D (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSIZE)=
 % rbuf->size;
> > >         }
> > >
> > > -       consumed =3D (idx - rbuf->pread) % rbuf->size;
> > > +       consumed =3D (idx - rbuf->pread);
> > > +       if (consumed < 0)
> > > +               consumed +=3D rbuf->size;
> > >
> > >         while((dvb_ringbuffer_avail(rbuf) - consumed) >
> > > DVB_RINGBUFFER_PKTHDRSIZE) {
> > >
> > > --
> > > 2.17.1
