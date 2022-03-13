Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43AC4D7777
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 19:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiCMSbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiCMSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 14:31:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4AE1EEF1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 11:30:04 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nTSyf-0001nK-GV; Sun, 13 Mar 2022 19:30:01 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report for mainline [2022-03-13]
Date:   Sun, 13 Mar 2022 18:30:00 +0000
Message-Id: <164719604221.161559.15456635663646196218@leemhuis.info>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1647196204;6d3c391e;
X-HE-SMSGID: 1nTSyf-0001nK-GV
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

From my side things look fine right now; the only regression in mainline
regzbot and I are aware of is the one with bnx2x and firmware loading
from the initramfs, which you were CCed on that needs more time to get
addressed, as the changes got backported to stable already:

https://lore.kernel.org/stable/ea05bcab-fe72-4bc2-3337-460888b2c44e@molgen.mpg.de/
https://lore.kernel.org/all/20220311002912.437871-1-kuba@kernel.org/

One report came in on Friday that looks a lot like a regression, but
that is not confirmed yet:

Bug 215673 - fsx dio testing get BAD DATA on NFS
https://bugzilla.kernel.org/show_bug.cgi?id!5673

Nothing else from my side.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 13 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.16.. aka v5.17-rc), culprit identified
========================================================


[ *NEW* ] firmware now as to be in the initramfs
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/46f2d9d9-ae7f-b332-ddeb-b59802be2bab@molgen.mpg.de/
https://lore.kernel.org/stable/46f2d9d9-ae7f-b332-ddeb-b59802be2bab@molgen.mpg.de/

By Paul Menzel, 4 days ago; 12 activities, latest 2 days ago.
Introduced in b7a49f73059f (v5.17-rc1)

Recent activities from: Paul Menzel (4), Manish Chopra (4), Linus
  Torvalds (2), Greg KH (1), Jakub Kicinski (1)

Noteworthy links:
* Re: [PATCH v2 net-next 1/2] bnx2x: Utilize firmware 7.13.21.0
  https://lore.kernel.org/stable/ea05bcab-fe72-4bc2-3337-460888b2c44e@molgen.mpg.de/
  4 days ago, by Paul Menzel; thread monitored.


=========================================================================================
previous cycle (v5.15..v5.16), culprit identified, with activity in the past three months
=========================================================================================


bluetooth: HSP/HFP mSBC profile broken with QCA6174
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215576-62941@https.bugzilla.kernel.org//
https://lore.kernel.org/linux-bluetooth/bug-215576-62941@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@kernel.org, 34 days ago; 18 activities, latest 4 days ago.
Introduced in b2af264ad3af (v5.16-rc1)

Recent activities from: bugzilla-daemon@kernel.org (1)

