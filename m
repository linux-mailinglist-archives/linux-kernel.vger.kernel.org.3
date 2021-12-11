Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01EC4714F0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhLKR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhLKR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:28:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D73C061714;
        Sat, 11 Dec 2021 09:28:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD153B80B2B;
        Sat, 11 Dec 2021 17:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AE33C341C3;
        Sat, 11 Dec 2021 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639243725;
        bh=MA+kJuIlCfMgknttMCZ3gd2d0dqbF19Ppx51ou1+g48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SkAZC977XGfqp1O9+l+28Os1r4bww0LePkFG3lLkMyvl/fqfAt6Xb1LSlgIw55PEk
         yA4d5IEw+CFf5sQsXcfLI4hNklh1pYXA7DhCVIBzUYphvBkC8o5qBGRWTFw9XlQCgO
         Xt8+GhDWf+NjA9O4sh+7W2tEAGSS/BJ0SiOrQ/lnI2CFauKa0pEsDvgO69Jf25khnE
         YQnwgI9P0uJI4EBB0rZIngEt8BIJWYhYe72Yuc6nygweOHw2HF0szOHsCrflVAUGbc
         AMJlGUB0mdw2JFU4n9B68ixoJV46aHlH04OTBmUP6BdZCnZhled+4OIWB8jCisR5JS
         a2axRvXYtSZow==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4D67460BD0;
        Sat, 11 Dec 2021 17:28:45 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211211022912.3311440-1-sboyd@kernel.org>
References: <20211211022912.3311440-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211211022912.3311440-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 2d4fcc5ab35fac2e995f497d62439dcbb416babc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2acdaf59e5958a96500b035830384168dbbe099e
Message-Id: <163924372531.9148.2784883854642582256.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 17:28:45 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 18:29:11 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2acdaf59e5958a96500b035830384168dbbe099e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
