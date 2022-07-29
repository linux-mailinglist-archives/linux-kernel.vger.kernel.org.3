Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57458519D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiG2Oco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiG2Ocn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:32:43 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55861691FB;
        Fri, 29 Jul 2022 07:32:42 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31f443e276fso53259907b3.1;
        Fri, 29 Jul 2022 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+B7+LE+7ckrSzq1LDDFpDWJ4LpGR3z3X6xguP749RzY=;
        b=nZcu2QWz3zdP1JVo5PzbvfPzG7uMpacwnR+vZs6MV98tNMrAYlfg46nxMtuJwnvZni
         ucylQvHnHG3zgB53hsj21hjqKbB8gVgWnQ+Oman2iY384xICJpfzlvQIppK4UYtocG08
         YYVT/vaiIRGA/nRhcdhj6K1jQ9/ALEz9vUqD47iu8NpoP/xc2NW5tn0jXJ6GnSOiQScY
         cWKWHwIbs4vkw7qU0t408+E35uOX35FGJKBlC9GIMgtN3c0ASx/RswIAUgk5JVJhGx6b
         391QMXMNRUdBmlF0S6vBhxc+a4YhIoDRjXGDXl0Z7bwAVBvpdbGn+Z4B8WbmVWzUUZAm
         YLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+B7+LE+7ckrSzq1LDDFpDWJ4LpGR3z3X6xguP749RzY=;
        b=YbOK61xojTuXV7HDj/ZSFq4265WAPard+eBVXupUfh1DjBYwTfCwzBpIWluMeZV2iA
         B/HaeSJMBMO7G+w6jvGtUfLgKXo5BZ6mjPkormSxqlx1PfarGQgCQgcLlvrS5seVzLwS
         0dLMVdUBax+okOA8f5JRuuOOambmL8yJNAnfiJOx0io4IiH86zf06cAvHWyr1LA1WdTk
         NutgWVRaIJmfMAvfF0PFXs6d12xjS3skL47xp3KyJIorCARTGmLfR1zuMfrmRmPORmgo
         qwNn8hOR9fmIzuH4OmQAhCe0W3yGsVpp0DmZ/8I+qv5yT1nQemI3SMM9/PFY77KDYfoC
         iEGw==
X-Gm-Message-State: ACgBeo0tWrhxDAtKDPKLfywrgEUX4pYuTa4NtcKjJPGPKE+aARhkp98p
        QbeWPTzy3xKwqi7Yi87jfCzZyDSCQvAQyPA+4xo=
X-Google-Smtp-Source: AA6agR7NQsK6STmR0PCenSTmqpe+1J5kRF9hYKF0Ob6VVR8njLa92DxPKFrSF4iwIKghlnnQvv1gpCFGm+3BnPenLlU=
X-Received: by 2002:a81:25c3:0:b0:323:9a15:7fd6 with SMTP id
 l186-20020a8125c3000000b003239a157fd6mr3270005ywl.104.1659105161308; Fri, 29
 Jul 2022 07:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
 <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com> <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com>
In-Reply-To: <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 29 Jul 2022 16:32:30 +0200
Message-ID: <CAKXUXMx=PVxZ7d3g8xFiF4bNiOazS1AHen6g_kW2d7xaL+At3g@mail.gmail.com>
Subject: Re: INFO: task hung in __floppy_read_block_0
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:20 PM Dipanjan Das
<mail.dipanjan.das@gmail.com> wrote:
>
> On Thu, Jul 28, 2022 at 7:23 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> w=
rote:
> >
> > Dipanjan, are you really sure that you want to report a "INFO: task
> > hung" bug identified with your syzkaller instance? Especially for a
> > floppy driver, probably in your case even just an emulated one
> > (right?). Reading data from floppies was always very slow as far as I
> > remember those times...
>
> From the bugs reported by syzkaller in the past, we observed that
> several of these =E2=80=9CINFO: task hung in=E2=80=A6 =E2=80=9C reports w=
ere considered and
> acted on, for example, this:
> https://groups.google.com/g/syzkaller-bugs/c/L0SBaHZ5bYc. For the
> reported issue, we noticed the read task stays blocked for 143
> seconds, which seemed to be one the higher, especially given that it
> is an emulated floppy drive (yes, you are right). If it deems normal,
> then we do apologize for our misassesment.
>

