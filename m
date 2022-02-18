Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9F4BBE90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiBRRkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:40:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbiBRRkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:40:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2439B6EB3A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52E761FFA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C774C36AE5;
        Fri, 18 Feb 2022 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645206000;
        bh=vLSGghE8lyFXLQvY6tEKN0r5r0LYeDJ6Hm+MSi/+wJ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T04Hn8oUC/ILR2OdWybEkv7fn5g0YuYiWSxNCw47hgNZZZpSVfVivJyp4OxNw2+9R
         CQuwIaIhS3v+8KNGQRJJL3CzhGKWJjSSTPk15Klb8UwnsqDu/aJS4XcJ3PORLlvXF6
         VKHTIc/A0AIH7gleQFnsvdChzxYPNz9Xm5bXrg9k19dgDl2LTpKkGRi1cXuypeMoYO
         sFAtzUVHXkOnCOeAOC54cgmH5z+ETgPx7Qb8qsCwr+LuhmG7fQJKQCiMOUwvWfu+tf
         XEG36VrFwhjCOSj3BFMQa+NfhWTs9JKS48/YMlQvr7xHwmwXYDB+y6NEIgwiajkfp9
         I8ciWGJ7Buqsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B0D2E6BBD2;
        Fri, 18 Feb 2022 17:40:00 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220218153617.016a905a@xps13>
References: <20220218153617.016a905a@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220218153617.016a905a@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.17-rc5
X-PR-Tracked-Commit-Id: 36415a7964711822e63695ea67fede63979054d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7993e65fdd0fe07beb9f36f998f9bbef2c0ee391
Message-Id: <164520600010.19024.296245073245345030.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Feb 2022 17:40:00 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 15:36:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7993e65fdd0fe07beb9f36f998f9bbef2c0ee391

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
