Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A134972B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbiAWPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:47:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49878 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbiAWPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:47:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2980760F3E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 911F2C340E2;
        Sun, 23 Jan 2022 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642952835;
        bh=zU4Cb1uhgvXM8LIa/reaRx1jx5bGjNtDuLpv8PDacQ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X4kYkAyvq/l1YxnOHV7KuMM5L4kYn4YxnF8tEpzxCYmlhtaPx87WLVR2/DUi1OWUp
         6UXWLVlu88qm7q2enbMtbDo2bFu0XdTlqKvWYZghouCmdxqufwhqX4an9saVwwkUEr
         T0N+5jwuzlMja8WZKC3u+7gOwxx31nzUrzJwTOHlrWIoxlhsSsjdQ48TU1ziyvO6qC
         1upf9MJcQ6XTlIj6jCd8D0FruwNRzlqYsEESr/M4nrPEdQFgcpbgQc30Vc4MT8DHH4
         iZPfcEL3s/K8qSlyEKa4ET+6S8nuAr6lygny3f4SqczsPB2kiKUO1DMU0rD3xfrOM0
         Cz8G8wkiIpMqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80ADFF6079D;
        Sun, 23 Jan 2022 15:47:15 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ye0xnC7imdiQC9m3@zn.tnic>
References: <Ye0xnC7imdiQC9m3@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ye0xnC7imdiQC9m3@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc2
X-PR-Tracked-Commit-Id: 8c16dc047b5dd8f7b3bf4584fa75733ea0dde7dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f9e04221227302d665bf64c69e5308360f4f88a
Message-Id: <164295283551.26749.12031072677525264546.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 15:47:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jan 2022 11:44:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f9e04221227302d665bf64c69e5308360f4f88a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
