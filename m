Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813A489F36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbiAJS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39212 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D45926133F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8399C36AFA;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=IadbE7tSXJwOlhPZbwkmlGpsnPSXSfDhXtWBEgOzsRs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hUKG8Spiu36hMY3N5t9Gb2la4BUUalSrit8V83U4ia9JkFcTUPctrE2eE0+slOqc4
         +khTcTZ9lVVFga7UaueOeHZ5cxZv/YdqrtAiQEZIwhA9bEKfjVRuDgcJVkWzLvSQFJ
         dsCzWFlb5+x1gkyII9hnCqHedgSK4pOD6t0gWNHoJMCkJ3/15zJYjHu+2LgL2UejDE
         bQuDv/DhmevM6OrvWMro3us+emCHQ1AnrDwTtC3vvekJd3Vsf0PW6w+OkKdOqcwwaD
         3aZGvewMhg8iCcERIpNxaNEuv7/0kSl7M+9K1t84R3s7wObToNEf4UG4BTg0+RyVuQ
         cBSmQ8vJtoa3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 925D2F6078B;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwO50sY81Qjr/H7@zn.tnic>
References: <YdwO50sY81Qjr/H7@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwO50sY81Qjr/H7@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 2056e2989bf47ad7274ecc5e9dda2add53c112f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfed6efb8e136c0e0a4cc854f2aaa2ed6ac1b9e0
Message-Id: <164183927659.9673.12035295978184277817.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:48:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfed6efb8e136c0e0a4cc854f2aaa2ed6ac1b9e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
