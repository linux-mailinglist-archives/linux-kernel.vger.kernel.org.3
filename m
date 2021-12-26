Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDAF47F8CA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhLZUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhLZUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 15:30:58 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E17C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:30:58 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1n1aAQ-0000RB-2G; Sun, 26 Dec 2021 21:30:54 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2021-12-26]
Date:   Sun, 26 Dec 2021 20:30:52 +0000
Message-Id: <164055061372.788592.14520202566843934212@leemhuis.info>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1640550658;c22b8d74;
X-HE-SMSGID: 1n1aAQ-0000RB-2G
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 24 regressions in linux-mainline. Find the
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
https://lore.kernel.org/lkml/YaUH5GFFoLiS4%2F3%2F@localhost.localdomain/

By Josef Bacik, 27 days ago; 11 activities, latest 4 days ago.
Introduced in 7fd7a9e0caba (v5.16-rc1)

Recent activities from: Valentin Schneider (1)


[ *NEW* ] RDMA/mlx5: Regression since v5.15-rc5: Kernel panic when called ib_dereg_mr
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com/
https://lore.kernel.org/linux-rdma/9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com/

By Tony Lu, 5 days ago; 5 activities, latest 4 days ago.
Introduced in f0ae4afe3d35 (v5.16-rc5)

Recent activities from: Tony Lu (2), Leon Romanovsky (2), Karsten
  Graul (1)

