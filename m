Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6D5AC5EB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiIDSmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 14:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIDSmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 14:42:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C88028730
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 11:42:13 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oUuZP-0002hH-8B; Sun, 04 Sep 2022 20:42:11 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-09-04]
Date:   Sun,  4 Sep 2022 18:42:10 +0000
Message-Id: <166231521235.1982292.2102689915618920245@leemhuis.info>
X-Mailer: git-send-email 2.37.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662316933;66c41da2;
X-HE-SMSGID: 1oUuZP-0002hH-8B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below is a slightly edited report from regzbot listing all
regression from this cycle that the bot and I are aware of.

People are working on fixing most of those where the root cause it
known; for some a fix is not far away or even on your way already.
There is just one regression found by 0-day bot ("[sched] f3dd3f6745:
fxmark.ssd_ext4_no_jnl_DWSL_72_directio.works/sec -30.5% regression")
that didn't get a single reply; and one from 0-day ("d4252071b9:
fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec -26.5% regression")
where you replied, but nobody else.

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 9 regressions in linux-mainline introduced
this cycle. Find the current status below and the latest on the
web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v5.19.. aka v6.0-rc), culprit identified
=======================================================


[ *NEW* ] snd: IO_PAGE_FAULT and a lot of errors since a8d302a0b770
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CABXGCsO+kB2t5QyHY-rUe76npr1m0-5JOtt8g8SiHUo34ur7Ww@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsO%2BkB2t5QyHY-rUe76npr1m0-5JOtt8g8SiHUo34ur7Ww@mail.gmail.com/

By Mikhail Gavrilov; 1 days ago; 3 activities, latest 0 days ago.
Introduced in a8d302a0b770

Recent activities from: Takashi Iwai (2), Mikhail Gavrilov (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [BUG] commit a8d302a0b77057568350fe0123e639d02dba0745 cause IO_PAGE_FAULT and a lot of errors
  https://lore.kernel.org/lkml/875yi3froa.wl-tiwai@suse.de/
  0 days ago, by Takashi Iwai


[bisected][regression] mediatek bluetooth 13d3:3563 (mt7921e) doesn't work with audio devices.
----------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216382/
https://bugzilla.kernel.org/show_bug.cgi?id=216382
https://lore.kernel.org/regressions/167d11c6-68a4-c10a-9703-fceaddac3e42@leemhuis.info/

By Arek Ruśniak and Arek Ruśniak; 16 days ago; 11 activities, latest 1 days ago.
Introduced in 26afbd826ee3 (v6.0-rc1)

Recent activities from: bugzilla-daemon@kernel.org (2), Arek
  Ruśniak (1), patchwork-bot+bluetooth@kernel.org (1),
  bluez.test.bot@gmail.com (1), Luiz Von Dentz (1), Luiz Augusto von
  Dentz (1)

One patch associated with this regression:
* [PATCH] Bluetooth: hci_sync: Fix hci_read_buffer_size_sync
  https://lore.kernel.org/all/20220902002717.1823748-1-luiz.dentz@gmail.com/
  2 days ago, by Luiz Augusto von Dentz; thread monitored.


[ *NEW* ] d4252071b9:  fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec -26.5% regression
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Yw8L7HTZ/dE2/o9C@xsang-OptiPlex-9020/
https://lore.kernel.org/lkml/Yw8L7HTZ%2FdE2%2Fo9C@xsang-OptiPlex-9020/

By kernel test robot; 4 days ago; 2 activities, latest 4 days ago.
Introduced in d4252071b9 (v6.0-rc1)

Recent activities from: Linus Torvalds (1), kernel test robot (1)


[ *NEW* ] [sched]  f3dd3f6745: fxmark.ssd_ext4_no_jnl_DWSL_72_directio.works/sec -30.5% regression
--------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Yw9xPOWgpPc5a0Pu@xsang-OptiPlex-9020/
https://lore.kernel.org/lkml/Yw9xPOWgpPc5a0Pu@xsang-OptiPlex-9020/

By kernel test robot; 4 days ago; 1 activities, latest 4 days ago.
Introduced in f3dd3f6745 (v6.0-rc1)

Recent activities from: kernel test robot (1)


===================================================
current cycle (v5.19.. aka v6.0-rc), unkown culprit
===================================================


acpi wake up with black screen(failed to get iomux index)
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216371/
https://bugzilla.kernel.org/show_bug.cgi?id=216371
https://lore.kernel.org/lkml/849a07ba-a53c-3f10-e2ec-25421c1e40ee@leemhuis.info/

By neoe and neoe; 18 days ago; 18 activities, latest 0 days ago.
Introduced in v5.19..v6.0-rc2

Recent activities from: The Linux kernel's regression tracker (Thorsten
  Leemhuis) (1), Mario Limonciello (AMD) (1)


