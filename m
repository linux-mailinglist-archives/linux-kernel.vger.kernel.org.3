Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0A577721
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiGQPma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiGQPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:42:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22477BC9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1E89B80E1B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79665C341CD;
        Sun, 17 Jul 2022 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658072544;
        bh=mSEXKZE2DFe0L0miI1bnZCt5n+AF/l6XQiGlHvzDME0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vm5eIXPbX4bnMA3mnB3x1YQu1LFlCLy2PKfpXNns5zuC/CSplkurkBxGNrNtHSkSL
         /LRRljY9zujRqT7bhXSb+4YyTAZADHuEmhy/JW4MKe0DVizPKF7o4x6yytF9biZ8e3
         qjtslWyZvXa+rR4F6nfeDrNkZW+4+j3WwpIARSPQIv/VSPMEO2XPUlVtdPWOTdeGn3
         bJ6eSNr2PW0xYPCyridTBwKLTcYnyEkQtolvRDqG4xq31xfNTDOIg34s1svonQ/z6/
         b78ycRmEChDYbfuqZCm9ffam7tfgqRrGi0O5xuBuas10HPCNVJnAgVYId/pNENWVT/
         +VGnj9vm10thw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A0B4E45230;
        Sun, 17 Jul 2022 15:42:24 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtO8e45NSh13PVRl@zn.tnic>
References: <YtO8e45NSh13PVRl@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YtO8e45NSh13PVRl@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.19_rc7
X-PR-Tracked-Commit-Id: 68e3c69803dada336893640110cb87221bb01dcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b18593e4b9f5781a7683fca256036515bd9b946
Message-Id: <165807254436.9863.13977804756765466431.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jul 2022 15:42:24 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Jul 2022 09:38:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.19_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b18593e4b9f5781a7683fca256036515bd9b946

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
