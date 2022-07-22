Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE957E7F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiGVUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiGVUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:08:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DC5A8769
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55991B82A5F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 20:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02199C36AE2;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520478;
        bh=EpLdF/DmZ2NzD+Su+giuqarOrVJLzZplK4qh6rvOcR8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r/RmDNGIqCNWA1HWMRq+GFKKD0BwwrylMg8ZvtSLTu8bTZcVWMNoiFVKnh5qV1wRe
         RUFDfJpD5DZvb/KGvsEh9XJZ2WVNxWoOqUvve04x/D9Kz2kWlIPTf9FvypkViwW+80
         kt9gf6s5n9dqOgIh5nbIH+09FJwh7Nh5Bnva+P3em/UVoRdAasSg7Mq4p8toBdwm07
         H9eKo1B823fbqQNjaLi03EK5v6cL85VqZhrhbKxWAurVDpc7/p2/FClQuoTT8MJVAl
         /tTTeHfNhM7ooWufsGWS0Ln/4eYsU6Qs5vruTm8o8eBzYdcOqvxDX96XxCM/vF1MEY
         iJe2mBOy3u6sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1E00D9DDDD;
        Fri, 22 Jul 2022 20:07:57 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmhx4a5n.wl-tiwai@suse.de>
References: <87pmhx4a5n.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmhx4a5n.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc8
X-PR-Tracked-Commit-Id: cf33ce6f0c220fbfe5dafcb08d4c5655097a5fa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f636c6a16f2a6809f7de27c99e0780dd569fb23
Message-Id: <165852047791.15752.17608272702041454650.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:07:57 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 14:14:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f636c6a16f2a6809f7de27c99e0780dd569fb23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
