Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA224A367E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354880AbiA3Na6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:30:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43242 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354874AbiA3Na4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:30:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28A7CCE0EE4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B9C9C340EB;
        Sun, 30 Jan 2022 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643549453;
        bh=GJVQVfP5Rsone7J/ss1PuZW2dIK6upQaPvd6kzqzTG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jz5KkWrDwuzRj1d8N3B7NdYTjyCz4pVdttb0UyFNRXP4h+2hnaMduYlX9SLiTdyU5
         gavsc65kwVjtlSMDEQDeF0Yj1JapasLn7Gm/YhpZ/6AgDoWXrca96wg24Y1MeJJSAc
         htszEDpaC7QpN97k0TY63ffMUC+1I8gKi343ZnUKhx+0+nzoRBhJ3ooiSFDlg79Ira
         ObvvjQcBrMf+SutQiIyrdNbYbE4xKY5DxqjNAuaL8dCnjHYXy0Ykb1kYsp5VZN9yo4
         oOO8Yeh1Y/l7zVXTe3P/DI6As0ZE5FHY12yEBc1ikQXUaE67l37S2Or3zmNzRtiefC
         Oo6/kijc/J+GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 874F9E5D07E;
        Sun, 30 Jan 2022 13:30:53 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfZ1GTDDVz5WzYOJ@zn.tnic>
References: <YfZ1GTDDVz5WzYOJ@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfZ1GTDDVz5WzYOJ@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc2_p2
X-PR-Tracked-Commit-Id: 243d30803744155a54bfb8a844cc964945cfd9a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5fe9de7903330df7641fd342733fec6fb91afa2
Message-Id: <164354945355.24404.9474586407447774954.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jan 2022 13:30:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jan 2022 12:23:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc2_p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5fe9de7903330df7641fd342733fec6fb91afa2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
