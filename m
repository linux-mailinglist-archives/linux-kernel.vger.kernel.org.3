Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD564D91B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbiCOAqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbiCOAqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:46:42 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CE656D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:45:32 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so4695553oou.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FfAmAKjAgj6bQe6BTe66EUAUXF5Jrw46PifagMQ1u0=;
        b=o4oWGwwe5ko2FVrqYc2L7nRRBp6MMHzzsXeI1UYczON1Mu4N2iS9kgdj//y/A6aMd8
         MtnK+XRkuYOH2hZsq9n2zgHjlTRaUyToYjj0LIQoFnj5SpEYrhxHlsrEs76yt9jRhL9a
         tdr+/IhN1k/uEBL231BTExmyKtlWyOinbXeB454Fbf4j10RJAxc3C/gEkcCiDHy/YM7+
         SnYm/qd7bbZjyYpaPYWOI9I3P3T2VMZIcqbwyF+p9r/Zi7Q6/S0VkYSr74xdALKLeB4n
         GUmh/orAHAnOHKSi05sK+jDPaEWTL+QzAQzpwp+laW0hiBll46B4gZlhZD7OxUutW/Lt
         odyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FfAmAKjAgj6bQe6BTe66EUAUXF5Jrw46PifagMQ1u0=;
        b=meiUvJTfRDkLgIm09f/OBQ8CqQNLnPhzHykacDdF2VSgdBTStPJ8MRnEQ1UJ2V+tVS
         cvS8vZ9SRIMMulxzUJkWepDUkjTZt7LU8tUjjnCNWIw/5Xjb5FmLlZWGvYDGgrzrNd2Z
         x3y2/X6Sr2pfeF2nc1tZ8X6pL2fXGPiEsPrb52wPg3QTSrWPuQ56pWXbtRt2MOs5V5YC
         SEnlqyzcaXswK+ZI3TRAuHRYKPJaMYILGlFxMdsH63fgbMV8YV211z7aBG1pxZGcch07
         SVKzImNH6vjSCtRlP0KklyKvcmt4Xfw04hDwADP71jpJrAGHthdvZLetFniabHPCS9HP
         AckQ==
X-Gm-Message-State: AOAM5311hlFbIA5/g/StzwTpwpWeLpqPy8mbaG7fkDfsuSVo47gmIQmM
        R2ASukBszQv9y/FuPxN1H5yHGR3tXlBm0GA9oPU=
X-Google-Smtp-Source: ABdhPJyuNYM2MM0RzEwvOKhy0xgOLQcQ9GVtrJvRP992zbmaFDz+S1SdzqX/jKlUJrjV09doSVyl5JpKRlTgidJzNQU=
X-Received: by 2002:a05:6870:1807:b0:d7:2a4c:14b8 with SMTP id
 t7-20020a056870180700b000d72a4c14b8mr599258oaf.97.1647305131065; Mon, 14 Mar
 2022 17:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
 <20220314192522.GA3031157@roeck-us.net> <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
In-Reply-To: <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
From:   Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
Date:   Mon, 14 Mar 2022 21:45:05 -0300
Message-ID: <CACjc_5paC=X4znTty8LBtobqBW2nq4mbQYnw_TMgVEFb1A7mhA@mail.gmail.com>
Subject: Re: Linux 5.17-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Linus,

I am the author of the "gpio: Revert regression..." patch.

On Mon, Mar 14, 2022 at 5:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Adding more people to the cc, since this last change was triggered
> by earlier changes.
>
> On Mon, Mar 14, 2022 at 12:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 155 pass: 155 fail: 0
> > Qemu test results:
> >         total: 488 pass: 484 fail: 4
>
> Uhhuh. We got all the previous problems sorted out, but a new one instead.
>
> > This is a new problem. It bisects to commit fc328a7d1fcc ("gpio: Revert
> > regression in sysfs-gpio (gpiolib.c)"). The network connection fails
> > in the affected tests. Reverting the offending commit (ie reverting the
> > revert) fixes the problem.
>
> Hmm. Looking at the changes since 5.16, that commit fc328a7d1fcc looks
> somewhat suspicious.
>
> It claims to "revert" things, but the behavior it reverts goes
> basically all the way back to v5.7 (with one of the patches going into
> 5.10).
>
> And it clearly breaks things that used to work much more recently (ie
> this worked in rc7, but it was also the state in every release since
> 5.10).
>
> So unless somebody can find the _real_ issue here, I suspect very
> strongly that that "fix" that came in last week was just wrong.
>
> It is also very non-specific "Some GPIO lines have stopped working"
> with no pointer to actual reports.

The original message in which I posted the patch also had a small
report. I listed the board in which the problem appeared and a small
test script to show the error, which I have used to bisect the issue.

The whole thread is here, the test is in the first message:
https://lore.kernel.org/all/a7fbb773-eb85-ccc7-8bfb-0bfab062ffe1@leemhuis.info/t/

> LinusW? Thierry? Bartoz? Anybody?
>
> Yes, there;s something bad going on here, but we can't randomly "fix"
> things in an rc8 that have worked for several releases by now.

The original patch just reverted the patch that introduced the problem
I found. But if the reversion introduces problems at this point, then
the sane thing to do is to revert the reversion.

At a certain point, I tried Thorsten's suggestion to add a gpio-ranges
property in a way similar to another patch, but the kernel went into
an EPROBE_DEFER deadlock. Thierry Reding made some comments about this
in the sequence.

Following Linus Walleij's suggestion, we are moving the code from the
sysfs interface to the character device. But in the meantime, we are
using this "revert patch" in a 5.10.80 kernel, so maybe someone could
point me to details of the network misbehaviour so that I can also
check it?

>
>                Linus

Regards,
Marcelo.
