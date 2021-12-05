Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172E0468CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhLES7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbhLES7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:59:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE5AC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 10:55:53 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mtwfw-00027y-6u; Sun, 05 Dec 2021 19:55:52 +0100
Message-ID: <3022040f-761c-54a0-62df-c975288822f4@leemhuis.info>
Date:   Sun, 5 Dec 2021 19:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Linux regressions report for mainline [2021-12-05]
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <163872839745.395685.15301798356990039860@leemhuis.info>
In-Reply-To: <163872839745.395685.15301798356990039860@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1638730553;9d8beba7;
X-HE-SMSGID: 1mtwfw-00027y-6u
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.21 19:21, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> Hi, this is regzbot, the Linux kernel regression tracking bot.

A few quick comments and questions. Let's start with one of the latter:

Does anyone want to see a category which lists "regressions fixed since
the last report" in these weekly reports? Or do we consider this
superfluous because they are fixed?

> [...]
> mm: LTP/memcg testcase regression induced by 8cd7c588decf..66ce520bb7c2 series
> ------------------------------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
> https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
> 
> By Mike Galbraith, 14 days ago; 58 activities, latest 1 days ago.
> Introduced in 8cd7c588decf..66ce520bb7c2 (v5.15..v5.16-rc1)
> 
> Recent activities from: Mel Gorman (16), Mike Galbraith (9), Alexey
>   Avramov (5), Shakeel Butt (3), Darrick J. Wong (2), kernel test
>   robot (2)

FYI, this is new, I hope it makes it easier to see if well-known kernel
developers are currently involved and working towards a fix. Sure, that
requires one to know their names, but the report is mainly targeted
towards people that will know such names anyway.

The web interface links to the five latest activities instead and
mentions date and author. I could do the same in the reports, but it
would make them quite a bit longer and maybe too cluttered.

> 10 patch postings are associated with this regression, the latest is this:

TWIMC: I noticed a bug in regzbot right before sending the report I
could not fix quickly: this patch...

> * [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
>   https://lore.kernel.org/lkml/20211202150614.22440-1-mgorman@techsingularity.net/
>   3 days ago, by Mel Gorman; thread monitored.

...should also have been mentioned...

> [...]
> mm: reclaim_throttle leads to stall in near-OOM conditions
> ----------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/20211124011954.7cab9bb4@mail.inbox.lv/
> https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/
> 
> By Alexey Avramov, 12 days ago; 12 activities, latest 7 days ago.
> Introduced in v5.15..v5.16-rc1
> 
> 4 patch postings are associated with this regression, the latest is this:
> * Re: mm: 5.16 regression: reclaim_throttle leads to stall in near-OOM conditions
>   https://lore.kernel.org/lkml/20211126162416.GK3366@techsingularity.net/
>   9 days ago, by Mel Gorman

...here as well. I guess I already known how this happened and will fix
this up.

> [...]

[quoting a bit out-of-order here]

BTW: I'm a bit unsure how to handle the following regression. I think it
might be one of those rare regressions that are unavoidable, but I still
wonder if it should be made easier to people to deal with the situation.
I asked developers for a statement a few days ago, but haven't got a
reply yet. :-/ For details see:
https://lore.kernel.org/regressions/96b3682d-71b3-ada0-6fc7-686e51609968@leemhuis.info/

> net: wireless: ath10k: 5GHz channels are marked as No-IR
> --------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
> https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
> 
> By Sebastian Bachmann, 8 days ago; 19 activities, latest 4 days ago.
> Introduced in 2dc016599cfa (v5.6-rc1)
> 
> Recent activities from: Thorsten Leemhuis (1)
> 
> Noteworthy links:
> * Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
>   https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
>   602 days ago, by svp; thread monitored.
> * Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
>   https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
>   530 days ago, by Brian Norris
> * [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
>   https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
>   493 days ago, by Alvin Šipraga; thread monitored.
> * [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
>   https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
>   409 days ago, by Félix Sipma; thread monitored.
> * Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
>   https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
>   349 days ago, by sparks71@gmx.de; thread monitored.
> * https://bugs.debian.org/959821
> * https://bbs.archlinux.org/viewtopic.php?id=254535

The following regressions are all waiting for input from a
non-developer, e.g. usually the reporter or someone else affected. Not
totally sure yet, but I guess I'll add something like a "#regzbot
needinfo: <reason>" for them. Then regzbot can sort them into their own
category and place them at the end. Obviously I as regression tracker
will watch when people use it to make sure it's not done to hide
regressions. ;-)

> drm/amd: AMD RX 6700 XT - Fails to resume after screen blank
> ------------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk/
> https://lore.kernel.org/regressions/99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk/
> 
> By Mark Boddington, 10 days ago; 3 activities, latest 9 days ago.
> Introduced in 61d861cf4785 (v5.15-rc1)

> [...]

> Bug in Memory Layout of rx_desc for QCA6174
> -------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
> https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
> 
> By Francesco Magliocca, 170 days ago; 5 activities, latest 35 days ago.
> Introduced in e3def6f7ddf8 (v4.16-rc1)
> 
> Noteworthy links:
> * Bug in Memory Layout of rx_desc for QCA6174
>   https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com/
>   37 days ago, by Francesco Magliocca; thread monitored.

> [...]

> idle power increased from ~20 to ~28 watts
> ------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/
> https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/
> 
> By Idzibear, 34 days ago; 3 activities, latest 34 days ago.
> Introduced in v5.14..v5.15

That's it. Thx for your attention, have a nice day everyone and a safe
flight with Linux kernel airlines.

Ciao, Thorsten
