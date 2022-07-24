Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881757F616
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiGXRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGXRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:01:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8D10FD9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 34B4BCE101C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 17:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46DFDC341D9;
        Sun, 24 Jul 2022 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658682062;
        bh=2FQRgzDw4FP93RWFwRU6EAB7eL+8qTUbP5Mq6QolXCk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ILpoURirswCwkYRfrdYWHm8BVx+1hdnbL3pFmUsvwZkKNiL5uybSGpZbHXoaZIaAK
         feXtV1ZUIuPqAy2TQ+unAMufI66ZT2KfxiuYN77/VdprQgt0PAtRi/u8ElCx3rWSgJ
         eb9X+EEYwYXmi73ZEhkxtqu1SRkWPvb66e89R1juBGMjSHsdIwUkOaqgm9dfaBeZCt
         PDy6NBb704KG9sgeDa48bWZ4aqZAzo3t+OnpAe2MHsWsem+C+w5dvqHpIz1TS4kwc7
         r4HTNdHsqVGvhgT5Whe89d655A6iAXXV5IcXmTGGvNGmXlML0fRF3tzFlj6GitkPtd
         3lnNoc2h3Dz1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24C7AE451AD;
        Sun, 24 Jul 2022 17:01:02 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yt0NwMa30uGQZ173@zn.tnic>
References: <Yt0NwMa30uGQZ173@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yt0NwMa30uGQZ173@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.19_rc8
X-PR-Tracked-Commit-Id: ddfc710395cccc61247348df9eb18ea50321cbed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2602a7ce0fc66318325df170a9ee275d7df5c2e
Message-Id: <165868206214.25283.1039458352838898776.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jul 2022 17:01:02 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jul 2022 11:15:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.19_rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2602a7ce0fc66318325df170a9ee275d7df5c2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
