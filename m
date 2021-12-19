Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8395147A219
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhLSUej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbhLSUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:34:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D49C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10258B80DBF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 20:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB343C36AE7;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639946069;
        bh=ut8bzpF8m5cdB7rkTMOKf7qUCfVgtVRBOamSzWzUCbE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UyvwxnA29evUg+rZSQ9krl/fGRBjeJaX23e48cNmg1EIniGRmcxBRTCjdb705DT8Q
         QkgxlRLtNRvRJ8v8xh6WgFxF46adxetQKWS94R1vHcScQ5lr9dcbaxzv5SDEyieQBA
         +8vbmRKHTam1KgMtEow745AZzq3wtMQ9fXX38HyfKdRl6fYih+uGBBBUdjwuJSjC3z
         LuF747t3KCSRRT4lEfdNsie7fzG3SXQ2u9ERVW1y2UXijmWIcJUQoFoPn3AzGBIbyX
         olT65Mt44PKRaFfueOh/kDX6cWneMTE7D5Z3O/rbvAgIPDBPJTGUCGgXjghR16TaNA
         uURsKi6q4JMRg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 87E3D60A6F;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
Subject: Re: [GIT PULL] core/urgent for v5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yb82O5i2DVcK9nAJ@zn.tnic>
References: <Yb82O5i2DVcK9nAJ@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yb82O5i2DVcK9nAJ@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.16_rc6
X-PR-Tracked-Commit-Id: 6c3118c32129b4197999a8928ba776bcabd0f5c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c36d891d787d03b36e18aa4ef254eebe6060b39a
Message-Id: <163994606955.11038.14171376551168733584.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:34:29 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Dec 2021 14:40:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c36d891d787d03b36e18aa4ef254eebe6060b39a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
