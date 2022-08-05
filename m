Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC458ADC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiHEP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbiHEP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:56:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E2D94;
        Fri,  5 Aug 2022 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659714950;
        bh=qz85uU+tOnmR0AteWIOLiGeXxgQrVxjjX0htQ9uuwk4=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=baNdOGFxnhK/hvMaSWj51ixHAbsWhrNo5JBjG7k6VRH8DMtmVm4qTmZbNzHgvBJWd
         eccRp51bb1NeUbfLst72zSdnKNeLxqLr033n1GCX2D3HufVtKZbfCSllvLvyJX7uGQ
         semLAYuLAPJNQK/Y+JzvQd2ZEOAS3ktqmhOnePMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.139.128]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1nnew81W0Y-00gawC; Fri, 05
 Aug 2022 17:55:50 +0200
Date:   Fri, 5 Aug 2022 17:55:46 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes and updates for v5.20-rc1
Message-ID: <Yu09gjA99eDcPNFM@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:lFJBL0IcNQ0tJLX/2H4A66QIte4cR+/qxlFnxo3hhlHVJydOqDJ
 QkA+Zv1wH6VY0D+8XlAGurRWGQPB5DUO23GyBAU0/VKdZHBVwPjF0uA6GvnctBXO3Bie//X
 4SVWF/TeSD4bYT6XpzmII4j8+vH22F1HS0bFl0UXKHgcG653EiOa0Gv2tikHkqCHkXniSrB
 Qxburc6MbIFAZYj/vpZNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uA+XH9mc53s=:c+psU45UPbY/BK9G42HrqA
 KfpPoPws7VdubNwz9JDsnPaQeiVbSxL/E5xkyx43mXr+bl293Qkz2QvWTNehPpZ/RM9y9RCSU
 2uxwaGddFktaADOTByXVgcXtpIkZ9w2HVAEFidvwH35bCnBA5VOJnFYQAdz5rhzDq+3ekqi15
 8QBNsmPr/H0NZAtRuTskjnhC2aOklDhalKw6OFWs7e/twvVEiaHU4Qj4q9x8lqBnMjI5r02aS
 czZr6Rk7e3WDwF22QkhdZcyIdKkR+RHp95fYUPXEYz/9Sm5+gjmemkPcBV7zE/k874Ot1Ew4p
 kQBJt4fpjs4HRBRmbo6lQdUX7D5l7qAE6ilhF3LWfDayVW1/4hWWFXx6HVXbP9k5siUHdvG0B
 x1GXeJdnZyfnTfNx2yjt3hYrtBs5S2x42+f8TRpBPVSC5QiNELJFZ0VYct2mfSpi1NDgHNfrD
 RiUJMx8S6l7XFcp7JsUUV2TfUSLa5niJ9SlJq2D2M/mT5pme8RXUyXAFaQnB0gVbuIq/6AdGQ
 ErE9ykRFd9FBLW8PT8kWNTfHwyY2D+Dcji7l6wy9xg6/tGj/lOiwbklO17BF539KYm+EvFeor
 rREAGDufKTyVoI7b6bx7yxxHj2Pvaw5MirXA7AG9RvnPSXBbZ4fzHF+0C1HxwIY4B9gDJGsCv
 hDZzc39alN+rSFW3nS4Ff0OEHLCr/JAz1LVmeGQYuenCBYzedPzDVQcPsJNVgPYYoKciI2Bte
 LIa82atdZi/9OJTaBTvvu7z+KaaAWG1bwHz8/BZUDEg5VLUHLV9UfM5ikixmgMd60KFrEptvM
 TG/Kif/AbZ4D9WwWDOMdzxfzEcRAARJ1KkvF5wBhI/ByA1uObyk7Oe9lxEtzLwp/tjOJL0KUL
 LRnf9MiPWKmbAJTZYF51N0NYap0CCL1SFEwFERLduC6PQYfGcqiFBEucoG2oMe1wuIHBZKvvZ
 V1aF+mghk+bZ+JVHXM+lfmqKnCE+zBnjV8Casd6OYXdQeXpGYd8SPjwlG2vvvhSokqMsFf8hT
 BoCowqQqMw/JIMY7KqdYWRn563N4VfxxckBHAWm8955jUR8bt24TZ1Y9m1ZbczhGuowRcGFag
 +dd37gvsoDCjlzEwf2BRVZ4rKe/3UzCXceFoCoUVUl5TFOTckegX2rMvA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.20/parisc-1

for you to fetch changes up to e61b3125a4f036b3c6b87ffd656fc1ab00440ae9:

  Input: gscps2 - check return value of ioremap() in gscps2_probe() (2022-08-02 10:31:59 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v5.20-rc1:

One real bugfix to change the io_pgetevents_time64() syscall to use the compat
implementation when running in compat mode, otherwise the signed int32
parameters min_nr and nr will be incorrectly handled as unsigned int64 values.

Other than that just small cleanups:
* hardware database housekeeping and proper /proc/iomem output
* add function exit code if probe functions fail
* drop stale variables (pa_swapper_pg_lock)
* drop unneccessary zero-initializations
* typo fixes in comments

----------------------------------------------------------------
Helge Deller (4):
      parisc: Clean up names in hardware database
      parisc: Fix device names in /proc/iomem
      parisc: Drop pa_swapper_pg_lock spinlock
      parisc: io_pgetevents_time64() needs compat syscall in 32-bit compat mode

Jason Wang (2):
      parisc: Fix comment typo in fault.c
      parisc: Drop zero variable initialisations in mm/init.c

William Dean (1):
      parisc: Check the return value of ioremap() in lba_driver_probe()

Xie Shaowen (1):
      Input: gscps2 - check return value of ioremap() in gscps2_probe()

Xin Gao (1):
      parisc: Do not initialise statics to 0

 arch/parisc/kernel/cache.c              |  3 ---
 arch/parisc/kernel/drivers.c            |  9 ++++-----
 arch/parisc/kernel/hardware.c           | 11 ++++-------
 arch/parisc/kernel/pci-dma.c            |  4 ++--
 arch/parisc/kernel/syscalls/syscall.tbl |  2 +-
 arch/parisc/mm/fault.c                  |  2 +-
 arch/parisc/mm/init.c                   |  2 +-
 drivers/input/serio/gscps2.c            |  4 ++++
 drivers/parisc/lba_pci.c                |  6 +++++-
 9 files changed, 22 insertions(+), 21 deletions(-)
