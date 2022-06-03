Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC353D1CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348006AbiFCSum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349273AbiFCSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19A286DC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB10619C2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6392DC36AEB;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282222;
        bh=VCeY0ggFJkX7nsO8Y1ux+1l48uM7be4QNz1MsV0CG6c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fnVSkm31qEuE9iJdGdrNS6YelDmRZqlUeOguJCl3m03xoQlhSUgGZPhvqI94A/HJo
         plTsU1qkwu+icdGUoC+r/JLyip0p/ZO06woECZQ3k7X7EYSBP728e+J009xOjrevBm
         nmaMnWmRG8q/9fZRqq7Bu3EADh2ik0qZ4VwuI2s3k4Qt4aXTivpGLjFQ1133uB/Iq3
         by2uf92MyD33jTIVV2sLWcfwJSoAf41Cd4L7f+vEbRXzw7D/rc2QmUBl0KLIwpJ5/u
         bZXuLRpWtVxmCvgWvKPQgg51Tat7g3Kb+1H4zWHAwvBrMJX7zAbwVyWnO+AhTHh+85
         5FhuMtHboNg+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5130EF03950;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bkva2li2.wl-tiwai@suse.de>
References: <87bkva2li2.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bkva2li2.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.19-rc1
X-PR-Tracked-Commit-Id: 672362cbe6df049299c8ed0a463d89daf66b081c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f6ebb9899861c8a4e49cc7d9796d024f731b512
Message-Id: <165428222232.10974.12855695395894124866.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:22 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jun 2022 10:34:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f6ebb9899861c8a4e49cc7d9796d024f731b512

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
