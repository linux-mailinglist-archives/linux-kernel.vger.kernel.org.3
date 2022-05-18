Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2702652BF21
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiERQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiERQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5316D1BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:01:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2797E6148E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 16:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BEC2C385A5;
        Wed, 18 May 2022 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652889676;
        bh=Rb6QChfWRni/U+m9DYBqCt7Wf1D3qXZAaBQMsHLESqI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NCw8g5lFInGpYEd11O//jJMSXUBGVEH+Ged9lguDBL+k2WSoAd+9OYd94gm+htfFG
         E7qhMAvfYw6ussRk3NBGR5yk6L9mWo2ZhAMFk8wb0SFowunpnFKxiwT+hO5mTPHiYa
         dCZvY8hhOwmSjZcwYY00IjPHjr8o14l3dzUNGH8OO8+khcD/kXCDVplf1kYajLFLwp
         /zUxVA86vrcioRWp5ydyNF87YtVjnyqdqUiCKoyhu8qMCCLotvZDpvnMTHRMzqooO8
         KFQHsZD2rrXh86zGsQxbDJc8ecgaJYinVRYJfXvitaZYC+sksxTZi3mY0aeaEkiw4s
         FE2LQ7Nvh74fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74944F0383D;
        Wed, 18 May 2022 16:01:16 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7zvuqkm.wl-tiwai@suse.de>
References: <87o7zvuqkm.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7zvuqkm.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18
X-PR-Tracked-Commit-Id: 5c62383c06837b5719cd5447a5758b791279e653
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef1302160bfb19f804451d0e919266703501c875
Message-Id: <165288967646.25663.16673985866612114729.pr-tracker-bot@kernel.org>
Date:   Wed, 18 May 2022 16:01:16 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 May 2022 11:40:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef1302160bfb19f804451d0e919266703501c875

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
