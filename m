Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36262533202
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbiEXTx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbiEXTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D2C60076
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1881B81BA7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8930CC3411F;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653422006;
        bh=RWtNztKXCFiE+lfJ7h4tgaidy5Eh5/H21F+f6TBTJ5g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gX0HSZpFRGdBK30BiBDTogkhnkjWk6kjvvvyCnIF4tBmYvjdaXP11ZtIfmbQoiYFA
         lp4h7DTXYNwvJDxQN+d96E8AlpXnNpDMzzFdoHuTD/2cN6C9vVUZyBP/r5Se4WwWOv
         76v66X/juIM/DMR0tQu9CzdNwKRPC1nP+IhYDFh0Lrr28WhqCCRL04gpyJUAzFQfFS
         aH3fzA5cn+E5Wip3cbPR1ckrFT31mMazcoyPQQphs+IB85UWQivk4hxtOKc0DBzPXU
         PB5IrpYSrPPGC5D9rg6wVmHlE3Vt+pW5o0BvJ4bSCr2VvKlv04ncoMz6wjp1K3HCXa
         PbpVzP5PXmfxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71AB8F03938;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <You+G0njuvLvLll3@gmail.com>
References: <You+G0njuvLvLll3@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <You+G0njuvLvLll3@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-05-23
X-PR-Tracked-Commit-Id: 991d8d8142cad94f9c5c05db25e67fa83d6f772a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f3f04c19074972ea12edeed23b07a32894e9e03
Message-Id: <165342200646.18932.16992591974830870665.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 19:02:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f3f04c19074972ea12edeed23b07a32894e9e03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
