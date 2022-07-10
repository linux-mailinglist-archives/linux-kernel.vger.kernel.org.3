Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116856D054
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiGJRKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:10:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F913E87
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 10:10:34 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oAaRz-0005Xa-S0; Sun, 10 Jul 2022 19:10:31 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-07-10]
Date:   Sun, 10 Jul 2022 17:10:31 +0000
Message-Id: <165747255136.969857.3241652331345232712@leemhuis.info>
X-Mailer: git-send-email 2.34.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1657473034;630cb6c7;
X-HE-SMSGID: 1oAaRz-0005Xa-S0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! With the changes you just merged, I'm only aware of two
unresolved regression in mainline. Fixes for both exist in git trees,
but they are not headed your way yet afaics.

I'm not aware of any other regressions for mainline that were introduced
in this cycle. I fear there might be some that were reported in
bugzilla, but I currently lack the time to keep an close eye on it,
sorry. :-/ That hopefully should change again in a few weeks.

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 2 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.18.. aka v5.19-rc), culprit identified
========================================================


[ *NEW* ] virtio_balloon regression in 5.19-rc3
-----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk/
https://lore.kernel.org/virtualization/64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk/

By Ben Hutchings; 19 days ago; 22 activities, latest 0 days ago.
Introduced in 8b4ec69d7e09 (v5.19-rc1)

Fix incoming:
* virtio: VIRTIO_HARDEN_NOTIFICATION is broken
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6a9720576cd00d30722c5f755bd17d4cfa9df636


[ *NEW* ] drm: fbdev/simplefb: Linux 5.19-rc5 gets stuck on boot, not rc4
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/272584304.305738.1657029005216@office.mailbox.org/
https://lore.kernel.org/lkml/272584304.305738.1657029005216@office.mailbox.org/

By torvic9@mailbox.org; 5 days ago; 12 activities, latest 1 days ago.
Introduced in ee7a69aa38d8 (v5.19-rc5)

Fix incoming:
* drm/aperture: Run fbdev removal before internal helpers
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=bf43e4521ff3223a613f3a496991a22a4d78e04b

=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/165263184972.441566.6613731168195248776@leemhuis.info

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
