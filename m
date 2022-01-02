Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8163E482CAE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 21:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiABUXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 15:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABUXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 15:23:00 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF4C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 12:22:59 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1n47NZ-0007XR-8e; Sun, 02 Jan 2022 21:22:57 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-01-02]
Date:   Sun,  2 Jan 2022 20:22:56 +0000
Message-Id: <164115482345.892609.132126317184270346@leemhuis.info>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641154979;b1eeb4f4;
X-HE-SMSGID: 1n47NZ-0007XR-8e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 23 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.15.. aka v5.16-rc), culprit identified
========================================================


[ *NEW* ] pm: laptop totally freezes when going to hibernation
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/256689953.114854578.1640622738334.JavaMail.root@zimbra40-e7.priv.proxad.net/
https://lore.kernel.org/linux-pm/256689953.114854578.1640622738334.JavaMail.root@zimbra40-e7.priv.proxad.net/

By casteyde.christian@free.fr, 6 days ago; 4 activities, latest 1 days ago.
Introduced in 804b6e5ee613 (v5.16-rc1)

Recent activities from: Thorsten Leemhuis (1), Christian Casteyde (1),
  Rafael J. Wysocki (1), casteyde.christian@free.fr (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215427


[ *NEW* ] drm: amdgpu: s0ix suspend stopped working
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f3aa1e12-c65f-8668-772c-b25dca79b642@leemhuis.info/
https://lore.kernel.org/regressions/f3aa1e12-c65f-8668-772c-b25dca79b642@leemhuis.info/

By Thorsten Leemhuis, 1 days ago; 1 activities, latest 1 days ago.
Introduced in 2a50edbf10c8 (v5.16-rc1)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://gitlab.freedesktop.org/drm/amd/-/issues/1821
* https://bugzilla.kernel.org/show_bug.cgi?id=215436


5-10% increase in IO latencies with nohz balance patch
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YaUH5GFFoLiS4/3/@localhost.localdomain/
https://lore.kernel.org/lkml/YaUH5GFFoLiS4%2F3%2F@localhost.localdomain/

By Josef Bacik, 34 days ago; 11 activities, latest 11 days ago.
Introduced in 7fd7a9e0caba (v5.16-rc1)


RDMA/mlx5: Regression since v5.15-rc5: Kernel panic when called ib_dereg_mr
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com/
https://lore.kernel.org/linux-rdma/9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com/

By Tony Lu, 12 days ago; 5 activities, latest 11 days ago.
Introduced in f0ae4afe3d35 (v5.16-rc5)

Noteworthy links:
* [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
  https://lore.kernel.org/lkml/f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com/
  12 days ago, by Leon Romanovsky; thread monitored.


fbdev/efifb: Monitors no longer sleep (amdgpu dual monitor setup)
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/
https://lore.kernel.org/linux-fbdev/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/

By Brandon Nielsen, 26 days ago; 4 activities, latest 16 days ago.
Introduced in 55285e21f045 (v5.16-rc1)

Noteworthy links:
* https://bugzilla.redhat.com/show_bug.cgi?id=2028613
* https://bugzilla.kernel.org/show_bug.cgi?id=215203


=========================================================================================
previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
=========================================================================================


[ *NEW* ] bluetooth: more Intel chips require the workaround for the broken initial command
-------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211202162256.31837-1-tiwai@suse.de/
https://lore.kernel.org/lkml/20211202162256.31837-1-tiwai@suse.de/

By Takashi Iwai, 31 days ago; 11 activities, latest 5 days ago.
Introduced in 83f2dafe2a62 (v5.15-rc1)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215167
* https://bugzilla.opensuse.org/show_bug.cgi?id=1193124


cifs: unable to mount cifs 1.0 shares because support for NTLM and weaker authentication algorithms was removed
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/dce98c91-d28c-0f5a-b177-1f4275cf0f35@leemhuis.info/
https://lore.kernel.org/regressions/dce98c91-d28c-0f5a-b177-1f4275cf0f35@leemhuis.info/

By Thorsten Leemhuis, 10 days ago; 1 activities, latest 10 days ago.
Introduced in 76a3c92ec9e0 (v5.15-rc1)


drm: amdgpu: NUC8i7HVKVA crashes during system suspend
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215315-2300@https.bugzilla.kernel.org//
https://lore.kernel.org/dri-devel/bug-215315-2300@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@bugzilla.kernel.org, 20 days ago; 1 activities, latest 20 days ago.
Introduced in f7d6779df642 (v5.15-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215315


Bluetooth not working on 5.15+ since "Bluetooth: Move shutdown callback before flushing tx and rx queue"
--------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com/
https://lore.kernel.org/lkml/CAJvGw%2BAJ5dHSb50RtJHnjbhMVQa%2BrJgYznFV4t-iaO0qx%2BW-jw@mail.gmail.com/

By coldolt, 23 days ago; 3 activities, latest 23 days ago.
Introduced in 0ea53674d07f (v5.15-rc1)


==================================================================================
older cycles (..v5.14), culprit identified, with activity in the past three months
==================================================================================


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

By Francesco Magliocca, 198 days ago; 8 activities, latest 10 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)

One patch associated with this regression:
* [PATCH v2] ath10k: abstract htt_rx_desc structure
  https://lore.kernel.org/linux-wireless/20211216151823.68878-1-franciman12@gmail.com/
  17 days ago, by Francesco Magliocca; thread monitored.

Noteworthy links:
* Bug in Memory Layout of rx_desc for QCA6174
  https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com/
  65 days ago, by Francesco Magliocca; thread monitored.


usb: gadget: atmel: ethernet over USB Gadget not recognized anymore after disconnect and reconnect
--------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211211183650.12183-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/regressions/20211211183650.12183-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 22 days ago; 7 activities, latest 11 days ago.
Introduced in 70a7f8be8598 (v5.2-rc1)


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 16 days ago; 7 activities, latest 12 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 36 days ago; 22 activities, latest 13 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
  630 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  558 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
  521 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
  437 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
  377 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


fbdev: matroxfb: display black ans warns "the current input timing is not supported by the monitor display"
-----------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211218180035.200552-1-liuzx@knownsec.com/
https://lore.kernel.org/lkml/20211218180035.200552-1-liuzx@knownsec.com/

By Z. Liu, 15 days ago; 2 activities, latest 13 days ago.
Introduced in 11be60bd66d5 (v5.7-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215355


pci: the pci sysfs "rom" file has disappeared for VGA devices
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YbxqIyrkv3GhZVxx@intel.com/
https://lore.kernel.org/linux-pci/YbxqIyrkv3GhZVxx@intel.com/

By Ville Syrjälä, 16 days ago; 4 activities, latest 15 days ago.
Introduced in 527139d738d7 (v5.13-rc1)


btrfs: deadlocks in dedupe
--------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 23 days ago; 11 activities, latest 15 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 20 days ago; 2 activities, latest 18 days ago.
Introduced in dfeae1073583 (v4.18-rc1)


drm: amdgpu: apps that need amdgpu do not start after system is woken from suspend
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1295184560.182511.1639075777725@mail.yahoo.com/
https://lore.kernel.org/linux-i2c/1295184560.182511.1639075777725@mail.yahoo.com/

By Tareque Md.Hanif, 24 days ago; 1 activities, latest 24 days ago.
Introduced in 5a7b95fb993e (v5.14-rc1)


bluetooth: "Query LE tx power on startup" broke Bluetooth on MacBookPro16,1
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com/
https://lore.kernel.org/regressions/4970a940-211b-25d6-edab-21a815313954@protonmail.com/

By Orlando Chamberlain, 95 days ago; 86 activities, latest 25 days ago.
Introduced in 7c395ea521e6 (v5.11-rc1)

Fix incoming:
* Bluetooth: btbcm: disable read tx power for some Macs with the T2 Security chip
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=801b4c027b44a185292007d3cf7513999d644723


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 65 days ago; 16 activities, latest 29 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  64 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  64 days ago, by Joakim Tjernlund


PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/
https://lore.kernel.org/linux-pci/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/

By Stéphane Graber, 45 days ago; 9 activities, latest 31 days ago.
Introduced in 6dce5aa59e0b (v5.5-rc1)

Fix incoming:
* PCI: xgene: Fix IB window setup
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=c7a75d07827a1f33d566e18e6098379cc2a0c2b2


=============================================================================
older cycles (..v5.14), unkown culprit, with activity in the past three weeks
=============================================================================


[ *NEW* ] Touchpad is not working after suspend to RAM since kernel 5.14 (fwd from b.k.o bug 214667)
----------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/12b9a10a-626b-cafd-05d6-cf0a116aa39b@leemhuis.info/
https://lore.kernel.org/lkml/12b9a10a-626b-cafd-05d6-cf0a116aa39b@leemhuis.info/

By Thorsten Leemhuis, 5 days ago; 2 activities, latest 1 days ago.
Introduced in b3e296425482

Recent activities from: Thorsten Leemhuis (1),
  regressions@leemhuis.info (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=214667


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


idle power increased from ~20 to ~28 watts
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/
https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/

By Idzibear, 62 days ago; 3 activities, latest 62 days ago.
Introduced in v5.14..v5.15


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164055061372.788592.14520202566843934212@leemhuis.info

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
