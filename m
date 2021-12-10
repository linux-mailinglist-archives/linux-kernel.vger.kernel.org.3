Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D08470B33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbhLJUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:02:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56704 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhLJUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:02:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44D33B829BC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 19:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18769C341CA;
        Fri, 10 Dec 2021 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639166326;
        bh=fnNZwD/qJ/E4/7TN8VbxUfN5A4foEOaZ9nLOwDEkmYA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lwAlZxDJfSRgiustOkBE5GUoNcNz6kB68ZQUoLFeuU5OFDu682Pk4P601FFvi6nC6
         NJ/4PGB6Ny33ar4nRjCTPG7ZuA9FTgaZgOn1TT8df7eiE6H2J1G46CNUB8RL1OEkgN
         Z5oxZQO5tQPc5gImcV9duk7tYbzJTiAvzl5NYxq0FH0HY8iRtAqb11CC1yVSgBgl4d
         6PwQ3Vz9kW8AN4v5AB/08YvXr6zpvQDp7TtpMj+8zDa1vsfVKKIbeuFk4cqP4IfqlW
         GR22MQC6jNgQ/T4DTM4/kz4V+3vF1srrB+1D77RqOWicGMsOHhwE1RBxf8l/PMInip
         q9DfdZj77G+kw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08D2660A39;
        Fri, 10 Dec 2021 19:58:46 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twm_TjmNrr7VELofghf58qpo=-1VmFf_pNr6tBNKZL-aw@mail.gmail.com>
References: <CAPM=9twm_TjmNrr7VELofghf58qpo=-1VmFf_pNr6tBNKZL-aw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twm_TjmNrr7VELofghf58qpo=-1VmFf_pNr6tBNKZL-aw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-10
X-PR-Tracked-Commit-Id: 675a095789a2663fe02fdebd6023e29d7f1f51ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b302ffe4e8d7e62f3170aa0097ff979880ba61d
Message-Id: <163916632603.27955.13646553226998147096.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 19:58:46 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 14:28:53 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b302ffe4e8d7e62f3170aa0097ff979880ba61d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
