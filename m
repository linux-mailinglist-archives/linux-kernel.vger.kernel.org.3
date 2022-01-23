Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F384972B5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiAWPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:47:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33296 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiAWPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:47:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A97EB80DC1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 15:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA3B0C340E9;
        Sun, 23 Jan 2022 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642952835;
        bh=fR1TLmxDKvQWn3K4dM7x48ekKKBzQONMbgdTzItKlPc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=htmwcl//K8q7VsEmjnu+HuidTG3xjPMnJbyB8bRlRA0UAxgCjFdetmWIVGHwLxfnP
         /VMK2uI22cigUpHtiIVfVMbfKt2TIpJLHnxpK0raynwtdbfEWMJRQyEQRx9foqsNX0
         JKnAGhl742hhhe12dajMMg4ARLqtr5DwirrCJgKCIP2BIlja2nnk3pbVswnNa5SHPG
         Wbp+zUuNInZe2zdvei4vdQk4ntJvNo0XTZrOoPC69QmvRiepQjz67SpDaj6CBwsJ81
         GM15PRjRUR7IrDFHdDaJqM93eWixsIgudDWWk8L27wq14la+FP548s04is1LBXydAk
         WzRK2dKJDEf7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6717C395DF;
        Sun, 23 Jan 2022 15:47:15 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ye04diH6Q/UtQ+Tg@zn.tnic>
References: <Ye04diH6Q/UtQ+Tg@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ye04diH6Q/UtQ+Tg@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc2
X-PR-Tracked-Commit-Id: a0af3d1104f752b6d0dba71788e3fddd67c857a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac5a9bb6b4fa22135b3e371ac9787de120e18c8d
Message-Id: <164295283574.26749.13958351879754010951.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 15:47:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jan 2022 12:13:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac5a9bb6b4fa22135b3e371ac9787de120e18c8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
