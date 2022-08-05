Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89158A475
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbiHEB2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbiHEB20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:28:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3891BEB6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D3DBB827DB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC22FC433B5;
        Fri,  5 Aug 2022 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659662902;
        bh=oiZfKLWa+yEDthRfnqmZInTGLkDM92qbEzrE4F8lnzU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ym09tN2uZofXE1bBEum7rcXIA4DdZCdpIAwyIJOFFftIZePL4bxvZCK9+3ethLlYF
         u4DJVGcpJTjWkmCim4zVa+Rx93CROT03rv78/nivkQillF7aS6PcLy6U4hRAz54wYg
         r3G1YIdFZiIzJ0K507VRkP0NZbYQK5rCjLSihN29MkJRIood2KkENApgewpmfUNQvp
         IT+5DP1NJyPOg4xWiDasxNJvPWVI7eyf1DGVcK0DMxabqGCdmylJBNMd3GoufH2aUj
         atAdBt92b0VDqkh+1UNge3JTPxNQwGFAfncZLHZI5Wm28GrrrLa3ZI6zN+cfI7L3tv
         Po5SCJjzFFq/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB11C43140;
        Fri,  5 Aug 2022 01:28:22 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <09ab7d4f-f1d6-7783-651f-e95b68533a59@redhat.com>
References: <09ab7d4f-f1d6-7783-651f-e95b68533a59@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <09ab7d4f-f1d6-7783-651f-e95b68533a59@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.0-1
X-PR-Tracked-Commit-Id: 3d46d78480757e6d403c3bc2b32d2b05ecbed543
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f0848190c6dd0f5b8a2aaf0f1d900a96d96bee0
Message-Id: <165966290269.8823.12320455981723293016.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 01:28:22 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 12:46:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f0848190c6dd0f5b8a2aaf0f1d900a96d96bee0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
