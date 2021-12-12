Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680C4471C86
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhLLTRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhLLTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:16:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C45CC061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:16:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0EA3B80CEA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 19:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82674C341C7;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639336609;
        bh=eUQPLVqbcNacLkfSOnaKEMJXyr4Gll6PzpRU58/Snlc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gP2s5ejJDiQmOOqH2QJLp5DdquWqOByEwsfDXoCJo11JdLWq2YzrncaVcLKNm3nVx
         IIFMzqTrP5hXkRuoU3uPaB+eyJ0kjy5ALJukkqJsmKoeWUXLipgDdiYKvb3tQP0Kqm
         vizx1Usr+XaTe5kc34o/W7/k2N3raYK7NCBm2RrWHqDY0OzwgNA53GCEXMUcDD+mcw
         S+F8MJ2qI8HXTK9rXOH9/Gvrp6pb9RPdno/n+xAxMg2qtuL4ehxOMDgzlnQ66YK7SP
         5w1JKYUj0EJYKwWmeXLmdNAneftGzxZE6P1t78N+ATO59mG+4nV5R73mB5MTS+5chH
         jlNPEQx4Kb1AQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6D29560A4D;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163930519667.2118055.7751610896538340816.tglx@xen13>
References: <163930519667.2118055.7751610896538340816.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163930519667.2118055.7751610896538340816.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-12-12
X-PR-Tracked-Commit-Id: b7fd35a0ad976ee8e7d4914e063410686b5fa353
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82d2ef454052372f36e3642ac09efe48c3d59220
Message-Id: <163933660944.938.7546907382582023113.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 19:16:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Dec 2021 11:34:20 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82d2ef454052372f36e3642ac09efe48c3d59220

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
