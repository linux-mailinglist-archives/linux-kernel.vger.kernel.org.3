Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637464A5B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiBALY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiBALY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:24:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCBAC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 03:24:57 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nErHL-00061Y-HE; Tue, 01 Feb 2022 12:24:55 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-02-01]
Date:   Tue,  1 Feb 2022 11:24:54 +0000
Message-Id: <164371304929.1634350.16427081736188154002@leemhuis.info>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643714697;9a599456;
X-HE-SMSGID: 1nErHL-00061Y-HE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is regzbot, the Linux kernel regression tracking bot.

The regression reports took a break, as the festive season and the merge
window shook things up a bit, that why I no reports were sent during the
merge window. And this one is a bit late, too, as something on lore got
stuck which impacted regzbot. But now everything is back to normal, so
here we go:

Currently I'm aware of 27 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.16.. aka v5.17-rc), culprit identified
========================================================


[ *NEW* ] Revert "mm/page_isolation: unset migratetype directly for non Buddy page"
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220117142712.3967624-1-chenwandun@huawei.com/
https://lore.kernel.org/lkml/20220117142712.3967624-1-chenwandun@huawei.com/

By Chen Wandun, 14 days ago; 12 activities, latest 0 days ago.
Introduced in 721fb891ad0b (v5.17-rc1)

Fix incoming:
* Revert "mm/page_isolation: unset migratetype directly for non Buddy page"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=95b50010de45c154da39429ab34bd0873d3e79c7


[ *NEW* ] Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220130171210.GA3545402@roeck-us.net/
https://lore.kernel.org/lkml/20220130171210.GA3545402@roeck-us.net/

By Guenter Roeck, 1 days ago; 4 activities, latest 0 days ago.
Introduced in f48235900182 (v5.17-rc1)

Recent activities from: Thomas Gleixner (2), Guenter Roeck (2)

One patch associated with this regression:
* Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
  https://lore.kernel.org/lkml/87ee4n38sm.ffs@tglx/
  0 days ago, by Thomas Gleixner


[ *NEW* ] Re: [PATCH v5 2/5] acpi: Store CRC-32 hash of the _PLD in struct acpi_device
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220130164126.GA2942650@roeck-us.net/
https://lore.kernel.org/lkml/20220130164126.GA2942650@roeck-us.net/

By Guenter Roeck, 1 days ago; 3 activities, latest 0 days ago.
Introduced in 882c982dada4 (v5.17-rc1)

Recent activities from: Guenter Roeck (2), Rafael J. Wysocki (1)


[ *NEW* ] Re:MIPS: Fix build error due to PTR used in more places
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220130163725.GA2792319@roeck-us.net/
https://lore.kernel.org/lkml/20220130163725.GA2792319@roeck-us.net/

By Guenter Roeck, 1 days ago; 2 activities, latest 1 days ago.
Introduced in fa62f39dc7e2 (v5.17-rc2)

Recent activities from: Thomas Bogendoerfer (1), Guenter Roeck (1)


[ *NEW* ] pci: HotPlug does not work on upstream kernel 5.17.0-rc1
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220124214635.GA1553164@bhelgaas/
https://lore.kernel.org/linux-pci/20220124214635.GA1553164@bhelgaas/

By , 7 days ago; 12 activities, latest 3 days ago.
Introduced in d0a231f01e5b (v5.17-rc1)

Recent activities from: Bjorn Helgaas (4), Mariusz Tkaczyk (2), Jonathan
  Derrick (2), Kai-Heng Feng (1), Thorsten Leemhuis (1), Lukas
  Wunner (1), Hans de Goede (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215525


=========================================================================================
previous cycle (v5.15..v5.16), culprit identified, with activity in the past three months
=========================================================================================


[ *NEW* ] pci: UI becomes unresponsive every couple of seconds
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/8fdd5bf8-afe8-d493-e617-a47f7b8e2e0e@leemhuis.info/
https://lore.kernel.org/regressions/8fdd5bf8-afe8-d493-e617-a47f7b8e2e0e@leemhuis.info/

By , 5 days ago; 2 activities, latest 0 days ago.
Introduced in 0e8ae5a6ff59 (v5.16-rc1)

Recent activities from: Thorsten Leemhuis (2)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215533


[ *NEW* ] net: wireless: rtl8723bs (SDIO) - Access point mode causes a kernel panic
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/
https://lore.kernel.org/regressions/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/

By José Ángel Pastrana, 2 days ago; 1 activities, latest 2 days ago.
Introduced in 54659ca026e5 (v5.16-rc1)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215542


[ *NEW* ] Re: Unable to transfer big files to Nokia N9
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de/
https://lore.kernel.org/lkml/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de/

By Paul Menzel, 15 days ago; 1 activities, latest 15 days ago.
Introduced in 81be03e026dc (v5.16-rc1)

Recent activities from: Paul Menzel (1)


==================================================================================
older cycles (..v5.15), culprit identified, with activity in the past three months
==================================================================================


[ *NEW* ] xfrm: TCP MSS calculation broken by commit b515d263, results in TCP stall
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220114173133.tzmdm2hy4flhblo3@dwarf.suse.cz/
https://lore.kernel.org/netdev/20220114173133.tzmdm2hy4flhblo3@dwarf.suse.cz/

By Jiri Bohac, 17 days ago; 11 activities, latest 0 days ago.
Introduced in b515d2637276 (v5.14-rc1)

Recent activities from: Jiri Bohac (6), Steffen Klassert (5)

3 patch postings are associated with this regression, the latest is this:
* Re: [PATCH] Revert "xfrm: xfrm_state_mtu should return at least 1280 for ipv6"
  https://lore.kernel.org/netdev/20220126150018.7cdfxtkq2nfkqj4j@dwarf.suse.cz/
  5 days ago, by Jiri Bohac


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

By Francesco Magliocca, 228 days ago; 10 activities, latest 1 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)

