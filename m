Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E75A3F15
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 20:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiH1SXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 14:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiH1SXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:23:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E872A957
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 11:23:13 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oSMwB-0006AL-MV; Sun, 28 Aug 2022 20:23:11 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-08-28]
Date:   Sun, 28 Aug 2022 18:23:10 +0000
Message-Id: <166170992386.1651569.17504808724724706636@leemhuis.info>
X-Mailer: git-send-email 2.37.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661710993;ef9f9c51;
X-HE-SMSGID: 1oSMwB-0006AL-MV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below is a slightly edited report from regzbot listing all
regression from this cycle that the bot and I are aware of. The list is
a bit longer than last cycle, as I keep an eye on bugzilla this cycle again.

Not sure, maybe it would have been good if the following fix would have
found the way into rc3, as it seems more than just one or two people
already stumbled over the regression fixed by it:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&ida8e0f6b01b14b2e28ba144e112c883f03a3db2
https://lore.kernel.org/all/?q�bffc7*

But well, it's not as bad as the regression caused by the "Rework
asynchronous resume support" commit that you reverted on Friday, which
iirc at least five different people had bisected in the past two
weeks... :-/ I should have have prodded the maintainers to speed up to
get this fixed before rc2, which would have saved a few people some
trouble; too late now, but well, I learned my lesson.

BTW, the 0-bot people make regzbot now track regressions their bot
finds. I'm not yet sure if that is a good idea, as it seems quite a few
developers don't even bother to reply to the reports from the bot -- at
least that's the fate so far for four recent mainline problems 0-bot
reported while getting regzbot involved:

https://lore.kernel.org/lkml/c8310cba-36ef-2940-b2c2-07573e015185@intel.com/
https://lore.kernel.org/lkml/db909f88-3f5c-afc8-424c-ced3f371037f@intel.com/
https://lore.kernel.org/lkml/8a410343-b82a-0972-0f26-cc63b50d2ef9@intel.com/
https://lore.kernel.org/lkml/YvpZYGa1Z1M38YcR@xsang-OptiPlex-9020/

HTH, Ciao, Thorsten

---
Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 62 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v5.19.. aka v6.0-rc), culprit identified
=======================================================


[ *NEW* ] pm: booting on NXP i.MX8ULP broke
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com/
https://lore.kernel.org/linux-arm-kernel/DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com/

By Peng Fan; 12 days ago; 24 activities, latest 0 days ago.
Introduced in 5a46079a9645 (v6.0-rc1)

Fix incoming:
* Revert "driver core: Delete driver_deferred_probe_check_state()"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=13a8e0f6b01b14b2e28ba144e112c883f03a3db2


[ *NEW* ] [bisected][regression] mediatek bluetooth 13d3:3563 (mt7921e) doesn't work with audio devices.
--------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216382/
https://bugzilla.kernel.org/show_bug.cgi?id=216382
https://lore.kernel.org/regressions/167d11c6-68a4-c10a-9703-fceaddac3e42@leemhuis.info/

By Arek Ruśniak and Arek Ruśniak; 9 days ago; 4 activities, latest 8 days ago.
Introduced in 26afbd826ee3 (v6.0-rc1)

Recent activities from: Arek Ruśniak (3), Luiz Von Dentz (1)


===================================================
current cycle (v5.19.. aka v6.0-rc), unkown culprit
===================================================


[ *NEW* ] Unable to handle kernel NULL pointer dereference at virtual address 00000008
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216420/
https://bugzilla.kernel.org/show_bug.cgi?id=216420
https://lore.kernel.org/lkml/29a5c3e3-a590-01dd-1a2b-8415cae4a292@leemhuis.info/

By frc.gabriel and frc.gabriel; 1 days ago; 4 activities, latest 0 days ago.
Introduced in v5.19..v6.0-rc2

Recent activities from: frc.gabriel (3), The Linux kernel's regression
  tracker (Thorsten Leemhuis) (1)


[ *NEW* ] [regression] nl80211: kernel reports: key addition failed
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216421/
https://bugzilla.kernel.org/show_bug.cgi?id=216421
https://lore.kernel.org/lkml/dd37d8af-d7e4-daee-1f80-36c53fbac076@leemhuis.info/

By XiaoYan Li and XiaoYan Li; 1 days ago; 1 activities, latest 1 days ago.
Introduced in v6.0-rc1..v6.0-rc2

Recent activities from: XiaoYan Li (1)


[ *NEW* ] acpi wake up with black screen(failed to get iomux index)
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216371/
https://bugzilla.kernel.org/show_bug.cgi?id=216371
https://lore.kernel.org/lkml/849a07ba-a53c-3f10-e2ec-25421c1e40ee@leemhuis.info/

By neoe and neoe; 11 days ago; 16 activities, latest 1 days ago.
Introduced in v5.19..v6.0-rc2

Recent activities from: neoe (9), Mario Limonciello (AMD) (7)


[ *NEW* ] pci or amdgpu: Uncorrected errors reported for AMD GPU
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220818203812.GA2381243@bhelgaas/
https://lore.kernel.org/linux-pci/20220818203812.GA2381243@bhelgaas/
https://bugzilla.kernel.org/show_bug.cgi?id=216373

By Bjorn Helgaas and Tom Seewald; 9 days ago; 17 activities, latest 2 days ago.
Introduced in v5.19..v6.0-rc1

Recent activities from: Bjorn Helgaas (5), Christian König (4), Lazar,
  Lijo (4), Tom Seewald (2), Felix Kuehling (1), Stefan Roese (1)

One patch associated with this regression:
* Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
  https://lore.kernel.org/linux-pci/20220819171303.GA2491617@bhelgaas/
  9 days ago, by Bjorn Helgaas


[ *NEW* ] New 6.1 net/mac80211/rx.c warning with iwlwifi / Ultimate-N 6300 wifi
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/498d714c-76be-9d04-26db-a1206878de5e@redhat.com/
https://lore.kernel.org/linux-wireless/498d714c-76be-9d04-26db-a1206878de5e@redhat.com/

By Hans de Goede; 8 days ago; 3 activities, latest 6 days ago.
Introduced in v5.19..v6.0-rc1

Recent activities from: Johannes Berg (1), Luís Henriques (1), Hans de
  Goede (1)

=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/165869171256.283493.2326902986633030609@leemhuis.info

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
