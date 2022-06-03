Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAA53D3DA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349441AbiFCXZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349755AbiFCXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C31F1F620
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 16:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1BB60B08
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 23:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59D46C3411C;
        Fri,  3 Jun 2022 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654298705;
        bh=MgWj+1MLla81lkU4pLEHQjXnj36W+5iUdw8gc2iV0+M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JbWSEnH8H9OE6rnIt+gtND+UrYAbrLwm5rN1/+iGwMu90w+4S1Fdof+NBx95JnnFI
         KvmdmiqsjFnj5eJchh4Hrwij3XpMWkM1FjdLoakrOXa25kZ94DxC2e0hj6GJUuP4Vf
         G5PmnNlRgr2x/r6ydbnPuj1PMvuX47HWS4o5nqoB4nj4WWyFgJ30EjNxLDGzGiYG6k
         MFSFmfUOMxnjK1Fx4Uc+Ir+nPP06Ara1qW2M14OOQkUdMgpEqqnV+zmsVlnR7/pc7i
         kc/basOQNX1/GookEi3X4VmUrf/R0ofXYru+dRIDiGIAs+KW+tinHxJLg3vLl9Vhxd
         LrQO0rrODM0LA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45625F03950;
        Fri,  3 Jun 2022 23:25:05 +0000 (UTC)
Subject: Re: [GIT PULL] 
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bkv97dvd.fsf@email.froward.int.ebiederm.org>
References: <87bkv97dvd.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bkv97dvd.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_stop-cleanup-for-v5.19
X-PR-Tracked-Commit-Id: 31cae1eaae4fd65095ad6a3659db467bc3c2599e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67850b7bdcd2803e10d019f0da5673a92139b43a
Message-Id: <165429870528.22913.15112936217165537642.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 23:25:05 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jun 2022 14:20:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_stop-cleanup-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67850b7bdcd2803e10d019f0da5673a92139b43a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
