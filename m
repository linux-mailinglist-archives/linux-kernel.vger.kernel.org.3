Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD924BD11E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbiBTTw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:52:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBTTw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:52:26 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C5B6E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:52:02 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nLsFT-00032i-Qk; Sun, 20 Feb 2022 20:51:59 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-02-20]
Date:   Sun, 20 Feb 2022 19:51:59 +0000
Message-Id: <164538626369.148226.6844131057670577043@leemhuis.info>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645386723;cce0895e;
X-HE-SMSGID: 1nLsFT-00032i-Qk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, with a quick preface before the latest report from
regzbot. From my side things seem to look normal right now; in fact
quite a few mainline regression that I've been tracking got resolved in
the past few days (I removed two from the report that are fixed by
changes in the git tags Borislav and Dmitry asked you to pull this
weekend; guess you will merge them later today).

Sadly it seems I still don't get aware of quite a few regressions as
people don't CC the regressions mailing list. :-/ Well, that's life...

BTW, to reduce noise Regzbot now supports putting some regressions on
"back burner" and will not list them in the report, unless there was
recent activity; they are still visible in the web-ui.

I hope to work on better bugzilla.kernel.org integration soon, then
regzbot will show a proper "last activity date" when an issue is only
discussed in a ticket.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 23 regressions in linux-mainline. Find the
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

By dann frazier, 15 days ago; 7 activities, latest 9 days ago.
Introduced in c7a75d07827a (v5.17-rc1)

Recent activities from: dann frazier (2), Rob Herring (2)

One patch associated with this regression:
* Re: [PATCH] PCI: xgene: Fix IB window setup
  https://lore.kernel.org/stable/YgHFFIRT6E0j9TlX@xps13.dannf/
  12 days ago, by dann frazier


====================================================
current cycle (v5.16.. aka v5.17-rc), unkown culprit
====================================================


[ *NEW* ] drm: radeon: no sound on video, *ERROR* Failed waiting for UVD message
--------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/978944b7-4e71-475a-2fe6-c414d3e8f64e@leemhuis.info/
https://lore.kernel.org/lkml/978944b7-4e71-475a-2fe6-c414d3e8f64e@leemhuis.info/

By Richard Herbert, 0 days ago; 1 activities, latest 0 days ago.
Introduced in v5.16..v5.17-rc1

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215600


[ *NEW* ] iwlwifi: Firmware crash with 66.f1c864e0.0 (cc-a0-66.ucode) and 68.01d30b0c (cc-a0-68.ucode)
------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/adf5ac57-cd60-a004-a05d-6d7c3ad7efa7@leemhuis.info/
https://lore.kernel.org/regressions/adf5ac57-cd60-a004-a05d-6d7c3ad7efa7@leemhuis.info/

By Udo Steinberg, 10 days ago; 1 activities, latest 10 days ago.
Introduced in v5.16..v5.17-rc1

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215523


=========================================================================================
previous cycle (v5.15..v5.16), culprit identified, with activity in the past three months
=========================================================================================


[ *NEW* ] Commit 59ec715 breaks systemd LimitNPROC with PrivateUsers
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/52d494d1-6133-d7ac-932b-1b70c136096c@leemhuis.info/
https://lore.kernel.org/regressions/52d494d1-6133-d7ac-932b-1b70c136096c@leemhuis.info/

By Etienne Dechamps, 0 days ago; 1 activities, latest 0 days ago.
Introduced in 59ec71575ab4 (v5.16-rc7)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215596


[ *NEW* ] gcc segv at startup on ia64
-------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info/
https://lore.kernel.org/lkml/a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info/

By matoro, 0 days ago; 2 activities, latest 0 days ago.
Introduced in 5f501d555653 (v5.16-rc1)

Recent activities from: Thorsten Leemhuis (2)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215601


Re: Unable to transfer big files to Nokia N9
--------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de/
https://lore.kernel.org/lkml/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de/

By Paul Menzel, 35 days ago; 16 activities, latest 1 days ago.
Introduced in 81be03e026dc (v5.16-rc1)

Fix incoming:
* Bluetooth: Fix bt_skb_sendmmsg not allocating partial chunks
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=8abc7824203217c23de0e513b2a9505d0f9a0603


