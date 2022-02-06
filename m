Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2304AB200
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 21:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiBFUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 15:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:21:47 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051FC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 12:21:43 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nGo2V-0001NV-SL; Sun, 06 Feb 2022 21:21:40 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-02-06]
Date:   Sun,  6 Feb 2022 20:21:39 +0000
Message-Id: <164417878250.37935.12983723607063220199@leemhuis.info>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1644178903;4530a854;
X-HE-SMSGID: 1nGo2V-0001NV-SL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
current cycle (v5.16.. aka v5.17-rc), culprit identified
========================================================


[ *NEW* ] Follow-up error for the commit fixing "PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization"
-------------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Yf2wTLjmcRj+AbDv@xps13.dannf/
https://lore.kernel.org/stable/Yf2wTLjmcRj%2BAbDv@xps13.dannf/

By dann frazier, 1 days ago; 3 activities, latest 0 days ago.
Introduced in c7a75d07827a (v5.17-rc1)

Recent activities from: dann frazier (2), Rob Herring (1)


=========================================================================================
previous cycle (v5.15..v5.16), culprit identified, with activity in the past three months
=========================================================================================


pci: UI becomes unresponsive every couple of seconds
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/8fdd5bf8-afe8-d493-e617-a47f7b8e2e0e@leemhuis.info/
https://lore.kernel.org/regressions/8fdd5bf8-afe8-d493-e617-a47f7b8e2e0e@leemhuis.info/

