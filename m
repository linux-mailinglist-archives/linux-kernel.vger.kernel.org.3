Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0348B95E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbiAKVYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:24:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56128 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244810AbiAKVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:24:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C972BB81D51
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72DF8C36AE9;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641936288;
        bh=56ZZQygVeKB1lhhbxn3fdASF7fHowfpE/zYby1rhTuA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TkMbldGcG9ipSU1iD6qycVfgN5t4C7rMU6+KAh8W5IEMPSGdwITa10HoPFWuBoXsr
         8m24T+/bNc3uQ0xMrWh7TY13ZLv7tmlSupPmm6ktZgnETwcUB0OYev1U9wp5cOlE8F
         Zp1eCNPFnJ3jlW20txFYA84jOXE3dPFVBwKvRDU9gDXH1mft5F9FAdBhLqZEci3sEg
         DdXKeWOEnT4pUgPYxEpwcDKcHzblTDrbTv5k16K6clv9coseInntch4zq58yeZM0jA
         4r1Qk7zo4KRsQ1b1yzOWXAeWFkDz5aF5ycFrY+O5geGUpQ905gNYGq6Sgt451A4vly
         40YSEQVxzvpcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61EE3F6078A;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTNyMFo6PW0FQKy6hTiVug-9ACQWazj0AJcih9YN2Sbyg@mail.gmail.com>
References: <CAHC9VhTNyMFo6PW0FQKy6hTiVug-9ACQWazj0AJcih9YN2Sbyg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTNyMFo6PW0FQKy6hTiVug-9ACQWazj0AJcih9YN2Sbyg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220110
X-PR-Tracked-Commit-Id: ed98ea2128b6fd83bce13716edf8f5fe6c47f574
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d7e52237c59e37a25da854196fc70e9b09704d9
Message-Id: <164193628839.30592.11377874110134481479.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 21:24:48 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 14:14:05 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220110

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d7e52237c59e37a25da854196fc70e9b09704d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
