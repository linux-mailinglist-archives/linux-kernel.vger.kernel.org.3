Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B26468CAE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhLESZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhLESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:25:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220CEC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 10:21:54 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mtw92-0000M1-8J; Sun, 05 Dec 2021 19:21:52 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2021-12-05]
Date:   Sun,  5 Dec 2021 18:21:51 +0000
Message-Id: <163872839745.395685.15301798356990039860@leemhuis.info>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1638728514;1dbd22c8;
X-HE-SMSGID: 1mtw92-0000M1-8J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 15 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.15.. aka v5.16-rc), culprit identified
========================================================


[ *NEW* ] 5-10% increase in IO latencies with nohz balance patch
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YaUH5GFFoLiS4/3/@localhost.localdomain/
https://lore.kernel.org/lkml/YaUH5GFFoLiS4/3/@localhost.localdomain/

By Josef Bacik, 6 days ago; 7 activities, latest 1 days ago.
Introduced in 7fd7a9e0caba (v5.16-rc1)

Recent activities from: Josef Bacik (5), Valentin Schneider (2)


====================================================
current cycle (v5.15.. aka v5.16-rc), unkown culprit
====================================================


mm: LTP/memcg testcase regression induced by 8cd7c588decf..66ce520bb7c2 series
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/

By Mike Galbraith, 14 days ago; 58 activities, latest 1 days ago.
Introduced in 8cd7c588decf..66ce520bb7c2 (v5.15..v5.16-rc1)

Recent activities from: Mel Gorman (16), Mike Galbraith (9), Alexey
  Avramov (5), Shakeel Butt (3), Darrick J. Wong (2), kernel test
  robot (2)