2 patch postings are associated with this regression, the latest is this:
* [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
  https://lore.kernel.org/linux-bluetooth/bug-215576-62941-2nprEl3omz@https.bugzilla.kernel.org%2F/
  22 days ago, by bugzilla-daemon@kernel.org

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215576
* [RFC] Bluetooth: don't use ESCO setup for BT_VOICE
  https://lore.kernel.org/linux-bluetooth/20220227163430.24694-1-pav@iki.fi/
  14 days ago, by Pauli Virtanen; thread monitored.
* [RFC] Bluetooth: HCI: Add HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN quirk
  https://lore.kernel.org/linux-bluetooth/20220302225049.432025-1-luiz.dentz@gmail.com/
  10 days ago, by Luiz Augusto von Dentz; thread monitored.


==================================================================================
older cycles (..v5.15), culprit identified, with activity in the past three months
==================================================================================


memory corruption on Atmel SAMA5D31
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/
https://lore.kernel.org/lkml/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/

By Peter Rosin, 10 days ago; 17 activities, latest 3 days ago.
Introduced in f9aa460672c9 (v5.11-rc1)

Recent activities from: Peter Rosin (5), Nicolas Ferre (1),
  Tudor.Ambarus@microchip.com (1)

One patch associated with this regression:
* Re: Regression: memory corruption on Atmel SAMA5D31
  https://lore.kernel.org/lkml/6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se/
  3 days ago, by Peter Rosin


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 90 days ago; 22 activities, latest 4 days ago.
Introduced in dfeae1073583 (v4.18-rc1)

Recent activities from: Ahmad Fatoum (3), Tokunori Ikegami (2), Vignesh
  Raghavendra (1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH v2] mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N
  https://lore.kernel.org/stable/20220306153213.411425-1-ikegami.t@gmail.com/
  7 days ago, by Tokunori Ikegami; thread monitored.

Noteworthy links:
* [PATCH] mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N
  https://lore.kernel.org/stable/20220214182011.8493-1-ikegami.t@gmail.com/
  27 days ago, by Tokunori Ikegami; thread monitored.


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 86 days ago; 21 activities, latest 6 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

Fix incoming:
* https://lore.kernel.org/stable/28ebe79a-6e94-4b1b-c4e8-291e614327b0@leemhuis.info/


drm: amdgpu: Too-low frequency limit for AMD GPU PCI-passed-through to Windows VM
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/87ee57c8fu.fsf@turner.link/
https://lore.kernel.org/lkml/87ee57c8fu.fsf@turner.link/

By James D. Turner, 55 days ago; 20 activities, latest 6 days ago.
Introduced in f9b7f3703ff9 (v5.14-rc1)

Recent activities from: James Turner (1)


Intel TGL notebook no longer enters power states deeper than PC2
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/
https://lore.kernel.org/regressions/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/

By MarcelHB, 52 days ago; 19 activities, latest 30 days ago.
Introduced in e5ad96f388b7 (v5.15-rc1)

One patch associated with this regression:
* Re: [PATCH] nvme/pci: default to simple suspend
  https://lore.kernel.org/linux-nvme/20220207160655.GB635727@dhcp-10-100-145-180.wdc.com/
  34 days ago, by Keith Busch

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215467
* [Bug] nvme blocks PC10 since v5.15 - bisected
  https://lore.kernel.org/lkml/CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com/
  50 days ago, by Rafael J. Wysocki; thread monitored.
* [PATCH] nvme/pci: default to simple suspend
  https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/
  40 days ago, by Keith Busch; thread monitored.


====================================================================================
previous cycle (v5.15..v5.16), unkown culprit, with activity in the past three weeks
====================================================================================


[ *NEW* ] md: Raid6 check performance regression
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/0eb91a43-a153-6e29-14b6-65f97b9f3d99@nuclearwinter.com/
https://lore.kernel.org/linux-raid/0eb91a43-a153-6e29-14b6-65f97b9f3d99@nuclearwinter.com/

By Larkin Lowrey, 6 days ago; 13 activities, latest 1 days ago.
Introduced in v5.15..v5.16

Recent activities from: Song Liu (3), Jens Axboe (3), Roger Heflin (2),
  Larkin Lowrey (2), Wilson Jonathan (2), Thorsten Leemhuis (1)

3 patch postings are associated with this regression, the latest is this:
* [PATCH 2/2] block: flush plug based on hardware and software queue order
  https://lore.kernel.org/linux-raid/20220311173041.165948-3-axboe@kernel.dk/
  2 days ago, by Jens Axboe

Noteworthy links:
* [PATCHSET 0/2] Fix raid rebuild performance regression
  https://lore.kernel.org/linux-raid/20220311173041.165948-1-axboe@kernel.dk/
  2 days ago, by Jens Axboe; thread monitored.


net: wireless: rtw_8822ce: Wifi connection doesn't really work anymore
----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com/
https://lore.kernel.org/linux-wireless/CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com/

By Nico Sneck, 26 days ago; 5 activities, latest 6 days ago.
Introduced in v5.15..v5.16

Recent activities from: Kalle Valo (1)


=============================================================================
older cycles (..v5.15), unkown culprit, with activity in the past three weeks
=============================================================================


Regression in workingset_refault latency on 5.15
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+wXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com/
https://lore.kernel.org/linux-mm/CA%2BwXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com/

By Daniel Dao, 18 days ago; 57 activities, latest 0 days ago.
Introduced in v3.0..v5.15.19

Recent activities from: Andrew Morton (4), Shakeel Butt (2), Hillf
  Danton (1), Michal Koutný (1)

12 patch postings are associated with this regression, the latest is this:
* Re: [PATCH] memcg: sync flush only if periodic flush is delayed
  https://lore.kernel.org/lkml/20220313025050.1463-1-hdanton@sina.com/
  0 days ago, by Hillf Danton

Noteworthy links:
* [PATCH] memcg: async flush memcg stats from perf sensitive codepaths
  https://lore.kernel.org/stable/20220226002412.113819-1-shakeelb@google.com/
  15 days ago, by Shakeel Butt; thread monitored.
* [PATCH] memcg: sync flush only if periodic flush is delayed
  https://lore.kernel.org/stable/20220304184040.1304781-1-shakeelb@google.com/
  8 days ago, by Shakeel Butt; thread monitored.
* + memcg-sync-flush-only-if-periodic-flush-is-delayed.patch added to -mm tree
  https://lore.kernel.org/stable/20220304235350.5043FC340E9@smtp.kernel.org/
  8 days ago, by Andrew Morton; thread monitored.
* [failures] memcg-sync-flush-only-if-periodic-flush-is-delayed.patch removed from -mm tree
  https://lore.kernel.org/stable/20220307024504.5EA2AC340EC@smtp.kernel.org/
  6 days ago, by Andrew Morton; thread monitored.
* + memcg-sync-flush-only-if-periodic-flush-is-delayed.patch added to -mm tree
  https://lore.kernel.org/stable/20220307034042.A64CEC340F3@smtp.kernel.org/
  6 days ago, by Andrew Morton; thread monitored.
* + memcg-sync-flush-only-if-periodic-flush-is-delayed.patch added to -mm tree
  https://lore.kernel.org/stable/20220307034236.DC2D6C340F3@smtp.kernel.org/
  6 days ago, by Andrew Morton; thread monitored.


cifs: Failure to access cifs mount of samba share after resume from sleep
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAFrh3J9soC36+BVuwHB=g9z_KB5Og2+p2_W+BBoBOZveErz14w@mail.gmail.com/
https://lore.kernel.org/linux-cifs/CAFrh3J9soC36%2BBVuwHB=g9z_KB5Og2%2Bp2_W%2BBBoBOZveErz14w@mail.gmail.com/

By Satadru Pramanik, 14 days ago; 10 activities, latest 9 days ago.
Introduced in v5.16.11..v5.17-rc5


md: unable to handle page fault while running badblocks (fsck.ext4 -c) on a raid5 md array
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info/
https://lore.kernel.org/lkml/53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info/

By Dominik Mierzejewski, 19 days ago; 4 activities, latest 9 days ago.
Introduced in v5.13..v5.14.10

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215605


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


backlight: Intel_backlight does not work after updating from 5.10.89 to latest 5.15.17
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/
https://lore.kernel.org/regressions/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/

By Filippo Falezza, 41 days ago; 1 activities, latest 41 days ago.
Introduced in v5.10.89..v5.15.17

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215553


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164659571791.547857.13375280613389065406@leemhuis.info

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
