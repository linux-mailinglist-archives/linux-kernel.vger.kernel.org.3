Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA648B95D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiAKVYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:24:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56118 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244801AbiAKVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:24:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8265EB81D39;
        Tue, 11 Jan 2022 21:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41CA5C36AE3;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641936288;
        bh=U0BhlehzUqrz8qzUI2X3xocQSqzqx/IKLa9tzWiSAjg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iqZrI0QtyiPSss7FBfqgtnRxgoO5Z6ktZcflHeVIbe3kgt0IJyzc9A9fI28fxSWP/
         fTTfGyJkk5o4nSpM3MZUOolnvld3XkGSV0cc3iv/b1am2fRGmGwv8DpbVmhHQvrin0
         L3O/ypElvXe7RdnVbwKlm/pJfAjjMhHU+qNHd5RqdD0cDNqk2k7j+WyoXPYZLS1VmC
         DB6BHHoLwGNtHzcjx6RQ+SB/U256tMLo/sl+8eu553B7uClIpY0PvYIFAljhhtpzGO
         XV8QbSZ1OG6F7ZAmtVSDRx3DsyYvVQaClHpYKynUI+2UaTfgm+0jfqzuABLOXxeHIH
         YPQYYGvVsk2KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30FC9F6078C;
        Tue, 11 Jan 2022 21:24:48 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRS4a2iK-n8mmo+5qKZ2jz6k6oie6isEPP1Qc=LEWc+cQ@mail.gmail.com>
References: <CAHC9VhRS4a2iK-n8mmo+5qKZ2jz6k6oie6isEPP1Qc=LEWc+cQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRS4a2iK-n8mmo+5qKZ2jz6k6oie6isEPP1Qc=LEWc+cQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220110
X-PR-Tracked-Commit-Id: 6cd9d4b97891560b61681cad9cc4307ce0719abc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a135ce4400bb87f229ab33a663987327d9e0b2a0
Message-Id: <164193628819.30592.673463223748026968.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 21:24:48 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 14:13:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220110

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a135ce4400bb87f229ab33a663987327d9e0b2a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
