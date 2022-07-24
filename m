Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4D57F618
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiGXRBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiGXRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:01:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCACF5B6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86906B80D8F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 17:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38E93C341D2;
        Sun, 24 Jul 2022 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658682062;
        bh=Cz1EOOjaglvtFXpnGbfNG1yE1xXSxaAwfoYWKSGRrc0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fDt5Iwe+7jxvay7NjDGNSD+kzvpkSb0nF8Z3EYMeGMkzjTyIY/bXJclnsaVT4/Erf
         GV9GCuh8JtflGGlHNzzDWUctd+doMfUliSuJV9zXC8DeJwUncyVHaAcsoxHpYOzSoa
         25Xs8mBERPjcpeZ6Kh/CfcmN/1xDg4ECg1nSazhIet0OMdk5p0mAEbrkAnf8OzfGPc
         yBfhjXKqod3kieVQLP7KOC5M6LsuScMYCExGO2ZeFZC2pL4gagtzbhFWNYoISoMToN
         PCekX/ax4OY1fANFCBcFly76wF4PXJdVhCjbvlHVqUY1Mffm8/3uDs201wSwkyc3Jb
         WipgOFBsFiIUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17851E451B0;
        Sun, 24 Jul 2022 17:01:02 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yt0LbbTNZyrM0pVw@zn.tnic>
References: <Yt0LbbTNZyrM0pVw@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yt0LbbTNZyrM0pVw@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc8
X-PR-Tracked-Commit-Id: b648ab487f31bc4c38941bc770ea97fe394304bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05017fed92de32c167bbd21a5ee9ad0e489e19d4
Message-Id: <165868206209.25283.8718555738191963915.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 24 Jul 2022 11:05:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05017fed92de32c167bbd21a5ee9ad0e489e19d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
