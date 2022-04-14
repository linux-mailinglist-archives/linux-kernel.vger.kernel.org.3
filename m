Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B8501B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbiDNTBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345017AbiDNTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:01:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A929E9945
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8EFEB82B9B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8522EC385A8;
        Thu, 14 Apr 2022 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649962746;
        bh=+zx7ctRFU9qLRN0YEXG1njhOh0aBmyhr4yS3knPfHHU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=beMxTU9cJq43DBAmCXJ6V9N6twP660xvaXnnLpRs1UjQPbavodv6NyVbG02bc9SWh
         3I/YHyXcyARKwi4chWDA1SbtV6FtAKVuMqZ5+MzIYDYTuSqBAFigX5ZffjeK32xxZy
         8KKj13KsYRNCJ9Cya1lIdDbvGEo2uZv4DflCQ2sJNZ4dlDK8LbmUMJWPwmpgGPe+Sf
         N3Ce7w9j4m9gUCxOaqP4omwUec2QBBb0UlnUYNr05OEfNRziEqjoilhTnBT2ZCURTz
         4qOHaA39ejGygXemdI3LKD7Oqv3L2YLDi+88SOvdX4G93JkHitbRi6QFaKkeRVkN1k
         IbUhFM67NTDhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73CFAE8DBD4;
        Thu, 14 Apr 2022 18:59:06 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv8vc3vpl.wl-tiwai@suse.de>
References: <s5hv8vc3vpl.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv8vc3vpl.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc3
X-PR-Tracked-Commit-Id: 24d0c9f0e7de95fe3e3e0067cbea1cd5d413244b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9b4c79e58305ac64352286ee5030d193fc8aa22
Message-Id: <164996274647.15440.5766284768997852742.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Apr 2022 18:59:06 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Apr 2022 10:39:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9b4c79e58305ac64352286ee5030d193fc8aa22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
