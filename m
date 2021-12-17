Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8FE47810F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhLQADR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:03:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35198 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLQADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:03:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A5C61FBF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57CC2C36AE2;
        Fri, 17 Dec 2021 00:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639699394;
        bh=S1y8Ta6wpMcLo+E5KqIpotjIxhBHEzE+3mkx9RAsZ2Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dd5A/3zqVUXl2V+mr/rZKUC6CsnzzVmx6Z5vSWqPbQA+DL92ItvyXLVKWgjmLQOIR
         9+VxTBPlYDwJOSSQXI0g3dCXid5qvZGVaU8LL6yFkLLKSk5OztutkOGMRiyowFJEEH
         5Wi+fkoKjbJxhcycOHuALSw8OtAtXfWiTLRLyUSnCCOQfbwhjhmvtrvDzL29c56uQC
         Q1QWen/NVtyGEBS9mWFUQCLI+XMGWcPZ8yQmAQNKhlOdn4J2KvFhPThP0WzMWzUurj
         3b07PSvgOAdUyu+HeC2jo1Ivll8OvMNW8t8Ir066+2wSYD7+NnR4Pwel91zx2PcX9Z
         IJBZc/KNBXIBw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4496B60A27;
        Fri, 17 Dec 2021 00:03:14 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v5.16 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSxFhFBXamDZOkVxnokgBDPDWPNQDLjoZuyqJm65j3JUA@mail.gmail.com>
References: <CAHC9VhSxFhFBXamDZOkVxnokgBDPDWPNQDLjoZuyqJm65j3JUA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSxFhFBXamDZOkVxnokgBDPDWPNQDLjoZuyqJm65j3JUA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20211216
X-PR-Tracked-Commit-Id: f4b3ee3c85551d2d343a3ba159304066523f730f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6441998e2e37131b0a4c310af9156d79d3351c16
Message-Id: <163969939427.17683.15579571197546038629.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 00:03:14 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Dec 2021 17:58:49 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20211216

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6441998e2e37131b0a4c310af9156d79d3351c16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
