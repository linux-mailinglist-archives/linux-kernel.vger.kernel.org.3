Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4908957F6B9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiGXTst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGXTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:48:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C4EE1F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:48:45 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oFhak-0007Uy-Ps; Sun, 24 Jul 2022 21:48:42 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-07-24]
Date:   Sun, 24 Jul 2022 19:48:41 +0000
Message-Id: <165869171256.283493.2326902986633030609@leemhuis.info>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1658692125;db11c0c6;
X-HE-SMSGID: 1oFhak-0007Uy-Ps
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below is the report from regzbot listing all regression from
this cycle that the bot and I are aware of. Let me please highlight two
things:

* The following patch fixing a build bug reported three times now, that
didn't get any reaction from the maintainer since it was posted six days
ago:
https://lore.kernel.org/lkml/20220717231105.33005-1-kilobyte@angband.pl/

* The virtio regression is kinda fixed by c346dae4f3fb already, but
there is a patch in the branch Michael usually uses to sent patches to
you that he for one reason or another hasn't sent your way yet:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=vhost&idj9720576cd00d30722c5f755bd17d4cfa9df636
I asked what's up here a few days ago, but sadly got no reply.

HTH, Ciao, Thorsten

---
Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 23 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.18.. aka v5.19-rc), culprit identified
========================================================


[BUILD BUG] regression from certs: Move load_certificate_list() to be with the asymmetric keys code
---------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220712104554.408dbf42@gandalf.local.home/
https://lore.kernel.org/lkml/20220712104554.408dbf42@gandalf.local.home/

By Steven Rostedt; 12 days ago; 3 activities, latest 6 days ago.
Introduced in 60050ffe3d77 (v5.19-rc4)

Recent activities from: Adam Borowski (2)

One patch associated with this regression:
* [PATCH] certs: make system keyring depend on x509 parser
  https://lore.kernel.org/lkml/20220718135034.51457-1-kilobyte@angband.pl/
  6 days ago, by Adam Borowski

Noteworthy links:
* [PATCH] certs: make system keyring depend on x509 parser
  https://lore.kernel.org/lkml/20220717231105.33005-1-kilobyte@angband.pl/
  6 days ago, by Adam Borowski; thread monitored.


[ *NEW* ] fs: recent changes to copy_file_range behavior breakage
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YtTM8GYn0/HkSoet@squish.home.loc/
https://lore.kernel.org/regressions/YtTM8GYn0%2FHkSoet@squish.home.loc/

By Paul Thompson; 6 days ago; 2 activities, latest 6 days ago.
Introduced in 868f9f2f8e00 (v5.19-rc5)

Recent activities from: Amir Goldstein (1), Paul Thompson (1)


virtio_balloon regression in 5.19-rc3
-------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk/
https://lore.kernel.org/virtualization/64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk/

By Ben Hutchings; 34 days ago; 22 activities, latest 14 days ago.
Introduced in 8b4ec69d7e09 (v5.19-rc1)

Fix incoming:
* virtio: VIRTIO_HARDEN_NOTIFICATION is broken
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6a9720576cd00d30722c5f755bd17d4cfa9df636


====================================================
current cycle (v5.18.. aka v5.19-rc), unkown culprit
====================================================


PM: hibernate: Sound Distortion on boot
---------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de/
https://lore.kernel.org/lkml/46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de/

By Daniel Exner; 12 days ago; 5 activities, latest 10 days ago.
Introduced in v5.19-rc1..v5.19-rc4

=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/165808300299.1270116.2805091955648892933@leemhuis.info

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
