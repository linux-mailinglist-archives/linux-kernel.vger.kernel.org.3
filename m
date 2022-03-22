Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3404E360C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiCVBll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiCVBlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:41:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA01B787
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C62D8B81B7E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B793C36AE2;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647913189;
        bh=RJ5ivrU0zUudaB27iC33d5wmMFKwtPE4EKT3AWTM+bU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IdMamQv7COs172kmTYn/k2EYSIKfSZVHGxtH3EqwlNtgCRMbgWnv9DpWksHMI9p+d
         gcnauKB6atFhtk0IsV6FXjCVeD8ASfH4YUMwjX5O4MwBR0ZSun4D8n+wH4a957pJK3
         3VneAfQ0Lp/YKTGuLThsuVts9yBmf/xY0tXWTSF2+8q7fGMbg88DMIZxc2aFvM5CgU
         68Vy4lWw7PPvKA0gvEnCUgU+SOHB/Bz5rpeGilVDdVdSRe/mkLHRqzPOBvVUh9uST8
         9ZLGlbWu1HoM58XMrEl7tWV1EaLBXLCyzB7QN8D2ZIvVObK0dgVpja/0DjmxVJ7/LF
         sbBqGYqxG+LoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 696B5EAC09C;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321123558.33FB1C340E8@smtp.kernel.org>
References: <20220321123558.33FB1C340E8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321123558.33FB1C340E8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.18
X-PR-Tracked-Commit-Id: 5999f85ddeb436b4007878f251a30ccc8b9c638b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6ccf45113fb6799885950293401e4b104c9b276
Message-Id: <164791318942.2267.11893458028396146264.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 01:39:49 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 12:35:47 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6ccf45113fb6799885950293401e4b104c9b276

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
