Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2055777CF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiGQSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQSnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:43:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB32739
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 11:43:20 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oD9Ec-0002hh-8X; Sun, 17 Jul 2022 20:43:18 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-07-17]
Date:   Sun, 17 Jul 2022 18:43:17 +0000
Message-Id: <165808300299.1270116.2805091955648892933@leemhuis.info>
X-Mailer: git-send-email 2.34.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1658083400;7456890f;
X-HE-SMSGID: 1oD9Ec-0002hh-8X
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Here is a quick summary of the regressions introduced this cycle
that I'm aware of. Not sure why Michael hasn't sent the virtio change to
avoid the troubles with VIRTIO_HARDEN_NOTIFICATION, will ask him tomorrow.

HTH, Ciao, Thorsten

---
Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 22 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.18.. aka v5.19-rc), culprit identified
========================================================


[ *NEW* ] drm: i915: support for ADL-P GPUs requires updates GuC firmware files
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAPM=9txdca1VnRpp-oNLXpBc2UWq3=ceeim5+Gw4N9tAriRY6A@mail.gmail.com/
https://lore.kernel.org/dri-devel/CAPM=9txdca1VnRpp-oNLXpBc2UWq3=ceeim5%2BGw4N9tAriRY6A@mail.gmail.com/

By Dave Airlie; 2 days ago; 6 activities, latest 0 days ago.
Introduced in 2584b3549f4c (v5.19-rc1)

Recent activities from: Patchwork (4), Daniele Ceraolo Spurio (1), Dave
  Airlie (1)

Noteworthy links:
* [PATCH] drm/i915/guc: support v69 in parallel to v70
  https://lore.kernel.org/dri-devel/20220715225451.1294354-1-daniele.ceraolospurio@intel.com/
  1 days ago, by Daniele Ceraolo Spurio; thread monitored.


[ *NEW* ] [BUILD BUG] regression from certs: Move load_certificate_list() to be with the asymmetric keys code
-------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220712104554.408dbf42@gandalf.local.home/
https://lore.kernel.org/lkml/20220712104554.408dbf42@gandalf.local.home/

By Steven Rostedt; 5 days ago; 1 activities, latest 5 days ago.
Introduced in 60050ffe3d77 (v5.19-rc4)

Recent activities from: Steven Rostedt (1)


virtio_balloon regression in 5.19-rc3
-------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk/
https://lore.kernel.org/virtualization/64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk/

By Ben Hutchings; 26 days ago; 22 activities, latest 7 days ago.
Introduced in 8b4ec69d7e09 (v5.19-rc1)

Fix incoming:
* virtio: VIRTIO_HARDEN_NOTIFICATION is broken
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6a9720576cd00d30722c5f755bd17d4cfa9df636


====================================================
current cycle (v5.18.. aka v5.19-rc), unkown culprit
====================================================


[ *NEW* ] PM: hibernate: Sound Distortion on boot
-------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de/
https://lore.kernel.org/lkml/46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de/

By Daniel Exner; 5 days ago; 5 activities, latest 3 days ago.
Introduced in v5.19-rc1..v5.19-rc4

Recent activities from: Thorsten Leemhuis (2), Daniel Exner (2), Dmitry
  Osipenko (1)

=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/165747255136.969857.3241652331345232712@leemhuis.info

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