Fix incoming:
* ath10k: abstract htt_rx_desc structure
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6bae9de622d3ef4805aba40e763eb4b0975c4f6d


[ *NEW* ] drm: amdgpu: Too-low frequency limit for AMD GPU PCI-passed-through to Windows VM
-------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/87ee57c8fu.fsf@turner.link/
https://lore.kernel.org/lkml/87ee57c8fu.fsf@turner.link/

By James D. Turner, 15 days ago; 15 activities, latest 2 days ago.
Introduced in f9b7f3703ff9 (v5.14-rc1)

Recent activities from: James Turner (5), Lazar, Lijo (3), Alex
  Deucher (2), Jim Turner (1), Alex Williamson (1), Thorsten
  Leemhuis (1), Greg KH (1), James D. Turner (1)


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 49 days ago; 4 activities, latest 2 days ago.
Introduced in dfeae1073583 (v4.18-rc1)

Recent activities from: Tokunori Ikegami (1), Ahmad Fatoum (1)


[ *NEW* ] sched: DMA Engine regression because of sched/fair changes
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220112152609.gg2boujeh5vv5cns@yadro.com/
https://lore.kernel.org/lkml/20220112152609.gg2boujeh5vv5cns@yadro.com/

By Alexander Fomichev, 19 days ago; 9 activities, latest 3 days ago.
Introduced in 7332dec055f2 (v4.16-rc1)

Recent activities from: Alexander Fomichev (6), Mel Gorman (3)


[ *NEW* ] cifs: unable to shares that require NTLM or weaker authentication algorithms
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com/
https://lore.kernel.org/lkml/CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf%2BwThmR72YTg@mail.gmail.com/

By Davyd McColl, 22 days ago; 17 activities, latest 3 days ago.
Introduced in 76a3c92ec9e0 (v5.15-rc1)

Recent activities from: Davyd McColl (5), Steve French (5), Thorsten
  Leemhuis (4), ronnie sahlberg (3)

Noteworthy links:
* Re: Possible regression: unable to mount CIFS 1.0 shares from older machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
  https://lore.kernel.org/lkml/ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info/
  21 days ago, by Thorsten Leemhuis; thread monitored.
* https://bugzilla.kernel.org/show_bug.cgi?id=215375


[ *NEW* ] Intel TGL notebook no longer enters power states deeper than PC2
--------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/
https://lore.kernel.org/regressions/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/

By MarcelHB, 11 days ago; 6 activities, latest 4 days ago.
Introduced in e5ad96f388b7 (v5.15-rc1)

Recent activities from: Rafael J. Wysocki (3), Keith Busch (2), Thorsten
  Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215467
* [Bug] nvme blocks PC10 since v5.15 - bisected
  https://lore.kernel.org/lkml/CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com/
  10 days ago, by Rafael J. Wysocki; thread monitored.


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 45 days ago; 12 activities, latest 4 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

Recent activities from: gregkh@linuxfoundation.org (1), Marcelo Roberto
  Jimenez (1)

One patch associated with this regression:
* Patch "ARM: dts: gpio-ranges property is now required" has been added to the 5.4-stable tree
  https://lore.kernel.org/linux-arm-kernel/16432993096685@kroah.com/
  4 days ago, by gregkh@linuxfoundation.org