[ *NEW* ] bluetooth: HSP/HFP mSBC profile broken with QCA6174
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bug-215576-62941@https.bugzilla.kernel.org//
https://lore.kernel.org/linux-bluetooth/bug-215576-62941@https.bugzilla.kernel.org%2F/

By bugzilla-daemon@kernel.org, 13 days ago; 7 activities, latest 1 days ago.
Introduced in b2af264ad3af (v5.16-rc1)

Recent activities from: bugzilla-daemon@kernel.org (5),
  bluez.test.bot@gmail.com (1), Luiz Augusto von Dentz (1)

2 patch postings are associated with this regression, the latest is this:
* [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
  https://lore.kernel.org/linux-bluetooth/bug-215576-62941-2nprEl3omz@https.bugzilla.kernel.org%2F/
  1 days ago, by bugzilla-daemon@kernel.org

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215576


net: wireless: rtl8723bs (SDIO) - Access point mode causes a kernel panic
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/
https://lore.kernel.org/regressions/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/

By José Ángel Pastrana, 21 days ago; 2 activities, latest 10 days ago.
Introduced in 54659ca026e5 (v5.16-rc1)

Recent activities from: Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215542


==================================================================================
older cycles (..v5.15), culprit identified, with activity in the past three months
==================================================================================


mtd: cfi_cmdset_0002: flash write accesses on the hardware fail on a PowerPC MPC8313 to a 8-bit-parallel S29GL064N flash
------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/
https://lore.kernel.org/lkml/b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de/

By Ahmad Fatoum, 69 days ago; 9 activities, latest 0 days ago.
Introduced in dfeae1073583 (v4.18-rc1)

Recent activities from: Tokunori Ikegami (3), Ahmad Fatoum (2)


btrfs: deadlocks in dedupe
--------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211210183456.GP17148@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20211210183456.GP17148@hungrycats.org/

By Zygo Blaxell, 72 days ago; 15 activities, latest 2 days ago.
Introduced in 3078d85c9a10 (v5.11-rc1)

Recent activities from: Thorsten Leemhuis (1), Libor Klepáč (1)


fbdev: matroxfb: display black ans warns "the current input timing is not supported by the monitor display"
-----------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211218180035.200552-1-liuzx@knownsec.com/
https://lore.kernel.org/lkml/20211218180035.200552-1-liuzx@knownsec.com/

By Z. Liu, 64 days ago; 5 activities, latest 2 days ago.
Introduced in 11be60bd66d5 (v5.7-rc1)

Fix incoming:
* video: fbdev: matroxfb: set maxvram of vbG200eW to the same as vbG200 to avoid black screen
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=62d89a7d49afe46e6b9bbe9e23b004ad848dbde4


cifs: unable to shares that require NTLM or weaker authentication algorithms
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com/
https://lore.kernel.org/lkml/CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf%2BwThmR72YTg@mail.gmail.com/

By Davyd McColl, 41 days ago; 18 activities, latest 2 days ago.
Introduced in 76a3c92ec9e0 (v5.15-rc1)

Recent activities from: Davyd McColl (1)

Noteworthy links:
* Re: Possible regression: unable to mount CIFS 1.0 shares from older machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
  https://lore.kernel.org/lkml/ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info/
  41 days ago, by Thorsten Leemhuis; thread monitored.
* https://bugzilla.kernel.org/show_bug.cgi?id=215375


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com/

By Eugene Bordenkircher, 114 days ago; 19 activities, latest 2 days ago.
Introduced in f79a60b8785 (v3.4-rc4)

Recent activities from: gregkh@linuxfoundation.org (2), Joakim
  Tjernlund (1)

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  113 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  113 days ago, by Joakim Tjernlund


gpio: some GPIO lines have stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20211217153555.9413-1-marcelo.jimenez@gmail.com/
https://lore.kernel.org/stable/20211217153555.9413-1-marcelo.jimenez@gmail.com/

By Marcelo Roberto Jimenez, 65 days ago; 19 activities, latest 3 days ago.
Introduced in 2ab73c6d8323 (v5.7-rc1)

Recent activities from: Linus Walleij (3), Marcelo Roberto Jimenez (2),
  Thierry Reding (1), Bartosz Golaszewski (1)

One patch associated with this regression:
* Patch "ARM: dts: gpio-ranges property is now required" has been added to the 5.4-stable tree
  https://lore.kernel.org/linux-arm-kernel/16432993096685@kroah.com/
  24 days ago, by gregkh@linuxfoundation.org


drm: amdgpu: Too-low frequency limit for AMD GPU PCI-passed-through to Windows VM
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/87ee57c8fu.fsf@turner.link/
https://lore.kernel.org/lkml/87ee57c8fu.fsf@turner.link/

By James D. Turner, 34 days ago; 19 activities, latest 4 days ago.
Introduced in f9b7f3703ff9 (v5.14-rc1)

Recent activities from: Alex Deucher (2), James D. Turner (1), Thorsten
  Leemhuis (1)


xfrm: TCP MSS calculation broken by commit b515d263, results in TCP stall
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220114173133.tzmdm2hy4flhblo3@dwarf.suse.cz/
https://lore.kernel.org/netdev/20220114173133.tzmdm2hy4flhblo3@dwarf.suse.cz/

By Jiri Bohac, 37 days ago; 13 activities, latest 4 days ago.
Introduced in b515d2637276 (v5.14-rc1)

Fix incoming:
* Revert "xfrm: xfrm_state_mtu should return at least 1280 for ipv6"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=a6d95c5a628a09be129f25d5663a7e9db8261f51


Intel TGL notebook no longer enters power states deeper than PC2
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/
https://lore.kernel.org/regressions/34eb9d46-d937-fc29-02b1-7cfb9162f9b8@leemhuis.info/

By MarcelHB, 31 days ago; 19 activities, latest 10 days ago.
Introduced in e5ad96f388b7 (v5.15-rc1)

Recent activities from: Keith Busch (4), Christoph Hellwig (3), Jonathan
  Derrick (1)

One patch associated with this regression:
* Re: [PATCH] nvme/pci: default to simple suspend
  https://lore.kernel.org/linux-nvme/20220207160655.GB635727@dhcp-10-100-145-180.wdc.com/
  13 days ago, by Keith Busch

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215467
* [Bug] nvme blocks PC10 since v5.15 - bisected
  https://lore.kernel.org/lkml/CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com/
  30 days ago, by Rafael J. Wysocki; thread monitored.
* [PATCH] nvme/pci: default to simple suspend
  https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/
  19 days ago, by Keith Busch; thread monitored.


sched: DMA Engine regression because of sched/fair changes
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220112152609.gg2boujeh5vv5cns@yadro.com/
https://lore.kernel.org/lkml/20220112152609.gg2boujeh5vv5cns@yadro.com/

By Alexander Fomichev, 39 days ago; 9 activities, latest 23 days ago.
Introduced in 7332dec055f2 (v4.16-rc1)


3D===================================================================================
previous cycle (v5.15..v5.16), unkown culprit, with activity in the past three weeks
====================================================================================


[ *NEW* ] net: wireless: rtw_8822ce: Wifi connection doesn't really work anymore
--------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com/
https://lore.kernel.org/linux-wireless/CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com/

By Nico Sneck, 6 days ago; 1 activities, latest 6 days ago.
Introduced in v5.15..v5.16

Recent activities from: Nico Sneck (1)


=============================================================================
older cycles (..v5.15), unkown culprit, with activity in the past three weeks
=============================================================================


100 ms boot time increase regression in acpi_init()/acpi_scan_bus()
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de/
https://lore.kernel.org/lkml/b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de/

By Paul Menzel, 41 days ago; 3 activities, latest 12 days ago.
Introduced in v5.13..v5.14-rc1

Recent activities from: Rafael J. Wysocki (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215419


backlight: Intel_backlight does not work after updating from 5.10.89 to latest 5.15.17
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/
https://lore.kernel.org/regressions/74ee2216-a295-c2b6-328b-3e6d0cc1847e@leemhuis.info/

By Filippo Falezza, 20 days ago; 1 activities, latest 20 days ago.
Introduced in v5.10.89..v5.15.17

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215553


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/164417878250.37935.12983723607063220199@leemhuis.info

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