Maybe, some of the "INFO: task hung" reports are considered once in a
while, but from the testing with fuzzing, they are often really
difficult to judge. Was the system first put into a strange state and
then the system was made slow/hanging by that setup?
Often, human users would never do that or if they do, they basically
would need to expect that the system slows down. So, these reports are
generally more difficult to consider valid. I cannot tell you if that
happens in this case, too. Certainly the floppy driver is special by
now, and I would not expect much bug investigation and fixing for
that.

If Dmitry and his team have not answered some of the questions below
and you are coming from an academic background, you might really want
to look into, which may help you in your interest in working on
syzkaller improvements and considering reporting to kernel developers:

We already have https://syzkaller.appspot.com/upstream to track and
report various issues identified by syzkaller.

At this syzbot instance, as of writing, we currently have 976 issues
open, 3904 fixed, 8461 considered invalid.

The bugs are of different types, e.g., BUG: ..., general protection
fault, INFO: ..., KASAN: ..., KMSAN: ..., memory leak: ..., possible
deadlock: ..., UBSAN: ...

So, from the current data, how many bugs of each type were actively
fixed (so, a dedicated commit to repair the code), not just a report
that was closed because it eventually disappeared? How many bugs of
each type are still open? How long does it take from first reporting
to the commit being accepted? Again, e.g., aggregated by type?

That can tell which type of bugs really are addressed more than
others. And that may help you to decide if to report a bug from your
syzkaller instance.

> > Consider the severity of the issue and judge if you would like to
> > point out such a 'bug'.
> >
> > It might happen that:
> >
> > Due to bad judgement on your side, kernel developers and maintainers
> > will consider the value/severity of the provided bug reports overall
> > and then eventually simply ignore all reports that you send.
>
> That would be very unfortunate. Please allow me to explain how we, as
> a *small* academic team, are operating. If you closely follow our
> reportings we did in the last few days, the first =E2=80=9Cquality contro=
l=E2=80=9D we
> are doing (to minimize the noise and frustration) is to make sure not
> to report any bug without a reproducer. Now, the unfortunate reality
> is that none of us is a pro kernel hacker with years of expertise in
> tinkering with Linux internals, which essentially means, no matter how
> hard we try, we cannot simply match up the combined level of expertise
> and competency of the people in these mailing groups. We are using our
> best judgement before reporting these bugs. Admittedly, we may be
> wrong, and we apologize in advance for such mishaps. The developers
> can confirm, or refute the reports (if they can spend a line or two
> why they think something we reported is not a problem, we would be
> grateful). In our defense, what we can say is that, in the last few
> days we responded to the developers who asked us to provide details of
> a bug, or test a patch. In fact, we are still in the process of
> responding to some of them, because being a small team, our turnaround
> time is higher than ideal. To answer you, simply ignoring all the
> reports we send might be too harsh (unfair?) to an academic group
> operating in good faith. Providing us pointers like you did above
> (thanks to Greg for helping us in some other thread), and letting us
> know what we did wrong will help us to align ourselves better with the
> reporting and patching workflow.
>

All good, but probably you need to follow some simple guidelines.

If you find an issue in older LTS kernel releases and not on the
current one, you can bisect the issue with the reproducer, and
identify the commit in which the issue is fixed. Then the usual stable
patch acceptance process works.

If you find an issue on the current kernel release, you can bisect the
issue with the reproducer to the commit that introduced the issue.
That is helpful for pinpointing the issue and creating a fix.

Do not report more issues than you can handle when testing suggestions
or writing responses. No one expects you to report everything you
find. (We know there are 900 bugs open, reported by syzkaller; so we
are not short of bug reports.). However, if you report, you should
really have time to follow up with responses and work in reasonable
time (probably within a few days). If you cannot handle that full
time, one important bug report each week might be okay and help a bit,
rather than automated sending 1000 bug reports and never being
available for questions on those reports.

> > Dmitry and his team around syzkaller and syzbot can give you more
> > insights on learning a good judgement of what to report, how and when.
>
> We would very much appreciate any help (even positive criticism) from
> the community in this regard.
>

I think there is not much documentation available specific to
reporting bugs from syzkaller, but there are a few best practices that
we already know and we really might want to write up here because "I
run some syzkaller instance and just report whatever I find to the
developers" simply does not work (we have seen that in the past
already). This keeps developers busy and does not necessarily get more
bugs or the important bugs fixed.

Lukas
