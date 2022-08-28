Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4175A3F0C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiH1SSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiH1SSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:18:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8326AEB;
        Sun, 28 Aug 2022 11:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ABE8B80B8B;
        Sun, 28 Aug 2022 18:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE60DC43141;
        Sun, 28 Aug 2022 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661710710;
        bh=G9lE3j2yTpn1EzyymK4bflAkRQL56lhrPN7Np8ClcZw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KPhR6MS3XwBbG9k8M/il+qN4JNZStxhXDSjN1lEJMbVJqqBEAn5l2zZ8lt5NXjo8S
         DTjt4/Kgd15U12HixmfS6tzb/x6B32gxZkJGuQXZMMpijjTlTvJp6MXlsvZxybIdUl
         neNZwF0F5ie3EJO09ZQ8NlXq3mRkzif9DT9PzOMXL3+rASFxxy18rAPmkZ1WUoe0WI
         Fg5khZOcUTKlK3oYnCZWI4rF8jX81VWOSSU0zgx80Szw6fV/Q5YTnlkPEP9YKZI/JD
         zCgGwLLqvhqHoSeDqKZXNTl8fnDPYIgYlVZvEcLActVOJAm8+AXAOfGjvI20DbOcoA
         ljG+DrdxNBPfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC1DAE2A040;
        Sun, 28 Aug 2022 18:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ywt9TYx6rWC5RHaV@gmail.com>
References: <Ywt9TYx6rWC5RHaV@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ywt9TYx6rWC5RHaV@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-28
X-PR-Tracked-Commit-Id: 11745ecfe8fea4b4a4c322967a7605d2ecbd5080
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4459d800f71d01042b36326fd8ece1f823b9da16
Message-Id: <166171070989.6107.15690139975504924669.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Aug 2022 18:18:29 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
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

The pull request you sent on Sun, 28 Aug 2022 16:35:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4459d800f71d01042b36326fd8ece1f823b9da16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
