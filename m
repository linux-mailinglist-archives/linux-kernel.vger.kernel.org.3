Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E747B2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhLTS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:29:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47050 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbhLTS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:29:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE805B8105C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C272C36AEB;
        Mon, 20 Dec 2021 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640024976;
        bh=/eYDAzfK91JhtE7ahIrBaTqVhUSiNAhI7ztBysohewI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kr5VB1nRCznLPtSLxYmmkujJ36ldVL8X2MwosUnNJZt7aq2aj6zTr3M/U+Pj6bJRc
         Z0doBCz9gdYE5DEPgR2ASwzcL7wbLvCI7wZT9AbWqc+EzJdiwEq9XJwDvBBjKJ2suG
         qdZUTeizmZagj3D+HNve+LmJe9qDcYwXe8jWqbqKH7uLuXsRHnZEa/3fx5CptoFG7O
         LN6rp98EQpQ8XvJ/yC0eX+83fRHJeZs1lMsWLZI/MKbFNkgjvlMc50QZbojkQk1kyh
         msiPUC3kGgP6/L0G6BVcQ/xYZfKrDzHG+wOF6ilA0FGqNJ0P29UTnSzCoicSNwHsYE
         d5r3o6PkgzG2A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5668960952;
        Mon, 20 Dec 2021 18:29:36 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211220171826.CDBE7C36AE2@smtp.kernel.org>
References: <20211220171826.CDBE7C36AE2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211220171826.CDBE7C36AE2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.16-rc6
X-PR-Tracked-Commit-Id: 85223d609c99eaa07cc598632b426cb33753526f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3856c1b3983530c58f95f508db952ddc46d269b2
Message-Id: <164002497628.23216.15433614397955194803.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Dec 2021 18:29:36 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Dec 2021 17:18:11 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3856c1b3983530c58f95f508db952ddc46d269b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
