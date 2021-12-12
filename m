Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11BD471C87
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhLLTRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:17:07 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43224 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhLLTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:16:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 451DBCE0D92
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 19:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E0A2C341C8;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639336609;
        bh=rlUUGSQHq1tdVnOeXerFxtabDE5hlrHox0WzmwN4QVY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gkIW8DaYKGtvt0lgmDv8WDrJcXtu39jg72csA6R5BGX8nvsu/KIcnQaiRex3GCUMm
         TAUNTblxRWXl5g3hNvf6lHrb8ORVTQ8znssw1fVMDiaszK+24hGnGOE8Pj/JJgKK8r
         jR5JeSWfkyB6uA1bZ+3Nk4WTdLV0qMnS9sB5yvU/FHrwvHGZ4EWCw1hN2RlTLDcjSF
         d20AO0Abpzv5cbBuWqxRBKPWR3v4IfUmAW2r779YZxlhUd1DKPz3bQ2RVJW29a6hqZ
         Hmy0KkhZWVHLRTU01t2M6Om7WwUAA7u8IDWnEbLLT4iXMzYbYdZcK4829v+zhbvP2H
         O/7TsgiAuhKRw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5DB3F60A3C;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163930519817.2118055.7014553397541088230.tglx@xen13>
References: <163930519667.2118055.7751610896538340816.tglx@xen13> <163930519817.2118055.7014553397541088230.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163930519817.2118055.7014553397541088230.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-12-12
X-PR-Tracked-Commit-Id: cabdc3a8475b918e55744f43719b26a82dc8fa6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 773602256a2ca73455b0baeae5737c4a9ed6ef49
Message-Id: <163933660937.938.12417822004916924573.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 19:16:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Dec 2021 11:34:22 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/773602256a2ca73455b0baeae5737c4a9ed6ef49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
