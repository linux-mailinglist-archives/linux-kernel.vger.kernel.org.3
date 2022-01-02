Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4241A482C4B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiABRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:04:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44508 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiABRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:04:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7693060F05
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 17:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBBBAC36AE9;
        Sun,  2 Jan 2022 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641143066;
        bh=SgQxRl9NPw71tXOXq40vgT6b2QsFu+ARtz+umgs6t2Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Czg8AxeEgR23RAI+Z6h+RreevUV6is/gSsXRx0AMVl51Wu+CnfKwLQ8KL815u+t5t
         pJthGqYZSItblflM03vROLeE20ZzUEzwp/SsI1FH4QRab1SskpYvVa3zMfLOUUm0yn
         FMF7xrwhbRvlkB6STNFzRxSwjdLwYhlogL2XdCPArUroYT/ZtghWtgRCi+DC/4tokh
         lHaqG9N+KDqzE3APdUs5oxaCTkTcU5VRXp6+SZiyGTF6InT1faS7sK+wZSlDFxRBMg
         XyEznp2jjDvyA+vyZ6JxBKmolDOyr1u+Kl2ScMPuo6V9C1xV+VctKtXfEZFZPiQXjD
         4ZxVKE0t0OrsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C784BC32795;
        Sun,  2 Jan 2022 17:04:26 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdFxi7TVYP61uA4f@zn.tnic>
References: <YdFxi7TVYP61uA4f@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdFxi7TVYP61uA4f@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc8
X-PR-Tracked-Commit-Id: d6f12f83989bb356ac6880a954f62c7667e35066
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1286cc4893cf356ad6c3a042116981e827dd3680
Message-Id: <164114306680.7230.4942660350214464195.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jan 2022 17:04:26 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Jan 2022 10:34:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1286cc4893cf356ad6c3a042116981e827dd3680

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
