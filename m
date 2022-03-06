Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B384CED91
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 20:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiCFT7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 14:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiCFT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 14:59:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026165C0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:58:53 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nQx1n-0008IS-Bc; Sun, 06 Mar 2022 20:58:51 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-03-06]
Date:   Sun,  6 Mar 2022 19:58:50 +0000
Message-Id: <164659571791.547857.13375280613389065406@leemhuis.info>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646596734;19de4d75;
X-HE-SMSGID: 1nQx1n-0008IS-Bc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Thorsten here, with a quick preface before the latest report
from regzbot.

From my side things seem to look normal right now; quite a few
regressions got fixed in the past few days. I (and thus regzbot) are
only aware of two regressions remaining that got introduced this cycle
(at least one of them pretty special); I didn't add those build problems
from Guenter to the tracking: he seems to look after those quite well
already (I need to talk to him if he want's me to track them, but I
didn't get around to do that).

Sadly I'm guess there are some regressions out there which I and regzbot
are not aware of. Hopefully more people will at least CC the regressions
mailing list (regressions@lists.linux.dev) on regressions reports in the
future (and/or get regzbot involved themselves), as that ensures I'll
get aware of them.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 15 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.16.. aka v5.17-rc), culprit identified
========================================================


Follow-up error for the commit fixing "PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization"
---------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Yf2wTLjmcRj+AbDv@xps13.dannf/
https://lore.kernel.org/stable/Yf2wTLjmcRj%2BAbDv@xps13.dannf/

By dann frazier, 29 days ago; 7 activities, latest 23 days ago; poked 13 days ago.
Introduced in c7a75d07827a (v5.17-rc1)


====================================================
current cycle (v5.16.. aka v5.17-rc), unkown culprit
====================================================


net: bluetooth: qualcom and intel adapters, unable to reliably connect to bluetooth devices
-------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com/
https://lore.kernel.org/linux-bluetooth/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i%2BRE%2BL2FTXSA@mail.gmail.com/

By Chris Murphy, 23 days ago; 47 activities, latest 3 days ago.
Introduced in v5.16..f1baf68e1383 (v5.16..v5.17-rc4)

Fix incoming:
* https://lore.kernel.org/regressions/1686eb5f-7484-8ec2-8564-84fe04bf6a70@leemhuis.info/


=========================================================================================
previous cycle (v5.15..v5.16), culprit identified, with activity in the past three months
=========================================================================================


drm: fb_helper:  Build failure of mainline kernel with qcom_defconfig
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YhofdlzadzRmy7tj@debian/
https://lore.kernel.org/lkml/YhofdlzadzRmy7tj@debian/

By Sudip Mukherjee, 8 days ago; 10 activities, latest 2 days ago.
Introduced in 9d6366e743f3 (v5.16-rc1)

Fix incoming:
* drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=eea89dff4c39a106f98d1cb5e4d626f8c63908b9


net: wireless: rtl8723bs (SDIO) - Access point mode causes a kernel panic
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/
https://lore.kernel.org/regressions/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/

By José Ángel Pastrana, 35 days ago; 3 activities, latest 2 days ago.
Introduced in 54659ca026e5 (v5.16-rc1)

Fix incoming:
* staging: rtl8723bs: Fix access-point mode deadlock
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=8f4347081be32e67b0873827e0138ab0fdaaf450


bluetooth: HSP/HFP mSBC profile broken with QCA6174
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215576-62941@https.bugzilla.kernel.org//
https://lore.kernel.org/linux-bluetooth/bug-215576-62941@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@kernel.org, 27 days ago; 11 activities, latest 7 days ago.
Introduced in b2af264ad3af (v5.16-rc1)

