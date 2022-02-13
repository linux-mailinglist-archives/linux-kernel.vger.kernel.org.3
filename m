Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE474B3CBF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiBMSE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:04:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiBMSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:04:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93615F24D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:04:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7393761236
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D809AC340F4;
        Sun, 13 Feb 2022 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775458;
        bh=REyYcXdyNPu2WZZjmQoqU/r9iIlLPGPL63IjJBL28jc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d3ZuCY9BwCFFbknJchtW2iwvc74bUwo4YJ4aYOBFV/nRzdAT0JYkPwkeFG3IS924u
         YiOPGOKstDSXxWDnlvU4dkggvZJ0+TJ7TkQpBpVk2YtUAnxtIgZD9fQjo9c30hSVnu
         RpZsAxbeKIBN4mE6PUU6MD85blR4jj29K7v+/ATqayfdzJjLwFHYQRUb+3jx4t2ot4
         BE+IYZHNq3ElxhY/HyMRciloI8eltHG7dmrs2/YsH941sDKKC8kQLFRt/CEnhSqHTd
         flNkwQI6bpShLQrvnRaafSMexQJyNb2F3grG0gwNKnHdHb3bUx1zBLTyK0V6016Psd
         vVvXGslQ9A6BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5063E6BBD2;
        Sun, 13 Feb 2022 18:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ygj7feK+vdtPw6zj@zn.tnic>
References: <Ygj7feK+vdtPw6zj@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ygj7feK+vdtPw6zj@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc4
X-PR-Tracked-Commit-Id: 13765de8148f71fa795e0a6607de37c49ea5915a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f3573672324b6391014680dd6e2cf7298aaea22
Message-Id: <164477545880.17492.10389622496867706433.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Feb 2022 18:04:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Feb 2022 13:37:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f3573672324b6391014680dd6e2cf7298aaea22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
