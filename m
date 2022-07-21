Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A157CE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiGUO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiGUOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:55:57 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6F11477
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:55:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D280162B9C5F;
        Thu, 21 Jul 2022 16:55:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eb-p_8buOLki; Thu, 21 Jul 2022 16:55:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7DF43615CC8F;
        Thu, 21 Jul 2022 16:55:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hnghox_vwKZD; Thu, 21 Jul 2022 16:55:50 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4C8D862B9C5F;
        Thu, 21 Jul 2022 16:55:50 +0200 (CEST)
Date:   Thu, 21 Jul 2022 16:55:49 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Message-ID: <1803003448.13661.1658415349943.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD fix for 5.19-final
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: xGq0B3rDLG5KF75EXGNeR2hH8Si0zQ==
Thread-Topic: MTD fix for 5.19-final
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.19-final

for you to fetch changes up to 0fddf9ad06fd9f439f137139861556671673e31c:

  mtd: rawnand: gpmi: Set WAIT_FOR_READY timeout based on program/erase times (2022-07-15 17:41:11 +0200)

----------------------------------------------------------------
NAND controller fix:
 * gpmi: Fix busy timeout setting (wrong calculation, yes again)

----------------------------------------------------------------
Sascha Hauer (1):
      mtd: rawnand: gpmi: Set WAIT_FOR_READY timeout based on program/erase times

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
