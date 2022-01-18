Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52A492D83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348151AbiARShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347998AbiARShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:37:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1428C06161C;
        Tue, 18 Jan 2022 10:37:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C16DB81747;
        Tue, 18 Jan 2022 18:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2BEC340E5;
        Tue, 18 Jan 2022 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642531057;
        bh=2tKT2LkkSw7F1pcMD5R/BU1/Sa9Qs105/gaBZjyvCHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C1e7ptTAiQs29o0U7mXPHIJZ6gO/fvMYPlMLkKf3TYB3Jrbx3nFKNUOJV7aGNHoIt
         53A0kLQ91GtbPr+i7hPxh3pCyYPsZjkBtysF+cqxMgK85endvY7uBwwbiQinWZJKaJ
         23DC8TQZ9wh1nJCsH11GXXLF/Wk0rRNc4RKb8UjormQLU7b1E/AZXWhZrbtccBOQxj
         /7+mdwUrP0o+zcrqc0ZNfo/wv7GssOrITR26dq/JUDXbULS7Fi5/0JDLGUqXDljlAa
         zVAtwmQuF6YGXc5ApFDPy9oVnu5/c10YdI3rKABTHv6Wyf7Ga8PLnUIHvn6cgCaiJb
         tIgR/qR9o5Gww==
Received: by mail-ed1-f41.google.com with SMTP id m4so83511897edb.10;
        Tue, 18 Jan 2022 10:37:37 -0800 (PST)
X-Gm-Message-State: AOAM533VFtE6UGnhsSc71hxyhwSfFzGgl5OL8Xt8nDuhZC+Y5bxw1XWH
        JA1Qa1050Qvoqe2ryFRLFASdXDMYdkrO+rfO8A==
X-Google-Smtp-Source: ABdhPJxo3mZozVtV4I4Y2c/YrH36dX/A++g5u12oIgnT/QjoF3/dV6tPlV2CLl2cYfKHczrqCDPMtB0IsYYCJ5lI3xc=
X-Received: by 2002:a17:906:1604:: with SMTP id m4mr14849598ejd.325.1642531055560;
 Tue, 18 Jan 2022 10:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
 <5bd2dba7-c56f-4d8c-2f28-f2428afdcead@leemhuis.info> <CAL_JsqKH90fgSPjKqALweEmZDfxy88jAiRZ4uRKE3+-OZv1ZXQ@mail.gmail.com>
 <2f55b629-2e5b-bd45-e0ea-4e476f603dc8@leemhuis.info>
In-Reply-To: <2f55b629-2e5b-bd45-e0ea-4e476f603dc8@leemhuis.info>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jan 2022 12:37:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQnPc=eSz_OD4HaK-MqXmmnfQkRNbHHLXpRH--w=dBNQ@mail.gmail.com>
Message-ID: <CAL_JsqLQnPc=eSz_OD4HaK-MqXmmnfQkRNbHHLXpRH--w=dBNQ@mail.gmail.com>
Subject: Re: ChipIdea USB regression
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 11:34 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 18.01.22 17:53, Rob Herring wrote:
> > On Sun, Jan 16, 2022 at 4:21 AM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> [TLDR: I'm adding this regression to regzbot, the Linux kernel
> >> regression tracking bot; most text you find below is compiled from a few
> >> templates paragraphs some of you might have seen already.]
> >>
> >> Hi, this is your Linux kernel regression tracker speaking.
> >>
> >> Adding the regression mailing list to the list of recipients, as it
> >> should be in the loop for all regressions, as explained here:
> >> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> >>
> >> On 14.01.22 11:56, Charles Keepax wrote:
> >>> Hi guys,
> >>>
> >>> My Zynq based board stopped booting today, a bisect points to this
> >>> patch:
> >>>
> >>> commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")
> >>
> >> Thanks for the report.
> >>
> >> To be sure this issue doesn't fall through the cracks unnoticed, I'm
> >> adding it to regzbot, my Linux kernel regression tracking bot:
> >>
> >> #regzbot ^introduced 0f153a1b8193
> >> #regzbot title usb: chipidea: Zynq based board stopped booting today
> >> #regzbot ignore-activity
> >>
> >> Reminder: when fixing the issue, please add a 'Link:' tag with the URL
> >> to the report (the parent of this mail) using the kernel.org redirector,
> >
> > 'kernel.org redirector' is lore.kernel.org? It would be clearer to
> > just say that.
>
> Yes/No it's lore.kernel.org/r/ (and not lore.kernel.org/list-foo/).
> You're right I'll rephrase next time.

Or now lore.kernel.org/all/...

> >> as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
> >> then will automatically mark the regression as resolved once the fix
> >> lands in the appropriate tree. For more details about regzbot see footer.
> >
> > Would it be possible for you to provide the exact link tag in your
> > reports? That would be easier and less error prone than describing
> > what to do in prose.
>
> Hmm. The webui already provides this (and other things you likely want
> to add) when you show the details for a tracked regression or visit its
> individual page:
>
> https://linux-regtracking.leemhuis.info/regzbot/mainline/
> https://linux-regtracking.leemhuis.info/regzbot/regression/20220114105620.GK18506@ediswmail.ad.cirrus.com/

That is the link I was originally expecting for when I went back to this thread.

> I see that it would be convenient for developers and less error prone if
> I could mention the proper Link: tag in mails like the one you quoted,
> that's why I considered that already. But it would make the regression
> tracker's job (aka my "job", which I'm kinda doing in my spare time) yet
> again somewhat harder, as I see no easy solution to automate that when
> writing these mails (which I do with thunderbird, currently). That's why
> I decided to not do that for now, as that job is already hard enough and
> I don't want to get burned out by this a second time; and those link
> tags are something that were expected from developers even before I came
> with regzbot.

Fair enough, I thought this was more automated than it is. I have some
scripts for writing replies[1] if that helps. I wrote them because I
couldn't find any that would quote emails. (Maybe because it's a pain
dealing with all the encodings). They are geared toward patches in
terms of trimming the email, but shouldn't be too hard to adapt.

Rob

[1] https://gitlab.com/robherring/pw-utils
