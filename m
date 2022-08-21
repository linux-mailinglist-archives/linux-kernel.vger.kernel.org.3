Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0EC59B6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiHUXNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiHUXNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665C12A94
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0444760D57
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62519C43141;
        Sun, 21 Aug 2022 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661123627;
        bh=oBTzLL//gI/SfvdMro322NNNyHSMiNrwxlh9gSgrJwI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PpLFVCX4Yq7o9fPyZOcsBpuLRkO+zYSYzn+PMMBsNEufbJdZZ1SiD5531nfRWMVjw
         1Ual6584iah/nYpCL0OLeq2e8r6FKsCfMM4ELo6GKqmCf51F0hrC9qiwGRBGY94XpF
         ZuCYZ5eKtA1FDiwdoL+FzGzHLajed9809vpx7UfHq6sdkhqOZNKtAJRA+mScX1gZes
         Zm1x6iUr4rpbJT1ZO5Gn+7FlRIqSYT6Zb5odmaKYKJN797g4o54SjY0RAJO1P/wm4U
         ggidriObiqSdjgwwSryjRrVp2kykvWEu5zhAVNk/mjCj0Qx6ywomovHFL5007v6+rd
         Yzsc6cnZ788mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 471C0C4166F;
        Sun, 21 Aug 2022 23:13:47 +0000 (UTC)
Subject: Re: [GIT PULL] kprobes fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YwKcC0dUSQS3vy7n@gmail.com>
References: <YwKcC0dUSQS3vy7n@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YwKcC0dUSQS3vy7n@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-21
X-PR-Tracked-Commit-Id: 8924779df820c53875abaeb10c648e9cb75b46d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f61f842d199a695bb0c310945f7f320c1730abc
Message-Id: <166112362728.15654.5529708560139360692.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Aug 2022 23:13:47 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Aug 2022 22:56:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f61f842d199a695bb0c310945f7f320c1730abc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
