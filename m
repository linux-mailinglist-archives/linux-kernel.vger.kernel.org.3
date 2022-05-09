Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127151FA66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiEIKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiEIKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:52:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67120E0B2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:47:52 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1no0vd-0004LQ-W0; Mon, 09 May 2022 12:47:50 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-05-09] (was: Linux 5.18-rc6)
Date:   Mon,  9 May 2022 10:47:49 +0000
Message-Id: <165209064657.193515.10163777181547077546@leemhuis.info>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1652093272;47c46674;
X-HE-SMSGID: 1no0vd-0004LQ-W0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Here's a quick compilation of open reports about regressions in
5.18-rc that I'm currently aware of; most of the reports are quite
recent and there afaics is nothing that looks particularly worrisome.

Sorry, I didn't get around to sent any reports in that past few weeks, I
simply didn't find enough time to get on top of things to compile a
meaningful report. But I nevertheless had an eye on things an poked some
developers when it seemed there wasn't any progress.

On reason why I was short on time: the number of tracked open
regressions increased a bit over the past few weeks. Most of them are
found in older cycles. Listing them all here would make the report quite
long and hard to read -- and people then might stop reading them, which
I'd like to avoid. That's why I stopped including all and only focused
on the ones in the current cycle. Is that okay for you? Or would you
prefer to have at least those from the previous cycle listed as well? Or
at least all that were bisected? Or should I split things up over
multiple reports? Or is having the others on the website enough for
everyone?

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 5 regressions in linux-mainline that
where introduced this cycle. Find the current status below
and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Regressions from previous cycles are listed there as well.

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.17.. aka v5.18-rc), culprit identified
========================================================


[ *NEW* ] drm/i915: BYT rendering broken due to "Remove short-term pins from execbuf, v6"
-----------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
https://lore.kernel.org/dri-devel/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/

By Hans de Goede; 0 days ago; 2 activities, latest 0 days ago.
Introduced in b5cfe6f7a6e1 (v5.18-rc1)

Recent activities from: Tvrtko Ursulin (1), Hans de Goede (1)


[ *NEW* ] net: atlantic: Crash on resume after suspend (5.17.5 and 5.15.36)
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/9-Ehc_xXSwdXcvZqKD5aSqsqeNj5Izco4MYEwnx5cySXVEc9-x_WC4C3kAoCqNTi-H38frroUK17iobNVnkLtW36V6VWGSQEOHXhmVMm5iQ=@protonmail.com/
https://lore.kernel.org/stable/9-Ehc_xXSwdXcvZqKD5aSqsqeNj5Izco4MYEwnx5cySXVEc9-x_WC4C3kAoCqNTi-H38frroUK17iobNVnkLtW36V6VWGSQEOHXhmVMm5iQ=@protonmail.com/

By Jordan Leppert; 4 days ago; 22 activities, latest 1 days ago.
Introduced in cbe6c3a8f8f4 (v5.18-rc4)

Recent activities from: Manuel Ullmann (11), Jordan Leppert (4), Holger
  Hoffstätte (4), Thorsten Leemhuis (2), Igor Russkikh (1)

Noteworthy links:
* [PATCH] net: atlantic: always deep reset on pm op, fixing null deref regression
  https://lore.kernel.org/lkml/87czgt2bsb.fsf@posteo.de/
  4 days ago, by Manuel Ullmann; thread monitored.
* [PATCH v2] net: atlantic: always deep reset on pm op, fixing null deref regression
  https://lore.kernel.org/lkml/877d6zirmy.fsf@posteo.de/
  3 days ago, by Manuel Ullmann; thread monitored.
* [PATCH v3] net: atlantic: always deep reset on pm op, fixing null deref regression
  https://lore.kernel.org/lkml/8735hniqcm.fsf@posteo.de/
  3 days ago, by Manuel Ullmann; thread monitored.
* [PATCH net-next v4] net: atlantic: always deep reset on pm op, fixing up my null deref regression
  https://lore.kernel.org/lkml/87zgjtz4sb.fsf@posteo.de/
  1 days ago, by Manuel Ullmann; thread monitored.
* [PATCH net-next v5] net: atlantic: always deep reset on pm op, fixing up my null deref regression
  https://lore.kernel.org/lkml/87fsllcd80.fsf@posteo.de/
  1 days ago, by Manuel Ullmann; thread monitored.
* [PATCH v6] net: atlantic: always deep reset on pm op, fixing up my null deref regression
  https://lore.kernel.org/lkml/87bkw8dfmp.fsf@posteo.de/
  1 days ago, by Manuel Ullmann; thread monitored.
* [PATCH v6] net: atlantic: always deep reset on pm op, fixing up my null deref regression
  https://lore.kernel.org/lkml/87bkw8dfmp.fsf@posteo.de/
  1 days ago, by Manuel Ullmann; thread monitored.


[ *NEW* ] net: dpaa2: TSO offload on lx2160a causes fatal exception in interrupt
--------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/7ca81e6b-85fd-beff-1c2b-62c86c9352e9@leemhuis.info/
https://lore.kernel.org/netdev/7ca81e6b-85fd-beff-1c2b-62c86c9352e9@leemhuis.info/

By Unkown; 5 days ago; 2 activities, latest 5 days ago.
Introduced in 3dc709e0cd47 (v5.18-rc1)

Recent activities from: Ioana Ciornei (1), Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215886


====================================================
current cycle (v5.17.. aka v5.18-rc), unkown culprit
====================================================


[ *NEW* ] rdma: hangs in blktests since 5.18-rc1+
-------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com/
https://lore.kernel.org/linux-rdma/e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com/

By Bob Pearson; 2 days ago; 10 activities, latest 0 days ago.
Introduced in v5.17..v5.18-rc6

Recent activities from: Yanjun Zhu (3), Bob Pearson (3), Bart Van
  Assche (2), Zhu Yanjun (1), Jason Gunthorpe (1)


[ *NEW* ] input/usb/???: bcm5974 trackpad causes error: xhci_hcd rejecting DMA map of vmalloc memory
----------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/76e24afa-ad7d-bf6d-d610-df61851b3e2b@leemhuis.info/
https://lore.kernel.org/linux-usb/76e24afa-ad7d-bf6d-d610-df61851b3e2b@leemhuis.info/

By Satadru Pramanik; 5 days ago; 1 activities, latest 5 days ago.
Introduced in v5.17..v5.18-rc4

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215890

=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164779309771.379023.10823585483674878438@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
