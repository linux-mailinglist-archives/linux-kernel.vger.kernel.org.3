Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABBD4E1C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244565AbiCTQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbiCTQ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:28:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B0B19BFE4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 09:26:53 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nVyOH-0003lr-Fy; Sun, 20 Mar 2022 17:26:49 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-03-20]
Date:   Sun, 20 Mar 2022 16:26:48 +0000
Message-Id: <164779309771.379023.10823585483674878438@leemhuis.info>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1647793615;95ef4dc5;
X-HE-SMSGID: 1nVyOH-0003lr-Fy
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

From my side things look normal right now. Regzbot is aware of three
(maybe just two) regressions in mainline:

* one in cifs that needs further tests
* one in hid/input where a patch exists, but needs polishing; and the
issue seems to affect only two Laptop models anyway
* one in DRM that might in fact be a problem already introduced in 5.11
(the report is not clear on this); the fix is in Linux-next
(27599aacbaef) for a few weeks already; for details see
https://bugzilla.kernel.org/show_bug.cgi?id!5678

Nothing else from my side.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 17 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.16.. aka v5.17-rc), culprit identified
========================================================


[ *NEW* ] HID: multitouch: right touchpad button is disabled on recent kernels
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/s5htubv32s8.wl-tiwai@suse.de/
https://lore.kernel.org/stable/s5htubv32s8.wl-tiwai@suse.de/

By Takashi Iwai, 2 days ago; 10 activities, latest 1 days ago.
Introduced in 37ef4c19b4c6 (v5.17-rc5)

Recent activities from: Takashi Iwai (4), José Expósito (3), kernel test
  robot (1), Thorsten Leemhuis (1), Benjamin Tissoires (1)

One patch associated with this regression:
* Re: [REGRESSION] Right touchpad button disabled on Dell 7750
  https://lore.kernel.org/stable/s5hh77v2uov.wl-tiwai@suse.de/
  2 days ago, by Takashi Iwai

Noteworthy links:
* https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/726#note_1303623


====================================================
current cycle (v5.16.. aka v5.17-rc), unkown culprit
====================================================


[ *NEW* ] "vmwgfx: probe of 0000:00:0f.0 failed with error -16" in guest
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/08e3a9b1-5ed3-be89-1d48-5d1061253789@leemhuis.info/
https://lore.kernel.org/dri-devel/08e3a9b1-5ed3-be89-1d48-5d1061253789@leemhuis.info/

By sander44, 2 days ago; 2 activities, latest 1 days ago.
Introduced in v5.16..v5.17-rc7

Recent activities from: Thorsten Leemhuis (2)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215678


cifs: Failure to access cifs mount of samba share after resume from sleep
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAFrh3J9soC36+BVuwHB=g9z_KB5Og2+p2_W+BBoBOZveErz14w@mail.gmail.com/
https://lore.kernel.org/linux-cifs/CAFrh3J9soC36%2BBVuwHB=g9z_KB5Og2%2Bp2_W%2BBBoBOZveErz14w@mail.gmail.com/

By Satadru Pramanik, 21 days ago; 19 activities, latest 2 days ago.
Introduced in v5.16..v5.17-rc5

Recent activities from: Satadru Pramanik (3), Shyam Prasad N (2), ronnie
  sahlberg (2), Steve French (1), Thorsten Leemhuis (1)


=========================================================================================
previous cycle (v5.15..v5.16), culprit identified, with activity in the past three months
=========================================================================================


[ *NEW* ] nvme: NVMe/writeback wb_workfn/blocked for more than 30 seconds
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/0a0b0127-8e5d-d6ca-52db-bf9937d6d887@leemhuis.info/
https://lore.kernel.org/regressions/0a0b0127-8e5d-d6ca-52db-bf9937d6d887@leemhuis.info/

By Imre Deak, 2 days ago; 1 activities, latest 2 days ago.
Introduced in 4f5022453acd (v5.16-rc1)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215679


bluetooth: HSP/HFP mSBC profile broken with QCA6174
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215576-62941@https.bugzilla.kernel.org//
https://lore.kernel.org/linux-bluetooth/bug-215576-62941@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@kernel.org, 40 days ago; 18 activities, latest 11 days ago.
Introduced in b2af264ad3af (v5.16-rc1)

