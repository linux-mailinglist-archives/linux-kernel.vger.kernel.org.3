Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF58488BC0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiAISvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 13:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiAISvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 13:51:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FBEC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 10:51:03 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1n6dHQ-0001mM-6I; Sun, 09 Jan 2022 19:51:00 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-01-09]
Date:   Sun,  9 Jan 2022 18:50:59 +0000
Message-Id: <164175418046.1037107.9730034714816887497@leemhuis.info>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641754263;46c0ae30;
X-HE-SMSGID: 1n6dHQ-0001mM-6I
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 21 regressions in linux-mainline. Find the
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

By Josef Bacik, 41 days ago; 12 activities, latest 6 days ago.
Introduced in 7fd7a9e0caba (v5.16-rc1)

Recent activities from: Josef Bacik (1)


pm: laptop totally freezes when going to hibernation
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/256689953.114854578.1640622738334.JavaMail.root@zimbra40-e7.priv.proxad.net/
https://lore.kernel.org/linux-pm/256689953.114854578.1640622738334.JavaMail.root@zimbra40-e7.priv.proxad.net/

By casteyde.christian@free.fr, 13 days ago; 4 activities, latest 8 days ago.
Introduced in 804b6e5ee613 (v5.16-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215427


drm: amdgpu: s0ix suspend stopped working
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f3aa1e12-c65f-8668-772c-b25dca79b642@leemhuis.info/
https://lore.kernel.org/regressions/f3aa1e12-c65f-8668-772c-b25dca79b642@leemhuis.info/

By Thorsten Leemhuis, 8 days ago; 1 activities, latest 8 days ago.
Introduced in 2a50edbf10c8 (v5.16-rc1)

Noteworthy links:
* https://gitlab.freedesktop.org/drm/amd/-/issues/1821
* https://bugzilla.kernel.org/show_bug.cgi?id=215436


=========================================================================================
previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
=========================================================================================


bluetooth: more Intel chips require the workaround for the broken initial command
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211202162256.31837-1-tiwai@suse.de/
https://lore.kernel.org/lkml/20211202162256.31837-1-tiwai@suse.de/

By Takashi Iwai, 38 days ago; 11 activities, latest 12 days ago.
Introduced in 83f2dafe2a62 (v5.15-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215167
* https://bugzilla.opensuse.org/show_bug.cgi?id=1193124


cifs: unable to mount cifs 1.0 shares because support for NTLM and weaker authentication algorithms was removed
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/dce98c91-d28c-0f5a-b177-1f4275cf0f35@leemhuis.info/
https://lore.kernel.org/regressions/dce98c91-d28c-0f5a-b177-1f4275cf0f35@leemhuis.info/

By Thorsten Leemhuis, 17 days ago; 1 activities, latest 17 days ago.
Introduced in 76a3c92ec9e0 (v5.15-rc1)


drm: amdgpu: NUC8i7HVKVA crashes during system suspend
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215315-2300@https.bugzilla.kernel.org//
https://lore.kernel.org/dri-devel/bug-215315-2300@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@bugzilla.kernel.org, 27 days ago; 1 activities, latest 27 days ago.
Introduced in f7d6779df642 (v5.15-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215315


Bluetooth not working on 5.15+ since "Bluetooth: Move shutdown callback before flushing tx and rx queue"
--------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com/
https://lore.kernel.org/lkml/CAJvGw%2BAJ5dHSb50RtJHnjbhMVQa%2BrJgYznFV4t-iaO0qx%2BW-jw@mail.gmail.com/

By coldolt, 30 days ago; 3 activities, latest 30 days ago.
Introduced in 0ea53674d07f (v5.15-rc1)


==================================================================================
older cycles (..v5.14), culprit identified, with activity in the past three months
==================================================================================


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 23 days ago; 10 activities, latest 0 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

Recent activities from: Olof Johansson (1), Stefan Wahren (1), Florian
  Fainelli (1)


btrfs: deadlocks in dedupe
--------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 30 days ago; 12 activities, latest 2 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)

Recent activities from: Zygo Blaxell (1)


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

By Francesco Magliocca, 205 days ago; 8 activities, latest 17 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)

One patch associated with this regression:
* [PATCH v2] ath10k: abstract htt_rx_desc structure
  https://lore.kernel.org/linux-wireless/20211216151823.68878-1-franciman12@gmail.com/
  24 days ago, by Francesco Magliocca; thread monitored.

Noteworthy links:
* Bug in Memory Layout of rx_desc for QCA6174
  https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com/
  72 days ago, by Francesco Magliocca; thread monitored.


usb: gadget: atmel: ethernet over USB Gadget not recognized anymore after disconnect and reconnect
--------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211211183650.12183-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/regressions/20211211183650.12183-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 29 days ago; 7 activities, latest 18 days ago.
Introduced in 70a7f8be8598 (v5.2-rc1)


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 43 days ago; 22 activities, latest 20 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
  637 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  565 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
  528 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
  444 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
  384 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


fbdev: matroxfb: display black ans warns "the current input timing is not supported by the monitor display"
-----------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211218180035.200552-1-liuzx@knownsec.com/
https://lore.kernel.org/lkml/20211218180035.200552-1-liuzx@knownsec.com/

By Z. Liu, 22 days ago; 2 activities, latest 20 days ago.
Introduced in 11be60bd66d5 (v5.7-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215355


pci: the pci sysfs "rom" file has disappeared for VGA devices
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YbxqIyrkv3GhZVxx@intel.com/
https://lore.kernel.org/linux-pci/YbxqIyrkv3GhZVxx@intel.com/

By Ville Syrjälä, 23 days ago; 4 activities, latest 22 days ago.
Introduced in 527139d738d7 (v5.13-rc1)


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 27 days ago; 2 activities, latest 25 days ago.
Introduced in dfeae1073583 (v4.18-rc1)


bluetooth: "Query LE tx power on startup" broke Bluetooth on MacBookPro16,1
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com/
https://lore.kernel.org/regressions/4970a940-211b-25d6-edab-21a815313954@protonmail.com/

By Orlando Chamberlain, 102 days ago; 86 activities, latest 32 days ago.
Introduced in 7c395ea521e6 (v5.11-rc1)

Fix incoming:
* Bluetooth: btbcm: disable read tx power for some Macs with the T2 Security chip
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=801b4c027b44a185292007d3cf7513999d644723


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 72 days ago; 16 activities, latest 36 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  71 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  71 days ago, by Joakim Tjernlund


PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/
https://lore.kernel.org/linux-pci/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com/

By Stéphane Graber, 52 days ago; 9 activities, latest 38 days ago.
Introduced in 6dce5aa59e0b (v5.5-rc1)

Fix incoming:
* PCI: xgene: Fix IB window setup
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=c7a75d07827a1f33d566e18e6098379cc2a0c2b2


====================================================================================
previous cycle (v5.14..v5.15), unkown culprit, with activity in the past three weeks
====================================================================================


bluetooth: Intel Bluetooth no longer works
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch/
https://lore.kernel.org/lkml/b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch/

By Ortwin Glück, 13 days ago; 4 activities, latest 1 days ago.
Introduced in v5.14..v5.15

Fix incoming:
* https://lore.kernel.org/lkml/cf5b69c6-532b-4c6e-c046-eaad65019e8f@leemhuis.info/


=============================================================================
older cycles (..v5.14), unkown culprit, with activity in the past three weeks
=============================================================================


Touchpad is not working after suspend to RAM since kernel 5.14 (fwd from b.k.o bug 214667)
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/12b9a10a-626b-cafd-05d6-cf0a116aa39b@leemhuis.info/
https://lore.kernel.org/lkml/12b9a10a-626b-cafd-05d6-cf0a116aa39b@leemhuis.info/

By Thorsten Leemhuis, 12 days ago; 2 activities, latest 8 days ago.
Introduced in b3e296425482

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=214667


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


idle power increased from ~20 to ~28 watts
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/
https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org/

By Idzibear, 69 days ago; 3 activities, latest 69 days ago.
Introduced in v5.14..v5.15


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164115482345.892609.132126317184270346@leemhuis.info

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
