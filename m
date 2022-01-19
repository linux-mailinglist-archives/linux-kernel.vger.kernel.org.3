Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30F4937B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353333AbiASJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:48:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51144 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353293AbiASJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35997B81915;
        Wed, 19 Jan 2022 09:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E8BEC340E7;
        Wed, 19 Jan 2022 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642585693;
        bh=Tp+yamzMMMZE/cJq2iWgjrvAsPDxFtIqy1SheQLqfYM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sq0TJLKa6h6g5bOL0n5UFI0YBx4rPvVUkenIUHgAeEkfZyaggw9DUIjkFCk8eq98Y
         TWNxPc2G2SahqJ11M+yi7bwvE4DDSf7ZZ038T3fa+TcazyosNJV4hGUgE4E4SJpJdB
         wD8GGmLV4ztXrrg5L2y+ZgLdkd1zxtf3soTVwWXZcAIvMatlmfWbGuqE6J6w2uSwI7
         KLiazSvWgy93fi2/gxElDUBU75QDCKm7I0khXc4fVbwG3yvT5aOtwhJ3eJRXK2l4xl
         AZz9QKeft7So+g05qkhOg9FkGhPKKvyRSsj2zy+tEw5hKSUJyH1rQ6RMOjnCAFgzZy
         LI0OWQuq0RYlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF10FF6079B;
        Wed, 19 Jan 2022 09:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAShL3dfQ0Ter2avCvGPjrd0YTJau-S4+8rJyWXmu0tG0Q@mail.gmail.com>
References: <CAK7LNAShL3dfQ0Ter2avCvGPjrd0YTJau-S4+8rJyWXmu0tG0Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAShL3dfQ0Ter2avCvGPjrd0YTJau-S4+8rJyWXmu0tG0Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.17
X-PR-Tracked-Commit-Id: c4d7f40b250c1a4d74ed259e84807f58032507b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd6f57bfda7c36f2d465cee39d5d8c623db5d7aa
Message-Id: <164258569297.19279.13038889410759232745.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jan 2022 09:48:12 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Jan 2022 04:42:17 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd6f57bfda7c36f2d465cee39d5d8c623db5d7aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