[ *NEW* ] Unable to set $xmm2-9 registers but able to set $xmm0-1,10-15 with ptrace syscall (fwd from bugzilla)
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/80bed7f8-525e-9324-b544-f5f5da8ef2e7@leemhuis.info/
https://lore.kernel.org/regressions/80bed7f8-525e-9324-b544-f5f5da8ef2e7@leemhuis.info/

By Luís Ferreira, 6 days ago; 1 activities, latest 6 days ago.
Introduced in 6164331d15f7 (v5.14-rc1)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215524


btrfs: deadlocks in dedupe
--------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 52 days ago; 13 activities, latest 11 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)

Recent activities from: Zygo Blaxell (1)


fbdev: matroxfb: display black ans warns "the current input timing is not supported by the monitor display"
-----------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211218180035.200552-1-liuzx@knownsec.com/
https://lore.kernel.org/lkml/20211218180035.200552-1-liuzx@knownsec.com/

By Z. Liu, 44 days ago; 4 activities, latest 14 days ago.
Introduced in 11be60bd66d5 (v5.7-rc1)

Fix incoming:
* matroxfb: set maxvram of vbG200eW to the same as vbG200 to avoid black screen
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=0c248dc26e9031841a0beb96e3f820c50d56e5b4


net: wireless: ath10k: 5GHz channels are marked as No-IR
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at/

By Sebastian Bachmann, 66 days ago; 22 activities, latest 42 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru/
  660 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  588 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk/
  550 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org/
  466 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de/
  406 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 94 days ago; 16 activities, latest 59 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  94 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  93 days ago, by Joakim Tjernlund


====================================================================================
previous cycle (v5.15..v5.16), unkown culprit, with activity in the past three weeks
====================================================================================


[ *NEW* ] net: iwlwifi: ax200: Firmware crashes on startup
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/6beced27-403e-7e8c-5c64-ec0feddd3331@leemhuis.info/
https://lore.kernel.org/regressions/6beced27-403e-7e8c-5c64-ec0feddd3331@leemhuis.info/

By Bernhard Rosenkränzer, 11 days ago; 4 activities, latest 0 days ago.
Introduced in v5.15..v5.16

Recent activities from: Thorsten Leemhuis (2), Kalle Valo (1), Luca
  Coelho (1)

One patch associated with this regression:
* [PATCH for v5.17 1/2] iwlwifi: remove deprecated broadcast filtering feature
  https://lore.kernel.org/linux-wireless/iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid/
  3 days ago, by Luca Coelho; thread monitored.

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215488


5-10% increase in IO latencies with nohz balance patch
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/YaUH5GFFoLiS4/3/@localhost.localdomain/
https://lore.kernel.org/lkml/YaUH5GFFoLiS4%2F3%2F@localhost.localdomain/

By Josef Bacik, 63 days ago; 14 activities, latest 18 days ago.
Introduced in v5.15..v5.16-rc1

Recent activities from: Roman Gushchin (1), Valentin Schneider (1)


=============================================================================
older cycles (..v5.15), unkown culprit, with activity in the past three weeks
=============================================================================


[ *NEW* ] 100 ms boot time increase regression in acpi_init()/acpi_scan_bus()
-----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de/
https://lore.kernel.org/lkml/b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de/

By Paul Menzel, 21 days ago; 2 activities, latest 0 days ago.
Introduced in v5.13..v5.14-rc1

Recent activities from: Bjorn Helgaas (1), Paul Menzel (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215419


[ *NEW* ] backlight: Intel_backlight does not work after updating from 5.10.89 to latest 5.15.17
------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/
https://lore.kernel.org/regressions/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/

By Filippo Falezza, 1 days ago; 1 activities, latest 1 days ago.
Introduced in v5.10.89..v5.15.17

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215553


[ *NEW* ] block: bfq: oops/random freeze in bfq_put_idle_entity / bfq_exit_icq_bfqq
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d51611e5-2e39-49b5-b300-917a9b024c59@leemhuis.info/
https://lore.kernel.org/regressions/d51611e5-2e39-49b5-b300-917a9b024c59@leemhuis.info/

By Bernd Buschinski, 6 days ago; 1 activities, latest 6 days ago.
Introduced in v5.14..v5.15

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215527


[ *NEW* ] nfs: noresvport + nfsv4 no longer working as expected
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/46a28c62-4610-00df-610c-ca3cc8861265@leemhuis.info/
https://lore.kernel.org/regressions/46a28c62-4610-00df-610c-ca3cc8861265@leemhuis.info/

By Daire Byrne, 6 days ago; 1 activities, latest 6 days ago.
Introduced in v5.11.11..v5.12.19

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215526


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164175418046.1037107.9730034714816887497@leemhuis.info

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
