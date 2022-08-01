Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765815871D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiHATzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiHATzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:55:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BAE218E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09AB9B81696
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90AC3C433B5;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659383717;
        bh=vcarhMnwhiAqd7b7B/b0bEqm0gKMZm0DHrh0pjoc9vs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lomyA7g1ajUmyPPc+Ovt0vfIj33prldMPs5YaKEZv7Sgu1lVl2M6RI4QxZYAE+h52
         6Wp+zD0kAAZ108R/9LjEViO++KelfhlKu9gZH4JzJ0FOK7JDu24Upx8mqPUuX6Y27z
         ckUYiXBrymhalGhpgzrIQrTahow7tYk44unrTBQLEwRkFHaeaV4oZ/rAIMUiSmDZUe
         UfqhvO8jLgid8XZntf0NxjyvAeFkNpoSepwqgnWtmsKPZjb2l0WASW0FA7LXIYP/Qj
         7y3KSyWJK9i1C14AF9JwQywDHzKyBvGUmcMeQkMXaqTLp5G6twO/ew0k/NxTZ1b7+/
         bOfe+3yrZwi5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8082BC43143;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler updates for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yufc5Mq1aqLVV/Ov@gmail.com>
References: <Yufc5Mq1aqLVV/Ov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yufc5Mq1aqLVV/Ov@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-08-01
X-PR-Tracked-Commit-Id: c17a6ff9321355487d7d5ccaa7d406a0ea06b6c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b167fdffe9e737007cbf7c691cde5fa489ca58d7
Message-Id: <165938371752.14399.12603678803106376609.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 19:55:17 +0000
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 16:02:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b167fdffe9e737007cbf7c691cde5fa489ca58d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
