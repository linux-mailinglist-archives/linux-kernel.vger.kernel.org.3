Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2EE48FB43
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 07:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiAPGpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 01:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiAPGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 01:45:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18578C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 22:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4C60B80C87
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 06:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73071C36AE3;
        Sun, 16 Jan 2022 06:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642315536;
        bh=8ACMQJaG2LYauNz2p+CW0H89Cqx2QFYVe1rsPWOL9tU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KO8rNlSMMwny/PAOXMRNVh8GMCEuhkuWio1YC61XJUiO3zqgAgASzmp9hN15D6s/L
         GlcBB/qZuF6mFtAtbf51/KWdyPFygPjKFYdDWUkYkZ5lmkNRPQMl3+8N1J/Ixy4mbc
         wy8nI5Oz4Q0onSguwBwQiqdhT4fgUwu44QMSk+B4/sPLwOpVV9Sc1L10oHJ3NF7Fw/
         N79myY+LasAVSDAyS0a3jtWx5uWj6e5mRszXO8JAIDe6GrJtYGalsHts7KkmmBM0AI
         rDR7DocmIwfJpw2ObNtkIjw/pKoyZti170fKq9fYW+X5ZJZ1SjLvTO5vp3QeObcxeT
         kBSgBvyvRndvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 606B5F60794;
        Sun, 16 Jan 2022 06:45:36 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: Remove #ifdef __KERNEL__ from memblock.h
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeFBiiDO0FUz3mpZ@kernel.org>
References: <YeFBiiDO0FUz3mpZ@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeFBiiDO0FUz3mpZ@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.17-rc1
X-PR-Tracked-Commit-Id: a59466ee91aaa9d43889a4c51e01de087d188448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2aab34f873cc611cf195231c3738080c8dbda7f3
Message-Id: <164231553639.30539.2928746094923895077.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jan 2022 06:45:36 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 11:25:30 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2aab34f873cc611cf195231c3738080c8dbda7f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
