Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A972F471CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhLLUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:39:33 -0500
Received: from wp530.webpack.hosteurope.de ([80.237.130.52]:40674 "EHLO
        wp530.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230388AbhLLUjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:39:32 -0500
X-Greylist: delayed 1586 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 15:39:32 EST
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mwVBL-0000PL-OL; Sun, 12 Dec 2021 21:10:51 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2021-12-12]
Date:   Sun, 12 Dec 2021 20:10:51 +0000
Message-Id: <163933981285.486507.5806345036032364969@leemhuis.info>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1639341572;6ed3dcf9;
X-HE-SMSGID: 1mwVBL-0000PL-OL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 19 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.15.. aka v5.16-rc), culprit identified
========================================================


5-10% increase in IO latencies with nohz balance patch
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YaUH5GFFoLiS4/3/@localhost.localdomain/
https://lore.kernel.org/lkml/YaUH5GFFoLiS4/3/@localhost.localdomain/

By Josef Bacik, 13 days ago; 10 activities, latest 3 days ago.
Introduced in 7fd7a9e0caba (v5.16-rc1)

Recent activities from: Valentin Schneider (2), Josef Bacik (1)


[ *NEW* ] fbdev/efifb: Monitors no longer sleep (amdgpu dual monitor setup)
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/
https://lore.kernel.org/linux-fbdev/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/

By Brandon Nielsen, 5 days ago; 2 activities, latest 5 days ago.
Introduced in 55285e21f045 (v5.16-rc1)

Recent activities from: Geert Uytterhoeven (1), Brandon Nielsen (1)


====================================================
current cycle (v5.15.. aka v5.16-rc), unkown culprit
====================================================


mm: LTP/memcg testcase regression induced by 8cd7c588decf..66ce520bb7c2 series
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/

By Mike Galbraith, 21 days ago; 27 activities, latest 3 days ago.
Introduced in 8cd7c588decf..66ce520bb7c2 (v5.15..v5.16-rc1)

Recent activities from: Mel Gorman (3), Shakeel Butt (2), Hugh
  Dickins (1)

