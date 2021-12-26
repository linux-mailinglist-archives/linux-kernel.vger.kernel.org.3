Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4047F881
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 19:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhLZSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 13:38:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55898 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLZSiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 13:38:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42BADB80B17
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 18:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFE89C36AE9;
        Sun, 26 Dec 2021 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640543892;
        bh=XunAspzST8cMfMKmKkFCDP9qPun4VKOIJnis++X6OoE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MnmBhlEReLK/gBGPXJp7tUlv75fVDRzFw9pTEke98Q4AeJNM2qpZyNntHrNxZNXUO
         LsMPrWsIbmT65PhumIX+Ih5BUOsBMBo+DTNhudsT5pjvcvsNaAPu7nnOiXJgQjR2KC
         GU1fDmLH7QRp/FkrwNCuuoxzOcJOfiGiwyk6awWQRFKRjIUH5d5eyPqsQgyRqC9Wk5
         R7SpmbkkNTjf1E2LZsNa7qXeD5oqaPg9tp3jjmaU6p4YzLqUx87aQt2FuVpM4RqS3V
         vjck14h3HsKxcuwzF1444ypy2nyPPLj5hp6ytvFNVrBHRdM+5HyZrU4VwlnX/Csk6L
         iwi/c25akj1lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBEADEAC068;
        Sun, 26 Dec 2021 18:38:12 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YchXJU2EiAFpWq4+@zn.tnic>
References: <YchXJU2EiAFpWq4+@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YchXJU2EiAFpWq4+@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.16_rc7
X-PR-Tracked-Commit-Id: dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2afa90bd1c7526766b5eadb1856988b61a31501f
Message-Id: <164054389271.393.285310617242957766.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Dec 2021 18:38:12 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Dec 2021 12:52:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.16_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2afa90bd1c7526766b5eadb1856988b61a31501f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
