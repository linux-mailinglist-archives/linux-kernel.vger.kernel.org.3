Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8656C037
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiGHRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiGHRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:42:15 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818185A45D;
        Fri,  8 Jul 2022 10:42:14 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r3so38959114ybr.6;
        Fri, 08 Jul 2022 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s7rfjFv2pxYiTyeXDG77gpPSG058438CTEH71lJGjxs=;
        b=a+FsaUYfq0qtR9QY2OuR7v2E9iCsNpROO86nDvM+iv8/OyQ/3ekajl2TGQipjanxWt
         ux6KoxQmY+BRsXLUwZbpeix6b9kxUO0lyE4zAjeWB5howOkzRXYxmvthu9qKWSaldXjB
         pZgWRuogdlLAWdICjXtsZRN7BGkI/TppAc4rTkEP5Ez8piFWDT278DzW31VO63hAJwzR
         oAHbmqQTQkIxdrV5ErR0i6BT1MCkRNGWGz9pfAQjV7j1C4I8o29T3meCECk9+jH6aeZP
         AACL4Uc1Fp9Gc0FidFjeWqYXI5Ga0fZTg8T7Ej0/R5d9NeDoVQ3+jt0gARESimU3Bzxf
         FfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s7rfjFv2pxYiTyeXDG77gpPSG058438CTEH71lJGjxs=;
        b=Frj0mJ3LSyWbacb0Jb0452rtANGF02za13xaeXuoPBM/iWS3Yt9nee6CFwNaa6zi+9
         hJpAoDIhS9HgUZOnOd4DdsM5sRGbMZNzqP434W+O8Fc59bQP7Ehf5pf+P+Hf+vQ3uEe9
         KdIG7yV4p1s8KGMkov3yHfGk5ubCeioam6eBE46UIjMNkzUcMbhxaLQjhqKZKeLmqyjC
         VPmE82OphQb7e2GyDVayTtrV+1en+adHRcpU3vty60+/GyHWirzr4D9JVor5RXqLStbs
         Mtf2Mg9Df5VLdXfmlBLoNqUiCXVt8zQz9BR9PRVJvqV537Rigc0T7Y+Gq5UUI4WryD5Y
         CMOQ==
X-Gm-Message-State: AJIora++W/pRcQzMhKf7Ktc2Pa0NYuLH0xMk5VAvmAhE0eJU5vmHADgN
        soPTfJLFbeQM4okE1FSIwalUshxwZfX6Oqazts4=
X-Google-Smtp-Source: AGRyM1stxFyo4NbOuYehHaTTVp9jk9rE09F65RoYnEjrYnP+TO+8Pg0Bk/5BqqC+tFmaTrH8bYc0ZYh5cFZDknGE2ew=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr4733744ybs.93.1657302133662; Fri, 08 Jul
 2022 10:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
 <YmK7drS0XgnTQcaf@kroah.com> <20220707084840.jvsstvyx2ul5ltb6@pali>
 <YsgsH94PV/wAX0Vu@kroah.com> <20220708132621.4v2es73h52aq3izn@pali>
 <Ysg2RW0B/cLL3k+k@kroah.com> <20220708142001.7fciqnfckznlvsa4@pali>
 <CAHp75Vci1zeDV1axd_v_PLLPGfF5AzAzmmcegjD1djqnR6XUcA@mail.gmail.com>
 <20220708155413.rlc3iyf72tdwthfa@pali> <CAHp75Vf=JGbmydAaeA=81YDViVtj7cG91Sr4teJ8mhFNH8AhAw@mail.gmail.com>
 <20220708162532.jefbmpokampkuahv@pali>
In-Reply-To: <20220708162532.jefbmpokampkuahv@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 19:41:37 +0200
Message-ID: <CAHp75VfD24SxejjQ6hq85BTaHpOGPj3-diEqxu5BGnABm0Yz1w@mail.gmail.com>
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

On Fri, Jul 8, 2022 at 6:25 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 08 July 2022 18:09:07 Andy Shevchenko wrote:
> > On Fri, Jul 8, 2022 at 5:54 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > On Friday 08 July 2022 17:42:03 Andy Shevchenko wrote:
> > > > On Fri, Jul 8, 2022 at 4:20 PM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
> > > > > On Friday 08 July 2022 15:51:01 Greg Kroah-Hartman wrote:
> > > > > > On Fri, Jul 08, 2022 at 03:26:21PM +0200, Pali Roh=C3=A1r wrote=
:
> > > > > > > On Friday 08 July 2022 15:07:43 Greg Kroah-Hartman wrote:
> > > > > > > > On Thu, Jul 07, 2022 at 10:48:40AM +0200, Pali Roh=C3=A1r w=
rote:
> > > > > > > > > On Friday 22 April 2022 16:28:06 Greg Kroah-Hartman wrote=
:
> > > >
> > > > ...
> > > >
> > > > > > > > I'm not saying remove them, I'm saying let us not add any m=
ore
> > > > > > > > dependancies on them in order to keep new applications from=
 ever wanting