2 patch postings are associated with this regression, the latest is this:
* [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
  https://lore.kernel.org/linux-bluetooth/bug-215576-62941-2nprEl3omz@https.bugzilla.kernel.org%2F/
  29 days ago, by bugzilla-daemon@kernel.org

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215576
* [RFC] Bluetooth: don't use ESCO setup for BT_VOICE
  https://lore.kernel.org/linux-bluetooth/20220227163430.24694-1-pav@iki.fi/
  20 days ago, by Pauli Virtanen; thread monitored.
* [RFC] Bluetooth: HCI: Add HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN quirk
  https://lore.kernel.org/linux-bluetooth/20220302225049.432025-1-luiz.dentz@gmail.com/
  17 days ago, by Luiz Augusto von Dentz; thread monitored.


==================================================================================
older cycles (..v5.15), culprit identified, with activity in the past three months
==================================================================================


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 93 days ago; 40 activities, latest 2 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

Fix incoming:
* Revert "gpio: Revert regression in sysfs-gpio (gpiolib.c)"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=56e337f2cf1326323844927a04e9dbce9a244835


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 97 days ago; 29 activities, latest 4 days ago.
Introduced in dfeae1073583 (v4.18-rc1)

Recent activities from: Tokunori Ikegami (5), Miquel Raynal (1), Vignesh
  Raghavendra (1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH v2] mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N
  https://lore.kernel.org/stable/20220306153213.411425-1-ikegami.t@gmail.com/
  14 days ago, by Tokunori Ikegami; thread monitored.

Noteworthy links:
* [PATCH] mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N
  https://lore.kernel.org/stable/20220214182011.8493-1-ikegami.t@gmail.com/
  33 days ago, by Tokunori Ikegami; thread monitored.


memory corruption on Atmel SAMA5D31
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/
https://lore.kernel.org/lkml/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/

By Peter Rosin, 17 days ago; 17 activities, latest 10 days ago.
Introduced in f9aa460672c9 (v5.11-rc1)

One patch associated with this regression:
* Re: Regression: memory corruption on Atmel SAMA5D31
  https://lore.kernel.org/lkml/6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se/
  10 days ago, by Peter Rosin


====================================================================================
previous cycle (v5.15..v5.16), unkown culprit, with activity in the past three weeks
====================================================================================


md: Raid6 check performance regression
--------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/0eb91a43-a153-6e29-14b6-65f97b9f3d99@nuclearwinter.com/
https://lore.kernel.org/linux-raid/0eb91a43-a153-6e29-14b6-65f97b9f3d99@nuclearwinter.com/

By Larkin Lowrey, 12 days ago; 14 activities, latest 3 days ago.
Introduced in v5.15..v5.16

Fix incoming:
* block: flush plug based on hardware and software queue order
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=26fed4ac4eab09c27fbae1859696cc38f0536407


[ *NEW* ] wireless: iwlwifi: Firmware crash frequently with firmware 36.ca7b901d.0 (8265-36.ucode)
--------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/915d6d66-4e42-8cbf-76bc-0f2f72d5e7d6@leemhuis.info/
https://lore.kernel.org/linux-wireless/915d6d66-4e42-8cbf-76bc-0f2f72d5e7d6@leemhuis.info/

By Udo Steinberg, 6 days ago; 1 activities, latest 6 days ago.
Introduced in v5.15..v5.16

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215635


=============================================================================
older cycles (..v5.15), unkown culprit, with activity in the past three weeks
=============================================================================


md: unable to handle page fault while running badblocks (fsck.ext4 -c) on a raid5 md array
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info/
https://lore.kernel.org/lkml/53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info/

By Dominik Mierzejewski, 26 days ago; 5 activities, latest 2 days ago.
Introduced in v5.13..v5.14.10

Recent activities from: Song Liu (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215605


[ *NEW* ] net: netfilter: Intermittent performance regression related to ipset
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/BY5PR13MB3604D24C813A042A114B639DEE109@BY5PR13MB3604.namprd13.prod.outlook.com/
https://lore.kernel.org/lkml/BY5PR13MB3604D24C813A042A114B639DEE109@BY5PR13MB3604.namprd13.prod.outlook.com/

By McLean, Patrick, 4 days ago; 2 activities, latest 3 days ago.
Introduced in v5.10..v5.15

Recent activities from: Jakub Kicinski (1), McLean, Patrick (1)


Regression in workingset_refault latency on 5.15
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+wXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com/
https://lore.kernel.org/linux-mm/CA%2BwXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com/

By Daniel Dao, 25 days ago; 60 activities, latest 3 days ago.
Introduced in v3.0..v5.15.19

Recent activities from: Michal Koutný (2), Shakeel Butt (1)

12 patch postings are associated with this regression, the latest is this:
* Re: [PATCH] memcg: sync flush only if periodic flush is delayed
  https://lore.kernel.org/lkml/20220313025050.1463-1-hdanton@sina.com/
  7 days ago, by Hillf Danton

Noteworthy links:
* [PATCH] memcg: async flush memcg stats from perf sensitive codepaths
  https://lore.kernel.org/stable/20220226002412.113819-1-shakeelb@google.com/
  22 days ago, by Shakeel Butt; thread monitored.
* [PATCH] memcg: sync flush only if periodic flush is delayed
  https://lore.kernel.org/stable/20220304184040.1304781-1-shakeelb@google.com/
  15 days ago, by Shakeel Butt; thread monitored.
* + memcg-sync-flush-only-if-periodic-flush-is-delayed.patch added to -mm tree
  https://lore.kernel.org/stable/20220304235350.5043FC340E9@smtp.kernel.org/
  15 days ago, by Andrew Morton; thread monitored.
* [failures] memcg-sync-flush-only-if-periodic-flush-is-delayed.patch removed from -mm tree
  https://lore.kernel.org/stable/20220307024504.5EA2AC340EC@smtp.kernel.org/
  13 days ago, by Andrew Morton; thread monitored.
* + memcg-sync-flush-only-if-periodic-flush-is-delayed.patch added to -mm tree
  https://lore.kernel.org/stable/20220307034042.A64CEC340F3@smtp.kernel.org/
  13 days ago, by Andrew Morton; thread monitored.
* + memcg-sync-flush-only-if-periodic-flush-is-delayed.patch added to -mm tree
  https://lore.kernel.org/stable/20220307034236.DC2D6C340F3@smtp.kernel.org/
  13 days ago, by Andrew Morton; thread monitored.


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


backlight: Intel_backlight does not work after updating from 5.10.89 to latest 5.15.17
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/
https://lore.kernel.org/regressions/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/

By Filippo Falezza, 48 days ago; 1 activities, latest 48 days ago.
Introduced in v5.10.89..v5.15.17

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215553


=======================================================
on back burner, but with activity since the last report
=======================================================


c7a75d07827a fixed 6dce5aa59e0b for XGene2, but that *further* broke XGene1
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Yf2wTLjmcRj+AbDv@xps13.dannf/
https://lore.kernel.org/stable/Yf2wTLjmcRj%2BAbDv@xps13.dannf/

By dann frazier, 43 days ago; 8 activities, latest 3 days ago.
Introduced in 6dce5aa59e0b (v5.5-rc1)

Recent activities from: Lorenzo Pieralisi (1)

One patch associated with this regression:
* Re: [PATCH] PCI: xgene: Fix IB window setup
  https://lore.kernel.org/stable/YgHFFIRT6E0j9TlX@xps13.dannf/
  40 days ago, by dann frazier


net: wireless: rtw_8822ce: Wifi connection doesn't really work anymore
----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com/
https://lore.kernel.org/linux-wireless/CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com/

By Nico Sneck, 33 days ago; 6 activities, latest 3 days ago.
Introduced in v5.15..v5.16

Recent activities from: Nico Sneck (1)


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 113 days ago; 26 activities, latest 5 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Fix incoming:
* Revert "ath: add support for special 0x0 regulatory domain"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=1ec7ed5163c70a0d040150d2279f932c7e7c143f


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164719604221.161559.15456635663646196218@leemhuis.info

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
