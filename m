Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC5C53215A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiEXCww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiEXCvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9060E22B29
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40569612B5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B582C3411B;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360676;
        bh=UMsfL1onP7nbArDuGurxatZdeRhJt6LJM1q6eECse+8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B2cKfxvPuncN7qwQMuJRnLGerDQNLNRKjuPAGva7Tn7uSgaciYXIjoqg9Q6PFxIWT
         PgMm6ISLtfpMCOFBfOYEZ2lQ+sxBee2OJV4mEVDbN33rjmESxDPYQML4hCA1dRTPs4
         mloNPLTBM8TT861l6k8JACM5Cc3hw55iHaJ9l7HEkv5ghLc6KicdC9i+62sbhPd8Ls
         JrnLn5riWa4QpL8n0m6RywXskJc7wx9vqjgmPgnovUfdelH32hwyh5Vdx//3b/XOTy
         Zb85V8hfj9aE49SE4qmdEmcqegD4aN6+ZER5bKdc3Ne1G3hBHr6vTYTHhEtOnDYwtw
         EHssAbQIYVo/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AF87F03938;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YovpweaJTtzSBvQw@zn.tnic>
References: <YovpweaJTtzSBvQw@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YovpweaJTtzSBvQw@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.19_rc1
X-PR-Tracked-Commit-Id: 1ef64b1e89e6d4018da46e08ffc32779a31160c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abc8babefbc1fc6f013573bc933d66bc906cf726
Message-Id: <165336067656.14181.3571735619248892718.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 23 May 2022 22:08:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abc8babefbc1fc6f013573bc933d66bc906cf726

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
