Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824F6591CCF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 23:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiHMVsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 17:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiHMVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E8E25C74
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E724E60F50
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 21:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55E5DC433D6;
        Sat, 13 Aug 2022 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660427289;
        bh=bQNK7tOYuH7gvnx/s4deReEkBoJMvPeV3Kkx07ahcT8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nY84BRdH7nfTvH3vmhKFfEeMH1mSNylhU1ETahWX4du8ZsqiH38VwdtOPPYNcPtVg
         vRkGtTOOdWHVmofLxepgTIlXFjKXNhrshwhtC8stMFhwwnQpng3KJ1pQCtO7T0Mx1T
         JhE6jIux1Ka2aET3kYQE36vKP3NMViTmTz4RE3esKLAx31EYA8DktTSAqY32jRgdfc
         XxAEZbfk7umgd5VREFAjTz+0pzqTj+nKVF3Tx8jVjkKFi0UU2MnQ72JMCrujK+pyUI
         ZRlOdhF7auJ3X9rXsaFWYz0X+V8lF+L4ntPK+FhDagRkhiCH3qoYSjGkOvTtAPU0Zk
         bgngHwwEWhXzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43931C43142;
        Sat, 13 Aug 2022 21:48:09 +0000 (UTC)
Subject: Re: [GIT PULL] timer fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yvd8L0qIbLarxrOQ@gmail.com>
References: <Yvd8L0qIbLarxrOQ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yvd8L0qIbLarxrOQ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-08-13
X-PR-Tracked-Commit-Id: e362359ace6f87c201531872486ff295df306d13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6eb0fed6a3957c0b93e3a00c1ffaad84d4ffc31
Message-Id: <166042728927.29926.12591229801523436449.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 21:48:09 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Aug 2022 12:25:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-08-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6eb0fed6a3957c0b93e3a00c1ffaad84d4ffc31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
