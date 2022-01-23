Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6821449705B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiAWGSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 01:18:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39764 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiAWGSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 01:18:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603206114F;
        Sun, 23 Jan 2022 06:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8263C340E3;
        Sun, 23 Jan 2022 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642918701;
        bh=jIF52wPB5rWGB5zQ+RKVpdDwIHaInkE5/sNQVP+4GTY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vCRkFgwVeDb3bdBXFd9N2KzuRmsJ0WM3Mw7DXj/7RCSM7t7fOdV3gLU27ZXKsVVUx
         5Lc6ddFgNe8kWMn34Bh4EDfK5QeRT15qFtev7AQBcc8jgfi1QjLDHk4CCTH5BvA6Qd
         H5jC3SBusT5vqOVLpA+pr2tOjtpXCRNRdXnkLc5RGsU8Xb/BZWkWMPQC9uJcJRjiPS
         GVbQspvrR2LIvMW55aJZ20rI6aNst4ZndtR3IvkXqMaOeYh317X7n56LvmCFQzecI8
         gfroXBO7toHeyEwMIBg5LGVhIvPuZifPTCHjOowGV7juz2eleckggJYtQbZ3Fg9QO1
         KljJeeBywjK5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7232F60795;
        Sun, 23 Jan 2022 06:18:21 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASs0jntOj63GoE9Lhasb-7zmVzBcq35CDeKnBqjG_v+kw@mail.gmail.com>
References: <CAK7LNASs0jntOj63GoE9Lhasb-7zmVzBcq35CDeKnBqjG_v+kw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASs0jntOj63GoE9Lhasb-7zmVzBcq35CDeKnBqjG_v+kw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.17
X-PR-Tracked-Commit-Id: e6340b6526eeec5a00fe26a6ff515afe7d0affa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 473aec0e1f84be97c7ea52c4266b7ef13ce36af3
Message-Id: <164291870174.10836.13232297867466149802.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 06:18:21 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jan 2022 00:17:58 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/473aec0e1f84be97c7ea52c4266b7ef13ce36af3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
