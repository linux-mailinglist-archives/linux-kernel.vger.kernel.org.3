Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C645AC1B6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 01:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiICXPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 19:15:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8A91F639;
        Sat,  3 Sep 2022 16:15:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y136so399210pfb.3;
        Sat, 03 Sep 2022 16:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=/UIVvNPGGuVuyXHfCkfmj/E2Gp1v4KdZ0mdzCPC+OYw=;
        b=dAOkDv239fvFc7/ElwPWxTQH97P40kR/orJoA9Xlw9ccnznIfgqb7O7ekI18YfqFzL
         CrbNXeJuh1WRELXO5l5EEyfLyPNCmvr5BcoUy/8utEYpzcqWRskhJK/8S1V+vcI6fP5F
         G6dCyUGPo1QT5tC/KxnkhuQaO5MB6iYety1tAk0VMZEvWNxaH8mVOSDeWdF2E8lRdLQ0
         sbzXagjXQM76ElnUNNA+bdtahiI0yYy9RbVitZe3tNynkJQgszj/zjNXVfexLscw/m7q
         OUIg4Nl+Xgu/Uk36j/7Z4ZjsNGh4NNRTGrTjibMMqq4inQeMx7P28opw1ii3f2cO/yi+
         25Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/UIVvNPGGuVuyXHfCkfmj/E2Gp1v4KdZ0mdzCPC+OYw=;
        b=QN896bwRbdDJIk3Kec0qTDO8Y4EXzNUTMQlD7R4f6d6HyjqyMsXwdeurD/bWBqWa9E
         zhVBJVIl8b6egETATO1boHZy7o2O4DG87HODo95HEPnEz7/rSFlJShFi6kXM4DumZdZg
         aUoNQv5wmL7pHBTds6GmsztIwe0wLPb+xdRutXqB9njovEEvsznPboPmbvPNIxJvZ4OJ
         u5TbjfiWqQzLkcFnF+nqzM6qO622qsEE2RFhEIZ6opZmPnEcYFMec1Yab4FRSHidJUca
         yOAlMKhwzhxhTv9OOlK1+04jKLmcHDAWC6cjncFLKBphcxLF6ie/hOPafl322rGiZBFc
         CelA==
X-Gm-Message-State: ACgBeo1bH0Ksn2STTnomt/jqAX94rEYqJK1l1f/KTP7S7UuIf7EXvp6E
        i+RVRT+8HEJoPxrRPhPI4VMawnVSwXfWkv1ImGesAJaZxg2tFg==
X-Google-Smtp-Source: AA6agR43Cdz+UJ42BXrfaxVQWH39Ywbee/ktCZmqwsjoke9j9bXqOMVfSIGBra4PqrCx+G43S5ttLLDNt3JpF6Nynos=
X-Received: by 2002:a63:62c3:0:b0:434:2b09:6f62 with SMTP id
 w186-20020a6362c3000000b004342b096f62mr2166716pgb.374.1662246910212; Sat, 03
 Sep 2022 16:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220826083612.1699194-1-floridsleeves@gmail.com>
 <CAHp75VcdqL4wYnhEi8LrxqJktA2uDzP3a6-08suJRghX=1UZsg@mail.gmail.com>
 <CAMEuxRqBEMdva3qEphvuYkFLpRjp=xg7vpqQT1oqb2AgkkG2+w@mail.gmail.com>
 <2033d06d-10a4-5a57-d650-7541c39990ee@linux.intel.com> <CAMEuxRq6wn+wakYHGtnS_vSgpcw6aNOir=KyXWb12vPrOr76pA@mail.gmail.com>
 <40e16474-99d2-2359-a545-4a437f555ec1@linux.intel.com>
In-Reply-To: <40e16474-99d2-2359-a545-4a437f555ec1@linux.intel.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Sat, 3 Sep 2022 16:14:59 -0700
Message-ID: <CAMEuxRpm5xNm2kEnhCSimoaCE3zSxbyoo7xUxNg74QrL7F6YUg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/tty/serial: check the return value of uart_port_check()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
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

On Tue, Aug 30, 2022 at 12:20 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 29 Aug 2022, Li Zhong wrote:
>
> > On Mon, Aug 29, 2022 at 12:09 AM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Sun, 28 Aug 2022, Li Zhong wrote:
> > >
> > > > On Fri, Aug 26, 2022 at 9:01 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Aug 26, 2022 at 11:38 AM Li Zhong <floridsleeves@gmail.co=
m> wrote:
> > > > > >
> > > > > > uart_port_check() will return NULL pointer when state->uart_por=
t is
> > > > > > NULL. Check the return value before dereference it to avoid
> > > > > > null-pointer-dereference error.
> > > > >
> > > > > Have you taken the locking into consideration?
> > > > > If no, please do, if yes, expand your commit message to explain w=
hy
> > > > > the current locking scheme doesn't prevent an error from happenin=
g.
> > > > >
> > > >
> > > > The locking is taken into consideration but these three checks do n=
ot need to
> > > > unlock in error-handling because unlock() will be called in the cal=
lers. Will
> > > > add the comment in v2 patch.
> > >
> > > I think he meant you should indicate why the current locking doesn't =
cover
> > > the case you're fixing, not whether this function should call unlock(=
) or
> > > not.
> > >
> >
> > Thanks for clarifications. The locking does not guarantee the return va=
lue of
> > uart_port_check()  is not NULL.
>
> Please put such explanation into the commit message like Andy was asking,
> thank you.
>

Thanks! I'll add this into the v3 patch.

> And make sure you properly mention what has changed for any new version
> of any patch you send so that Greg don't need to auto-mail you about it
> (and end up ignoring your patch).
>

I'll mention this in the commit message of new patch.

> > Actually in line 773 of this file
> > (drivers/tty/serial/serial_core.c), uart_port_check() is also called in
> > critical section but still there is check on whether the return value i=
s NULL.
>
> Existance of such a check elsewhere alone isn't enough to guarantee that
> the check is necessary (and not even that the check in that other place
> would be necessary). You need a deeper analysis than that. I'm not
> claiming its either way here, just pointing out to the direction/details
> you should consider while writing the analysis of the problem.
>

Thanks for the suggestions. We will try consider more factor into our analy=
sis
tools to reduce false postives.

>
> --
>  i.
