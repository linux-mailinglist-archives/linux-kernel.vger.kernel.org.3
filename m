Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D325331FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiEXTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbiEXTxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC579391;
        Tue, 24 May 2022 12:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D42A5B81BA2;
        Tue, 24 May 2022 19:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F501C36AEA;
        Tue, 24 May 2022 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653421994;
        bh=LojAAVo8IKoL5BIDsIg6O9qeNnJu30kScLXbIignBt0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fhxfBxY+GRejQZOn6QRpMwLGvlagyO7472QWUQ6YyK3kSUyELUQoPdS/XFn9w0ww/
         K79OALchTCRxJ2um/4Re035kB3Mp1vWrTdyTeJI3/hUW4ns8wV0BKGWwNU0LN8HgD5
         k0ORx4h+cMvED/fkmeK7H0d3ZxIhcdfttplgM2drkFPSOJT5GgBCazJhPQfAMYgnSu
         KMzdJ1FNo/agDQaCGPavx6rlHe/U36zOsISN77qFgSboYGoLpLcYquMrL23E2E1piq
         a+CsXAuDwDGjo92QxOoPWS6WEo2rF2PzC1Rf2NXo0rnwEFpPAGQsSzmXrX8ytz9iok
         R7jFDIYfoDhBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C4C2E8DD61;
        Tue, 24 May 2022 19:53:14 +0000 (UTC)
Subject: Re: [GIT PULL] perf events changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <You6yGPUttvBcg8s@gmail.com>
References: <You6yGPUttvBcg8s@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <You6yGPUttvBcg8s@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-05-23
X-PR-Tracked-Commit-Id: bae19fdd7e9e759580ac4693d2df3bc23ab415d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfeb2522c3777923c2bd24772b914195dc93c86b
Message-Id: <165342199450.18932.1506748982319231188.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 18:48:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfeb2522c3777923c2bd24772b914195dc93c86b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
