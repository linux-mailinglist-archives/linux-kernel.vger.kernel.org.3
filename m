Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326964A35DD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiA3LKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:10:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44974 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbiA3LKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:10:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8445B828F0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D0ECC340E4;
        Sun, 30 Jan 2022 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643541047;
        bh=/n1aRJoZRVHIeAQbmMBAduf8TveRpGqhhauLuSMbfwo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Do7nUfXOkZSH+I0J5AiZ7D36HMihwnFPhnlf72b0IrWiqpsQ0SrDjrOlg8O1SgDQ7
         SUd7wTaO0kWMhBwf5vIWtsocr0/ZcMTEwQ3OmnRrbWB38g41mMjNCFhM4/qevdOecQ
         kwPM4VAXid0QHhjsw0A0HDjUdTOKmeMpcMbgsQZBnD4WUMRyJXDUjBAdRjWvJ8Iq9B
         BnFj7ZKzEP/phM4F5gjUDnBAJtSfUzmYJiPA6V9ylHgOR6DzmIjkDfuJYsmZiyzBNg
         rAkynFZvA7WsZyMg2iMkGblXEWt7nJq0Lh6FkUVXwmvHCupU41oie+9VPi5U1GknZY
         IuCewRKk7Z42A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BB27E5D07D;
        Sun, 30 Jan 2022 11:10:47 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfZw3s6XOmj9rtq1@zn.tnic>
References: <YfZw3s6XOmj9rtq1@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfZw3s6XOmj9rtq1@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc2_p2
X-PR-Tracked-Commit-Id: 809232619f5b15e31fb3563985e705454f32621f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24f4db1f3a2725a6308105081d822b26889e1018
Message-Id: <164354104749.1472.15361449786180333604.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jan 2022 11:10:47 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jan 2022 12:05:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc2_p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24f4db1f3a2725a6308105081d822b26889e1018

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
