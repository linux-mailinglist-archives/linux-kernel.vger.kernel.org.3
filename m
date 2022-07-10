Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6613456D030
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGJQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGJQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:46:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF70A13F59
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 134BEB80B6C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6FE0C3411E;
        Sun, 10 Jul 2022 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657471539;
        bh=59V1EHeLbBqd5fdINfxqA2doe+Hb3RzJ6Dl/Zh5YZ3c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jNAQvAQTjghTeHJRjh/YyEinRNrwHXx8MzWkGWjq2GdILm1Pk3SizGi1caH7FAtPM
         +qYSpaqrZyhsTn6E+XgO0A1QHwZ9eyme1pKYwuh1A+V9S/gH3whKpZEhwnNBf5st7H
         STDMzcfaizkBFbVwmFXzWh/onyS7Ew4+/tQuuuB6j+Zsd5lHyeVT3eSlO47gseyiKc
         5VlW+iOcnyWF1YiABSptxReDYn9E2F1lsvGaWpJM/bGtO3Z+AtAVmorUW7fDwiP1FW
         iyqV8KlEFLO7ZqwDSqoYjh28WTUKUmW8osU2IDEGnEL5TZpN8GrB3dZMQSze13onFp
         SHpKZ21WHabeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B55FE45BD9;
        Sun, 10 Jul 2022 16:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YsqnlPzrnQThDLil@zn.tnic>
References: <YsqnlPzrnQThDLil@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YsqnlPzrnQThDLil@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc6
X-PR-Tracked-Commit-Id: cb8a4beac39b90cd60abbf9fd639a3357274e469
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74a0032b8524ee2bd4443128c0bf9775928680b0
Message-Id: <165747153963.25707.622816080449540151.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jul 2022 16:45:39 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jul 2022 12:19:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74a0032b8524ee2bd4443128c0bf9775928680b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