> > > > > > > > to use them.
> > > > > > >
> > > > > > > Last time you wrote to remove them. Now saying not to remove =
them. So I
> > > > > > > do not understand you now.
> > > >
> > > > There was a _new_ addition of the ugly SPD_CUST, that's what I beli=
eve
> > > > Greg opposes to. And I support that.
> > >
> > > Which addition? I do not understand you. There was not any new driver
> > > with introduction of SPD support.
> >
> > You stated that SPD_CUST is broken in some drivers, so you are trying
> > to fix a broken ugly hack. Why? Instead of making it rot and be
> > removed eventually, you pump life into frankenstein.
>
> Firstly I got rejection of my other patches because they does not handle
> SDP_CUST correctly. So I decided to look at those issues and fix it via
> helper function which can be easily reused in all drivers. So helper
> function wrap all "ugly" hacks. Then I got reaction that SDP should be
> removed. Then I got another reaction that that "I'm not saying to remove
> them" and another another reaction why to be removed eventually.
>
> So how should I interpret this? I'm feeling that you are just trying to
> annoy people with this "do this", "do opposite", "do again it", "do
> again opposite"...

Ask someone who makes a decision. I wrote just my p.o.v. on the
"problem". I think there is no problem with SPD_CUST, it should be
oblivionized.

> > > > > > I'm sorry, I am totally lost.
> > > > >
> > > > > So look what you have wrote? Who is lost here is me.
> > > > >
> > > > > > How about starting over and resubmitting
> > > > > > the changes you want and we can go from there.
> > > > >
> > > > > What to resubmit? I do not understand you. In case you lost email=
s or
> > > > > accidentally removed them, you can look at them in archive, not? =
I hope
> > > > > that you do not want me to copy+paste all existing patches with a=
ll your
> > > > > quotes on them which you wrote into new emails.
> > > >
> > > > That change that adds the new user of SPD_CUST?
> > >
> > > What you are talking about? Which user?
> >
> > This I missed, I was thinking that you are talking about a new user,
> > now I read briefly and it seems that it's about an existing user.
> > Anyway, that change I suppose.
> >
> > > > In any case the best summary about BOTHER I ever read is this [1] (=
and
> > > > an initial steps in picocom [2]).
> > >
> > > Is not that example in manpage enough?
> >
> > Dunno.
> > Can you point it out to me? I can't find it quickly.
>
> Argh... Have you read emails to which you wrote reply? So copy+paste
> relevant part from my previous email just for you:
>
>  "New version of tcsetattr and ioctl_tty manpages would have documented
>   how to use BOTHER (it is currently in the manpages git)."

I do not know the "manpages git" URL. Neither its hosting. kernel.org?
And then? It took time for you to just write something instead of helping m=
e.
Whatever. I found the commits.

> Plus in past I also pointed to the extended version of that example from
> manpage which is currently in my repo on github:
> https://github.com/pali/linux-baudrate.git
>
> > > > And I believe that instead of
> > > > SPD_CUST we should get rid (or at least minimize) the problems with
> > > > BOTHER in user space.
> > >
> > > I looked into archives and seems that glibc people are not interested=
 in
> > > this area. And I'm not going to spend time on another project which s=
eems
> > > to be useless.
> >
> > So why should the kernel suffer if it already provides something good
> > for the user and user space ignores that?
>
> Because it is unusable? API which standard linux userspace applications
> cannot use is useless. And for application develop it does not matter if
> issue is in kernel part of API or userspace part of API. At the end
> would be use used.

Then help make it happen?

> With whole this discussion I have feeling that there correct way is just
> to use SDP flags in userspace as there is no interest in fixing BOTHER's
> c_ospeed and c_ispeed in kernel drivers and it was rejected just because
> of not handling SDP flags correctly.

I'm puzzled who asked you about SPD_CUST implementation... It.is.an.ugly.ha=
ck.

--=20
With Best Regards,
Andy Shevchenko
