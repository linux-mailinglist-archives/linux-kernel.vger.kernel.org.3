Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3744972B4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiAWPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiAWPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:47:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CFAC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 07:47:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 519F560F5A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3D6DC340E8;
        Sun, 23 Jan 2022 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642952835;
        bh=SOm/0xQ2I4KXwkM9f+frAOPkHLXKCkDxtFLIXMSPm7w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EFgjEUcSa62EmWFqhVnF8ogJz5fGh/0Lew+2l5H1pr0zF+PkPX4VN0JXg6bxQLZ+H
         0zYCEQPsklY59aZSdixv0zlWCYOALs+5QMx+sRkWSHi6+rnQAHM62981FbBNFQYKQl
         QiOgLGPw4vm8hTQKMnki0IFW462TXz0VCzzS3DBwBDtX0Lno3qO6/0cdB7tED5TuF4
         ZI5GB/1k0FJmS15lwhAGjE/BRd5hzhMNBrHOxg9bF3jKb84R2809LXoyYrpVxwAGcG
         9YUHmgqoWS18GN4K70wzhYpfmfMfCVMJFMi9jOcnqdoJr/vso/CL4KfM6obz/vh/D3
         oKQCQqzX2/e1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F0ABF60797;
        Sun, 23 Jan 2022 15:47:15 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ye02u8jFsitJqSO7@zn.tnic>
References: <Ye02u8jFsitJqSO7@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ye02u8jFsitJqSO7@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc2
X-PR-Tracked-Commit-Id: 0e3872499de1a1230cef5221607d71aa09264bd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10c64a0f280636652ec63bb1ddd34b6c8e2f5584
Message-Id: <164295283564.26749.10678833503862600525.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 15:47:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jan 2022 12:06:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10c64a0f280636652ec63bb1ddd34b6c8e2f5584

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
