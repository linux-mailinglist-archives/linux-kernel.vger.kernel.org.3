Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0728F47EA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245067AbhLXBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:22:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51402 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbhLXBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:22:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBD42B8224F;
        Fri, 24 Dec 2021 01:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84C61C36AE5;
        Fri, 24 Dec 2021 01:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640308932;
        bh=xm3Vj5goYYccdBozB75K4lm+Ob70Qf5rWD1y8iszGTA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fkcIRHrehLGlba9A9O7TSD3Y2NA9eB2DK5veNYG3S6cDijQoh4pVdZCvd7ntzSJtn
         ekTI3tY8F0LN+ZGWzFICozyAPqJ1hW0L0VKQVu4PH0HMy5kv5scMiq5s14KIVAMMKd
         fdhQF/yODOSnHS9a6JTuYu+N3Q4zLB2FveUlgnAM9ryw3c4HNKiMbxkTaon81L92pI
         6HajZPUAJSfcVu+a+c/DP3UAP6EBN4Lhb6HPeotMznuRb4lLGsodRbtNDb8gSxJfDC
         CumC/Nwq93x+2G1nn6+xhinznadJZOMT7j1RRiJqN7dNH4M8GVyWcbW2LsrNOXTWWG
         XuxYEQ8BKibkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60B91EAC06C;
        Fri, 24 Dec 2021 01:22:12 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvWBb7-Br3fz-Y6Jn4d3vQL_OEpRcnR_AjqEpSmNwxHtQ@mail.gmail.com>
References: <CAH2r5mvWBb7-Br3fz-Y6Jn4d3vQL_OEpRcnR_AjqEpSmNwxHtQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvWBb7-Br3fz-Y6Jn4d3vQL_OEpRcnR_AjqEpSmNwxHtQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/5.16-rc5-ksmbd-fixes
X-PR-Tracked-Commit-Id: 83912d6d55be10d65b5268d1871168b9ebe1ec4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a29b11da9651ef6a970e2f6bfd276f053aeb06a
Message-Id: <164030893232.23059.557863938742866724.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Dec 2021 01:22:12 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Dec 2021 18:45:52 -0600:

> git://git.samba.org/ksmbd.git tags/5.16-rc5-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a29b11da9651ef6a970e2f6bfd276f053aeb06a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
