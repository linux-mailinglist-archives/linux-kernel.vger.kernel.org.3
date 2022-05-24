Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80DF53212E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiEXCwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiEXCvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B016405
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FEA8B8173D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFE66C385AA;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360676;
        bh=LrLp2Pv0n0WxOn3HuZnUaMssSCyw1lzAux4xkMwalsE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hpsB2h2HMPEJ2IY7u/WXAiqM4fqjgJiQzXwL9QLHFQ/g4q8gJvTkmnqcvE5H5GhyP
         +wLqbEC1QPs94JBC9/rEMHvxRW7YNyHaj2Pd2DjhXaazufwI+6BUMdDGoHQGtESbOh
         Pjc0ZJWZTtCzpXvTq4R0/UBDXkHOP/vRfqA4TsqktT+4ovtFqcgayp6BNQkLIIqnGJ
         KBL8bmZgg+Owa0Hr0+mw6nGM7wvCvx5fz+jV02hFHVdOQijgxJ4kKtq6p+DMCs6N89
         JdOrPQF7nrkIKEQWR9bexy2v2VK2VMUQQ9pSySfoQewsi+zSJbjVN+tAExqGKKGB3L
         XwADEKKtUWgrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE0FBF03948;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
Subject: Re: [GIT PULL] x86/vdso for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YovsdAxZsUWxGVl4@zn.tnic>
References: <YovsdAxZsUWxGVl4@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YovsdAxZsUWxGVl4@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v5.19_rc1
X-PR-Tracked-Commit-Id: bf00745e7791fe2ba7941aeead8528075a158bbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6ecaa0024485effd065124fe774de2e22095f2d
Message-Id: <165336067670.14181.4271534404795006950.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:16 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 22:20:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6ecaa0024485effd065124fe774de2e22095f2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
