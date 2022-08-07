Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1958B8CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiHGAug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiHGAuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F91EF;
        Sat,  6 Aug 2022 17:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7922660CF4;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D4D2C4347C;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659833411;
        bh=tiKFkTYUsERcXmLVDqt6Al0l2xGSKr6wXDRZDev1Pjk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D0Ixhy7mIdi/MZwcFZEC62qDdim4aInt/s6E/q8kUrTsrPhsaLiP8yUWHFwwjuaon
         Fv31KVkPhozvenyUIC7xkAf5YDfJEJMteUESwCIDxjGDOV/7CcruF9Yqzm+ie6p26U
         PI0iECvcLgWXhi29kLzAp3HKhnynFgwCfxilznnf+LNGsf6+yK8G01vv6DUZoGywoG
         Oiyo8MGVZ4wcVK0Zjroa6PylN+qF46E51waP9DO7+Kr3nJuPkcAN/RrpZkuwqRgIrQ
         9e76Tw7AruOfi6lzOeFmH3tN5f+yPhFVaLgAxHlhxloIPtIIsLhwOMz6TDOg9HuyWg
         pHVNCg9rAG1EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28A5CC43143;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] perf fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu68rPjbQXEJlrdj@gmail.com>
References: <Yu68rPjbQXEJlrdj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu68rPjbQXEJlrdj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-06
X-PR-Tracked-Commit-Id: 99643bab36b642be10bf09cd3285c37c9e5b597f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 592d8362bc2526bbb08cf7d258661691e957b5ea
Message-Id: <165983341116.27609.3050783210469761691.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 00:50:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 21:10:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/592d8362bc2526bbb08cf7d258661691e957b5ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
