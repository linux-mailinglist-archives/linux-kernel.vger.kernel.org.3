Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85B148B8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiAKUxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbiAKUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B0AC034006
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57807616C3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B5EAC36AEF;
        Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934389;
        bh=y4FqKYM0EZqjhdSdjUsml/kpmJkuX/4FZDtLEozQKX4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BXl9Wn69au3gfg6Px/F134q0kK0nK4ZiXIX0xLesHnzb3cyd9ghmIKsdCkv/3of1J
         0jyz+eCe+qYmUGJh5Xz521tZ/sZ7RVB2esw2xiNcZl6XX3nBKvMWHXOhVLhMghGh0o
         mg8UPEjsK36k3ZBtZX5LGcWmEMqDPjteH4L3aXCo6eHGG6LI30EbICl9CSk2rdS4Ng
         3uez9N5k3MhZC0Bi3LUY3hFYfqNcxB31MGnw3rhy7l/BLK83oOlj3YOc1HWDeo9/Dp
         1ffqKHphxkgv7pvmFW3wa/g/cDlAUbkuZRIwhCXzz08IREtunddryLaNJbEep9hJ2q
         n8eBQQAEVpnfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B66AF6078A;
        Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110132929.8B6D8C36AE5@smtp.kernel.org>
References: <20220110132929.8B6D8C36AE5@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110132929.8B6D8C36AE5@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.17
X-PR-Tracked-Commit-Id: bfff546aae50ae68ed395bf0e0848188d27b0ba3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fef8dfaea9d6c444b6c2174b3a2b0fca4d226c5e
Message-Id: <164193438910.11435.4228420009955898906.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 13:29:13 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fef8dfaea9d6c444b6c2174b3a2b0fca4d226c5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
