Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A85489F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiAJS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbiAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBFEC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABED61362
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F0EEC36AFD;
        Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839277;
        bh=nSuUr39J5T9nVUcJfhBFte47cjcPcFpgS78/RhYKFes=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JwPf+K7fGVBn3ZxjGKhegpNiRRENyVxkNB9vsOGq7PuK9zkCnJnxtpqaOC56TCd3v
         T9EcHjqWMjHQb6OZRCgmxUns80jkQh7fHPpr29SRBoba8HFogo+LUCCvXMRQe5AmvH
         gqrgqcZw4fc8Mr/olu4f2ssGxfy+qFjEIsWt1D3CHXYu3v+16mw7EmR66ok6u05Pzv
         Sxn2SnxiP1pUHdiVA1+8P5G/rK51VW2W5K3rYWjhxFouf5dtefANaBkeGEXouaV7wE
         6E63gI6jH+QCDnV+chuPMIZ9FL7UmvV5SYrcozX0D/Ziz7nXwXs7LdGgMKqhAEX4/A
         i15We7sAl+CGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFE63F6078B;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwTkIqIyOtdWN/c@zn.tnic>
References: <YdwTkIqIyOtdWN/c@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwTkIqIyOtdWN/c@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 0be4838f018c10d7f138a213c006d345db35ef5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 308319e990ae95b2a752fa0a1730f88598ca0dc7
Message-Id: <164183927697.9673.8453462401248386218.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:08:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/308319e990ae95b2a752fa0a1730f88598ca0dc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