3 patch postings are associated with this regression, the latest is this:
* [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211202150614.22440-1-mgorman@techsingularity.net/
  10 days ago, by Mel Gorman; thread monitored.

Noteworthy links:
* Related regression, likely to be fixed by the same patch
  https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/
  19 days ago, by Alexey Avramov; link later added and described by Thorsten Leemhuis
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211202131842.9217-1-mgorman@techsingularity.net/
  10 days ago, by Mel Gorman; thread monitored.


mm: reclaim_throttle leads to stall in near-OOM conditions
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211124011954.7cab9bb4@mail.inbox.lv/
https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/

By Alexey Avramov, 19 days ago; 14 activities, latest 10 days ago.
Introduced in v5.15..v5.16-rc1

6 patch postings are associated with this regression, the latest is this:
* [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211202150614.22440-1-mgorman@techsingularity.net/
  10 days ago, by Mel Gorman; thread monitored.

Noteworthy links:
* Related regression, likely to be fixed by the same patch
  https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
  21 days ago, by Mike Galbraith; link later added and described by Thorsten Leemhuis
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211125151853.8540-1-mgorman@techsingularity.net/
  17 days ago, by Mel Gorman; thread monitored.
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211202131842.9217-1-mgorman@techsingularity.net/
  10 days ago, by Mel Gorman; thread monitored.


=========================================================================================
previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
=========================================================================================


[ *NEW* ] drm: nouveau: annoying black flickering in some applications with KDE Plasma with Xorg
------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/da142fb9-07d7-24fe-4533-0247b8d16cdd@sfritsch.de/
https://lore.kernel.org/dri-devel/da142fb9-07d7-24fe-4533-0247b8d16cdd@sfritsch.de/

By Stefan Fritsch, 8 days ago; 13 activities, latest 1 days ago.
Introduced in 3e1ad79bf661 (v5.15-rc1)

Recent activities from: Christian König (4), Stefan Fritsch (3), Dan
  Moulding (3), Daniel Vetter (1), Karol Herbst (1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH] drm/nouveau: wait for the exclusive fence after the shared ones v2
  https://lore.kernel.org/dri-devel/20211209102335.18321-1-christian.koenig@amd.com/
  3 days ago, by Christian König; thread monitored.


Kernel 5.15 reboots / freezes upon ifup/ifdown
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de/
https://lore.kernel.org/stable/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de/

By Stefan Dietrich, 18 days ago; 21 activities, latest 1 days ago.
Introduced in a90ec8483732 (v5.15-rc1)

Recent activities from: Stefan Dietrich (3), Vinicius Costa Gomes (1),
  Thorsten Leemhuis (1)

One patch associated with this regression:
* [PATCH] igc: Avoid possible deadlock during suspend/resume
  https://lore.kernel.org/stable/20211201185731.236130-1-vinicius.gomes@intel.com/
  11 days ago, by Vinicius Costa Gomes


[ *NEW* ] Bluetooth not working on 5.15+ since "Bluetooth: Move shutdown callback before flushing tx and rx queue"
------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com/
https://lore.kernel.org/lkml/CAJvGw%2BAJ5dHSb50RtJHnjbhMVQa%2BrJgYznFV4t-iaO0qx%2BW-jw@mail.gmail.com/

By coldolt, 2 days ago; 3 activities, latest 2 days ago.
Introduced in 0ea53674d07f (v5.15-rc1)

Recent activities from: Thorsten Leemhuis (1), An, Tedd (1), coldolt (1)


net: kernel hangs during power down
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211124144505.31e15716@hermes.local/
https://lore.kernel.org/netdev/20211124144505.31e15716@hermes.local/

By Stephen Hemminger, 17 days ago; 14 activities, latest 11 days ago.
Introduced in f32a21376573 (v5.15-rc1)

Fix incoming:
* https://lore.kernel.org/regressions/cb51a8cc-7c43-745e-e075-398eee47b071@leemhuis.info/


==================================================================================
older cycles (..v5.14), culprit identified, with activity in the past three months
==================================================================================


[ *NEW* ] usb: gadget: atmel: ethernet over USB Gadget not recognized anymore after disconnect and reconnect
------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211211183650.12183-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/regressions/20211211183650.12183-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 1 days ago; 1 activities, latest 1 days ago.
Introduced in 70a7f8be8598 (v5.2-rc1)

Recent activities from: Marcelo Roberto Jimenez (1)


[ *NEW* ] btrfs: deadlocks in dedupe
------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 2 days ago; 1 activities, latest 2 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)

Recent activities from: Zygo Blaxell (1)


[ *NEW* ] drm: amdgpu: apps that need amdgpu do not start after system is woken from suspend
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1295184560.182511.1639075777725@mail.yahoo.com/
https://lore.kernel.org/linux-i2c/1295184560.182511.1639075777725@mail.yahoo.com/

By Tareque Md.Hanif, 3 days ago; 1 activities, latest 3 days ago.
Introduced in 5a7b95fb993e (v5.14-rc1)

Recent activities from: Tareque Md.Hanif (1)


bluetooth: "Query LE tx power on startup" broke Bluetooth on MacBookPro16,1
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com/
https://lore.kernel.org/regressions/4970a940-211b-25d6-edab-21a815313954@protonmail.com/

By Orlando Chamberlain, 74 days ago; 86 activities, latest 4 days ago.
Introduced in 7c395ea521e6 (v5.11-rc1)

Fix incoming:
* Bluetooth: btbcm: disable read tx power for some Macs with the T2 Security chip
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=801b4c027b44a185292007d3cf7513999d644723


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 15 days ago; 20 activities, latest 6 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Recent activities from: Sebastian Bachmann (1)

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
  609 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  537 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
  500 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
  416 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
  356 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 44 days ago; 16 activities, latest 8 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  43 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  43 days ago, by Joakim Tjernlund


PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/
https://lore.kernel.org/linux-pci/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/

By Stéphane Graber, 24 days ago; 9 activities, latest 10 days ago.
Introduced in 6dce5aa59e0b (v5.5-rc1)

Fix incoming:
* PCI: xgene: Fix IB window setup
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=c7a75d07827a1f33d566e18e6098379cc2a0c2b2


wireless AP (Raspberry Pi with rt2x00usb) crashes every hour or so
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211118132556.GD334428@darkstar.musicnaut.iki.fi/
https://lore.kernel.org/lkml/20211118132556.GD334428@darkstar.musicnaut.iki.fi/

By Aaro Koskinen, 24 days ago; 6 activities, latest 13 days ago.
Introduced in 03c3911d2d67 (v5.14-rc1)

Fix incoming:
* mac80211: fix rate control for retransmitted frames
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=18688c80ad8a8dd50523dc9276e929932cac86d4


Ralink RT2800 kernel deference issue since kernel 5.14
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net/
https://lore.kernel.org/linux-wireless/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net/

By Robert W, 29 days ago; 6 activities, latest 13 days ago.
Introduced in 03c3911d2d67 (v5.14-rc1)

Fix incoming:
* mac80211: fix rate control for retransmitted frames
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=18688c80ad8a8dd50523dc9276e929932cac86d4


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

By Francesco Magliocca, 177 days ago; 5 activities, latest 42 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)

Noteworthy links:
* Bug in Memory Layout of rx_desc for QCA6174
  https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com/
  44 days ago, by Francesco Magliocca; thread monitored.


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


idle power increased from ~20 to ~28 watts
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/
https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/

By Idzibear, 41 days ago; 3 activities, latest 41 days ago.
Introduced in v5.14..v5.15


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/163872839745.395685.15301798356990039860@leemhuis.info

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
