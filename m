Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD584FAF7A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiDJRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiDJRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6B4B419
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5D261141
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08D8FC385A1;
        Sun, 10 Apr 2022 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649613152;
        bh=uH4ddn1tXYBpAFWuoscQa62nqcbHPtD1MFnMtEppSWc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UBKVP7cmI0tc/z/j6rxCk3pDtdxgc3cmEUXCUFL8lWQ3ZoIsp5KO7SKzdTXht/oP1
         M6Xiq4KAo6E24Tt9b8tJzbwGMqD3FABMnZrcAqFSGg6jgnu8YzSB0Q5PI96n7oVrXs
         Rl+8CPfxtS9Qwb26s75dsjAqxeQhlMKaaEdkPG00bi7Do9g5KFlg0+sqBdgQuKE9O+
         wNPOdOoUbIcypPKFPD6afN9TBe/LpapKlE0lP9WGrY/lUH3eWRdOAasITG0qxA2LZw
         kH274avUBlj1zKLzNxMqEV4RbEQf77qOZGtRVEyc9GzjR60mFZbeZjeLLuLACw6D37
         7ZZt5blQq6PIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF3F9E8DBD1;
        Sun, 10 Apr 2022 17:52:31 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlKzdjk+VtarQ5pr@zn.tnic>
References: <YlKzdjk+VtarQ5pr@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlKzdjk+VtarQ5pr@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.18_rc2
X-PR-Tracked-Commit-Id: 0a70045ed8516dfcff4b5728557e1ef3fd017c53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7136849ea95280685dc6a00a893501e61983b6b9
Message-Id: <164961315191.10430.6014072793414297829.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 17:52:31 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 12:37:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.18_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7136849ea95280685dc6a00a893501e61983b6b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
