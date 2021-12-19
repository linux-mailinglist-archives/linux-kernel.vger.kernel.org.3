Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E581247A217
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhLSUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:34:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39804 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbhLSUec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:34:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6C28B80DBB;
        Sun, 19 Dec 2021 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 823B9C36AE8;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639946069;
        bh=sGuRJ0oBNM+S09wwPLsE0sPGJD2fEgU1KKNN2+auAJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uI+oH4+8aYAELQXHUlUQcbbwfz94/aoQZevEfnEV7hKQMprwLvx93Lq9IgtK0VU4S
         Iv0lM9QtTaZ8XP4VfysKXpUrJdTEn0/cVvCabVMkxJ9tvTEHAAqJJ+yebrr0YanG9p
         Quko7ZqcM1o9fVjHRe+ncJ1DNjnq8Nkqo/3GmErCewF90jLgRQL89tT+CjDgstMY0M
         JRWrNKfsXpopcjLg/End5RPYcCIVvtJIuQHSD0hu5fg7LwGSUcR8U1jvpKyBXwdsmG
         /MnT7mncZxAmSm7BYeXkwNERiMBjkEgXYpUtw5rm4RnR9ClpYTKaqb7igYzfWFq1NK
         WxN2d4l1jcS7w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6F87560A25;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211219105455.GA3372@alpha.franken.de>
References: <20211219105455.GA3372@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211219105455.GA3372@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.16_3
X-PR-Tracked-Commit-Id: 09d97da660ff77df20984496aa0abcd6b88819f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4cc5ea443e7f0649b322a47abc7ce612c5c0581
Message-Id: <163994606945.11038.2349874353103075160.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:34:29 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Dec 2021 11:54:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.16_3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4cc5ea443e7f0649b322a47abc7ce612c5c0581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