10 patch postings are associated with this regression, the latest is this:
* [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211202150614.22440-1-mgorman@techsingularity.net/
  3 days ago, by Mel Gorman; thread monitored.

Noteworthy links:
* Related regression, likely to be fixed by the same patch
  https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/
  12 days ago, by Alexey Avramov; link later added and described by Thorsten Leemhuis
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211125151853.8540-1-mgorman@techsingularity.net/
  10 days ago, by Mel Gorman; thread monitored.
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211202131842.9217-1-mgorman@techsingularity.net/
  3 days ago, by Mel Gorman; thread monitored.


mm: reclaim_throttle leads to stall in near-OOM conditions
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211124011954.7cab9bb4@mail.inbox.lv/
https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/

By Alexey Avramov, 12 days ago; 12 activities, latest 7 days ago.
Introduced in v5.15..v5.16-rc1

4 patch postings are associated with this regression, the latest is this:
* Re: mm: 5.16 regression: reclaim_throttle leads to stall in near-OOM conditions
  https://lore.kernel.org/lkml/20211126162416.GK3366@techsingularity.net/
  9 days ago, by Mel Gorman

Noteworthy links:
* Related regression, likely to be fixed by the same patch
  https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
  14 days ago, by Mike Galbraith; link later added and described by Thorsten Leemhuis
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211125151853.8540-1-mgorman@techsingularity.net/
  10 days ago, by Mel Gorman; thread monitored.


=========================================================================================
previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
=========================================================================================


Kernel 5.15 reboots / freezes upon ifup/ifdown
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de/
https://lore.kernel.org/stable/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de/

By Stefan Dietrich, 11 days ago; 16 activities, latest 2 days ago.
Introduced in a90ec8483732 (v5.15-rc1)

Recent activities from: Vinicius Costa Gomes (4), Stefan Dietrich (1),
  Greg KH (1)

One patch associated with this regression:
* [PATCH] igc: Avoid possible deadlock during suspend/resume
  https://lore.kernel.org/stable/20211201185731.236130-1-vinicius.gomes@intel.com/
  3 days ago, by Vinicius Costa Gomes


net: kernel hangs during power down
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211124144505.31e15716@hermes.local/
https://lore.kernel.org/netdev/20211124144505.31e15716@hermes.local/

By Stephen Hemminger, 10 days ago; 14 activities, latest 4 days ago.
Introduced in f32a21376573 (v5.15-rc1)

Recent activities from: Heiner Kallweit (4), Jakub Kicinski (3), Stephen
  Hemminger (1)

Noteworthy links:
* [PATCH net] igb: fix deadlock caused by taking RTNL in RPM resume path
  https://lore.kernel.org/netdev/6bb28d2f-4884-7696-0582-c26c35534bae@gmail.com/
  5 days ago, by Heiner Kallweit; thread monitored.
* https://bugzilla.kernel.org/show_bug.cgi?id=215129


drm/amd: AMD RX 6700 XT - Fails to resume after screen blank
------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk/
https://lore.kernel.org/regressions/99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk/

By Mark Boddington, 10 days ago; 3 activities, latest 9 days ago.
Introduced in 61d861cf4785 (v5.15-rc1)


==================================================================================
older cycles (..v5.14), culprit identified, with activity in the past three months
==================================================================================


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 37 days ago; 16 activities, latest 1 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Recent activities from: Leo Li (3), Joakim Tjernlund (3), Eugene
  Bordenkircher (2)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  36 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  36 days ago, by Joakim Tjernlund


bluetooth: "Query LE tx power on startup" broke Bluetooth on MacBookPro16,1
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com/
https://lore.kernel.org/regressions/4970a940-211b-25d6-edab-21a815313954@protonmail.com/

By Orlando Chamberlain, 67 days ago; 84 activities, latest 1 days ago.
Introduced in 7c395ea521e6 (v5.11-rc1)

Recent activities from: Aditya Garg (38), Marcel Holtmann (8), Greg
  KH (6), Orlando Chamberlain (1), Thorsten Leemhuis (1)

35 patch postings are associated with this regression, the latest is this:
* [PATCH v10 2/2] btbcm: disable read tx power for some Macs with the T2 Security chip
  https://lore.kernel.org/stable/51575680-E9C3-4962-A3C4-ADCBD6DBCA00@live.com/
  3 days ago, by Aditya Garg


PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/
https://lore.kernel.org/linux-pci/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/

By Stéphane Graber, 17 days ago; 9 activities, latest 3 days ago.
Introduced in 6dce5aa59e0b (v5.5-rc1)

Fix incoming:
* PCI: xgene: Fix IB window setup
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=c7a75d07827a1f33d566e18e6098379cc2a0c2b2


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 8 days ago; 19 activities, latest 4 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
  602 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  530 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
  493 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
  409 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
  349 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


wireless AP (Raspberry Pi with rt2x00usb) crashes every hour or so
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211118132556.GD334428@darkstar.musicnaut.iki.fi/
https://lore.kernel.org/lkml/20211118132556.GD334428@darkstar.musicnaut.iki.fi/

By Aaro Koskinen, 17 days ago; 6 activities, latest 6 days ago.
Introduced in 03c3911d2d67 (v5.14-rc1)

Fix incoming:
* mac80211: fix rate control for retransmitted frames
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=18688c80ad8a8dd50523dc9276e929932cac86d4


Ralink RT2800 kernel deference issue since kernel 5.14
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net/
https://lore.kernel.org/linux-wireless/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net/

By Robert W, 22 days ago; 6 activities, latest 6 days ago.
Introduced in 03c3911d2d67 (v5.14-rc1)

Fix incoming:
* mac80211: fix rate control for retransmitted frames
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=18688c80ad8a8dd50523dc9276e929932cac86d4


mhi: ath11k resume fails on some devices
----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/871r5p0x2u.fsf@codeaurora.org/
https://lore.kernel.org/regressions/871r5p0x2u.fsf@codeaurora.org/

By Kalle Valo, 80 days ago; 23 activities, latest 17 days ago.
Introduced in 020d3b26c07a (v5.13-rc1)


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

By Francesco Magliocca, 170 days ago; 5 activities, latest 35 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)

Noteworthy links:
* Bug in Memory Layout of rx_desc for QCA6174
  https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com/
  37 days ago, by Francesco Magliocca; thread monitored.


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


idle power increased from ~20 to ~28 watts
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/
https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/

By Idzibear, 34 days ago; 3 activities, latest 34 days ago.
Introduced in v5.14..v5.15


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report.
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
