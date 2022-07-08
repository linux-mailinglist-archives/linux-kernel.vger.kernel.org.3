Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C59B56BF1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiGHQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiGHQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:09:45 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80377E098;
        Fri,  8 Jul 2022 09:09:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 6so9664584ybc.8;
        Fri, 08 Jul 2022 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NiBAmwWr10y6CHObyc48uD9nFW5jkoG89MkhIpP9Xnw=;
        b=ZjOMS1DWv4rXK5iN9pFJzlcAtFscvuO/14syZxKG75wxk22F4zoMwS44UT3WQDH+GD
         GPI/TepMyco+s3itI7Z57Lj4RUyCEPG37Yys7Y3RhO3yNOZ0Jt7lnrhOdCuganu9gsNA
         dmir/5YvN67iRgNx/7eqMELIRPKutBWpJ3GYV60POn1TiCxcYOa/fRdnh4J69i9q/0Nm
         fbdb6sJw3sdnav+S3myzHyj6A1nCJFvX8CqrFHTFw8lebEePFhjhysK4A/I1Iuu/jB4c
         89XMhblSXEYpXcyyjhNeJ/ocGschD7dhkYPQqbHmIX/L7pnYglbvrrWJJybyfGsZbskI
         CwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NiBAmwWr10y6CHObyc48uD9nFW5jkoG89MkhIpP9Xnw=;
        b=JHUg3q24TlKHE/USZNAD4WB9nHleZt2SiHToUAcEr3uMUV/bJAEZSI6JPCNCCjDQjn
         hOREFGTW9XcTSeD+OXCjgU1WLed8qGfhdD2Q9iyEx5IHMj8xQ0FHWmCwroYDuGH0y5tI
         HKE2wJpXtJjZZAlhJHmzGwzJ9XfFmS579QG5GcmiIlE2ZXF2OTGWoHPTuwKrxsksz9Ux
         mTSAhJmtek8BKB+p4WphzB2iAVie2ejg5GCLRchT5oxLA9Fg6DNeSGy7cFqDZkRVuFvE
         ysPTryUyAA4zRVbjs2fmHR+8p+501YCARjAxrCNUuSbYiMf+dTgJPSB9kRKKu4jba4oa
         u+0g==
X-Gm-Message-State: AJIora8xi1ZWSvoIlZQO/Y0KCyQ3UuFZcBVG4JtXqzrLwqDXJiVsU9vE
        E4uYrMRhcoyWQ1YmtluRL5jQpmL7tmeskZukETE=
X-Google-Smtp-Source: AGRyM1snNGAnWmURbdR/Bz0c+IXCwfys5LS4JOVYPJLs24z7iSKouS0PVwgEICtxnhUcTC1s5Fj4Uon/NX9iD0aM0Rw=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr4439046ybu.128.1657296583588; Fri, 08
 Jul 2022 09:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220321163055.4058-1-pali@kernel.org> <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
 <YmK7drS0XgnTQcaf@kroah.com> <20220707084840.jvsstvyx2ul5ltb6@pali>
 <YsgsH94PV/wAX0Vu@kroah.com> <20220708132621.4v2es73h52aq3izn@pali>
 <Ysg2RW0B/cLL3k+k@kroah.com> <20220708142001.7fciqnfckznlvsa4@pali>
 <CAHp75Vci1zeDV1axd_v_PLLPGfF5AzAzmmcegjD1djqnR6XUcA@mail.gmail.com> <20220708155413.rlc3iyf72tdwthfa@pali>
In-Reply-To: <20220708155413.rlc3iyf72tdwthfa@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 18:09:07 +0200
Message-ID: <CAHp75Vf=JGbmydAaeA=81YDViVtj7cG91Sr4teJ8mhFNH8AhAw@mail.gmail.com>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jul 8, 2022 at 5:54 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Friday 08 July 2022 17:42:03 Andy Shevchenko wrote:
> > On Fri, Jul 8, 2022 at 4:20 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > On Friday 08 July 2022 15:51:01 Greg Kroah-Hartman wrote:
> > > > On Fri, Jul 08, 2022 at 03:26:21PM +0200, Pali Roh=C3=A1r wrote:
> > > > > On Friday 08 July 2022 15:07:43 Greg Kroah-Hartman wrote:
> > > > > > On Thu, Jul 07, 2022 at 10:48:40AM +0200, Pali Roh=C3=A1r wrote=
:
> > > > > > > On Friday 22 April 2022 16:28:06 Greg Kroah-Hartman wrote:
> >
> > ...
> >
> > > > > > I'm not saying remove them, I'm saying let us not add any more
> > > > > > dependancies on them in order to keep new applications from eve=
r wanting
> > > > > > to use them.
> > > > >
> > > > > Last time you wrote to remove them. Now saying not to remove them=
. So I
> > > > > do not understand you now.
> >
> > There was a _new_ addition of the ugly SPD_CUST, that's what I believe
> > Greg opposes to. And I support that.
>
> Which addition? I do not understand you. There was not any new driver
> with introduction of SPD support.

You stated that SPD_CUST is broken in some drivers, so you are trying
to fix a broken ugly hack. Why? Instead of making it rot and be
removed eventually, you pump life into frankenstein.

> > > > I'm sorry, I am totally lost.
> > >
> > > So look what you have wrote? Who is lost here is me.
> > >
> > > > How about starting over and resubmitting
> > > > the changes you want and we can go from there.
> > >
> > > What to resubmit? I do not understand you. In case you lost emails or
> > > accidentally removed them, you can look at them in archive, not? I ho=
pe
> > > that you do not want me to copy+paste all existing patches with all y=
our
> > > quotes on them which you wrote into new emails.
> >
> > That change that adds the new user of SPD_CUST?
>
> What you are talking about? Which user?

This I missed, I was thinking that you are talking about a new user,
now I read briefly and it seems that it's about an existing user.
Anyway, that change I suppose.

> > In any case the best summary about BOTHER I ever read is this [1] (and
> > an initial steps in picocom [2]).
>
> Is not that example in manpage enough?

Dunno.
Can you point it out to me? I can't find it quickly.

> > And I believe that instead of
> > SPD_CUST we should get rid (or at least minimize) the problems with
> > BOTHER in user space.
>
> I looked into archives and seems that glibc people are not interested in
> this area. And I'm not going to spend time on another project which seems
> to be useless.

So why should the kernel suffer if it already provides something good
for the user and user space ignores that?

> > [1]: https://github.com/npat-efault/picocom/blob/master/termios2.txt
> > [2]: https://github.com/jmesmon/picocom/issues/2

--=20
With Best Regards,
Andy Shevchenko
