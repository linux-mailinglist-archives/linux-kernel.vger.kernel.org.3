Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293258CDE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiHHSnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244486AbiHHSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132686408;
        Mon,  8 Aug 2022 11:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E7986123E;
        Mon,  8 Aug 2022 18:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FEA2C433D6;
        Mon,  8 Aug 2022 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659984129;
        bh=dLom5WoDPgVle1FZKTXD4cAFJ5jFaVJGbqS8M3xe9uA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i6Lpan5mvz3Vv2swH+gcfs0g71s7HszoJwCQ0Gs3KhvpXWY4EcLkcoNbgSIn66CFf
         0DqGAf0FJYNdjqWYMzxL7FiCixOPAT+3SJL4C0n7uhpJaDbjwC6w8dOQ0w16H2BrNv
         85rbcv8ot5iDVfAbxQfL5/MOGqtBe4wxxzz6rlODfdGeMlwzcrV0lhQ9nZRJBMz+Jz
         5bYBMA2mpDQtEIc4TyudSfCu7Coz/lpHYi6N2tXrTyzJQnhxjwrH/nevtibJWZ2+zD
         ddIPxQFQGhbnP6Pl2cR1b+lEsmm5x4ynuUf5DXn+Btcxr9SBAw91Bp/XCQx04/oMJF
         FnlQCE+QglWWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F25FBC43140;
        Mon,  8 Aug 2022 18:42:08 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvD84wGcwBuUpdtn@kroah.com>
References: <YvD84wGcwBuUpdtn@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvD84wGcwBuUpdtn@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc1
X-PR-Tracked-Commit-Id: 0fec518018cc5ceffa706370b6e3acbbb1e3c798
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 607ca0f742b7d990b6efb3c3e7a52830f7e96419
Message-Id: <165998412898.757.4684873970176787879.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 18:42:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 14:09:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/607ca0f742b7d990b6efb3c3e7a52830f7e96419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
