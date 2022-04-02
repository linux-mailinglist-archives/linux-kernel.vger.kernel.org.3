Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16B4F010E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354650AbiDBL3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348433AbiDBL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:29:21 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF9101A6E4E;
        Sat,  2 Apr 2022 04:27:29 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nabuh-0000Ts-00; Sat, 02 Apr 2022 13:27:27 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E7F35C4E4E; Sat,  2 Apr 2022 13:27:19 +0200 (CEST)
Date:   Sat, 2 Apr 2022 13:27:19 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes vor v5.18
Message-ID: <20220402112719.GA5234@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8f9f21c7848e63133c16c899f3d84aa54eb79fe:

  MIPS: Fix build error for loongson64 and sgi-ip27 (2022-03-24 09:45:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.18_1

for you to fetch changes up to 41022eff9c2d21e658c7a6fcd31005bf514d28b7:

  MIPS: crypto: Fix CRC32 code (2022-04-01 10:19:03 +0200)

----------------------------------------------------------------
- build fix for gpio
- fix crc32 build problems
- check for failed memory allocations

----------------------------------------------------------------
Jackie Liu (1):
      MIPS: rb532: move GPIOD definition into C-files

Paul Cercueil (1):
      MIPS: crypto: Fix CRC32 code

Xiaoke Wang (2):
      mips: sgi-ip22: add a check for the return of kzalloc()
      MIPS: lantiq: check the return value of kzalloc()

 arch/mips/crypto/crc32-mips.c           | 46 +++++++++++++++++++--------------
 arch/mips/include/asm/mach-rc32434/rb.h |  9 -------
 arch/mips/lantiq/falcon/sysctrl.c       |  2 ++
 arch/mips/lantiq/xway/gptu.c            |  2 ++
 arch/mips/lantiq/xway/sysctrl.c         | 46 +++++++++++++++++++++------------
 arch/mips/rb532/gpio.c                  | 10 +++++++
 arch/mips/sgi-ip22/ip22-gio.c           |  2 ++
 7 files changed, 72 insertions(+), 45 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
