Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D245588BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiHCMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiHCMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:05:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820391A072;
        Wed,  3 Aug 2022 05:04:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so6347941pfb.12;
        Wed, 03 Aug 2022 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=HdGfOeXezbgbP8QayfnATfWBu9OsYip9xRe8mOklBIU=;
        b=Yld7l631oi7+tpGn2LNv1r9k2u5LqzevMC3SrNO59N0kMRFPtcjsbLfolY7UC+5bSG
         sQSQi1jnYV8dkbCE4CcAI4IJdN/g+uTCLqgxxvXp8/sRrMUyrYevsjnccK82GbLnLrvb
         jZ3A5FtFAJT75izRgKquodxyRyUK6FGaUWCesNegPU/Dec8EKV/3/lmhRZXHAczh+18a
         /qLLoUzO0VhxJZgcLS0YcIv7OsGsfJSl+4nllmAzsB1nMdGU8qAqzzfPgrpQURVAjjHw
         kDsdFEfLV6xD49wES8JcKdkD47kA8Vvb3StYMZ5km8aD8x49XxQ35vyPdaUiVM5NXlaw
         Z2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=HdGfOeXezbgbP8QayfnATfWBu9OsYip9xRe8mOklBIU=;
        b=xwIfT5oN7KJJ/To6HBSfpVadJsoWaknojXiL4n2s7v284Tvp/HlCtYp5/gcKFBpfwe
         E/4OGqM9+ulTwD9g2tzIF609f09OrHNitMMfFerTpIphaworW19wpsGemE9r4TdlQIcs
         hR3YuE01HD1HPyH2Fc5NBsFvzh9bSz1M/GWJVfTqrrrUZzzVj4d1u7YSAi5HcOUGFL54
         GR9Hd+wPehPUqq5IyXayS6Hij6sY/MZxet5Zz5R0tOxtyAKMmTaLrjwlen5Za70AmPJ9
         /2syHdVQd1p7hN0RnfxC8rdNAHCBZZfaw1FnjnkWXxF/3Q7zZcbHfWLAXJxdx7A3dQ4X
         tPPA==
X-Gm-Message-State: AJIora9VtSnH6vGkPTTtMY717xNjGIjBp295GGQ/pVnxevLVxKTPfQud
        KhMgy8KpJqSMxlaRzVVjemKnsATyUeduD9JML1s=
X-Google-Smtp-Source: AGRyM1uBEjXqXRfTk40XskdX+hFpRZxnzbZ9QsDJaRBmrFW2gVZcgKhRFP2q6mOE/9NUtyDMwGof3T8qrWCFWFob6oE=
X-Received: by 2002:a63:570b:0:b0:41a:5129:42d3 with SMTP id
 l11-20020a63570b000000b0041a512942d3mr21078017pgb.216.1659528299014; Wed, 03
 Aug 2022 05:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus> <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
 <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
In-Reply-To: <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Wed, 3 Aug 2022 21:04:51 +0900
Message-ID: <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Cc:     =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>,
        0215yys@hanmail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All.
Too much time has already passed since I first sent this Email.
Can you share how this patch is going ?

2022=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:11, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Dear Kieran Bingham
>
> I sent E-mail again by Linux terminal by using the command " ... git
> send-email .."
> I believe that you will surely get the diff file.
>
> Thank you
>
> 2022=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:12=
, Hans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > Hi Kieran,
> >
> > The consumed variable should not be negative. This bug has been there
> > since the beginning of the GIT at Linux from what I can see.
> >
> > +1
> >
> > --HPS
> >
> >  From 108c6acb2cc4bc4314b96f6f254a04b2873a096c Mon Sep 17 00:00:00 2001
> > From: YongSu Yoo <yongsuyoo0215@gmail.com>
> > Date: Sun, 22 May 2022 04:53:12 +0000
> > Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
> >
> > Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> >
> > The function dvb_ringbuffer_pkt_next in
> > /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
> > which searches the idx of the next valid packet in the ring
> > buffer of the ca->slot_info[slot].rx_buffer at
> > /linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
> > has the following problem.
> > In calculating the amounts of the consumed address of the ring
> > buffer, if the read address(rbuf->pread) of the ring buffer is
> > smaller than the idx, the amounts of the searched address
> > should be (idx - rbuf->pread),
> > whereas if the read address(rbuf->pread) of the ring buffer is
> > larger than the idx, the amounts of the consumed address should
> > be (idx - rbuf->pread + rbug->size). But there exists an
> > incorrect logic that the rbug-size was not properly added on
> > (idx - rbug->pread) in the later case. With this commit, we
> > fixed this bug.
> > ---
> >   drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c
> > b/drivers/media/dvb-core/dvb_ringbuffer.c
> > index d1d471af0636..7d4558de8e83 100644
> > --- a/drivers/media/dvb-core/dvb_ringbuffer.c
> > +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
> > @@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct
> > dvb_ringbuffer *rbuf, size_t idx, size_t*
> >                 idx =3D (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSIZE) %=
 rbuf->size;
> >         }
> >
> > -       consumed =3D (idx - rbuf->pread) % rbuf->size;
> > +       consumed =3D (idx - rbuf->pread);
> > +       if (consumed < 0)
> > +               consumed +=3D rbuf->size;
> >
> >         while((dvb_ringbuffer_avail(rbuf) - consumed) >
> > DVB_RINGBUFFER_PKTHDRSIZE) {
> >
> > --
> > 2.17.1