By , 11 days ago; 2 activities, latest 5 days ago.
Introduced in 0e8ae5a6ff59 (v5.16-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215533


net: wireless: rtl8723bs (SDIO) - Access point mode causes a kernel panic
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/
https://lore.kernel.org/regressions/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/

By José Ángel Pastrana, 7 days ago; 1 activities, latest 7 days ago.
Introduced in 54659ca026e5 (v5.16-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215542


Re: Unable to transfer big files to Nokia N9
--------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de/
https://lore.kernel.org/lkml/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de/

By Paul Menzel, 21 days ago; 1 activities, latest 21 days ago.
Introduced in 81be03e026dc (v5.16-rc1)


==================================================================================
older cycles (..v5.15), culprit identified, with activity in the past three months
==================================================================================


xfrm: TCP MSS calculation broken by commit b515d263, results in TCP stall
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220114173133.tzmdm2hy4flhblo3@dwarf.suse.cz/
https://lore.kernel.org/netdev/20220114173133.tzmdm2hy4flhblo3@dwarf.suse.cz/

By Jiri Bohac, 23 days ago; 12 activities, latest 2 days ago.
Introduced in b515d2637276 (v5.14-rc1)

Fix incoming:
* Revert "xfrm: xfrm_state_mtu should return at least 1280 for ipv6"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=a6d95c5a628a09be129f25d5663a7e9db8261f51


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

By Francesco Magliocca, 233 days ago; 10 activities, latest 6 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)

Fix incoming:
* ath10k: abstract htt_rx_desc structure
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6bae9de622d3ef4805aba40e763eb4b0975c4f6d


drm: amdgpu: Too-low frequency limit for AMD GPU PCI-passed-through to Windows VM
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/87ee57c8fu.fsf@turner.link/
https://lore.kernel.org/lkml/87ee57c8fu.fsf@turner.link/

By James D. Turner, 20 days ago; 15 activities, latest 7 days ago.
Introduced in f9b7f3703ff9 (v5.14-rc1)


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 55 days ago; 4 activities, latest 8 days ago.
Introduced in dfeae1073583 (v4.18-rc1)


sched: DMA Engine regression because of sched/fair changes
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220112152609.gg2boujeh5vv5cns@yadro.com/
https://lore.kernel.org/lkml/20220112152609.gg2boujeh5vv5cns@yadro.com/

By Alexander Fomichev, 25 days ago; 9 activities, latest 9 days ago.
Introduced in 7332dec055f2 (v4.16-rc1)


cifs: unable to shares that require NTLM or weaker authentication algorithms
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com/
https://lore.kernel.org/lkml/CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf%2BwThmR72YTg@mail.gmail.com/

By Davyd McColl, 27 days ago; 17 activities, latest 9 days ago.
Introduced in 76a3c92ec9e0 (v5.15-rc1)

Noteworthy links:
* Re: Possible regression: unable to mount CIFS 1.0 shares from older machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
  https://lore.kernel.org/lkml/ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info/
  27 days ago, by Thorsten Leemhuis; thread monitored.
* https://bugzilla.kernel.org/show_bug.cgi?id=215375


Intel TGL notebook no longer enters power states deeper than PC2
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/
https://lore.kernel.org/regressions/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/

By MarcelHB, 17 days ago; 6 activities, latest 10 days ago.
Introduced in e5ad96f388b7 (v5.15-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215467
* [Bug] nvme blocks PC10 since v5.15 - bisected
  https://lore.kernel.org/lkml/CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com/
  16 days ago, by Rafael J. Wysocki; thread monitored.


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 51 days ago; 12 activities, latest 10 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

One patch associated with this regression:
* Patch "ARM: dts: gpio-ranges property is now required" has been added to the 5.4-stable tree
  https://lore.kernel.org/linux-arm-kernel/16432993096685@kroah.com/
  10 days ago, by gregkh@linuxfoundation.org


Unable to set $xmm2-9 registers but able to set $xmm0-1,10-15 with ptrace syscall (fwd from bugzilla)
-----------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/80bed7f8-525e-9324-b544-f5f5da8ef2e7@leemhuis.info/
https://lore.kernel.org/regressions/80bed7f8-525e-9324-b544-f5f5da8ef2e7@leemhuis.info/

By Luís Ferreira, 11 days ago; 1 activities, latest 11 days ago.
Introduced in 6164331d15f7 (v5.14-rc1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215524


btrfs: deadlocks in dedupe
--------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 58 days ago; 13 activities, latest 16 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)


fbdev: matroxfb: display black ans warns "the current input timing is not supported by the monitor display"
-----------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211218180035.200552-1-liuzx@knownsec.com/
https://lore.kernel.org/lkml/20211218180035.200552-1-liuzx@knownsec.com/

By Z. Liu, 50 days ago; 4 activities, latest 19 days ago.
Introduced in 11be60bd66d5 (v5.7-rc1)

Fix incoming:
* matroxfb: set maxvram of vbG200eW to the same as vbG200 to avoid black screen
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=0c248dc26e9031841a0beb96e3f820c50d56e5b4


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 71 days ago; 22 activities, latest 48 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
  665 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  593 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
  556 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
  472 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
  412 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 100 days ago; 16 activities, latest 64 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  99 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  99 days ago, by Joakim Tjernlund


====================================================================================
previous cycle (v5.15..v5.16), unkown culprit, with activity in the past three weeks
====================================================================================


net: iwlwifi: ax200: Firmware crashes on startup
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/6beced27-403e-7e8c-5c64-ec0feddd3331@leemhuis.info/
https://lore.kernel.org/regressions/6beced27-403e-7e8c-5c64-ec0feddd3331@leemhuis.info/

By Bernhard Rosenkränzer, 17 days ago; 8 activities, latest 2 days ago.
Introduced in v5.15..v5.16

Fix incoming:
* iwlwifi: remove deprecated broadcast filtering feature
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=92883a524ae918736a7b8acef98698075507b8c1


[ *NEW* ] snd: usb: snd-usb-audio:reset_resume error -22 after suspen
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/a8100c3d-007e-3207-7dc1-92849f638d71@leemhuis.info/
https://lore.kernel.org/regressions/a8100c3d-007e-3207-7dc1-92849f638d71@leemhuis.info/

By , 3 days ago; 1 activities, latest 3 days ago.
Introduced in v5.15..v5.16

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215561


=============================================================================
older cycles (..v5.15), unkown culprit, with activity in the past three weeks
=============================================================================


100 ms boot time increase regression in acpi_init()/acpi_scan_bus()
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de/
https://lore.kernel.org/lkml/b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de/

By Paul Menzel, 27 days ago; 2 activities, latest 5 days ago.
Introduced in v5.13..v5.14-rc1

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215419


backlight: Intel_backlight does not work after updating from 5.10.89 to latest 5.15.17
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/
https://lore.kernel.org/regressions/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/

By Filippo Falezza, 6 days ago; 1 activities, latest 6 days ago.
Introduced in v5.10.89..v5.15.17

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215553


block: bfq: oops/random freeze in bfq_put_idle_entity / bfq_exit_icq_bfqq
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d51611e5-2e39-49b5-b300-917a9b024c59@leemhuis.info/
https://lore.kernel.org/regressions/d51611e5-2e39-49b5-b300-917a9b024c59@leemhuis.info/

By Bernd Buschinski, 11 days ago; 1 activities, latest 11 days ago.
Introduced in v5.14..v5.15

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215527


nfs: noresvport + nfsv4 no longer working as expected
-----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/46a28c62-4610-00df-610c-ca3cc8861265@leemhuis.info/
https://lore.kernel.org/regressions/46a28c62-4610-00df-610c-ca3cc8861265@leemhuis.info/

By Daire Byrne, 11 days ago; 1 activities, latest 11 days ago.
Introduced in v5.11.11..v5.12.19

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215526


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


5-10% increase in IO latencies with nohz balance patch
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YaUH5GFFoLiS4/3/@localhost.localdomain/
https://lore.kernel.org/lkml/YaUH5GFFoLiS4%2F3%2F@localhost.localdomain/

By Josef Bacik, 69 days ago; 14 activities, latest 24 days ago.
Introduced in v5.15..v5.16-rc1


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164371304929.1634350.16427081736188154002@leemhuis.info

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