[regression] nl80211: kernel reports: key addition failed
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216421/
https://bugzilla.kernel.org/show_bug.cgi?id=216421
https://lore.kernel.org/lkml/dd37d8af-d7e4-daee-1f80-36c53fbac076@leemhuis.info/

By XiaoYan Li and XiaoYan Li; 8 days ago; 4 activities, latest 0 days ago.
Introduced in v6.0-rc1..v6.0-rc2

Recent activities from: Johannes Berg (2), The Linux kernel's regression
  tracker (Thorsten Leemhuis) (1)


Unable to handle kernel NULL pointer dereference at virtual address 00000008
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216420/
https://bugzilla.kernel.org/show_bug.cgi?id=216420
https://lore.kernel.org/lkml/29a5c3e3-a590-01dd-1a2b-8415cae4a292@leemhuis.info/

By frc.gabriel and frc.gabriel; 8 days ago; 7 activities, latest 0 days ago.
Introduced in v5.19..v6.0-rc2

Recent activities from: frc.gabriel (2), The Linux kernel's regression
  tracker (Thorsten Leemhuis) (1)


New 6.1 net/mac80211/rx.c warning with iwlwifi / Ultimate-N 6300 wifi
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/498d714c-76be-9d04-26db-a1206878de5e@redhat.com/
https://lore.kernel.org/linux-wireless/498d714c-76be-9d04-26db-a1206878de5e@redhat.com/

By Hans de Goede; 15 days ago; 6 activities, latest 2 days ago.
Introduced in v5.19..v6.0-rc1

Recent activities from: Johannes Berg (3)

Noteworthy links:
* [PATCH v2] wifi: mac80211: fix link warning in RX agg timer expiry
  https://lore.kernel.org/linux-wireless/20220902161130.af23678ddc21.I3d9a23c49e1df3bd0c91ef0e1c1805dd09937db8@changeid/
  2 days ago, by Johannes Berg; thread monitored.
* [PATCH v3] wifi: mac80211: fix link warning in RX agg timer expiry
  https://lore.kernel.org/linux-wireless/20220902170143.71fc830073b8.I3d9a23c49e1df3bd0c91ef0e1c1805dd09937db8@changeid/
  2 days ago, by Johannes Berg; thread monitored.
* [PATCH v4] wifi: mac80211: fix link warning in RX agg timer expiry
  https://lore.kernel.org/linux-wireless/20220902170201.9fa6c20e2c64.I3d9a23c49e1df3bd0c91ef0e1c1805dd09937db8@changeid/
  2 days ago, by Johannes Berg; thread monitored.


Uncorrected errors reported for AMD GPU
---------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216373/
https://bugzilla.kernel.org/show_bug.cgi?id=216373
https://lore.kernel.org/linux-pci/20220818203812.GA2381243@bhelgaas/

By Tom Seewald; 17 days ago; 51 activities, latest 2 days ago.
Introduced in v5.19..v6.0-rc1

Recent activities from: Gustaw Smolarczyk (14), Alex Deucher (12), Bjorn
  Helgaas (3), Lazar, Lijo (3), Lijo Lazar (2)

A patch posting is associated with this regression:
* [PATCH v2 1/2] drm/amdgpu: Move HDP remapping earlier during init
  https://lore.kernel.org/all/CADnq5_O1Z0FK99cKDmRuCoxg-hbD3LtcW1q3n4zvrB9xFo0XHw@mail.gmail.com/
  2 days ago, by Lijo Lazar; thread monitored


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/166170992386.1651569.17504808724724706636@leemhuis.info

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