Noteworthy links:
* [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
  https://lore.kernel.org/lkml/f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com/
  5 days ago, by Leon Romanovsky; thread monitored.


fbdev/efifb: Monitors no longer sleep (amdgpu dual monitor setup)
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/
https://lore.kernel.org/linux-fbdev/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/

By Brandon Nielsen, 19 days ago; 4 activities, latest 9 days ago.
Introduced in 55285e21f045 (v5.16-rc1)

Noteworthy links:
* https://bugzilla.redhat.com/show_bug.cgi?id=2028613
* https://bugzilla.kernel.org/show_bug.cgi?id=215203


====================================================
current cycle (v5.15.. aka v5.16-rc), unkown culprit
====================================================


mm: reclaim_throttle leads to stall in near-OOM conditions
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211124011954.7cab9bb4@mail.inbox.lv/
https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/

By Alexey Avramov, 33 days ago; 21 activities, latest 3 days ago.
Introduced in v5.15..v5.16-rc1

Fix incoming:
* mm: vmscan: reduce throttling due to a failure to make progress
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=57af06179e3ef2359c3a5e1678edfe0363a0b551


mm: LTP/memcg testcase regression induced by 8cd7c588decf..66ce520bb7c2 series
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/

By Mike Galbraith, 35 days ago; 33 activities, latest 3 days ago.
Introduced in 8cd7c588decf..66ce520bb7c2 (v5.15..v5.16-rc1)

Fix incoming:
* mm: vmscan: reduce throttling due to a failure to make progress
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=57af06179e3ef2359c3a5e1678edfe0363a0b551


usb: ucsi_acpi: kernel NULL pointer dereference
-----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215117-208809@https.bugzilla.kernel.org//
https://lore.kernel.org/linux-usb/bug-215117-208809@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@bugzilla.kernel.org, 33 days ago; 13 activities, latest 4 days ago.
Introduced in v5.15..v5.16-rc1

Fix incoming:
* usb: typec: ucsi: Only check the contract if there is a connection
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=3f345e907a8e7c56fdebf7231cd67afc85d02aaa


=========================================================================================
previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
=========================================================================================


[ *NEW* ] cifs: unable to mount cifs 1.0 shares because support for NTLM and weaker authentication algorithms was removed
-------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/dce98c91-d28c-0f5a-b177-1f4275cf0f35@leemhuis.info/
https://lore.kernel.org/regressions/dce98c91-d28c-0f5a-b177-1f4275cf0f35@leemhuis.info/

By Thorsten Leemhuis, 3 days ago; 1 activities, latest 3 days ago.
Introduced in 76a3c92ec9e0 (v5.15-rc1)

Recent activities from: Thorsten Leemhuis (1)


Kernel 5.15 reboots / freezes upon ifup/ifdown
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de/
https://lore.kernel.org/stable/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de/

By Stefan Dietrich, 32 days ago; 26 activities, latest 3 days ago.
Introduced in a90ec8483732 (v5.15-rc1)

Recent activities from: Thorsten Leemhuis (1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH net v1] igc: Do not enable crosstimestamping for i225-V models
  https://lore.kernel.org/netdev/20211214003949.666642-1-vinicius.gomes@intel.com/
  12 days ago, by Vinicius Costa Gomes


drm: nouveau: annoying black flickering in some applications with KDE Plasma with Xorg
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/da142fb9-07d7-24fe-4533-0247b8d16cdd@sfritsch.de/
https://lore.kernel.org/dri-devel/da142fb9-07d7-24fe-4533-0247b8d16cdd@sfritsch.de/

By Stefan Fritsch, 22 days ago; 18 activities, latest 4 days ago.
Introduced in 3e1ad79bf661 (v5.15-rc1)

Fix incoming:
* drm/nouveau: wait for the exclusive fence after the shared ones v2
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=67f74302f45d5d862f22ced3297624e50ac352f0


drm: amdgpu: NUC8i7HVKVA crashes during system suspend
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215315-2300@https.bugzilla.kernel.org//
https://lore.kernel.org/dri-devel/bug-215315-2300@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@bugzilla.kernel.org, 13 days ago; 1 activities, latest 13 days ago.
Introduced in f7d6779df642 (v5.15-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215315


Bluetooth not working on 5.15+ since "Bluetooth: Move shutdown callback before flushing tx and rx queue"
--------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com/
https://lore.kernel.org/lkml/CAJvGw%2BAJ5dHSb50RtJHnjbhMVQa%2BrJgYznFV4t-iaO0qx%2BW-jw@mail.gmail.com/

By coldolt, 16 days ago; 3 activities, latest 16 days ago.
Introduced in 0ea53674d07f (v5.15-rc1)


==================================================================================
older cycles (..v5.14), culprit identified, with activity in the past three months
==================================================================================


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

By Francesco Magliocca, 191 days ago; 8 activities, latest 3 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)

Recent activities from: Francesco Magliocca (1), Kalle Valo (1)

One patch associated with this regression:
* [PATCH v2] ath10k: abstract htt_rx_desc structure
  https://lore.kernel.org/linux-wireless/20211216151823.68878-1-franciman12@gmail.com/
  10 days ago, by Francesco Magliocca; thread monitored.

Noteworthy links:
* Bug in Memory Layout of rx_desc for QCA6174
  https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com/
  58 days ago, by Francesco Magliocca; thread monitored.


usb: gadget: atmel: ethernet over USB Gadget not recognized anymore after disconnect and reconnect
--------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211211183650.12183-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/regressions/20211211183650.12183-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 15 days ago; 7 activities, latest 4 days ago.
Introduced in 70a7f8be8598 (v5.2-rc1)

Recent activities from: Cristian.Birsan@microchip.com (1), Greg Kroah-
  Hartman (1)


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 9 days ago; 7 activities, latest 5 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

Recent activities from: Marcelo Roberto Jimenez (3), Will McVicker (1),
  Geert Uytterhoeven (1), Bartosz Golaszewski (1)


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 29 days ago; 22 activities, latest 6 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Recent activities from: Nuno Oliveira (1), Kalle Valo (1)

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
  623 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  551 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
  514 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
  430 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
  370 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


fbdev: matroxfb: display black ans warns "the current input timing is not supported by the monitor display"
-----------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211218180035.200552-1-liuzx@knownsec.com/
https://lore.kernel.org/lkml/20211218180035.200552-1-liuzx@knownsec.com/

By Z. Liu, 8 days ago; 2 activities, latest 6 days ago.
Introduced in 11be60bd66d5 (v5.7-rc1)

Recent activities from: Geert Uytterhoeven (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215355


pci: the pci sysfs "rom" file has disappeared for VGA devices
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YbxqIyrkv3GhZVxx@intel.com/
https://lore.kernel.org/linux-pci/YbxqIyrkv3GhZVxx@intel.com/

By Ville Syrjälä, 9 days ago; 4 activities, latest 8 days ago.
Introduced in 527139d738d7 (v5.13-rc1)


btrfs: deadlocks in dedupe
--------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 16 days ago; 11 activities, latest 8 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 13 days ago; 2 activities, latest 11 days ago.
Introduced in dfeae1073583 (v4.18-rc1)


drm: amdgpu: apps that need amdgpu do not start after system is woken from suspend
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1295184560.182511.1639075777725@mail.yahoo.com/
https://lore.kernel.org/linux-i2c/1295184560.182511.1639075777725@mail.yahoo.com/

By Tareque Md.Hanif, 17 days ago; 1 activities, latest 17 days ago.
Introduced in 5a7b95fb993e (v5.14-rc1)


bluetooth: "Query LE tx power on startup" broke Bluetooth on MacBookPro16,1
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com/
https://lore.kernel.org/regressions/4970a940-211b-25d6-edab-21a815313954@protonmail.com/

By Orlando Chamberlain, 88 days ago; 86 activities, latest 18 days ago.
Introduced in 7c395ea521e6 (v5.11-rc1)

Fix incoming:
* Bluetooth: btbcm: disable read tx power for some Macs with the T2 Security chip
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=801b4c027b44a185292007d3cf7513999d644723


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 58 days ago; 16 activities, latest 22 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  57 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  57 days ago, by Joakim Tjernlund


PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/
https://lore.kernel.org/linux-pci/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/

By Stéphane Graber, 38 days ago; 9 activities, latest 24 days ago.
Introduced in 6dce5aa59e0b (v5.5-rc1)

Fix incoming:
* PCI: xgene: Fix IB window setup
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=c7a75d07827a1f33d566e18e6098379cc2a0c2b2


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


idle power increased from ~20 to ~28 watts
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/
https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/

By Idzibear, 55 days ago; 3 activities, latest 55 days ago.
Introduced in v5.14..v5.15


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/163994301274.632569.11641612108460583135@leemhuis.info

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
