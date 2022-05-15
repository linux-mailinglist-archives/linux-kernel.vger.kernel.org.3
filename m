Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875805278C7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiEOQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiEOQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 12:36:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D383DFFA
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 09:36:55 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nqHEj-00022T-CU; Sun, 15 May 2022 18:36:53 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-05-15]
Date:   Sun, 15 May 2022 16:36:51 +0000
Message-Id: <165263184972.441566.6613731168195248776@leemhuis.info>
X-Mailer: git-send-email 2.34.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1652632616;f9af9837;
X-HE-SMSGID: 1nqHEj-00022T-CU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Find below a quick compilation of open reports about
regressions in 5.18-rc that I'm currently aware of.

There is WIP for most of them:

* the "clk/bcm2835 breaking raspi" is report and patch at the same time
that is more that two weeks old, but seems the maintainer hasn't picked
it up yet :-/

* for the "input/usb problem with bcm5974" there is a rough but already
tested patch in bugzilla

* didn't look closely at the "mm: [mm/page_alloc]  f26b3fa046:
netperf.Throughput_Mbps -18.0% regression" thing, you were involved in
those discussions yourself

* for the "net: dpaa2" thing there is a patch in bugzilla that is
awaiting testing by the reporter

* for the intel graphics problem a patch was tested and discussed on the
list, but not yet heading towards you afaics

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 30 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.17.. aka v5.18-rc), culprit identified
========================================================


[ *NEW* ] clk: bcm2835: 09e3b18ca5de broke the behavior of bcm2835_clock_choose_div() and booting of Raspberry Pi booting of Raspberry Pi
-----------------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220428183010.1635248-1-stefan.wahren@i2se.com/
https://lore.kernel.org/lkml/20220428183010.1635248-1-stefan.wahren@i2se.com/

By Stefan Wahren; 16 days ago; 5 activities, latest 1 days ago.
Introduced in 09e3b18ca5de (v5.18-rc1)

Recent activities from: Stefan Wahren (1), Maxime Ripard (1)


input/usb/???: bcm5974 trackpad causes error: xhci_hcd rejecting DMA map of vmalloc memory
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/76e24afa-ad7d-bf6d-d610-df61851b3e2b@leemhuis.info/
https://lore.kernel.org/linux-usb/76e24afa-ad7d-bf6d-d610-df61851b3e2b@leemhuis.info/

By Satadru Pramanik; 11 days ago; 4 activities, latest 2 days ago.
Introduced in f5ff79fddf0e (v5.18-rc1)

Recent activities from: Christoph Hellwig (2), Thorsten Leemhuis (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215890


[ *NEW* ] mm: [mm/page_alloc]  f26b3fa046:  netperf.Throughput_Mbps -18.0% regression
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220420013526.GB14333@xsang-OptiPlex-9020/
https://lore.kernel.org/lkml/20220420013526.GB14333@xsang-OptiPlex-9020/

By kernel test robot; 25 days ago; 33 activities, latest 2 days ago.
Introduced in f26b3fa04611 (v5.18-rc1)

Recent activities from: ying.huang@intel.com (5), Linus Torvalds (5),
  Aaron Lu (5), Waiman Long (3), Andrew Morton (1), Peter Zijlstra (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0% regression
  https://lore.kernel.org/lkml/YnuYV3J2ljY88DyQ@ziqianlu-desk1/
  4 days ago, by Aaron Lu


net: dpaa2: TSO offload on lx2160a causes fatal exception in interrupt
----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/7ca81e6b-85fd-beff-1c2b-62c86c9352e9@leemhuis.info/
https://lore.kernel.org/netdev/7ca81e6b-85fd-beff-1c2b-62c86c9352e9@leemhuis.info/

By Unkown; 11 days ago; 3 activities, latest 2 days ago.
Introduced in 3dc709e0cd47 (v5.18-rc1)

Recent activities from: Jakub Kicinski (1)

Noteworthy links:
* https://bugzilla.kernel.org/show_bug.cgi?id=215886


drm/i915: BYT rendering broken due to "Remove short-term pins from execbuf, v6"
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
https://lore.kernel.org/dri-devel/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/

By Hans de Goede; 7 days ago; 8 activities, latest 3 days ago.
Introduced in b5cfe6f7a6e1 (v5.18-rc1)

Recent activities from: Matthew Auld (2), Maarten Lankhorst (2),
  Patchwork (2)

Noteworthy links:
* [PATCH] drm/i915: Use i915_gem_object_ggtt_pin_ww for reloc_iomap
  https://lore.kernel.org/dri-devel/20220511115219.46507-1-maarten.lankhorst@linux.intel.com/
  4 days ago, by Maarten Lankhorst; thread monitored.
* https://gitlab.freedesktop.org/drm/intel/-/issues/5806


3D============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/165209064657.193515.10163777181547077546@leemhuis.info

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