2 patch postings are associated with this regression, the latest is this:
* [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
  https://lore.kernel.org/linux-bluetooth/bug-215576-62941-2nprEl3omz@https.bugzilla.kernel.org%2F/
  15 days ago, by bugzilla-daemon@kernel.org

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215576


==================================================================================
older cycles (..v5.15), culprit identified, with activity in the past three months
==================================================================================


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 83 days ago; 16 activities, latest 0 days ago.
Introduced in dfeae1073583 (v4.18-rc1)

Recent activities from: Tokunori Ikegami (3), Ahmad Fatoum (1), Vignesh
  Raghavendra (1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH v2] mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N
  https://lore.kernel.org/stable/20220306153213.411425-1-ikegami.t@gmail.com/
  0 days ago, by Tokunori Ikegami; thread monitored.

Noteworthy links:
* [PATCH] mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N
  https://lore.kernel.org/stable/20220214182011.8493-1-ikegami.t@gmail.com/
  20 days ago, by Tokunori Ikegami; thread monitored.


[ *NEW* ] memory corruption on Atmel SAMA5D31
---------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/
https://lore.kernel.org/lkml/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/

By Peter Rosin, 3 days ago; 10 activities, latest 1 days ago.
Introduced in f9aa460672c9 (v5.11-rc1)

Recent activities from: Peter Rosin (5), Saravana Kannan (3),
  Tudor.Ambarus@microchip.com (2)


btrfs: deadlocks in dedupe
--------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 86 days ago; 15 activities, latest 16 days ago; poked 0 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 79 days ago; 19 activities, latest 17 days ago; poked 2 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

One patch associated with this regression:
* Patch "ARM: dts: gpio-ranges property is now required" has been added to the 5.4-stable tree
  https://lore.kernel.org/linux-arm-kernel/16432993096685@kroah.com/
  38 days ago, by gregkh@linuxfoundation.org


drm: amdgpu: Too-low frequency limit for AMD GPU PCI-passed-through to Windows VM
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/87ee57c8fu.fsf@turner.link/
https://lore.kernel.org/lkml/87ee57c8fu.fsf@turner.link/

By James D. Turner, 48 days ago; 19 activities, latest 18 days ago; poked 0 days ago.
Introduced in f9b7f3703ff9 (v5.14-rc1)


Intel TGL notebook no longer enters power states deeper than PC2
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/
https://lore.kernel.org/regressions/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/

By MarcelHB, 45 days ago; 19 activities, latest 24 days ago.
Introduced in e5ad96f388b7 (v5.15-rc1)

One patch associated with this regression:
* Re: [PATCH] nvme/pci: default to simple suspend
  https://lore.kernel.org/linux-nvme/20220207160655.GB635727@dhcp-10-100-145-180.wdc.com/
  27 days ago, by Keith Busch

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215467
* [Bug] nvme blocks PC10 since v5.15 - bisected
  https://lore.kernel.org/lkml/CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com/
  44 days ago, by Rafael J. Wysocki; thread monitored.
* [PATCH] nvme/pci: default to simple suspend
  https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/
  33 days ago, by Keith Busch; thread monitored.


=============================================================================
older cycles (..v5.15), unkown culprit, with activity in the past three weeks
=============================================================================


Regression in workingset_refault latency on 5.15
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+wXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com/
https://lore.kernel.org/linux-mm/CA%2BwXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com/

By Daniel Dao, 11 days ago; 49 activities, latest 1 days ago.
Introduced in v3.0..v5.15.19

Recent activities from: Shakeel Butt (11), Ivan Babrou (8), Michal
  Koutný (3), Andrew Morton (1), Frank Hofmann (1), Michal Hocko (1)

8 patch postings are associated with this regression, the latest is this:
* + memcg-sync-flush-only-if-periodic-flush-is-delayed.patch added to -mm tree
  https://lore.kernel.org/stable/20220304235350.5043FC340E9@smtp.kernel.org/
  1 days ago, by Andrew Morton; thread monitored.

Noteworthy links:
* [PATCH] memcg: async flush memcg stats from perf sensitive codepaths
  https://lore.kernel.org/stable/20220226002412.113819-1-shakeelb@google.com/
  8 days ago, by Shakeel Butt; thread monitored.
* [PATCH] memcg: sync flush only if periodic flush is delayed
  https://lore.kernel.org/stable/20220304184040.1304781-1-shakeelb@google.com/
  2 days ago, by Shakeel Butt; thread monitored.


cifs: Failure to access cifs mount of samba share after resume from sleep
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAFrh3J9soC36+BVuwHB=g9z_KB5Og2+p2_W+BBoBOZveErz14w@mail.gmail.com/
https://lore.kernel.org/linux-cifs/CAFrh3J9soC36%2BBVuwHB=g9z_KB5Og2%2Bp2_W%2BBBoBOZveErz14w@mail.gmail.com/

By Satadru Pramanik, 7 days ago; 10 activities, latest 2 days ago.
Introduced in v5.16.11..v5.17-rc5

Recent activities from: Satadru Pramanik (6), Shyam Prasad N (2), Steve
  French (1)


md: unable to handle page fault while running badblocks (fsck.ext4 -c) on a raid5 md array
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info/
https://lore.kernel.org/lkml/53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info/

By Dominik Mierzejewski, 12 days ago; 4 activities, latest 2 days ago.
Introduced in v5.13..v5.14.10

Recent activities from: Song Liu (2), Dominik Mierzejewski (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215605


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


backlight: Intel_backlight does not work after updating from 5.10.89 to latest 5.15.17
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/
https://lore.kernel.org/regressions/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/

By Filippo Falezza, 34 days ago; 1 activities, latest 34 days ago.
Introduced in v5.10.89..v5.15.17

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215553


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164598944963.346832.10219407090470852309@leemhuis.info

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
