Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105D569160
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiGFSGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiGFSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83971EECE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A60961FDF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C163EC3411C;
        Wed,  6 Jul 2022 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657130794;
        bh=bxD5nMv+RFvod/z5p3giNFod7bS/GVcUc00piNI5OvY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H6MCDwunS7+e+fMV68MkeubRpzj5GVYmFR2R3PfqmE5XT2NjClwNkog2OKkxP5D9d
         QxeTVRkcyls9YiURAKXyMA7W8lREOhrwypRWZXWowIsEZfI4q50C14lqXRL94v2yf9
         mpBys2vCSpXmUAdHJRCR5Sjd5yW3xAXqHCKFphmgaBMYIrhhSJmx3dHbazfm0osfsb
         /Z6E5ev08Qp1piaot1wSVeiwQQn+6fTf3MALdhVPKe1PJut9LYAxpbhBaFv+tJqxmj
         wAQB/nTQxHdJ7AptsFu06PgFpSoLOQk3eFFLhtu9AI7ouWgpFubCZMzxqWqycE/TyI
         lI3EJa7vM0vLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD538E45BD9;
        Wed,  6 Jul 2022 18:06:34 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k08qs8vh.wl-tiwai@suse.de>
References: <87k08qs8vh.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k08qs8vh.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc6
X-PR-Tracked-Commit-Id: c5e58c4545a69677d078b4c813b5d10d3481be9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3850b3f975f94317011421bb55325f828ae72ea
Message-Id: <165713079468.25095.1236010539777270144.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Jul 2022 18:06:34 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 06 Jul 2022 14:50:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3850b3f975f94317011421bb55325f828ae72ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
