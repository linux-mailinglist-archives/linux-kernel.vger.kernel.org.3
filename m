Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90C54CC330
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiCCQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCCQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:49:36 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08FF514A07A;
        Thu,  3 Mar 2022 08:48:51 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nPodF-00006B-00; Thu, 03 Mar 2022 17:48:49 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 18EF9C28F6; Thu,  3 Mar 2022 17:48:42 +0100 (CET)
Date:   Thu, 3 Mar 2022 17:48:42 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v5.17
Message-ID: <20220303164842.GA12460@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d9565bf40da22426d2f660cb31700b6858d1911d:

  MIPS: DTS: CI20: fix how ddc power is enabled (2022-02-09 13:58:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_4

for you to fetch changes up to 5d8965704fe5662e2e4a7e4424a2cbe53e182670:

  MIPS: ralink: mt7621: use bitwise NOT instead of logical (2022-03-01 10:08:45 +0100)

----------------------------------------------------------------
- Fix memory detection for MT7621 devices
- Fix setnocoherentio kernel option
- Fix warning when CONFIG_SCHED_CORE is enabled

----------------------------------------------------------------
Alexander Lobakin (1):
      MIPS: smp: fill in sibling and core maps earlier

Chuanhong Guo (1):
      MIPS: ralink: mt7621: do memory detection on KSEG1

Ilya Lipnitskiy (1):
      MIPS: ralink: mt7621: use bitwise NOT instead of logical

Randy Dunlap (1):
      mips: setup: fix setnocoherentio() boolean setting

 arch/mips/kernel/setup.c  |  2 +-
 arch/mips/kernel/smp.c    |  6 +++---
 arch/mips/ralink/mt7621.c | 36 +++++++++++++++++++++++-------------
 3 files changed, 27 insertions(+), 17 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
